import { Component, ElementRef, OnInit, ViewChild, inject, signal } from '@angular/core';
import { HttpErrorResponse } from '@angular/common/http';
import { MatDialogRef } from '@angular/material/dialog';
import { TranslateService } from '@ngx-translate/core';
import { firstValueFrom } from 'rxjs';
import { FormThesaurusService } from '../services/form-thesaurus.service';
import { AdditionalFileCriterion, AdditionalFileRow } from '../models/form-thesaurus.model';

/** One piece of crit1: the legacy SQL text it appended, and its condition (null = broken SQL). */
interface Token { sql: string; criterion: AdditionalFileCriterion | null; }
interface MessageBox { text: string; after?: () => void; }
type ColumnKey = 'fileNo' | 'finalFlag' | 'fileName' | 'remark' | 'place' | 'date' | 'userNo' | 'serial';

const BLANK_DATE = '__/__/____';
/** create proc tmp_result as SELECT DISTINCT … FROM dbo.tmp_fileadd (CRIT in tmp_file.frm). */
const CRIT = 'create proc tmp_result as SELECT DISTINCT  dbo.tmp_fileadd.tmp_fAD_no,dbo.tmp_fileadd.tmp_ser,'
  + 'dbo.tmp_fileadd.tmp_file_name,dbo.tmp_fileadd.tmp_rmrk,dbo.tmp_fileadd.tmp_mk,dbo.tmp_fileadd.tmp_user_no,'
  + 'dbo.tmp_fileadd.tmp_date,dbo.tmp_fileadd.tmp_final  FROM         dbo.tmp_fileadd ';

/** VB CDate on a dd/mm/yyyy text (Arabic locale), falling back to mm/dd when dd/mm is impossible. */
export function vbDate(text: string): Date | null {
  const m = /^\s*(\d{1,2})[/.-](\d{1,2})[/.-](\d{2}|\d{4})\s*$/.exec(text);
  if (!m) return null;
  let y = parseInt(m[3], 10);
  if (m[3].length === 2) y += y < 30 ? 2000 : 1900;
  const mk = (d: number, mo: number) => {
    const dt = new Date(y, mo - 1, d);
    return dt.getFullYear() === y && dt.getMonth() === mo - 1 && dt.getDate() === d ? dt : null;
  };
  const a = parseInt(m[1], 10), b = parseInt(m[2], 10);
  return mk(a, b) ?? mk(b, a);
}

const pad2 = (n: number) => String(n).padStart(2, '0');
const iso = (d: Date) => `${d.getFullYear()}-${pad2(d.getMonth() + 1)}-${pad2(d.getDate())}`;
const ddmmyyyy = (d: Date) => `${pad2(d.getDate())}/${pad2(d.getMonth() + 1)}/${d.getFullYear()}`;

/**
 * "ملفات اضافية للادخال" — legacy tmp_file.frm, shown (modeless) by coding.frm Command7.
 *
 * Every filled filter is appended once to crit1 and its box is disabled (qst1…qst6); النتيجة
 * appends the pending ones, shows the generated statement (MsgBox crit2) and reloads DataGrid1 with
 * "execute tmp_result". Form_Load and بحث جديد start from "الى تاريخ = today". DataGrid1 is editable
 * (AllowUpdate / AllowAddNew / AllowDelete) on tmp_fileadd and requeries after each cell edit.
 */
@Component({
  standalone: false,
  selector: 'app-additional-files',
  templateUrl: './additional-files.component.html',
  styleUrls: ['./additional-files.component.scss']
})
export class AdditionalFilesComponent implements OnInit {

  private api = inject(FormThesaurusService);
  private translate = inject(TranslateService);
  private dialogRef = inject(MatDialogRef<AdditionalFilesComponent>);

  @ViewChild('resultBtn', { read: ElementRef }) resultBtn?: ElementRef<HTMLButtonElement>;
  @ViewChild('msgOkBtn', { read: ElementRef }) msgOkBtn?: ElementRef<HTMLButtonElement>;
  @ViewChild('grid') grid?: ElementRef<HTMLElement>;
  @ViewChild('cellEditor') cellEditor?: ElementRef<HTMLInputElement>;

  readonly columns: { key: ColumnKey; label: string }[] = [
    { key: 'fileNo', label: 'رقم الملف' }, { key: 'finalFlag', label: 'منجز' }, { key: 'fileName', label: 'اسم الملف' },
    { key: 'remark', label: 'الشرح' }, { key: 'place', label: 'مكان الملف' }, { key: 'date', label: 'التاريخ' },
    { key: 'userNo', label: 'الموثق' }, { key: 'serial', label: 'المتسلسل' }
  ];

  // ─── criteria boxes ───
  fromDate = signal(BLANK_DATE);     // M_tmp_date (MaskEdBox ##/##/####)
  toDate = signal(BLANK_DATE);       // M_tmp_date1
  userNo = signal('');               // m_user_no "رقم المعد"
  word = signal('');                 // m_word "كلمة معينة"
  option = signal<'' | 'final' | 'notFinal'>('');   // Option1 "منجز" / Option2 "غيرمنجز"
  fromEnabled = signal(true);
  toEnabled = signal(true);
  userEnabled = signal(true);
  wordEnabled = signal(true);
  focused = signal<'' | 'from' | 'to'>('');

  // ─── DataGrid1 / f_tmp ───
  rows = signal<AdditionalFileRow[]>([]);
  current = signal<number | null>(null);      // the recordset's current record (▶)
  rowSelected = signal(false);                // the whole row picked with the record selector
  currentCol = signal<ColumnKey>('fileNo');
  editing = signal<{ row: number | 'new'; col: ColumnKey; value: string } | null>(null);
  newRow = signal<Record<string, string>>({});
  loading = signal(false);
  messageBox = signal<MessageBox | null>(null);

  private tokens: Token[] = [];
  private qst = { q1: 0, q2: 0, q3: 0, q4: 0, q5: 0, q6: 0 };
  private firstQst = 0;
  private lastCriteria: AdditionalFileCriterion[] | null = [];

  ngOnInit(): void {
    // Form_Load: M_tmp_date1 = today; crit1 = "( tmp_date <= today or null )"; execute tmp_result (no MsgBox)
    this.toDate.set(ddmmyyyy(new Date()));
    this.resetQuery();
    this.consumeTo(false);
    this.run();
  }

  // ═══ criteria (crit1) ═══

  private resetQuery(): void {
    this.qst = { q1: 0, q2: 0, q3: 0, q4: 0, q5: 0, q6: 0 };
    this.firstQst = 0;
    this.tokens = [];
  }

  /** If first_qst = 0 Then crit1 = " where " Else crit1 = crit1 & " and " … */
  private add(sql: string, criterion: AdditionalFileCriterion | null): void {
    this.firstQst = 1;
    this.tokens.push({ sql, criterion });
  }

  private crit1(): string {
    return this.tokens.map((t, i) => (i === 0 ? ' where ' : ' and ') + t.sql).join('');
  }

  /** ( tmp_DaTE <= convert(datetime,'yyyy-mm-dd',102) or tmp_date is null) */
  private consumeTo(trailingSpace: boolean): void {
    if (this.qst.q2 === 0 && this.toDate() !== BLANK_DATE) {
      this.qst.q2 = 1;
      const d = vbDate(this.toDate());
      const lit = d ? iso(d) : this.toDate();
      this.add(` ( tmp_DaTE <= convert(datetime,'${lit}',102) or tmp_date is null)${trailingSpace ? ' ' : ''}`,
        d && !lit.includes("'") ? { kind: 'TO', date: iso(d) } : null);
      this.toEnabled.set(false);
    }
  }

  private consumeFrom(field: 'tmp_DaTE' | 'tmp_date'): void {
    const d = vbDate(this.fromDate());
    const lit = d ? iso(d) : this.fromDate();
    this.add(` ( ${field} >= convert(datetime,'${lit}',102) or tmp_date is null)`, d ? { kind: 'FROM', date: iso(d) } : null);
    this.qst.q3 = 1;
    this.fromEnabled.set(false);
  }

  private consumeUser(): void {
    const t = this.userNo();
    this.qst.q1 = 1;
    this.add(`tmp_user_no = '${t}'`, t.includes("'") ? null : { kind: 'USER', text: t });
    this.userEnabled.set(false);
  }

  private consumeWord(): void {
    const t = this.word();
    this.qst.q6 = 1;
    this.add(`tmp_file_name + tmp_rmrk like '%${t}%'`, t.includes("'") ? null : { kind: 'WORD', text: t });
    this.wordEnabled.set(false);
  }

  // ═══ criteria box events ═══

  /** M_tmp_date_KeyPress 13 */
  onFromEnter(): void {
    if (this.fromDate() === BLANK_DATE) return;
    if (vbDate(this.fromDate())) {
      this.consumeFrom('tmp_date');
      this.focusResult();
    }
    // invalid date: legacy SetFocus on the disabled M_tmp_date1 (a VB runtime error) — focus stays
  }

  /** m_user_no_KeyPress 13 */
  onUserEnter(): void {
    if (this.userNo() === '') return;
    this.consumeUser();
    this.focusResult();
  }

  /** m_word_KeyPress 13 */
  onWordEnter(): void {
    if (this.word() === '') return;
    this.consumeWord();
    this.focusResult();
  }

  /** Option1_Click / Option2_Click — only when the option becomes selected. */
  selectOption(value: 'final' | 'notFinal'): void {
    if (this.option() === value) return;
    this.option.set(value);
    if (value === 'final') {
      this.qst.q4 = 1;
      this.add('tmp_final = 1', { kind: 'FINAL' });
    } else {
      this.qst.q5 = 1;
      this.add(' (tmp_final = 0 or tmp_final is null)', { kind: 'NOT_FINAL' });
    }
    this.focusResult();
  }

  // ═══ commands ═══

  /** Command1 "النتيجة" */
  result(): void {
    if (this.qst.q3 === 0 && this.fromDate() !== BLANK_DATE) this.consumeFrom('tmp_DaTE');
    this.consumeTo(true);
    if (this.qst.q1 === 0 && this.userNo() !== '') this.consumeUser();
    if (this.qst.q6 === 0 && this.word() !== '') this.consumeWord();
    if (this.firstQst > 0) {
      // MsgBox crit2 — legacy shows the generated statement before running it
      this.showMessage(CRIT + this.crit1() + ' order by tmp_ser desc ', () => this.run());
    } else {
      this.showMessage(this.t('FORM_THESAURUS.FILES.ASK_FIRST'));
    }
  }

  /** Command4 "بحث جديد" */
  newSearch(): void {
    this.toEnabled.set(true);
    this.fromEnabled.set(true);
    this.fromDate.set(BLANK_DATE);
    this.toDate.set(ddmmyyyy(new Date()));
    this.userEnabled.set(true);
    this.userNo.set('');
    this.word.set('');
    this.wordEnabled.set(true);
    this.option.set('');
    this.resetQuery();
    this.consumeTo(false);
    this.run();
  }

  /** Command6 "عدد العمليات" */
  count(): void {
    const n = this.rows().length;
    if (n === 0) {
      this.showMessage(this.t('FORM_THESAURUS.FILES.NONE'));
    } else {
      this.current.set(0);                         // f_tmp.Recordset.MoveFirst
      this.showMessage(this.t('FORM_THESAURUS.FILES.COUNT') + ' ' + n);
    }
  }

  /** Command5 "خروج" — Unload tmp_file. */
  close(): void {
    this.dialogRef.close();
  }

  // ═══ f_tmp navigation bar ═══

  move(to: 'first' | 'prev' | 'next' | 'last'): void {
    const n = this.rows().length;
    if (!n) return;
    const c = this.current() ?? 0;
    const next = to === 'first' ? 0 : to === 'last' ? n - 1 : to === 'prev' ? Math.max(0, c - 1) : Math.min(n - 1, c + 1);
    this.setCurrent(next);
  }

  // ═══ DataGrid1 ═══

  setCurrent(i: number, col?: ColumnKey): void {
    this.current.set(i);
    this.rowSelected.set(false);
    if (col) this.currentCol.set(col);
  }

  selectRow(i: number): void {
    this.current.set(i);
    this.rowSelected.set(true);
    this.grid?.nativeElement.focus();
  }

  cellText(row: AdditionalFileRow, col: ColumnKey): string {
    const v = row[col];
    if (v === null || v === undefined) return '';
    if (col === 'date') {
      const d = new Date(String(v));
      return isNaN(d.getTime()) ? String(v) : ddmmyyyy(d);
    }
    return String(v);
  }

  beginEdit(row: number | 'new', col: ColumnKey, initial?: string): void {
    const value = initial !== undefined ? initial
      : row === 'new' ? (this.newRow()[col] ?? '') : this.cellText(this.rows()[row], col);
    this.editing.set({ row, col, value });
    if (row !== 'new') this.setCurrent(row, col);
    setTimeout(() => this.cellEditor?.nativeElement.focus());
  }

  async commitEdit(): Promise<void> {
    const e = this.editing();
    if (!e) return;
    this.editing.set(null);
    try {
      if (e.row === 'new') {
        // AllowAddNew: the pending new record is written by the AfterColEdit Requery
        const values = { ...this.newRow(), [e.col]: e.value };
        this.newRow.set(values);
        await firstValueFrom(this.api.insertAdditionalFile(values));
        this.newRow.set({});
      } else {
        const original = this.rows()[e.row];
        if (this.cellText(original, e.col) === e.value) return;
        await firstValueFrom(this.api.updateAdditionalFile(original, e.col, e.value));
      }
    } catch (err) {
      this.handleError(err);
      return;
    }
    // DataGrid1_AfterColEdit: m_row = Bookmark - 1; Requery; Move m_row
    const keep = e.row === 'new' ? this.rows().length : e.row;
    await this.run();
    if (this.rows().length) this.setCurrent(Math.min(keep, this.rows().length - 1));
    this.grid?.nativeElement.focus();
  }

  cancelEdit(): void {
    this.editing.set(null);
    this.grid?.nativeElement.focus();
  }

  onEditorKeydown(e: KeyboardEvent): void {
    if (e.key === 'Enter' || e.key === 'Tab') { e.preventDefault(); this.commitEdit(); }
    else if (e.key === 'Escape') { e.preventDefault(); this.cancelEdit(); }
  }

  onGridKeydown(e: KeyboardEvent): void {
    if (this.editing()) return;
    const n = this.rows().length;
    const c = this.current();
    const ci = this.columns.findIndex(x => x.key === this.currentCol());
    switch (e.key) {
      case 'ArrowDown': e.preventDefault(); if (n) this.setCurrent(c === null ? 0 : Math.min(n - 1, c + 1)); return;
      case 'ArrowUp': e.preventDefault(); if (n) this.setCurrent(c === null ? 0 : Math.max(0, c - 1)); return;
      case 'ArrowLeft': e.preventDefault(); if (ci < this.columns.length - 1) this.currentCol.set(this.columns[ci + 1].key); return;
      case 'ArrowRight': e.preventDefault(); if (ci > 0) this.currentCol.set(this.columns[ci - 1].key); return;
      case 'Home': e.preventDefault(); if (n) this.setCurrent(0); return;
      case 'End': e.preventDefault(); if (n) this.setCurrent(n - 1); return;
      case 'F2': e.preventDefault(); if (c !== null) this.beginEdit(c, this.currentCol()); return;
      case 'Insert': case 'Delete': case 'F12': e.preventDefault(); return;   // DataGrid1_KeyUp
    }
    if (e.key.length === 1 && !e.ctrlKey && !e.altKey && c !== null) {
      e.preventDefault();
      this.beginEdit(c, this.currentCol(), e.key);   // typing starts editing the current cell
    }
  }

  /** DataGrid1_KeyUp */
  async onGridKeyup(e: KeyboardEvent): Promise<void> {
    if (this.editing()) return;
    if (e.key === 'Insert') {
      // execute op_tmp Form2.Text1, box_user_no, today — Form2 (التحليل) holds no document here
      try {
        await firstValueFrom(this.api.opTmp(''));
      } catch (err) {
        this.handleError(err);
      }
      await this.run();
    } else if (e.key === 'Delete') {
      if (!this.rows().length) return;
      const i = this.current();
      if (this.rowSelected() && i !== null) {
        // AllowDelete: the selected record is deleted by the grid (del_tmp itself is commented out)
        try {
          await firstValueFrom(this.api.deleteAdditionalFile(this.rows()[i]));
        } catch (err) {
          this.handleError(err);
        }
      }
      await this.run();
    } else if (e.key === 'F12') {
      this.openDocument();
    }
  }

  /** datagrid1_DblClick / F12: m_bk_no = Columns(0); Form6 (استمارة التوثيق) shows that main record. */
  openDocument(): void {
    const i = this.current();
    if (i === null || !this.rows()[i]) return;
    const appNo = this.rows()[i].fileNo ?? '';
    window.open('/catalogue/new?appNo=' + encodeURIComponent(appNo), '_blank');
  }

  // ═══ MaskEdBox ##/##/#### ═══

  onMaskKeydown(which: 'from', e: KeyboardEvent): void {
    const slots = [0, 1, 3, 4, 6, 7, 8, 9];
    const cur = this.fromDate().split('');
    if (/^\d$/.test(e.key)) {
      e.preventDefault();
      const free = slots.find(s => cur[s] === '_');
      if (free !== undefined) { cur[free] = e.key; this.fromDate.set(cur.join('')); }
    } else if (e.key === 'Backspace') {
      e.preventDefault();
      const filled = [...slots].reverse().find(s => cur[s] !== '_');
      if (filled !== undefined) { cur[filled] = '_'; this.fromDate.set(cur.join('')); }
    } else if (e.key === 'Enter') {
      e.preventDefault();
      this.onFromEnter();
    } else if (e.key.length === 1) {
      e.preventDefault();
    }
  }

  /** MaskEdBox Format "dd/mm/yy" applies when the box does not have the focus. */
  shownDate(which: 'from' | 'to'): string {
    const text = which === 'from' ? this.fromDate() : this.toDate();
    if (this.focused() === which) return text;
    const d = vbDate(text);
    return d && !text.includes('_') ? `${pad2(d.getDate())}/${pad2(d.getMonth() + 1)}/${String(d.getFullYear()).slice(-2)}` : text;
  }

  // ═══ internals ═══

  /** f_tmp.RecordSource = "execute tmp_result"; Refresh. */
  private async run(): Promise<void> {
    const criteria = this.tokens.map(t => t.criterion);
    this.loading.set(true);
    try {
      if (criteria.some(c => c === null)) {
        // the generated procedure does not compile: drop proc succeeded, create/execute fail
        this.rows.set([]);
        this.current.set(null);
        this.showMessage(this.t('FORM_THESAURUS.FILES.QUERY_FAILED'));
        return;
      }
      this.lastCriteria = criteria as AdditionalFileCriterion[];
      const res = await firstValueFrom(this.api.searchAdditionalFiles(this.lastCriteria));
      this.rows.set(res.data ?? []);
      this.current.set(this.rows().length ? 0 : null);
      this.rowSelected.set(false);
    } catch (err) {
      this.handleError(err);
    } finally {
      this.loading.set(false);
    }
  }

  private focusResult(): void {
    setTimeout(() => this.resultBtn?.nativeElement.focus());
  }

  private showMessage(text: string, after?: () => void): void {
    this.messageBox.set({ text, after });
    const tryFocus = (n: number) => {
      const el = this.msgOkBtn?.nativeElement;
      if (el?.isConnected) el.focus(); else if (n < 30) requestAnimationFrame(() => tryFocus(n + 1));
    };
    setTimeout(() => tryFocus(0));
  }

  closeMessage(): void {
    const box = this.messageBox();
    this.messageBox.set(null);
    box?.after?.();
  }

  private handleError(err: unknown): void {
    const message = err instanceof HttpErrorResponse ? err.error?.message : null;
    this.showMessage(message || this.t('APP.ERROR'));
  }

  private t(key: string): string {
    return this.translate.instant(key);
  }
}
