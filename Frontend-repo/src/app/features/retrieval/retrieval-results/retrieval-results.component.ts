import { Component, OnInit, inject, signal, computed } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { firstValueFrom, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { RetrievalService } from '../services/retrieval.service';
import { RETRIEVAL_SCOPE_SCREENS, RetrievalColumn, RetrievalResultRow, RetrievalScope, RetrievalSearchRequest } from '../models/retrieval.model';
import { SearchScreenService } from '../../catalogue/unified-search/search-screen.service';
import { ArchiveSearchService } from '../../archive-search/services/archive-search.service';
import { DigitizationService } from '../../digitization/services/digitization.service';
import { VIDEO_ORDER_PRELOAD_STATE, VideoOrderPreload } from '../../digitization/models/digitization.model';
import { AutocompleteService, CodingOption } from '../../../core/services/autocomplete.service';

/** frm_result datagrid1_DblClick (:1432-1499) opens these through OpenDoc; 02/04 went to vd_preview. */
const OPENDOC_ASSET_CLASSES = new Set(['01', '02', '03', '05']);

/**
 * Migrated equivalent of frm_result's DataGrid1: a dynamic-column results grid built from
 * whichever fields the builder screen marked for display.
 *
 * Bank scope (main_form = 1) reproduces frm_result's keys and buttons on the DIGIT file behind
 * each row (one row per file): double-click opens the file, F2 opens استمارة التوثيق (only for
 * "ق" numbers), F9 toggles الاختيار, F3 shows the copy panel (نسخ الاختيار / نسخ الجدول, مع تسجيل
 * الطلب), F6 sends the clip to طلبيات الفيديو; عدد المقالات, طباعة الملف and خروج. Not reproduced:
 * F4/F5 (serh_text / serh_text5 are missing from the DDL) and F7 (tm_* columns come from a TIME
 * join no captured tmp_result body contains). Additional-files rows are FORM records and
 * periodicals rows PERIOD/TRANS records — legacy only ran these actions for main_form = 1.
 */
@Component({
  standalone: false,
  selector: 'app-retrieval-results',
  templateUrl: './retrieval-results.component.html',
  styleUrls: ['./retrieval-results.component.scss']
})
export class RetrievalResultsComponent implements OnInit {

  private retrievalService = inject(RetrievalService);
  private searchScreenService = inject(SearchScreenService);
  private archiveSearchService = inject(ArchiveSearchService);
  private digitizationService = inject(DigitizationService);
  private autocomplete = inject(AutocompleteService);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);
  private fb = inject(FormBuilder);
  private router = inject(Router);
  private route = inject(ActivatedRoute);

  readonly scope: RetrievalScope = this.route.snapshot.data['scope'] ?? 'BANK';
  readonly isBank = this.scope === 'BANK';
  readonly canOpenRecord = this.isBank;

  columns = signal<RetrievalColumn[]>([]);
  rows = signal<RetrievalResultRow[]>([]);
  totalElements = signal(0);
  pageIndex = signal(0);
  pageSize = signal(25);
  isLoading = signal(false);
  hasQuery = signal(false);

  displayedColumns = computed(() => {
    const cols = this.columns().map(c => c.fieldKey);
    return this.isBank ? [...cols, 'digitNo', 'choice', 'actions'] : cols;
  });

  // DataGrid1 cursor — one row per DIGIT file, so the key is document + file.
  focusedKey = signal<string | null>(null);

  // Frame2 (F3): folder, isrec, المستفيد / الجهة المستفيدة (32) / الجهة الموافقة (33) / الموضوع
  copyPanelOpen = signal(false);
  copyFolderName = signal<string | null>(null);
  private copyFolder: any = null;
  isRec = signal(false);
  copying = signal(false);
  coteOptions = signal<CodingOption[]>([]);
  permitOptions = signal<CodingOption[]>([]);
  copyForm = this.fb.group({ person: [''], cote: [''], permit: [''], subject: [''] });

  // Frame1 (F4 / F5): m_rchtext + m_word / Command5 "البحث عن كلمة"
  textPanelOpen = signal(false);
  panelText = signal('');
  highlightWord = signal('');
  textSegments = computed(() => {
    const text = this.panelText();
    const word = this.highlightWord().trim();
    if (!word) return [{ text, hit: false }];
    return text.split(word).flatMap((part, i, all) =>
      i < all.length - 1 ? [{ text: part, hit: false }, { text: word, hit: true }] : [{ text: part, hit: false }]);
  });
  wordInput = '';

  private request: RetrievalSearchRequest | null = null;

  ngOnInit(): void {
    if (this.isBank) {
      this.autocomplete.getCodingByCodePrefix('32').pipe(catchError(() => of({ data: [] } as any)))
        .subscribe(r => this.coteOptions.set(r?.data ?? []));
      this.autocomplete.getCodingByCodePrefix('33').pipe(catchError(() => of({ data: [] } as any)))
        .subscribe(r => this.permitOptions.set(r?.data ?? []));
    }
    const pending = this.retrievalService.pendingSearch();
    if (!pending || pending.scope !== this.scope) {
      this.hasQuery.set(false);
      return;
    }
    this.hasQuery.set(true);
    this.request = pending.request;
    this.pageIndex.set(pending.request.page);
    this.pageSize.set(pending.request.size);
    this.runSearch();
  }

  onPage(e: PageEvent): void {
    this.pageIndex.set(e.pageIndex);
    this.pageSize.set(e.pageSize);
    this.runSearch();
  }

  cellValue(row: RetrievalResultRow, fieldKey: string): unknown {
    return row.values[fieldKey];
  }

  private rowKey(row: RetrievalResultRow): string {
    return `${row.appNo}|${row.digit?.digitNo ?? ''}|${row.digit?.type1 ?? ''}`;
  }

  focusRow(row: RetrievalResultRow): void { this.focusedKey.set(this.rowKey(row)); }

  isFocused(row: RetrievalResultRow): boolean { return this.focusedKey() === this.rowKey(row); }

  /** frm_result DataGrid1_KeyDown (F9 / F2 / F3) and KeyUp (F6), :1529-1630. */
  onGridKeydown(event: KeyboardEvent): void {
    if (!this.isBank) return;
    const row = this.rows().find(r => this.rowKey(r) === this.focusedKey());
    if (event.key === 'F9') {
      event.preventDefault();
      if (row) this.toggleChoice(row);
    } else if (event.key === 'F2') {
      event.preventDefault();
      if (row) this.openDocumentForm(row);
    } else if (event.key === 'F3') {
      event.preventDefault();
      this.copyPanelOpen.set(true);
    } else if (event.key === 'F6') {
      event.preventDefault();
      if (row) this.openVideoOrders(row);
    } else if (event.key === 'F4') {
      event.preventDefault();
      if (row) this.showDescriptorText(row);
    } else if (event.key === 'F5') {
      event.preventDefault();
      if (row) this.showDocumentText(row);
    }
  }

  /** Open action (kept from the earlier build): the analysis page of the record. */
  openRecord(row: RetrievalResultRow): void {
    if (!this.canOpenRecord) {
      return;
    }
    this.router.navigate(['/catalogue', row.appNo]);
  }

  /** F2 (:1550-1560): Form6 — استمارة التوثيق — only when the number starts with "ق". */
  openDocumentForm(row: RetrievalResultRow): void {
    if (row.appNo?.trim().startsWith('ق')) {
      this.router.navigate(['/catalogue/new'], { queryParams: { appNo: row.appNo } });
    }
  }

  /** F9 (:1529-1548): upd_dig_choice(dig_DIG_NO, 0/1, dig_typ1). */
  toggleChoice(row: RetrievalResultRow): void {
    const d = row.digit;
    if (!d?.digitNo || !d.type1) return;
    const next = d.choice === 1 ? 0 : 1;
    this.searchScreenService.setChoice(d.digitNo, d.type1, next).subscribe({
      next: () => this.setChoiceLocally(d.digitNo!, d.type1!, next)
    });
  }

  private setChoiceLocally(digitNo: string, type1: string, choice: number): void {
    // DIG_choice lives on DIGIT, so every row showing that file reflects it.
    this.rows.update(list => list.map(r =>
      r.digit && r.digit.digitNo === digitNo && r.digit.type1 === type1 ? { ...r, digit: { ...r.digit, choice } } : r));
  }

  /** datagrid1_DblClick (:1432-1499): open the archived file, or "هذا الملف غير موجود في الارشيف....". */
  openAsset(row: RetrievalResultRow): void {
    if (!this.isBank) return;
    const d = row.digit;
    if (!d?.digitNo || !d.type1 || !OPENDOC_ASSET_CLASSES.has(d.type1)) {
      this.snackBar.open(this.translate.instant('SEARCH_SCREEN.FILE_NOT_FOUND'), '', { duration: 4000 });
      return;
    }
    this.archiveSearchService.downloadAsset(d.digitNo, d.type1, d.type).subscribe({
      next: blob => window.open(URL.createObjectURL(blob), '_blank'),
      error: () => this.snackBar.open(this.translate.instant('SEARCH_SCREEN.FILE_NOT_FOUND'), '', { duration: 4000 })
    });
  }

  /** F6 (:1568-1630): new_vdpreview with the row's clip (dig_o/m/s → dig_o1/m1/s1). */
  openVideoOrders(row: RetrievalResultRow): void {
    const d = row.digit;
    if (!d) return;
    const n = (v: number | null) => (v == null ? 0 : Number(v));
    const typ = d.type?.trim() || null;
    const preload: VideoOrderPreload = {
      machineNo: row.appNo,
      title: d.title,
      stock: d.digitNo?.trim() || null,
      inSeconds: n(d.seconds) + n(d.minutes) * 60 + n(d.hours) * 3600,
      outSeconds: n(d.seconds1) + n(d.minutes1) * 60 + n(d.hours1) * 3600,
      lowExtension: typ,
      highExtension: d.highType?.trim() || typ || 'avi'
    };
    this.router.navigate(['/video-orders'], { state: { [VIDEO_ORDER_PRELOAD_STATE]: preload } });
  }

  /** F4 (:1631-1647): serh_text(mn_app_no, fad_rltv_n, fad_ser_no) — only rows that carry FILE_ADD columns. */
  showDescriptorText(row: RetrievalResultRow): void {
    const ser = row.digit?.fadSerNo;
    const rel = row.digit?.fadRelNo;
    this.panelText.set('');
    this.textPanelOpen.set(true);
    if (!ser || !rel) return;
    this.retrievalService.getDocumentText(row.appNo, ser, rel).subscribe({
      next: r => this.panelText.set(r.data?.text ?? '')
    });
  }

  /** F5 (:1648-1662): serh_text5(mn_app_no). */
  showDocumentText(row: RetrievalResultRow): void {
    this.panelText.set('');
    this.textPanelOpen.set(true);
    this.retrievalService.getAllDocumentText(row.appNo).subscribe({
      next: r => this.panelText.set(r.data?.text ?? '')
    });
  }

  /** Command5: HighlightWords m_rchtext, m_word.Text, vbRed */
  highlight(): void { this.highlightWord.set(this.wordInput); }

  closeTextPanel(): void {
    this.textPanelOpen.set(false);
    this.highlightWord.set('');
    this.wordInput = '';
  }

  /** عدد المقالات */
  countArticles(): void {
    const count = this.totalElements();
    this.snackBar.open(count === 0
      ? this.translate.instant('SEARCH_SCREEN.ARTICLE_COUNT_EMPTY')
      : this.translate.instant('SEARCH_SCREEN.RESULT_COUNT', { count }), '', { duration: 4000 });
  }

  /** طباعة الملف (Command8 → form_report): the generic reports page, as on شاشة البحث. */
  openReports(): void {
    window.open('/reports', '_blank');
  }

  /** خــروج (Command6): back to sort_form. */
  backToBuilder(): void {
    this.router.navigate([RETRIEVAL_SCOPE_SCREENS[this.scope].path]);
  }

  async chooseCopyFolder(): Promise<void> {
    const w = window as any;
    if (typeof w.showDirectoryPicker !== 'function') {
      this.snackBar.open(this.translate.instant('SEARCH_SCREEN.FOLDER_DOWNLOADS'), '', { duration: 4000 });
      return;
    }
    try {
      this.copyFolder = await w.showDirectoryPicker({ mode: 'readwrite' });
      this.copyFolderName.set(this.copyFolder.name);
    } catch { /* cancelled */ }
  }

  /** Command10 "الغاء الامر" */
  cancelCopy(): void { this.copyPanelOpen.set(false); }

  /** Command9 "نسخ الاختيار" (:1327-1430): rows with DIG_choice = 1; scan/waves/photos/private only; a copied file's mark is cleared. */
  copySelection(): void {
    this.copyRows(this.rows().filter(r => r.digit?.choice === 1), ['01', '02', '03', '05'], true);
  }

  /** Command11 "نسخ الجدول" (:1193-1288): every row; also copies videos (videos\); marks untouched. */
  copyTable(): void {
    this.copyRows(this.rows(), ['01', '02', '03', '04', '05'], false);
  }

  private async copyRows(rows: RetrievalResultRow[], copyable: string[], clearMarks: boolean): Promise<void> {
    if (this.copying()) return;
    this.copying.set(true);
    const logged: RetrievalResultRow[] = [];
    for (const row of rows) {
      const d = row.digit;
      const type1 = (d?.type1 ?? '').trim();
      const no = (d?.digitNo ?? '').trim();
      if (!d || !type1 || !no) continue;
      if (copyable.includes(type1)) {
        try {
          // videos\ (04) is read through the stock resolver the players use; the rest by asset class.
          const blob = await firstValueFrom(type1 === '04'
            ? this.archiveSearchService.downloadMedia(no, 'LOW', d.type)
            : this.archiveSearchService.downloadAsset(no, type1, d.type));
          await this.writeCopy(this.copyName(row), blob);
          if (clearMarks) {
            await firstValueFrom(this.searchScreenService.setChoice(no, type1, 0)).catch(() => null);
            this.setChoiceLocally(no, type1, 0);
          }
        } catch {
          if (clearMarks) {
            this.snackBar.open(no + ' ' + this.translate.instant('SEARCH_SCREEN.FILE_MISSING'), '', { duration: 4000 });
          }
        }
      } else if (clearMarks) {
        // Command9 has no videos\ branch: the path resolves to nothing → "… غير موجودة في الارشيف".
        this.snackBar.open(no + ' ' + this.translate.instant('SEARCH_SCREEN.FILE_MISSING'), '', { duration: 4000 });
      }
      if (this.isRec()) logged.push(row);
    }
    if (this.isRec() && logged.length) {
      const v = this.copyForm.getRawValue();
      try {
        await firstValueFrom(this.digitizationService.logUsageRequest({
          items: logged.map(r => ({
            catalogueAppNo: r.appNo, digitNo: r.digit?.digitNo ?? undefined,
            type: r.digit?.type?.trim() || undefined, type1: r.digit?.type1?.trim() || undefined
          })),
          person: v.person ?? '', cote: v.cote || undefined, permit: v.permit || undefined, subject: v.subject || undefined
        }));
      } catch (e: any) {
        this.snackBar.open(e?.error?.message || this.translate.instant('APP.ERROR'), '', { duration: 4000 });
      }
    }
    this.copying.set(false);
    this.copyPanelOpen.set(false);
    this.snackBar.open(this.translate.instant('SEARCH_SCREEN.COPY_DONE'), '', { duration: 4000 });
  }

  /** v_nam = mn_app_no + filter_desc(Trim(MN_ACT_TTL)) + Str(Day) + "-" + Str(Month) + "-" + Str(Year) + "." + dig_typ */
  private copyName(row: RetrievalResultRow): string {
    const filter = (t: string) => t.trimStart().replace(/['"\/?<>*\\|؟:\r\n]/g, ' ');
    let name = (row.appNo ?? '').trim() + filter((row.digit?.title ?? '').trim());
    if (row.digit?.articleDate) {
      const dt = new Date(row.digit.articleDate);
      name += ' ' + dt.getDate() + '- ' + (dt.getMonth() + 1) + '- ' + dt.getFullYear();   // VB Str() keeps a leading space
    }
    return name + '.' + (row.digit?.type ?? '').trim();
  }

  private async writeCopy(name: string, blob: Blob): Promise<void> {
    if (this.copyFolder) {
      const fh = await this.copyFolder.getFileHandle(name, { create: true });
      const w = await fh.createWritable();
      await w.write(blob);
      await w.close();
      return;
    }
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url; a.download = name; a.click();
    setTimeout(() => URL.revokeObjectURL(url), 5000);
  }

  private runSearch(): void {
    if (!this.request) {
      return;
    }
    this.isLoading.set(true);
    const req: RetrievalSearchRequest = { ...this.request, page: this.pageIndex(), size: this.pageSize() };
    this.retrievalService.search(this.scope, req).subscribe({
      next: r => {
        this.columns.set(r.data.columns);
        this.rows.set(r.data.rows);
        this.totalElements.set(r.data.totalElements);
        this.focusedKey.set(null);
        this.isLoading.set(false);
      },
      error: () => this.isLoading.set(false)
    });
  }
}
