import { Component, ElementRef, OnInit, ViewChild, inject, signal } from '@angular/core';
import { HttpErrorResponse } from '@angular/common/http';
import { Router } from '@angular/router';
import { CdkVirtualScrollViewport } from '@angular/cdk/scrolling';
import { TranslateService } from '@ngx-translate/core';
import { firstValueFrom } from 'rxjs';
import { AuthorCodingService } from '../services/author-coding.service';
import { AuthorCodingListState, AuthorCodingQuery, AuthorCodingRow } from '../models/author-coding.model';

/** Form8 mod_typ: "1" add, "2" edit, "3" search, "" never set since Form_Load. */
type ModType = '' | '1' | '2' | '3';
/** Form8 typ_serh: 1 idle, 2 prefix search pending (serh_auther1), 3 word search pending (serh_auther2). */
type SearchType = 1 | 2 | 3;

interface MessageBox { text: string; after?: () => void; }
interface InputBox { prompt: string; value: string; }

/**
 * "المؤلفين ودور النشر" — legacy Form8.frm, opened by ARCHIVE.frm menu التــرميــز → m10 (Ctrl+K).
 *
 * The screen keeps Form8's own state machine: mod_typ / typ_serh decide what Enter in the name
 * box, F10 on the list and تسجيل do, the معالجات panel (Shape3, Label6/7/8, desc) and the
 * number box (code) show and hide independently exactly where the legacy handlers toggle them,
 * and the list always shows the rows of the "current query" that AUTHER.Refresh re-runs.
 * SendKeys "{up}" after Esc / search / delete moves the list selection up one line.
 */
@Component({
  standalone: false,
  selector: 'app-author-coding',
  templateUrl: './author-coding.component.html',
  styleUrls: ['./author-coding.component.scss']
})
export class AuthorCodingComponent implements OnInit {

  private service = inject(AuthorCodingService);
  private translate = inject(TranslateService);
  private router = inject(Router);

  @ViewChild('listViewport') listViewport?: CdkVirtualScrollViewport;
  @ViewChild('listBox') listBox?: ElementRef<HTMLElement>;
  @ViewChild('descInput') descInput?: ElementRef<HTMLInputElement>;
  @ViewChild('saveBtn', { read: ElementRef }) saveBtn?: ElementRef<HTMLButtonElement>;
  @ViewChild('msgOkBtn', { read: ElementRef }) msgOkBtn?: ElementRef<HTMLButtonElement>;
  @ViewChild('inputBoxInput') inputBoxInput?: ElementRef<HTMLInputElement>;

  readonly itemSize = 30;

  rows = signal<AuthorCodingRow[]>([]);
  selectedIndex = signal<number | null>(null);
  loading = signal(false);

  /** Text1 — the AUT_NO of the row last selected in DBList1 (DBList1_Click). */
  selectedNumber = signal('');

  /** Shape3 + Label6 "معالجات" + Label7 "الرقم" + Label8 + desc — always toggled together. */
  panelVisible = signal(false);
  /** code — shown by اضافة/تعديل only, and left visible by a search (its hide line is commented out). */
  codeVisible = signal(false);
  /** code.Enabled — set False by تعديل and never set back while the form stays loaded. */
  codeEnabled = signal(true);
  codeText = signal('');
  descText = signal('');

  messageBox = signal<MessageBox | null>(null);
  inputBox = signal<InputBox | null>(null);

  private modType: ModType = '';
  private searchType: SearchType = 1;
  private currentQuery: AuthorCodingListState = { query: 'BY_NUMBER' };

  ngOnInit(): void {
    // Form_Load: typ_serh = 1; the MSRDC opens its RecordSource.
    this.searchType = 1;
    this.requery({ query: 'BY_NUMBER' });
  }

  // ─── Commands (شاشة الاوامر) ──────────────────────────────────────────

  /** Command1 "اضافة" */
  add(): void {
    this.modType = '1';
    this.descText.set('');
    this.codeVisible.set(true);
    this.panelVisible.set(true);
    // AUTHER.Resultset.MoveLast: the last row of whatever the list currently holds, + 1.
    const rows = this.rows();
    const last = rows.length ? rows[rows.length - 1] : null;
    if (last === null) {
      this.showMessage(this.t('AUTHORS.MSG_NO_CURRENT_RECORD'));
      return;
    }
    this.codeText.set(String((last.number ?? 0) + 1));
    this.focusDesc();
  }

  /** Command2 "تعديل" */
  edit(): void {
    this.modType = '2';
    const row = this.selectedRow();
    if (!row) {
      this.showMessage(this.t('AUTHORS.MSG_SELECT_ROW'));
      return;
    }
    this.codeText.set(this.formatNumber(row.number));
    this.descText.set(row.name ?? '');
    this.codeVisible.set(true);
    this.panelVisible.set(true);
    this.codeEnabled.set(false);
    this.focusDesc();
  }

  /** Command3 "تسجيل" */
  async save(): Promise<void> {
    if (this.modType === '1') {
      try {
        await firstValueFrom(this.service.insert(this.codeText(), this.descText()));
      } catch (e) {
        this.showError(e);
        return;
      }
      await this.requery({ query: 'BY_NUMBER' });
    } else if (this.modType === '2') {
      try {
        await firstValueFrom(this.service.updateName(Number(this.codeText()), this.descText()));
      } catch (e) {
        this.showError(e);
        return;
      }
      await this.requery(this.currentQuery);
    }
    this.hidePanel(true);
    this.focusList();
  }

  /** Command4 "الغاء" — InputBox("هل تريد الغاء المقالة(ن/ك)"), accepts "y" or "ن". */
  remove(): void {
    this.inputBox.set({ prompt: this.t('AUTHORS.DELETE_PROMPT'), value: '' });
    setTimeout(() => this.inputBoxInput?.nativeElement.focus());
  }

  async confirmInputBox(ok: boolean): Promise<void> {
    const box = this.inputBox();
    this.inputBox.set(null);
    // InputBox returns "" on Cancel.
    const answer = ok && box ? box.value : '';
    if (answer !== 'y' && answer !== 'ن') {
      return;
    }
    const row = this.selectedRow();
    if (!row || row.number === null) {
      this.showMessage(this.t('AUTHORS.MSG_SELECT_ROW'));
      return;
    }
    try {
      await firstValueFrom(this.service.delete(row.number));
    } catch (e) {
      this.showError(e);
      return;
    }
    await this.requery(this.currentQuery);
    this.focusList();
    this.moveSelectionUp();
  }

  /** Command5 "بحث (F10)" */
  openPrefixSearch(): void {
    this.modType = '3';
    this.panelVisible.set(true);
    this.focusDesc();
    this.searchType = 2;
    this.descText.set('');
  }

  /** Command7 "بحث كلمة" — note: legacy does not clear desc here. */
  openWordSearch(): void {
    this.panelVisible.set(true);
    this.searchType = 3;
    this.modType = '3';
    this.focusDesc();
  }

  /** Command6 "خــروج" — Unload Form8. */
  exit(): void {
    this.router.navigate(['/catalogue']);
  }

  // ─── DBList1 ─────────────────────────────────────────────────────────

  /** DBList1_Click */
  selectRow(index: number): void {
    const row = this.rows()[index];
    if (!row) return;
    this.selectedIndex.set(index);
    if (row.number !== null) {
      this.selectedNumber.set(this.formatNumber(row.number));
    }
  }

  onListKeydown(event: KeyboardEvent): void {
    const count = this.rows().length;
    const current = this.selectedIndex();
    const page = Math.max(1, Math.floor((this.listViewport?.getViewportSize() ?? 300) / this.itemSize) - 1);
    let next: number | null = null;
    switch (event.key) {
      case 'ArrowDown': next = current === null ? 0 : Math.min(count - 1, current + 1); break;
      case 'ArrowUp': next = current === null ? 0 : Math.max(0, current - 1); break;
      case 'PageDown': next = current === null ? 0 : Math.min(count - 1, current + page); break;
      case 'PageUp': next = current === null ? 0 : Math.max(0, current - page); break;
      case 'Home': next = 0; break;
      case 'End': next = count - 1; break;
      case 'Escape':
        event.preventDefault();
        // DBList1_KeyPress 27: back to the RecordSource only when a different SQL is loaded.
        if (this.currentQuery.query !== 'BY_NUMBER') {
          this.requery({ query: 'BY_NUMBER' });
        }
        return;
      case 'F10':
        event.preventDefault(); // the action itself runs on key-up, like DBList1_KeyUp
        return;
      default:
        return;
    }
    event.preventDefault();
    if (count > 0 && next !== null) {
      this.selectRow(next);
      this.scrollToSelection();
    }
  }

  /** DBList1_KeyUp vbKeyF10 */
  async onListKeyup(event: KeyboardEvent): Promise<void> {
    if (event.key !== 'F10') return;
    event.preventDefault();
    if (this.searchType === 1) {
      this.panelVisible.set(true);
      this.focusDesc();
      this.searchType = 2;
    } else if (this.searchType === 2) {
      await this.runSearch('PREFIX');
    }
  }

  // ─── desc / code ────────────────────────────────────────────────────

  /** desc_KeyPress */
  async onDescKeydown(event: KeyboardEvent): Promise<void> {
    if (event.key === 'Escape') {
      event.preventDefault();
      this.escapePanel();
    } else if (event.key === 'Enter') {
      event.preventDefault();
      if (this.modType === '3') {
        if (this.searchType === 2) {
          await this.runSearch('PREFIX');
        } else if (this.searchType === 3) {
          await this.runSearch('WORD');
        }
      } else {
        await this.checkDuplicateName();
      }
    }
  }

  /** code_KeyPress — only Esc is handled. */
  onCodeKeydown(event: KeyboardEvent): void {
    if (event.key === 'Escape') {
      event.preventDefault();
      this.escapePanel();
    }
  }

  // ─── Message boxes ──────────────────────────────────────────────────

  closeMessage(): void {
    const box = this.messageBox();
    this.messageBox.set(null);
    box?.after?.();
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

  // ─── Internals ──────────────────────────────────────────────────────

  /**
   * serh_auther1 / serh_auther2 with the untrimmed desc.Text, then typ_serh = 1 and the panel
   * hides — except the number box, whose hide line is commented out in every search branch.
   */
  private async runSearch(query: Extract<AuthorCodingQuery, 'PREFIX' | 'WORD'>): Promise<void> {
    await this.requery({ query, text: this.descText() });
    this.searchType = 1;
    this.panelVisible.set(false);
    this.focusList();
    this.moveSelectionUp();
  }

  /**
   * desc Enter outside search mode: serh_auther1 on Trim(desc) is loaded into the list; any row
   * → "هذا الاسم موجود سابقا...!!!"; either way the list becomes "select * from auther" and
   * focus goes to تسجيل.
   */
  private async checkDuplicateName(): Promise<void> {
    await this.requery({ query: 'PREFIX', text: this.descText().trim() });
    const exists = this.rows().length > 0;
    const finish = async () => {
      await this.requery({ query: 'UNORDERED' });
      this.saveBtn?.nativeElement.focus();
    };
    if (exists) {
      this.showMessage(this.t('AUTHORS.MSG_NAME_EXISTS'), finish);
    } else {
      await finish();
    }
  }

  /** Esc in desc/code: hide everything, focus the list, SendKeys "{up}". */
  private escapePanel(): void {
    this.hidePanel(true);
    this.focusList();
    this.moveSelectionUp();
  }

  private hidePanel(includingCode: boolean): void {
    this.panelVisible.set(false);
    if (includingCode) this.codeVisible.set(false);
  }

  /** AUTHER.sql = …; AUTHER.Refresh; DBList1.Refresh */
  private async requery(state: AuthorCodingListState): Promise<void> {
    this.currentQuery = state;
    this.loading.set(true);
    try {
      const res = await firstValueFrom(this.service.list(state));
      this.rows.set(res.data ?? []);
      this.selectedIndex.set(null);
    } catch (e) {
      this.showError(e);
    } finally {
      this.loading.set(false);
    }
  }

  /** SendKeys "{up}" into DBList1 — with nothing selected the first line becomes selected. */
  private moveSelectionUp(): void {
    if (!this.rows().length) return;
    const current = this.selectedIndex();
    this.selectRow(current === null ? 0 : Math.max(0, current - 1));
    this.scrollToSelection();
  }

  private scrollToSelection(): void {
    const index = this.selectedIndex();
    const viewport = this.listViewport;
    if (index === null || !viewport) return;
    const top = index * this.itemSize;
    const offset = viewport.measureScrollOffset('top');
    const height = viewport.getViewportSize();
    if (top < offset) {
      viewport.scrollToOffset(top);
    } else if (top + this.itemSize > offset + height) {
      viewport.scrollToOffset(top + this.itemSize - height);
    }
  }

  private selectedRow(): AuthorCodingRow | null {
    const index = this.selectedIndex();
    return index === null ? null : this.rows()[index] ?? null;
  }

  private focusDesc(): void {
    setTimeout(() => this.descInput?.nativeElement.focus());
  }

  private focusList(): void {
    setTimeout(() => this.listBox?.nativeElement.focus());
  }

  private showMessage(text: string, after?: () => void): void {
    this.messageBox.set({ text, after });
    setTimeout(() => this.msgOkBtn?.nativeElement.focus());
  }

  private showError(error: unknown): void {
    const message = error instanceof HttpErrorResponse ? error.error?.message : null;
    this.showMessage(message || this.t('APP.ERROR'));
  }

  formatNumber(value: number | null): string {
    return value === null ? '' : String(value);
  }

  activeDescendant(): string | null {
    const index = this.selectedIndex();
    return index === null ? null : `author-row-${index}`;
  }

  private t(key: string): string {
    return this.translate.instant(key);
  }
}
