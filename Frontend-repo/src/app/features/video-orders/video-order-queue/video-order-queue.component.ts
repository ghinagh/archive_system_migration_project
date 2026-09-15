import { Component, OnDestroy, OnInit, ViewChild, inject, signal, computed } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { DigitizationService } from '../../digitization/services/digitization.service';
import { DigitDemand, DemandFulfilMechanism, DemandStats } from '../../digitization/models/digitization.model';
import { TokenService } from '../../../core/services/token.service';
import { VideoPreviewComponent } from '../../../shared/components/video-preview/video-preview.component';

/**
 * Migrated equivalent of the legacy new_vdpreview.frm "طلبيات الفيديو" order-queue console
 * (the ARCHIVE.frm f5 menu entry point): filterable list of `demand` rows, preview, cancel,
 * admin-only path reassignment, an explicit bulk mark-fulfilled/pending action, and — since
 * the legacy form's door-2 entry point genuinely exposes the same clip-marking/creation
 * controls once a video is loaded (e.g. via double-click) — in/out marking, jog, and
 * submit-as-new-demand right in this console's own player pane.
 *
 * The legacy screen's three fulfilment mechanisms map onto real server-side actions:
 * Command9 "start" (full re-encode), Command4 "newstart" (ffmpeg stream-copy trim), Command5
 * "copy" (plain whole-file copy) — see FfmpegService/MediaService on the backend. Command19
 * "test" dry-runs playability; Check3 "كليب" merges the selected clips into one output.
 */
@Component({
  standalone: false,
  selector: 'app-video-order-queue',
  templateUrl: './video-order-queue.component.html',
  styleUrls: ['./video-order-queue.component.scss']
})
export class VideoOrderQueueComponent implements OnInit, OnDestroy {

  private digitizationService = inject(DigitizationService);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);
  private fb = inject(FormBuilder);
  private tokenService = inject(TokenService);

  @ViewChild(VideoPreviewComponent) playerComponent?: VideoPreviewComponent;

  readonly isAdmin = this.tokenService.getUser()?.level === 'A';

  displayedColumns = ['select', 'userName', 'demandNo', 'serial', 'description', 'checked', 'machineStock', 'inputSize', 'outputSize', 'catalogueTitle', 'date', 'actions'];

  items = signal<DigitDemand[]>([]);
  totalElements = signal(0);
  pageIndex = signal(0);
  pageSize = signal(10);
  isLoading = signal(false);

  selected = signal<Set<number>>(new Set());
  hasSelection = computed(() => this.selected().size > 0);

  previewUrl = signal<string | null>(null);
  previewTitle = signal('');
  previewRow = signal<DigitDemand | null>(null);

  // Clip-marking state — mirrors legacy Command1/2 (in/out), Command6/7 + m_step (jog),
  // Command27/28 (re-seek), m_dmd_desc + Command10/14 (add / add-whole-scene).
  markedIn = signal<number | null>(null);
  markedOut = signal<number | null>(null);
  jogStep = signal(1);
  newClipDescription = signal('');
  currentDemandNo = signal<string | null>(null);

  // Bulk fulfilment strip — mechanism + كليب (merge) + test + stats + export.
  bulkMechanism = signal<DemandFulfilMechanism>('COPY');
  mergeClip = signal(false);
  stats = signal<DemandStats | null>(null);

  // Status footer — mirrors legacy m_tit1 (status line) / nb_copy (counter) / ProgressBar1.
  isProcessing = signal(false);
  processingStatus = signal('');
  processedCount = signal(0);
  processingTotal = signal(0);

  filters = this.fb.group({
    dateFrom: [this.today()],
    dateTo: [this.today()],
    fulfilled: [''],
    search: [''],
    demandNo: [''],
    machineStock: [''],
    userNo: ['']
  });

  ngOnInit(): void {
    this.load();
  }

  ngOnDestroy(): void {
    this.releasePreview();
  }

  load(): void {
    this.isLoading.set(true);
    this.digitizationService.getDemands(this.pageIndex(), this.pageSize(), this.activeFilters()).subscribe({
      next: r => {
        this.items.set(r.data.content);
        this.totalElements.set(r.data.totalElements);
        this.isLoading.set(false);
        this.selected.set(new Set());
      },
      error: () => this.isLoading.set(false)
    });
  }

  applyFilters(): void { this.pageIndex.set(0); this.load(); }

  clearFilters(): void {
    this.filters.reset({ dateFrom: '', dateTo: '', fulfilled: '', search: '', demandNo: '', machineStock: '', userNo: '' });
    this.pageIndex.set(0);
    this.stats.set(null);
    this.load();
  }

  onPage(e: PageEvent): void { this.pageIndex.set(e.pageIndex); this.pageSize.set(e.pageSize); this.load(); }

  isSelected(id: number): boolean { return this.selected().has(id); }

  toggleSelected(id: number): void {
    const next = new Set(this.selected());
    if (next.has(id)) next.delete(id); else next.add(id);
    this.selected.set(next);
  }

  toggleSelectAll(): void {
    this.selected.set(this.selected().size === this.items().length ? new Set() : new Set(this.items().map(i => i.id)));
  }

  statusClass(row: DigitDemand): string { return row.checked === 2 ? 'status-fulfilled' : 'status-pending'; }
  statusLabel(row: DigitDemand): string { return this.translate.instant(row.checked === 2 ? 'VIDEO_ORDERS.FULFILLED' : 'VIDEO_ORDERS.PENDING'); }

  preview(row: DigitDemand): void {
    if (!row.machineStock) return;
    this.releasePreview();
    this.previewRow.set(row);
    this.previewTitle.set(row.catalogueTitle || row.description || row.demandNo);
    this.markedIn.set(null);
    this.markedOut.set(null);
    this.currentDemandNo.set(row.demandNo);
    this.newClipDescription.set(row.catalogueTitle ?? '');
    this.digitizationService.downloadMedia(row.machineStock).subscribe({
      next: blob => this.previewUrl.set(URL.createObjectURL(blob)),
      error: () => this.snackBar.open(this.translate.instant('VIDEO_ORDERS.MEDIA_UNAVAILABLE'), '', { duration: 3000 })
    });
  }

  closePreview(): void { this.releasePreview(); }

  // --- Clip marking (Group A) ---

  markIn(): void {
    const t = this.currentTime();
    if (t == null) return;
    this.markedIn.set(t);
  }

  markOut(): void {
    const t = this.currentTime();
    if (t == null) return;
    if (this.markedIn() != null && t < this.markedIn()!) {
      this.snackBar.open(this.translate.instant('VIDEO_ORDERS.OUT_BEFORE_IN'), '', { duration: 3000 });
      return;
    }
    this.markedOut.set(t);
  }

  seekToIn(): void { if (this.markedIn() != null) this.setCurrentTime(this.markedIn()!); }
  seekToOut(): void { if (this.markedOut() != null) this.setCurrentTime(this.markedOut()!); }

  jogForward(): void { const t = this.currentTime(); if (t != null) this.setCurrentTime(t + this.jogStep()); }
  jogBackward(): void { const t = this.currentTime(); if (t != null) this.setCurrentTime(Math.max(0, t - this.jogStep())); }

  clearMarks(): void { this.markedIn.set(null); this.markedOut.set(null); }

  /** Command10 "اضافة" — submit the marked in/out range as a new clip on the current (or a new) demand. */
  addClip(): void {
    const row = this.previewRow();
    if (!row || this.markedIn() == null || this.markedOut() == null) {
      this.snackBar.open(this.translate.instant('VIDEO_ORDERS.MARK_IN_OUT_FIRST'), '', { duration: 3000 });
      return;
    }
    this.submitScene(row, this.markedIn()!, this.markedOut()!);
  }

  /** Command14 "اضافة - كامل المشهد" — submit the entire loaded recording as one clip. */
  addWholeScene(): void {
    const row = this.previewRow();
    const duration = this.videoDuration();
    if (!row || !duration) {
      this.snackBar.open(this.translate.instant('VIDEO_ORDERS.NO_VIDEO_LOADED'), '', { duration: 3000 });
      return;
    }
    this.submitScene(row, 0, duration);
  }

  private submitScene(row: DigitDemand, inSeconds: number, outSeconds: number): void {
    this.digitizationService.addScene({
      demandNo: this.currentDemandNo() ?? undefined,
      machineNo: row.machineNo,
      machineStock: row.machineStock,
      description: this.newClipDescription() || row.catalogueTitle,
      inSeconds,
      outSeconds
    }).subscribe({
      next: r => {
        this.currentDemandNo.set(r.data.demandNo);
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.clearMarks();
        this.load();
      }
    });
  }

  private currentTime(): number | null {
    return this.playerComponent?.videoRef?.nativeElement.currentTime ?? null;
  }

  private videoDuration(): number | null {
    const d = this.playerComponent?.videoRef?.nativeElement.duration;
    return d && isFinite(d) ? d : null;
  }

  private setCurrentTime(seconds: number): void {
    const el = this.playerComponent?.videoRef?.nativeElement;
    if (el) el.currentTime = seconds;
  }

  // --- Fulfilment (single row: start / newstart / copy) ---

  fulfil(row: DigitDemand, mechanism: DemandFulfilMechanism): void {
    this.digitizationService.fulfilDemand(row.id, mechanism).subscribe({
      next: () => { this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 }); this.load(); },
      error: () => this.snackBar.open(this.translate.instant('VIDEO_ORDERS.FULFIL_FAILED'), '', { duration: 4000 })
    });
  }

  reassignPath(row: DigitDemand): void {
    const path = window.prompt(this.translate.instant('VIDEO_ORDERS.NEW_PATH'), row.path ?? '');
    if (!path) return;
    this.digitizationService.reassignDemandPath(row.id, path).subscribe({
      next: () => { this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 }); this.load(); }
    });
  }

  cancel(row: DigitDemand): void {
    if (!confirm(this.translate.instant('VIDEO_ORDERS.CONFIRM_CANCEL'))) return;
    this.digitizationService.deleteDemand(row.id).subscribe({
      next: () => { this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 }); this.load(); }
    });
  }

  bulkMark(fulfilled: boolean): void {
    const ids = Array.from(this.selected());
    if (ids.length === 0) return;
    const confirmKey = fulfilled ? 'VIDEO_ORDERS.CONFIRM_BULK_FULFIL' : 'VIDEO_ORDERS.CONFIRM_BULK_PENDING';
    if (!confirm(this.translate.instant(confirmKey, { count: ids.length }))) return;
    this.digitizationService.bulkSetDemandsFulfilled(ids, fulfilled).subscribe({
      next: () => { this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 }); this.load(); }
    });
  }

  // --- Command19 "test" ---

  testSelected(): void {
    const ids = Array.from(this.selected());
    if (ids.length === 0) return;
    this.digitizationService.testDemands(ids).subscribe({
      next: r => {
        const failed = r.data.filter(x => !x.ok);
        const message = failed.length === 0
          ? this.translate.instant('VIDEO_ORDERS.TEST_ALL_OK', { count: ids.length })
          : this.translate.instant('VIDEO_ORDERS.TEST_SOME_FAILED', { failed: failed.length, total: ids.length });
        this.snackBar.open(message, '', { duration: 5000 });
      }
    });
  }

  // --- Bulk fulfilment (Command9/4/5 + Check3 كليب) ---

  bulkFulfilSelected(): void {
    const ids = Array.from(this.selected());
    if (ids.length === 0) return;

    if (this.mergeClip()) {
      this.isProcessing.set(true);
      this.processingStatus.set(this.translate.instant('VIDEO_ORDERS.MERGING'));
      this.digitizationService.bulkFulfilDemands(ids, this.bulkMechanism(), true).subscribe({
        next: () => { this.isProcessing.set(false); this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 }); this.load(); },
        error: () => { this.isProcessing.set(false); this.snackBar.open(this.translate.instant('VIDEO_ORDERS.FULFIL_FAILED'), '', { duration: 4000 }); }
      });
      return;
    }

    // Without merging, fulfil sequentially so the status footer can show real per-item progress
    // — the closest modern equivalent of the legacy m_tit1/nb_copy/ProgressBar1 trio.
    this.isProcessing.set(true);
    this.processedCount.set(0);
    this.processingTotal.set(ids.length);
    this.fulfilNext(ids, 0);
  }

  private fulfilNext(ids: number[], index: number): void {
    if (index >= ids.length) {
      this.isProcessing.set(false);
      this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
      this.load();
      return;
    }
    const id = ids[index];
    const row = this.items().find(i => i.id === id);
    this.processingStatus.set(row?.catalogueTitle || row?.description || String(id));
    this.digitizationService.fulfilDemand(id, this.bulkMechanism()).subscribe({
      next: () => { this.processedCount.set(index + 1); this.fulfilNext(ids, index + 1); },
      error: () => { this.processedCount.set(index + 1); this.fulfilNext(ids, index + 1); }
    });
  }

  // --- Command15 "عدد ومدة المشاهد" ---

  showStats(): void {
    this.digitizationService.getDemandStats(this.activeFilters()).subscribe({
      next: r => this.stats.set(r.data)
    });
  }

  formatDuration(totalSeconds: number): string {
    const s = Math.max(0, Math.round(totalSeconds));
    const h = Math.floor(s / 3600);
    const m = Math.floor((s % 3600) / 60);
    const sec = s % 60;
    return [h, m, sec].map(n => String(n).padStart(2, '0')).join(':');
  }

  // --- Command20 "طباعة الجدول" — CSV export of the current page (a full-list print job needs
  // a proper background report, out of scope here; this covers the practical, common case). ---

  exportCsv(): void {
    const rows = this.items();
    const header = ['demandNo', 'serial', 'userName', 'date', 'description', 'machineStock', 'inputSize', 'outputSize', 'catalogueTitle', 'checked'];
    const lines = [header.join(',')];
    for (const r of rows) {
      lines.push(header.map(h => `"${String((r as unknown as Record<string, unknown>)[h] ?? '').replace(/"/g, '""')}"`).join(','));
    }
    const blob = new Blob([lines.join('\n')], { type: 'text/csv;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'video-orders.csv';
    a.click();
    URL.revokeObjectURL(url);
  }

  private activeFilters() {
    const v = this.filters.value;
    return {
      demandNo: v.demandNo || undefined,
      machineStock: v.machineStock || undefined,
      userNo: this.isAdmin ? (v.userNo || undefined) : undefined,
      fulfilled: v.fulfilled === '' ? undefined : v.fulfilled === 'true',
      dateFrom: v.dateFrom ? new Date(v.dateFrom).toISOString() : undefined,
      dateTo: v.dateTo ? new Date(v.dateTo).toISOString() : undefined,
      search: v.search || undefined
    };
  }

  private releasePreview(): void {
    const current = this.previewUrl();
    if (current) URL.revokeObjectURL(current);
    this.previewUrl.set(null);
    this.previewRow.set(null);
  }

  private today(): string {
    return new Date().toISOString().slice(0, 10);
  }
}
