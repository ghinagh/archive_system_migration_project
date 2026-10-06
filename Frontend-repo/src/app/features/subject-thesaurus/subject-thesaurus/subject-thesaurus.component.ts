import { Component, ElementRef, OnDestroy, OnInit, ViewChild, inject, signal } from '@angular/core';
import { HttpErrorResponse } from '@angular/common/http';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { firstValueFrom } from 'rxjs';
import { SubjectThesaurusService } from '../services/subject-thesaurus.service';
import { SubjectThesaurusAccessService } from '../../../core/services/subject-thesaurus-access.service';
import { ThesaurusQuery, ThesaurusTerm } from '../models/subject-thesaurus.model';
import { ThesaurusListComponent } from '../thesaurus-list/thesaurus-list.component';

/** Form5 mod_typ: "0" since Form_Load, "1" add on level 1/2, "2" edit or level-3 add. */
type ModType = '0' | '1' | '2';
/** Form5 typ_serh: 1 idle, 2 prefix search pending (serh_macnz), 3 word search pending (serh_wrdmacnz). */
type SearchType = 1 | 2 | 3;
type Level = 1 | 2 | 3;

interface ListState {
  rows: ThesaurusTerm[];
  selected: number | null;
  query: ThesaurusQuery;
  loading: boolean;
}

interface MessageBox { text: string; }
interface InputBox { prompt: string; value: string; }

/**
 * "المكنز الموضوعي" — legacy Form5.frm ("مكنز الموضوعات"), opened from ARCHIVE.frm menu
 * التــرميــز → m6 (Ctrl+A) after the Frame3 key (see subjectThesaurusAccessGuard).
 *
 * Three DataLists drill down MACNZ level 1 → 2 → 3. The "active" list is the first enabled one
 * (DataList1, else DataList2, else DataList3) — every command works on it. mod_typ / typ_serh are
 * kept exactly as Form5 keeps them, so تسجيل / بحث / Enter in the description box do what the
 * legacy handlers do in the same state. SendKeys "{up}" moves the selection up one line (with
 * nothing selected it selects the first line).
 */
@Component({
  standalone: false,
  selector: 'app-subject-thesaurus',
  templateUrl: './subject-thesaurus.component.html',
  styleUrls: ['./subject-thesaurus.component.scss']
})
export class SubjectThesaurusComponent implements OnInit, OnDestroy {

  private service = inject(SubjectThesaurusService);
  private access = inject(SubjectThesaurusAccessService);
  private translate = inject(TranslateService);
  private router = inject(Router);

  @ViewChild('list1') list1Ref?: ThesaurusListComponent;
  @ViewChild('list2') list2Ref?: ThesaurusListComponent;
  @ViewChild('list3') list3Ref?: ThesaurusListComponent;
  @ViewChild('codeInput') codeInput?: ElementRef<HTMLInputElement>;
  @ViewChild('descInput') descInput?: ElementRef<HTMLInputElement>;
  @ViewChild('saveBtn', { read: ElementRef }) saveBtn?: ElementRef<HTMLButtonElement>;
  @ViewChild('searchBtn', { read: ElementRef }) searchBtn?: ElementRef<HTMLButtonElement>;
  @ViewChild('msgOkBtn', { read: ElementRef }) msgOkBtn?: ElementRef<HTMLButtonElement>;
  @ViewChild('inputBoxInput') inputBoxInput?: ElementRef<HTMLInputElement>;

  /** macnz1 / macnz2 / macnz3 with DataList1/2/3. */
  lists = [
    signal<ListState>({ rows: [], selected: null, query: { query: 'LEVEL1' }, loading: false }),
    signal<ListState>({ rows: [], selected: null, query: { query: 'LEVEL1' }, loading: false }),
    signal<ListState>({ rows: [], selected: null, query: { query: 'LEVEL1' }, loading: false })
  ];

  /** DataList2 + Label3 + Line2 + Text2 / DataList3 + Label4 + Line1 + Text3 — toggled together. */
  list2Visible = signal(false);
  list3Visible = signal(false);
  list1Enabled = signal(true);
  list2Enabled = signal(true);

  /** Text1/2/3 — sub_code of the row last clicked in each list (datalistN_Click). */
  codes = [signal(''), signal(''), signal('')];

  /** Shape3 + Label6 "معالجات" + Label7 "الرمز" + Label8 "الواصفة" + desc. */
  panelVisible = signal(false);
  /** code — shown by اضافة/تعديل, hidden by تسجيل/Esc, left alone by a search. */
  codeVisible = signal(false);
  /** code.Enabled — set False by تعديل and the level-3 add, never set back while Form5 is loaded. */
  codeEnabled = signal(true);
  codeMaxLength = signal(9);
  codeText = signal('');
  descText = signal('');

  /** box_user_no = "244". */
  canWrite = signal(false);

  messageBox = signal<MessageBox | null>(null);
  inputBox = signal<InputBox | null>(null);

  private modType: ModType = '0';
  private searchType: SearchType = 1;
  private requestSeq = [0, 0, 0];

  async ngOnInit(): Promise<void> {
    // Form_Load: mod_typ = "0"; typ_serh = 1; macnz1.RecordSource = "execute proc_macnz1".
    this.modType = '0';
    this.searchType = 1;
    try {
      const ctx = await firstValueFrom(this.service.context());
      this.canWrite.set(!!ctx.data?.canWrite);
    } catch (e) {
      this.handleError(e);
      return;
    }
    await this.requery(1, { query: 'LEVEL1' });
    // The first control in Form5's tab order is بحث (Command5, TabIndex 4).
    setTimeout(() => this.searchBtn?.nativeElement.focus());
  }

  ngOnDestroy(): void {
    this.access.release();
  }

  // ─── Commands (شاشة الاوامر) ──────────────────────────────────────────

  /** Command1 "اضافة (insert)" */
  async add(): Promise<void> {
    if (!this.canWrite()) return;
    this.modType = '1';
    this.codeVisible.set(true);
    this.panelVisible.set(true);
    const level = this.activeLevel();
    this.codeText.set('');
    this.descText.set('');
    if (level === 1) {
      this.codeMaxLength.set(9);
    } else if (level === 2) {
      this.codeMaxLength.set(7);
    } else {
      this.codeMaxLength.set(9);
      this.modType = '2';
      // m_sub = Mid(macnz2.Recordset![sub_code], 1, 6); EXECUTE OP_macnz; max_macnz; code = m_sub + max1
      const parent = this.selectedRow(2);
      if (!parent) {
        this.showMessage(this.t('SUBJECT_THESAURUS.MSG_SELECT_ROW'));
        return;
      }
      try {
        const res = await firstValueFrom(this.service.openLevelThree(parent.code ?? ''));
        this.codeText.set(res.data.code);
      } catch (e) {
        this.handleError(e);
        return;
      }
      this.codeEnabled.set(false);
      this.descText.set('');
      this.focusDesc();
      return;
    }
    this.focusCodeOrDesc();
  }

  /** Command2 "تعديل (F2)" — no user check in legacy; تسجيل is what is gated. */
  edit(): void {
    this.modType = '2';
    const row = this.selectedRow(this.activeLevel());
    if (!row) {
      this.showMessage(this.t('SUBJECT_THESAURUS.MSG_SELECT_ROW'));
      return;
    }
    this.codeText.set(row.code ?? '');
    this.descText.set(row.description ?? '');
    this.codeVisible.set(true);
    this.panelVisible.set(true);
    this.codeEnabled.set(false);
    this.focusDesc();
  }

  /** Command3 "تسجيل" */
  async save(): Promise<void> {
    if (!this.canWrite()) return;
    const level = this.activeLevel();
    if (this.modType === '1') {
      // insr_macnz desc, m_code, m_leve — then div_word(m_code, desc, "1") on the server.
      let code: string;
      let wordCode: string;
      if (level === 1) {
        code = this.codeText();
        wordCode = ''; // Command3 never assigns m_code on the first level.
      } else {
        // Level 2: Mid(macnz2 sub_code, 1, 2) + code; level 3: Mid(macnz3 sub_code, 1, 6) + code.
        let source = this.selectedRow(level)?.code;
        const query = this.lists[level - 1]().query;
        if (source == null && level === 2 && query.query === 'CHILDREN') {
          // Legacy stops with a runtime error on an empty DataList2; every row proc_macnz puts
          // there shares the parent's first two characters, so use them for the first child.
          source = query.parentCode;
        }
        if (source == null) {
          this.showMessage(this.t('SUBJECT_THESAURUS.MSG_SELECT_ROW'));
          return;
        }
        code = source.substring(0, level === 2 ? 2 : 6) + this.codeText();
        wordCode = code;
      }
      try {
        await firstValueFrom(this.service.insert(code, this.descText(), String(level), wordCode));
      } catch (e) {
        this.handleError(e);
        return;
      }
      await this.requery(level, this.lists[level - 1]().query);
      this.focusList(level);
      this.moveSelectionUp(level);
      this.hidePanel(true);
    } else if (this.modType === '2') {
      try {
        await firstValueFrom(this.service.update(this.codeText(), this.descText()));
      } catch (e) {
        this.handleError(e);
        return;
      }
      await this.requery(level, this.lists[level - 1]().query);
      this.focusList(level);
      this.moveSelectionUp(level);
      this.hidePanel(true);
    }
  }

  /** Command4 "الغاء (Delete)" — InputBox("هل تريد الغاء المقالة(ن/ك)"), only "y" or "ن" deletes. */
  remove(): void {
    if (!this.canWrite()) return;
    this.inputBox.set({ prompt: this.t('SUBJECT_THESAURUS.DELETE_PROMPT'), value: '' });
    setTimeout(() => this.inputBoxInput?.nativeElement.focus());
  }

  async confirmInputBox(ok: boolean): Promise<void> {
    const box = this.inputBox();
    this.inputBox.set(null);
    const answer = ok && box ? box.value : ''; // InputBox returns "" on Cancel.
    if (answer !== 'y' && answer !== 'ن') {
      return;
    }
    const level = this.activeLevel();
    const row = this.selectedRow(level);
    if (!row) {
      this.showMessage(this.t('SUBJECT_THESAURUS.MSG_SELECT_ROW'));
      return;
    }
    try {
      await firstValueFrom(this.service.delete(row.code ?? ''));
    } catch (e) {
      this.handleError(e);
      return;
    }
    await this.requery(level, this.lists[level - 1]().query);
    this.focusList(level);
    this.moveSelectionUp(level);
  }

  /** Command5 "بحث (F10)": first click opens the description box, the second runs serh_macnz. */
  async search(): Promise<void> {
    if (this.searchType === 1) {
      this.panelVisible.set(true);
      this.focusDesc();
      this.searchType = 2;
    } else if (this.searchType === 2) {
      await this.runPrefixSearch();
    }
  }

  /** Command6 "خروج" — Unload Form5. */
  exit(): void {
    this.router.navigate(['/']);
  }

  // ─── DataLists ──────────────────────────────────────────────────────

  /** datalistN_Click */
  selectRow(level: Level, index: number): void {
    const list = this.lists[level - 1];
    const row = list().rows[index];
    if (!row) return;
    list.update(s => ({ ...s, selected: index }));
    this.codes[level - 1].set(row.code ?? '');
    this.listRef(level)?.scrollToIndex(index);
  }

  /** datalist1_DblClick / datalist2_DblClick (and Enter in datalist1/2_KeyPress). */
  async drillDown(level: Level, index?: number): Promise<void> {
    if (index !== undefined) this.selectRow(level, index);
    const row = this.selectedRow(level);
    if (!row || level === 3) return;
    const child = (level + 1) as 2 | 3;
    await this.requery(child, { query: 'CHILDREN', level: child === 2 ? '2' : '3', parentCode: row.code ?? '' });
    if (child === 2) {
      this.list2Visible.set(true);
      this.list1Enabled.set(false);
    } else {
      this.list3Visible.set(true);
      this.list2Enabled.set(false);
    }
    this.focusList(child);
    this.moveSelectionUp(child);
  }

  /** datalist1_GotFocus: SendKeys "{up}" — applied when focus arrives by code or Tab, not by a click. */
  onListFocus(level: Level, byMouse: boolean): void {
    if (level === 1 && !byMouse) {
      this.moveSelectionUp(1);
    }
  }

  /** datalistN_KeyDown (F2 / F8 / F9) and datalistN_KeyPress (Enter / Esc). */
  async onListKeydown(level: Level, event: KeyboardEvent): Promise<void> {
    switch (event.key) {
      case 'F2':
        event.preventDefault();
        this.edit();
        return;
      case 'F8':
        event.preventDefault();
        this.openSearch(level, 2);
        return;
      case 'F9':
        event.preventDefault();
        this.openSearch(level, 3);
        return;
      case 'Insert':
      case 'Delete':
        event.preventDefault(); // acted on at key-up, like datalistN_KeyUp
        return;
      case 'Enter':
        event.preventDefault();
        if (level !== 3) await this.drillDown(level);
        return;
      case 'Escape':
        event.preventDefault();
        await this.escapeList(level);
        return;
    }
  }

  /** datalistN_KeyUp: Insert → Command1, Delete → Command4. */
  async onListKeyup(event: KeyboardEvent): Promise<void> {
    if (event.key === 'Insert') {
      event.preventDefault();
      await this.add();
    } else if (event.key === 'Delete') {
      event.preventDefault();
      this.remove();
    }
  }

  // ─── code / desc ───────────────────────────────────────────────────

  /** code_KeyPress: Esc hides the panel, Enter moves to desc. */
  onCodeKeydown(event: KeyboardEvent): void {
    if (event.key === 'Escape') {
      event.preventDefault();
      this.escapePanel();
    } else if (event.key === 'Enter') {
      event.preventDefault();
      this.focusDesc();
    }
  }

  /** desc_KeyPress */
  async onDescKeydown(event: KeyboardEvent): Promise<void> {
    if (event.key === 'Escape') {
      event.preventDefault();
      this.escapePanel();
    } else if (event.key === 'Enter') {
      event.preventDefault();
      if (this.searchType === 2) {
        await this.runPrefixSearch();
      } else if (this.searchType === 3) {
        await this.runWordSearch();
      } else {
        this.saveBtn?.nativeElement.focus(); // Command3.SetFocus — a second Enter saves.
      }
    }
  }

  // ─── Message boxes ─────────────────────────────────────────────────

  closeMessage(): void {
    this.messageBox.set(null);
  }

  onInputBoxKeydown(event: KeyboardEvent): void {
    if (event.key === 'Enter') {
      event.preventDefault();
      this.confirmInputBox(true);
    } else if (event.key === 'Escape') {
      event.preventDefault();
      this.confirmInputBox(false);
    }
  }

  // ─── Internals ─────────────────────────────────────────────────────

  /** DataList1.Enabled → 1, DataList2.Enabled → 2, else 3 — the order every Form5 handler tests. */
  activeLevel(): Level {
    if (this.list1Enabled()) return 1;
    if (this.list2Enabled()) return 2;
    return 3;
  }

  /** F8 / F9 on a list: the description box opens; on DataList3 it is also cleared. */
  private openSearch(level: Level, type: 2 | 3): void {
    this.panelVisible.set(true);
    if (level === 3) this.descText.set('');
    this.focusDesc();
    this.searchType = type;
  }

  /** serh_macnz into the active list; typ_serh = 1; the panel hides but code keeps its visibility. */
  private async runPrefixSearch(): Promise<void> {
    const level = this.activeLevel();
    await this.requery(level, { query: 'PREFIX', text: this.descText() });
    this.searchType = 1;
    this.panelVisible.set(false);
    this.focusList(level);
  }

  /**
   * serh_wrdmacnz always goes to macnz3 / DataList3 — whichever list is active. When DataList3 is
   * hidden its SetFocus fails silently (On Error Resume Next) and nothing visible changes.
   */
  private async runWordSearch(): Promise<void> {
    await this.requery(3, { query: 'WORD', text: this.descText() });
    if (this.list3Visible()) {
      this.focusList(3);
      this.moveSelectionUp(3);
    }
    this.searchType = 1;
    this.panelVisible.set(false);
  }

  /** datalist1 Esc: proc_macnz1 again; datalist2/3 Esc: back to the previous level. */
  private async escapeList(level: Level): Promise<void> {
    if (level === 1) {
      await this.requery(1, { query: 'LEVEL1' });
      this.moveSelectionUp(1);
    } else if (level === 2) {
      this.list1Enabled.set(true);
      this.list2Visible.set(false);
      this.focusList(1);
    } else {
      this.list2Enabled.set(true);
      this.list3Visible.set(false);
      this.focusList(2);
    }
  }

  /** Esc in desc/code: hide the panel and the code box, focus the active list, SendKeys "{up}". */
  private escapePanel(): void {
    this.hidePanel(true);
    const level = this.activeLevel();
    this.focusList(level);
    this.moveSelectionUp(level);
  }

  private hidePanel(includingCode: boolean): void {
    this.panelVisible.set(false);
    if (includingCode) this.codeVisible.set(false);
  }

  /** macnzN.RecordSource = …; macnzN.Refresh; DataListN.Refresh */
  private async requery(level: Level, query: ThesaurusQuery): Promise<void> {
    const list = this.lists[level - 1];
    // Legacy Refresh was synchronous: only the latest RecordSource of a list may land in it.
    const seq = ++this.requestSeq[level - 1];
    list.update(s => ({ ...s, query, loading: true }));
    try {
      const res = await firstValueFrom(this.service.list(query));
      if (seq !== this.requestSeq[level - 1]) return;
      list.set({ rows: res.data ?? [], selected: null, query, loading: false });
    } catch (e) {
      if (seq !== this.requestSeq[level - 1]) return;
      list.update(s => ({ ...s, loading: false }));
      this.handleError(e);
    }
  }

  /** SendKeys "{up}" — with nothing selected the first line becomes selected. */
  private moveSelectionUp(level: Level): void {
    const state = this.lists[level - 1]();
    if (!state.rows.length) return;
    this.selectRow(level, state.selected === null ? 0 : Math.max(0, state.selected - 1));
  }

  /** DataListN.SetFocus — raises datalist1_GotFocus only when focus actually moves. */
  private focusList(level: Level): void {
    const ref = this.listRef(level);
    if (!ref || ref.hasFocus()) return;
    setTimeout(() => ref.focus());
  }

  private listRef(level: Level): ThesaurusListComponent | undefined {
    return level === 1 ? this.list1Ref : level === 2 ? this.list2Ref : this.list3Ref;
  }

  private selectedRow(level: Level): ThesaurusTerm | null {
    const state = this.lists[level - 1]();
    return state.selected === null ? null : state.rows[state.selected] ?? null;
  }

  private focusDesc(): void {
    setTimeout(() => this.descInput?.nativeElement.focus());
  }

  private focusCodeOrDesc(): void {
    setTimeout(() => {
      if (this.codeEnabled()) this.codeInput?.nativeElement.focus();
      else this.descInput?.nativeElement.focus();
    });
  }

  private showMessage(text: string): void {
    this.messageBox.set({ text });
    setTimeout(() => this.msgOkBtn?.nativeElement.focus());
  }

  /** A 403 means the key grant is gone (expired / server restart): the screen closes like Unload. */
  private handleError(error: unknown): void {
    if (error instanceof HttpErrorResponse && error.status === 403 && !this.access.hasAccess()) {
      this.router.navigate(['/']);
      return;
    }
    if (error instanceof HttpErrorResponse && error.status === 403 && /كلمة السر/.test(error.error?.message ?? '')) {
      this.router.navigate(['/']);
      return;
    }
    const message = error instanceof HttpErrorResponse ? error.error?.message : null;
    this.showMessage(message || this.t('APP.ERROR'));
  }

  private t(key: string): string {
    return this.translate.instant(key);
  }
}
