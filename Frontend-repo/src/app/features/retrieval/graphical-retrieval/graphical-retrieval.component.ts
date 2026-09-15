import { Component, DestroyRef, inject, signal, computed } from '@angular/core';
import { FormControl } from '@angular/forms';
import { Router } from '@angular/router';
import { debounceTime, distinctUntilChanged, switchMap, catchError, of } from 'rxjs';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { RetrievalService } from '../services/retrieval.service';
import { AccumulatorToken, RetrievalConditionNode, RetrievalFieldOption } from '../models/retrieval.model';

/**
 * Migrated equivalent of the legacy sort_from.frm ("الاسترجاع البياني لبنك المعلومات"):
 * a metadata-driven cross-domain query builder covering the catalogue, article,
 * periodical, author and thesaurus fields. The accumulator textbox and AND/OR/( / )
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
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);
  private destroyRef = inject(DestroyRef);

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

  displayFields = signal<RetrievalFieldOption[]>([]);

  tokens = signal<AccumulatorToken[]>([]);

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
  canAddConjunction = computed(() => this.lastTokenKind() === 'CONDITION' || this.lastTokenKind() === 'RPAREN');
  canOpenGroup = computed(() => {
    const last = this.lastTokenKind();
    return last === null || last === 'AND' || last === 'OR' || last === 'LPAREN';
  });
  canCloseGroup = computed(() => {
    const last = this.lastTokenKind();
    return this.openParens() > 0 && (last === 'CONDITION' || last === 'RPAREN');
  });

  constructor() {
    this.retrievalService.getFields().subscribe({ next: r => this.fields.set(r.data) });

    this.lookupControl.valueChanges.pipe(
      debounceTime(250),
      distinctUntilChanged(),
      switchMap(term => {
        const field = this.selectedField();
        if (!field?.lookupEnabled) {
          return of(null);
        }
        return this.retrievalService.lookupValues(field.fieldKey, term ?? undefined).pipe(
          catchError(() => of(null))
        );
      }),
      takeUntilDestroyed(this.destroyRef)
    ).subscribe(response => this.lookupResults.set(response?.data ?? []));
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
    this.operator.set(field.fieldType === 'STRING' ? this.searchMode() : 'EQUALS');
  }

  onSearchModeChange(mode: 'STARTS_WITH' | 'CONTAINS'): void {
    this.searchMode.set(mode);
    if (this.selectedField()?.fieldType === 'STRING') {
      this.operator.set(mode);
    }
  }

  pickLookupValue(val: string): void {
    this.value.set(val);
  }

  toggleDisplayField(field: RetrievalFieldOption): void {
    const current = this.displayFields();
    const exists = current.some(f => f.fieldKey === field.fieldKey);
    this.displayFields.set(exists ? current.filter(f => f.fieldKey !== field.fieldKey) : [...current, field]);
  }

  isDisplayField(field: RetrievalFieldOption): boolean {
    return this.displayFields().some(f => f.fieldKey === field.fieldKey);
  }

  markCategoryForDisplay(): void {
    const cat = this.selectedCategory();
    if (!cat) {
      return;
    }
    const merged = [...this.displayFields()];
    for (const f of this.fields().filter(x => x.category === cat)) {
      if (!merged.some(m => m.fieldKey === f.fieldKey)) {
        merged.push(f);
      }
    }
    this.displayFields.set(merged);
  }

  addCondition(): void {
    const field = this.selectedField();
    if (!field) {
      this.snackBar.open(this.translate.instant('RETRIEVAL.SELECT_FIELD_FIRST'), '', { duration: 3000 });
      return;
    }
    if (!this.value().trim()) {
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
      value: this.value(),
      value2: opValue === 'BETWEEN' ? this.value2() : undefined
    }]);

    this.value.set('');
    this.value2.set('');
    this.lookupControl.setValue('');
  }

  addAnd(): void {
    if (!this.canAddConjunction()) {
      return;
    }
    this.tokens.update(t => [...t, { kind: 'AND' }]);
  }

  addOr(): void {
    if (!this.canAddConjunction()) {
      return;
    }
    this.tokens.update(t => [...t, { kind: 'OR' }]);
  }

  addLeftParen(): void {
    if (!this.canOpenGroup()) {
      return;
    }
    this.tokens.update(t => [...t, { kind: 'LPAREN' }]);
  }

  addRightParen(): void {
    if (!this.canCloseGroup()) {
      return;
    }
    this.tokens.update(t => [...t, { kind: 'RPAREN' }]);
  }

  clearAll(): void {
    this.tokens.set([]);
  }

  close(): void {
    this.router.navigate(['/catalogue']);
  }

  runSearch(): void {
    if (this.openParens() !== 0) {
      this.snackBar.open(this.translate.instant('RETRIEVAL.UNBALANCED_PARENS'), '', { duration: 3000 });
      return;
    }
    if (this.displayFields().length === 0) {
      this.snackBar.open(this.translate.instant('RETRIEVAL.SELECT_DISPLAY_FIELDS'), '', { duration: 3000 });
      return;
    }

    const rootCondition = this.tokens().length ? this.parseTokens(this.tokens()) : null;
    this.retrievalService.pendingSearch.set({
      rootCondition,
      outputFieldKeys: this.displayFields().map(f => f.fieldKey),
      page: 0,
      size: 25
    });
    this.router.navigate(['/retrieval/results']);
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
