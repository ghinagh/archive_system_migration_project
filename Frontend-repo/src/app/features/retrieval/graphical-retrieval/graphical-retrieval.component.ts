import { Component, DestroyRef, inject, signal, computed } from '@angular/core';
import { FormControl } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Location } from '@angular/common';
import { debounceTime, distinctUntilChanged, switchMap, catchError, of, tap, map } from 'rxjs';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { RetrievalService } from '../services/retrieval.service';
import { AccumulatorToken, RETRIEVAL_SCOPE_SCREENS, RetrievalCodeOption, RetrievalConditionNode, RetrievalFieldOption, RetrievalScope } from '../models/retrieval.model';

/**
 * Migrated equivalent of the legacy sort_from.frm, serving the three ARCHIVE.frm menu items that
 * open it: "الاسترجاع البياني لبنك المعلومات" (route scope BANK), "استرجاع الملفات الاضافية"
 * (route scope ADDITIONAL_FILES) and "استـرجـاع الصحف والمجلات" (route scope PERIODICALS). The UI is identical, but every backend call carries the
 * scope so each screen reads its own legacy field catalogue, per-user marks and data root. The accumulator textbox and AND/OR/( / )
 * toolbar reproduce the original's "cumulative questions" sentence exactly, but a
 * condition is a real nested tree (see parseTokens) rather than a matched pair of
 * literal parenthesis characters.
 *
 * Positions were intentionally left out of the field catalogue for this first pass
 * (no confirmed join path from a documentation record to a position record) — the
 * legacy screen's video-orders sibling and the frm_result print/export/full-text-search
 * actions were likewise scoped out; see the results screen for what carried over.
 */
@Component({
  standalone: false,
  selector: 'app-graphical-retrieval',
  templateUrl: './graphical-retrieval.component.html',
  styleUrls: ['./graphical-retrieval.component.scss']
})
export class GraphicalRetrievalComponent {

  private retrievalService = inject(RetrievalService);
  private router = inject(Router);
  private route = inject(ActivatedRoute);
  private location = inject(Location);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);
  private destroyRef = inject(DestroyRef);

  /** Which legacy screen this instance is — set per route in RetrievalModule. */
  readonly scope: RetrievalScope = this.route.snapshot.data['scope'] ?? 'BANK';
  readonly titleKey = RETRIEVAL_SCOPE_SCREENS[this.scope].titleKey;
  private readonly basePath = RETRIEVAL_SCOPE_SCREENS[this.scope].path;

  readonly numberOperators = ['EQUALS', 'GT', 'GTE', 'LT', 'LTE', 'BETWEEN'];

  fields = signal<RetrievalFieldOption[]>([]);
  categories = computed(() => Array.from(new Set(this.fields().map(f => f.category))));
  selectedCategory = signal<string | null>(null);
  fieldsInCategory = computed(() => {
    const cat = this.selectedCategory();
    return cat ? this.fields().filter(f => f.category === cat) : this.fields();
  });

  selectedField = signal<RetrievalFieldOption | null>(null);
  operator = signal<string>('EQUALS');
  searchMode = signal<'STARTS_WITH' | 'CONTAINS'>('STARTS_WITH');
  value = signal('');
  value2 = signal('');

  lookupControl = new FormControl<string>('');
  lookupResults = signal<string[]>([]);
  /** Coded fields only: the c_getcond list and the code (BoundText) of the picked name. */
  codeOptions = signal<RetrievalCodeOption[]>([]);
  pickedCode = signal<string | null>(null);

  /**
   * Legacy sort_from.frm Form_Load: BNKOUT2.sql filters view_user_bnkout to the current user's
   * rows where user_out_choice is 1 or 2 — i.e. "حقول العرض في الجدول" starts populated with
   * whatever THIS user has already marked (persisted server-side), not empty every load, and
   * not the full catalogue either. Populated from RetrievalService.myFieldState() in the
   * constructor; every mutation below (dblclick/F10/Command3) now calls the backend so it
   * survives a reload/re-login exactly like legacy's user_bnkout.
   */
  displayFields = signal<RetrievalFieldOption[]>([]);

  /**
   * Legacy F10 ("حقول العرض في الجدول" / DBList2_KeyDown / user_out_choi1) — fields marked to
   * participate in ORDER BY, kept as its own distinct list from `displayFields` per the audit
   * ruling (F10 is a separate mechanism from the dblclick output-column toggle, even though
   * both operate on the same legacy list control). Also persisted per-user now.
   */
  orderFields = signal<RetrievalFieldOption[]>([]);

  tokens = signal<AccumulatorToken[]>([]);

  /** F8 whitelist per legacy sort_from.frm c_getcond_KeyDown (RTrim(out_slct1) membership check). */
  readonly F8_SOURCE_TABLES = ['form', 'macnz', 'view_form1', 'main', 'auther', 'period'];
  /** F9 whitelist — same set plus 'view_form' (confirmed in sort_from.frm + end_user.frm). */
  readonly F9_SOURCE_TABLES = [...this.F8_SOURCE_TABLES, 'view_form'];

  openParens = computed(() => {
    let depth = 0;
    for (const t of this.tokens()) {
      if (t.kind === 'LPAREN') depth++;
      if (t.kind === 'RPAREN') depth--;
    }
    return depth;
  });

  accumulatorText = computed(() => {
    const parts = this.tokens().map(t => {
      if (t.kind === 'CONDITION') return t.display;
      if (t.kind === 'AND') return this.translate.instant('RETRIEVAL.AND_TOKEN');
      if (t.kind === 'OR') return this.translate.instant('RETRIEVAL.OR_TOKEN');
      if (t.kind === 'LPAREN') return '(';
      return ')';
    });
    return parts.join(' ');
  });

  private lastTokenKind = computed(() => this.tokens().at(-1)?.kind ?? null);
  /** Legacy x_and_Click/x_or_Click guard (`nb_and+nb_or < nb_ad`) — see addAnd()/addOr(). */
  canAddConjunction = computed(() => this.lastTokenKind() === 'CONDITION' || this.lastTokenKind() === 'RPAREN');

  constructor() {
    this.retrievalService.getFields(this.scope).subscribe({
      next: r => {
        this.fields.set(r.data);
        this.loadMyFieldState();
      }
    });

    this.lookupControl.valueChanges.pipe(
      debounceTime(250),
      distinctUntilChanged(),
      switchMap(term => {
        const field = this.selectedField();
        if (!field?.lookupEnabled) {
          return of(null);
        }
        if (field.codeLookup) {
          return this.retrievalService.lookupCodes(this.scope, field.fieldKey, term ?? undefined).pipe(
            tap(r => this.codeOptions.set(r.data)),
            map(() => null),
            catchError(() => of(null))
          );
        }
        return this.retrievalService.lookupValues(this.scope, field.fieldKey, term ?? undefined).pipe(
          catchError(() => of(null))
        );
      }),
      takeUntilDestroyed(this.destroyRef)
    ).subscribe(response => this.lookupResults.set(response?.data ?? []));
  }

  /**
   * Legacy Form_Load's BNKOUT2 query — fetches this user's persisted display/order marks and
   * populates displayFields/orderFields from them, instead of starting empty every load.
   */
  private loadMyFieldState(): void {
    this.retrievalService.myFieldState(this.scope).subscribe({
      next: r => {
        const byKey = new Map(this.fields().map(f => [f.fieldKey, f]));
        const display: RetrievalFieldOption[] = [];
        const order: RetrievalFieldOption[] = [];
        for (const state of r.data) {
          const field = byKey.get(state.fieldKey);
          if (!field) continue;
          if (state.display) display.push(field);
          if (state.orderMark) order.push(field);
        }
        this.displayFields.set(display);
        this.orderFields.set(order);
      },
      error: () => { /* fresh user with no prior marks yet — legacy shows an empty list too */ }
    });
  }

  onSelectCategory(category: string | null): void {
    this.selectedCategory.set(category);
  }

  onSelectField(field: RetrievalFieldOption): void {
    this.selectedField.set(field);
    this.value.set('');
    this.value2.set('');
    this.lookupControl.setValue('');
    this.lookupResults.set([]);
    this.codeOptions.set([]);
    this.pickedCode.set(null);
    // A coded condition is always "<stored code> = '<picked code>'" (legacy add_question).
    this.operator.set(field.fieldType === 'STRING' && !field.codeLookup ? this.searchMode() : 'EQUALS');
  }

  onSearchModeChange(mode: 'STARTS_WITH' | 'CONTAINS'): void {
    this.searchMode.set(mode);
    const field = this.selectedField();
    if (field?.fieldType === 'STRING' && !field.codeLookup) {
      this.operator.set(mode);
    }
  }

  pickLookupValue(val: string): void {
    this.value.set(val);
  }

  /** Legacy c_getcond selection: the name is shown, its code (BoundText) goes into the query. */
  pickCodeOption(option: RetrievalCodeOption): void {
    this.value.set(option.label);
    this.pickedCode.set(option.code);
  }

  /** Legacy DBList2_DblClick — toggles user_out_choice for this user, persisted server-side. */
  toggleDisplayField(field: RetrievalFieldOption): void {
    const wasDisplayed = this.isDisplayField(field);
    // Optimistic local update so the UI responds immediately; the backend call is the source
    // of truth and will be re-applied below in case of a mismatch (e.g. a conflicting tab).
    const current = this.displayFields();
    this.displayFields.set(wasDisplayed ? current.filter(f => f.fieldKey !== field.fieldKey) : [...current, field]);

    this.retrievalService.toggleDisplay(this.scope, field.fieldKey).subscribe({
      next: r => {
        const list = this.displayFields();
        const has = list.some(f => f.fieldKey === field.fieldKey);
        if (r.data.display && !has) {
          this.displayFields.set([...list, field]);
        } else if (!r.data.display && has) {
          this.displayFields.set(list.filter(f => f.fieldKey !== field.fieldKey));
        }
      }
    });
  }

  isDisplayField(field: RetrievalFieldOption): boolean {
    return this.displayFields().some(f => f.fieldKey === field.fieldKey);
  }

  /**
   * Legacy F10 on "حقول العرض في الجدول" (DBList2_KeyDown) — toggles whether a field
   * participates in ORDER BY, persisted server-side per user.
   */
  toggleOrderField(field: RetrievalFieldOption): void {
    const wasOrdered = this.isOrderField(field);
    const current = this.orderFields();
    this.orderFields.set(wasOrdered ? current.filter(f => f.fieldKey !== field.fieldKey) : [...current, field]);

    this.retrievalService.toggleOrder(this.scope, field.fieldKey).subscribe({
      next: r => {
        const list = this.orderFields();
        const has = list.some(f => f.fieldKey === field.fieldKey);
        if (r.data.orderMark && !has) {
          this.orderFields.set([...list, field]);
        } else if (!r.data.orderMark && has) {
          this.orderFields.set(list.filter(f => f.fieldKey !== field.fieldKey));
        }
      }
    });
  }

  isOrderField(field: RetrievalFieldOption): boolean {
    return this.orderFields().some(f => f.fieldKey === field.fieldKey);
  }

  /**
   * Legacy F2 (`DBList2_77`) "#" marker — global per-field flag (bnkout.OUT_CHIOCE), not
   * per-user, persisted via /fields/{key}/toggle-hash-mark. Updates the shared `fields` list
   * in place from the backend's authoritative response.
   */
  toggleHashMark(field: RetrievalFieldOption): void {
    this.retrievalService.toggleHashMark(this.scope, field.fieldKey).subscribe({
      next: r => {
        this.fields.update(list => list.map(f => f.fieldKey === r.data.fieldKey ? r.data : f));
        const selected = this.selectedField();
        if (selected?.fieldKey === r.data.fieldKey) {
          this.selectedField.set(r.data);
        }
      }
    });
  }

  isHashMarked(field: RetrievalFieldOption): boolean {
    return this.fields().find(f => f.fieldKey === field.fieldKey)?.hashMarked ?? field.hashMarked;
  }

  /** Legacy c_getcond_KeyDown F8 whitelist check: RTrim(out_slct1) membership. */
  canUseStartsWith(field: RetrievalFieldOption | null): boolean {
    const table = field?.legacySourceTable?.trim();
    return !!table && this.F8_SOURCE_TABLES.includes(table);
  }

  /** Legacy c_getcond_KeyDown F9 whitelist check: RTrim(out_slct1) membership. */
  canUseContains(field: RetrievalFieldOption | null): boolean {
    const table = field?.legacySourceTable?.trim();
    return !!table && this.F9_SOURCE_TABLES.includes(table);
  }

  /**
   * F8 keyboard shortcut — mirrors legacy exactly: Option1/Option2 radio buttons themselves are
   * never disabled in sort_from.frm, only the F8/F9 *keyboard* activation on c_getcond is gated
   * by the out_slct1 whitelist. A field outside the whitelist simply does nothing on F8/F9,
   * same as legacy (no error, no visible feedback).
   */
  onF8Shortcut(): void {
    if (this.canUseStartsWith(this.selectedField())) {
      this.onSearchModeChange('STARTS_WITH');
    }
  }

  onF9Shortcut(): void {
    if (this.canUseContains(this.selectedField())) {
      this.onSearchModeChange('CONTAINS');
    }
  }

  /** Legacy Command3_Click ("تعليم حقول العرض") — bulk-marks the category server-side for this user. */
  markCategoryForDisplay(): void {
    const cat = this.selectedCategory();
    if (!cat) {
      return;
    }
    this.retrievalService.markCategoryForDisplay(this.scope, cat).subscribe({
      next: r => {
        const byKey = new Map(this.fields().map(f => [f.fieldKey, f]));
        const merged = [...this.displayFields()];
        for (const state of r.data) {
          if (state.display && !merged.some(m => m.fieldKey === state.fieldKey)) {
            const field = byKey.get(state.fieldKey);
            if (field) merged.push(field);
          }
        }
        this.displayFields.set(merged);
      }
    });
  }

  addCondition(): void {
    const field = this.selectedField();
    if (!field) {
      this.snackBar.open(this.translate.instant('RETRIEVAL.SELECT_FIELD_FIRST'), '', { duration: 3000 });
      return;
    }
    if (!this.value().trim() || (field.codeLookup && !this.pickedCode())) {
      this.snackBar.open(this.translate.instant('RETRIEVAL.ENTER_VALUE_FIRST'), '', { duration: 3000 });
      return;
    }
    if (this.operator() === 'BETWEEN' && !this.value2().trim()) {
      this.snackBar.open(this.translate.instant('RETRIEVAL.ENTER_SECOND_VALUE'), '', { duration: 3000 });
      return;
    }

    const opValue = this.operator();
    const display = this.formatCondition(field, opValue, this.value(), this.value2());
    this.tokens.update(t => [...t, {
      kind: 'CONDITION',
      display,
      fieldKey: field.fieldKey,
      operator: opValue,
      value: field.codeLookup ? this.pickedCode()! : this.value(),
      value2: opValue === 'BETWEEN' ? this.value2() : undefined
    }]);

    this.value.set('');
    this.pickedCode.set(null);
    this.value2.set('');
    this.lookupControl.setValue('');
  }

  /**
   * BUG FIX (live-browser regression report): legacy x_and_Click/x_or_Click (sort_from.frm
   * lines 2409-2422, 2539-2551) are buttons that are ALWAYS clickable — the guard
   * (`nb_and+nb_or < nb_ad`) only decides whether the click *succeeds* or pops a MsgBox; it
   * never disables the control. The previous migrated version instead used `[disabled]` on
   * the button, which gives a user zero feedback on an invalid click — indistinguishable from
   * "the button doesn't work" (exactly what was reported). Reproducing legacy exactly: the
   * button is always enabled; an invalid click shows the same message legacy did, via the
   * existing snackbar pattern already used elsewhere in this component.
   *   nb_and+nb_or = 0  -> "لايمكن اضافة /و/ قبل اختيار السؤال"  (x_and_Click's first MsgBox)
   *   otherwise         -> "لا يمكن اضافة /و/ لانها موجودة"      (x_and_Click's second MsgBox)
   */
  addAnd(): void {
    if (this.canAddConjunction()) {
      this.tokens.update(t => [...t, { kind: 'AND' }]);
      return;
    }
    const key = this.lastTokenKind() === null ? 'RETRIEVAL.AND_BEFORE_CONDITION' : 'RETRIEVAL.AND_ALREADY_EXISTS';
    this.snackBar.open(this.translate.instant(key), '', { duration: 3000 });
  }

  /** Same fix as addAnd(), mirroring x_or_Click's two MsgBox texts. */
  addOr(): void {
    if (this.canAddConjunction()) {
      this.tokens.update(t => [...t, { kind: 'OR' }]);
      return;
    }
    const key = this.lastTokenKind() === null ? 'RETRIEVAL.OR_BEFORE_CONDITION' : 'RETRIEVAL.OR_ALREADY_EXISTS';
    this.snackBar.open(this.translate.instant(key), '', { duration: 3000 });
  }

  /**
   * BUG FIX (live-browser regression report): legacy x_left_Click/x_right_Click (sort_from.frm
   * lines 423-430, 415-422) are completely UNGATED — they unconditionally append the paren
   * character every time, with no guard of any kind. The previous migrated version invented a
   * `canOpenGroup()`/`canCloseGroup()` guard with no legacy basis, which disabled these buttons
   * in states a user hits constantly (e.g. immediately after adding one condition) — reported
   * as the buttons "not working." Fixed to match legacy exactly: always appends, unconditionally.
   * Final paren-balance validation still happens once, at submit time, in runSearch() — that
   * check is unchanged and still prevents an unbalanced query from being sent.
   */
  addLeftParen(): void {
    this.tokens.update(t => [...t, { kind: 'LPAREN' }]);
  }

  /** Same fix as addLeftParen() — see its comment. */
  addRightParen(): void {
    this.tokens.update(t => [...t, { kind: 'RPAREN' }]);
  }

  clearAll(): void {
    this.tokens.set([]);
  }

  /**
   * Legacy Command1_Click ("اغلاق", sort_form.frm line 1533-1535) is literally:
   *   Private Sub Command1_Click()
   *     Unload sort_form
   *   End Sub
   * — no navigation of any kind. Both ARCHIVE.frm (the menu screen that opens this one via
   * f2_Click) and sort_form.frm are plain `VB.Form`, not `MDIForm`/`MDIChild`, so Unload
   * simply removes this window and reveals whatever screen was already open underneath it —
   * there is no legacy evidence for "return to a specific screen." Location.back() is the
   * accurate Angular equivalent of that (return to whatever was open before), with a fallback
   * to the app's default route only for the case Unload never had to handle: this screen
   * opened with no browser history (e.g. a direct link in a new tab).
   */
  close(): void {
    if (history.length > 1) {
      this.location.back();
    } else {
      this.router.navigate(['/catalogue']);
    }
  }

  runSearch(): void {
    // Legacy cmd_result_Click (sort_form.frm line 1064: "If nb_ad > 0 Then" ... line 1527-1529:
    // "Else / MsgBox "لا يوجد جواب لانه لم تطلب سوال " / End If") — the entire query build/execute
    // path is skipped and this exact message shown when no condition was ever added (nb_ad = 0).
    // tokens() containing no CONDITION entry is the migrated equivalent of nb_ad = 0.
    if (!this.tokens().some(t => t.kind === 'CONDITION')) {
      this.snackBar.open(this.translate.instant('RETRIEVAL.NO_CONDITIONS'), '', { duration: 3000 });
      return;
    }
    if (this.openParens() !== 0) {
      this.snackBar.open(this.translate.instant('RETRIEVAL.UNBALANCED_PARENS'), '', { duration: 3000 });
      return;
    }
    if (this.displayFields().length === 0) {
      this.snackBar.open(this.translate.instant('RETRIEVAL.SELECT_DISPLAY_FIELDS'), '', { duration: 3000 });
      return;
    }

    const rootCondition = this.tokens().length ? this.parseTokens(this.tokens()) : null;
    const displayKeys = this.displayFields().map(f => f.fieldKey);
    // Backend requires ORDER BY columns to also be selected output columns (SELECT DISTINCT
    // constraint) — legacy F10 operates on the same list the output-column toggle does, so a
    // field marked for order but no longer marked for display is dropped here rather than
    // sent as an invalid request.
    const orderKeys = this.orderFields().map(f => f.fieldKey).filter(k => displayKeys.includes(k));
    this.retrievalService.pendingSearch.set({
      scope: this.scope,
      request: {
        rootCondition,
        outputFieldKeys: displayKeys,
        orderFieldKeys: orderKeys.length ? orderKeys : undefined,
        page: 0,
        size: 25
      }
    });
    this.router.navigate([this.basePath, 'results']);
  }

  private formatCondition(field: RetrievalFieldOption, operator: string, value: string, value2: string): string {
    const opLabel = this.translate.instant('RETRIEVAL.OPERATOR.' + operator);
    if (operator === 'BETWEEN') {
      return `(${field.label} ${opLabel} ${value} - ${value2})`;
    }
    return `(${field.label} ${opLabel} ${value})`;
  }

  /** Turns the flat, legacy-style token stream into the nested tree the backend expects — a group's children combine among themselves, then the group combines with its own siblings via its own conjunction. */
  private parseTokens(tokens: AccumulatorToken[]): RetrievalConditionNode {
    let pos = 0;

    const parseGroup = (): RetrievalConditionNode => {
      const children: RetrievalConditionNode[] = [];
      let nextConjunction: RetrievalConditionNode['conjunction'] = 'AND';

      while (pos < tokens.length) {
        const t = tokens[pos];
        if (t.kind === 'RPAREN') {
          pos++;
          break;
        }
        if (t.kind === 'AND' || t.kind === 'OR') {
          nextConjunction = t.kind;
          pos++;
          continue;
        }
        if (t.kind === 'LPAREN') {
          pos++;
          const child = parseGroup();
          child.conjunction = children.length ? nextConjunction : 'AND';
          children.push(child);
          continue;
        }
        // t.kind === 'CONDITION' — the only remaining case
        if (t.kind === 'CONDITION') {
          children.push({
            type: 'FIELD',
            conjunction: children.length ? nextConjunction : 'AND',
            fieldKey: t.fieldKey,
            operator: t.operator,
            value: t.value,
            value2: t.value2
          });
        }
        pos++;
      }

      return { type: 'GROUP', conjunction: 'AND', children };
    };

    return parseGroup();
  }
}
