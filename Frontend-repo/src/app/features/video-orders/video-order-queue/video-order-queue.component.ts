import { Component, ElementRef, OnDestroy, OnInit, ViewChild, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { Subscription, interval, switchMap } from 'rxjs';
import { DigitizationService } from '../../digitization/services/digitization.service';
import {
  DemandQueueContext, DemandQueueCriteria, DemandQueueMechanism, DemandQueueUser, DeliveryJobStatus, DigitDemand,
  VIDEO_ORDER_PRELOAD_STATE, VideoOrderPreload
} from '../../digitization/models/digitization.model';
import { VideoPreviewComponent } from '../../../shared/components/video-preview/video-preview.component';

/**
 * The record the player and clip panel work on — legacy V_MCH_STOCK / v_mch_no / v_mch_tit /
 * v_mch_typ_high with m_time / m_time1. Set by a grid double-click, or handed over by the
 * search screen's F6.
 */
interface LoadedRecord {
  machineNo: string;
  stock: string;
  title: string | null;
  inSeconds: number;
  outSeconds: number;
  highExtension?: string;
}

/** Criteria fields that, as in legacy, are locked once applied until "بحث جديد". */
type LockKey = 'dateFrom' | 'dateTo' | 'done' | 'notDone' | 'text' | 'demandNo' | 'user' | 'stock';

/** Characters new_vdpreview.frm Command10/14 blank out of the description (:1389). */
const UNSAFE_DESC = new Set(["'", '"', '\n', '\r', '/', '?', '<', '>', '*', '\\', '|', '؟', ':']);

/**
 * "طلبيات الفيديو" — the migrated new_vdpreview.frm (ARCHIVE.frm menu f5, under الاسترجاعات).
 *
 * Layout and behaviour follow that form: player (WindowsMediaPlayer1 + jog strip) | clip panel
 * (in / out / الشرح / copy · test · newstart · start · اضافة / كليب) | search panel, then the
 * 12-column grid and the m_tit1 / ProgressBar1 / nb_copy footer. The grid is the whole result
 * (no paging) ordered by dmd_no DESC, and the persisted dmd_chek column is the selection:
 * F1 sets every row to 1, F2 to 2, F5 opens the path panel, Delete cancels the current row.
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
  private router = inject(Router);

  @ViewChild(VideoPreviewComponent) playerComponent?: VideoPreviewComponent;
  @ViewChild('resultBtn') resultBtn?: ElementRef<HTMLButtonElement>;
  @ViewChild('descInput') descInput?: ElementRef<HTMLInputElement>;
  @ViewChild('addBtn') addBtn?: ElementRef<HTMLButtonElement>;
  @ViewChild('dateToInput') dateToInput?: ElementRef<HTMLInputElement>;
  @ViewChild('grid') grid?: ElementRef<HTMLElement>;

  readonly columns = ['userName', 'demandNo', 'serial', 'description', 'checked', 'machineStock',
    'inputSize', 'outputSize', 'timeFrm', 'catalogueTitle', 'path', 'date'];

  ctx = signal<DemandQueueContext | null>(null);
  rows = signal<DigitDemand[]>([]);
  isLoading = signal(false);
  currentIndex = signal(0);

  // --- Search panel (M_dmd_dte / M_dmd_dte1 / Check1 / Check2 / search_text / m_dmd_no / m_dmd_user / m_mch_stock) ---
  dateFrom = signal(this.today());
  dateTo = signal(this.today());
  done = signal(false);
  notDone = signal(false);
  text = signal('');
  demandNo = signal('');
  userName = signal('');
  stock = signal('');
  userOptions = signal<DemandQueueUser[]>([]);
  private pickedUserNo: string | null = null;
  locked = signal<Set<LockKey>>(new Set());
  private applied: DemandQueueCriteria = {};

  // --- Player (WindowsMediaPlayer1) ---
  previewUrl = signal<string | null>(null);
  loadedRecord = signal<LoadedRecord | null>(null);
  readonly step = 1; // m_step — locked at "1" in legacy
  private mTm = 0;    // m_tm  — jog cursor
  private mTime = 0;  // m_time  — row in point (from)
  private mTime1 = 0; // m_time1 — row in + duration (to)

  // --- Clip panel ---
  streamStart = signal<number | null>(null); // m_streamstart (in)
  lenMch = signal<number | null>(null);      // m_len_mch (out - in)
  desc = signal('');                         // m_dmd_desc
  clip = signal(false);                      // Check3 كليب
  /** Legacy m_dmd_ser: 0 → the next add opens a new request number. */
  private hasDemand = false;

  // --- F5 path panel (Frame1) ---
  pathPanelOpen = signal(false);
  pathOptions = signal<string[]>([]);
  pathChoice = signal('');

  // --- Footer: m_tit1 / ProgressBar1 / nb_copy ---
  statusTitle = signal('');
  progress = signal(0);
  nbCopy = signal<number | null>(null);
  isProcessing = signal(false);
  private jobSub?: Subscription;

  ngOnInit(): void {
    this.digitizationService.getQueueContext().subscribe({
      next: r => {
        const ctx = r.data;
        this.ctx.set(ctx);
        // Form_Load: both dates applied and locked; the user filter locked to oneself unless unlocked.
        const locks = new Set<LockKey>(['dateFrom', 'dateTo']);
        if (!ctx.canSeeAllUsers) {
          this.userName.set(ctx.userName ?? '');
          locks.add('user');
        }
        this.locked.set(locks);
        this.applied = { dateFrom: this.dateFrom(), dateTo: this.dateTo() };
        this.runQuery(true);
        this.loadPreload();
      }
    });
  }

  /**
   * Opened from the search screen's F6: new_vdpreview's Form_Load / Form_Activate load
   * V_MCH_STOCK's preview file (LOW tier, extension v_mch_typ — Form_Load's ".avi" when that is
   * empty) and park it, paused, at m_time, ready for in / out / اضافة / اضافة - كامل المشهد.
   */
  private loadPreload(): void {
    const state = history.state as Record<string, unknown> | null;
    const preload = state?.[VIDEO_ORDER_PRELOAD_STATE] as VideoOrderPreload | undefined;
    if (!preload) return;
    history.replaceState({ ...state, [VIDEO_ORDER_PRELOAD_STATE]: undefined }, '');
    if (!preload.stock) return;
    this.openRecord({
      machineNo: preload.machineNo,
      stock: preload.stock,
      title: preload.title,
      inSeconds: preload.inSeconds,
      outSeconds: preload.outSeconds,
      highExtension: preload.highExtension ?? undefined
    }, preload.stock, preload.lowExtension || 'avi', false);
  }

  ngOnDestroy(): void {
    this.jobSub?.unsubscribe();
    this.releasePreview();
  }

  isLocked(key: LockKey): boolean { return this.locked().has(key); }

  private lock(key: LockKey): void {
    const next = new Set(this.locked());
    next.add(key);
    this.locked.set(next);
  }

  // ===================== Search =====================

  /** M_dmd_dte_KeyPress / M_dmd_dte1_KeyPress — Enter applies both dates and locks the field. */
  onDateEnter(which: 'dateFrom' | 'dateTo'): void {
    if (!this.dateFrom() || !this.dateTo()) return;
    this.applied.dateFrom = this.dateFrom();
    this.applied.dateTo = this.dateTo();
    this.lock(which);
    if (which === 'dateFrom') this.dateToInput?.nativeElement.focus();
    else this.resultBtn?.nativeElement.focus();
  }

  /** Check1_Click / Check2_Click — ticking adds the criterion at once; unticking does not remove it. */
  onDoneToggle(kind: 'done' | 'notDone', checked: boolean): void {
    if (!checked) return;
    (kind === 'done' ? this.done : this.notDone).set(true);
    this.applied[kind] = true;
    this.lock(kind);
    this.resultBtn?.nativeElement.focus();
  }

  /** Enter in search_text / m_dmd_no / m_mch_stock applies that field and moves to النتيجة. */
  onFieldEnter(key: 'text' | 'demandNo' | 'stock'): void {
    this.applyField(key);
    this.resultBtn?.nativeElement.focus();
  }

  private applyField(key: 'text' | 'demandNo' | 'stock'): void {
    if (this.isLocked(key)) return;
    const value = (key === 'text' ? this.text() : key === 'demandNo' ? this.demandNo() : this.stock()).trim();
    if (!value) return;
    if (key === 'demandNo') {
      const padded = value.length >= 7 ? value : '0'.repeat(7 - value.length) + value;
      this.demandNo.set(padded);
      this.applied.demandNo = padded;
    } else if (key === 'text') {
      this.applied.text = value;
    } else {
      this.applied.stock = value;
    }
    this.lock(key);
  }

  /** m_dmd_user_Change → serh_config: list users whose name starts with what was typed. */
  onUserInput(value: string): void {
    this.userName.set(value);
    this.pickedUserNo = null;
    if (!this.ctx()?.canSeeAllUsers || !value.trim()) { this.userOptions.set([]); return; }
    this.digitizationService.getQueueUsers(value).subscribe({
      next: r => {
        this.userOptions.set(r.data);
        if (r.data.length === 0) this.message('VIDEO_QUEUE.USER_LIST_EMPTY');
      }
    });
  }

  onUserPicked(user: DemandQueueUser): void {
    this.pickedUserNo = user.userNo;
    this.userName.set(user.userName);
    this.resultBtn?.nativeElement.focus();
  }

  /** Command12 "النتيجة" — applies every filled, not-yet-applied field, then runs the query. */
  onResult(): void {
    this.applyField('text');
    this.applyField('demandNo');
    this.applyField('stock');
    if (!this.isLocked('user') && this.pickedUserNo) {
      this.applied.userNo = this.pickedUserNo;
      this.lock('user');
    }
    this.runQuery(false);
  }

  /** Command11 "بحث جديد" — today's dates (applied, editable), everything else cleared. */
  onNewSearch(): void {
    const today = this.today();
    this.dateFrom.set(today);
    this.dateTo.set(today);
    this.done.set(false);
    this.notDone.set(false);
    this.text.set('');
    this.demandNo.set('');
    this.stock.set('');
    const locks = new Set<LockKey>();
    if (this.ctx()?.canSeeAllUsers) {
      this.userName.set('');
      this.pickedUserNo = null;
    } else {
      locks.add('user');
    }
    this.locked.set(locks);
    this.applied = { dateFrom: today, dateTo: today };
    this.runQuery(true, true);
  }

  private runQuery(initial: boolean, resetDemandWhenEmpty = false): void {
    this.isLoading.set(true);
    this.digitizationService.searchQueue(this.applied).subscribe({
      next: r => {
        this.rows.set(r.data);
        this.currentIndex.set(0);
        this.isLoading.set(false);
        // Form_Load: m_dmd_ser = first row's serial (or 0); Command11: 0 when empty.
        if (initial && !resetDemandWhenEmpty) this.hasDemand = r.data.length > 0;
        if (resetDemandWhenEmpty && r.data.length === 0) this.hasDemand = false;
        setTimeout(() => this.grid?.nativeElement.focus());
      },
      error: () => this.isLoading.set(false)
    });
  }

  /** view_demand.Refresh — re-run the current query, back on the first row. */
  private refresh(): void { this.runQuery(false); }

  // ===================== Grid =====================

  current(): DigitDemand | null { return this.rows()[this.currentIndex()] ?? null; }

  selectRow(i: number): void { this.currentIndex.set(i); }

  /** dmd_chek as the legacy grid shows it — blank when NULL. */
  checkText(r: DigitDemand): string {
    const v = r.checked as number | null | undefined;
    return v == null ? '' : String(v);
  }

  timeFrm(r: DigitDemand): string {
    if (r.seconds == null || r.minutes == null || r.hours == null) return '';
    return `${r.seconds}  ${r.minutes}  ${r.hours}`;
  }

  /** DataGrid1_KeyUp — Delete / F1 / F2 / F5, plus row navigation. */
  onGridKey(e: KeyboardEvent): void {
    const rows = this.rows();
    if (e.key === 'ArrowDown') { this.currentIndex.set(Math.min(rows.length - 1, this.currentIndex() + 1)); e.preventDefault(); return; }
    if (e.key === 'ArrowUp') { this.currentIndex.set(Math.max(0, this.currentIndex() - 1)); e.preventDefault(); return; }
    if (e.key === 'Delete') { e.preventDefault(); this.deleteCurrent(); return; }
    if (e.key === 'F1' || e.key === 'F2') {
      e.preventDefault();
      if (rows.length === 0) return;
      this.digitizationService.setQueueChecked(rows.map(x => x.id), e.key === 'F1' ? 1 : 2)
        .subscribe({ next: () => this.refresh() });
      return;
    }
    if (e.key === 'F5') {
      e.preventDefault();
      if (this.ctx()?.canOperate) this.openPathPanel();
    }
  }

  /** The editable الاختيار cell (DataGrid AllowUpdate) — blank clears, 0/1/2 are stored as typed. */
  onCheckEdit(row: DigitDemand, raw: string): void {
    const v = raw.trim();
    const value = v === '' ? null : Number(v);
    if (value !== null && ![0, 1, 2].includes(value)) { this.refresh(); return; }
    if ((row.checked as number | null | undefined ?? null) === value) return;
    const keep = this.currentIndex();
    this.digitizationService.setQueueChecked([row.id], value).subscribe({
      next: () => this.digitizationService.searchQueue(this.applied).subscribe({
        next: r => { this.rows.set(r.data); this.currentIndex.set(Math.min(keep, r.data.length - 1)); }
      })
    });
  }

  /** Frame6 "الغاء استمارة" — del_demand unless the row is already done (dmd_chek = 2). */
  private deleteCurrent(): void {
    const row = this.current();
    if (!row) return;
    if (!confirm(this.translate.instant('VIDEO_QUEUE.CONFIRM_DELETE'))) return;
    if (row.checked === 2) return;
    this.digitizationService.deleteDemand(row.id).subscribe({ next: () => this.refresh() });
  }

  // ===================== F5 path panel =====================

  private openPathPanel(): void {
    this.digitizationService.getQueuePathOptions().subscribe({
      next: r => { this.pathOptions.set(r.data); this.pathChoice.set(''); this.pathPanelOpen.set(true); }
    });
  }

  /** Command3 "تنفيذ الكل" / Command18 "تنفيذ مشهد". */
  applyPath(all: boolean): void {
    const base = this.pathChoice();
    const row = this.current();
    const ids = all ? this.rows().map(r => r.id) : (row && row.checked === 1 ? [row.id] : []);
    this.pathPanelOpen.set(false);
    if (!base || ids.length === 0) { this.refresh(); return; }
    this.digitizationService.assignQueuePath(ids, base).subscribe({ next: () => this.refresh() });
  }

  closePathPanel(): void { this.pathPanelOpen.set(false); this.refresh(); }

  // ===================== Player =====================

  /** datagrid1_DblClick — load the row's LOW-tier recording (its own extension) at dmd_in. */
  onRowDblClick(row: DigitDemand, i: number): void {
    this.currentIndex.set(i);
    if (!row.machineStock || row.description == null) return;
    const inPoint = Number(row.inputSize ?? 0);
    const path = (row.path ?? '').trim();
    const ext = path.length >= 3 ? path.substring(path.length - 3) : undefined;
    this.openRecord({
      machineNo: row.machineNo,
      stock: row.machineStock,
      title: row.catalogueTitle,
      inSeconds: inPoint,
      outSeconds: inPoint + Number(row.outputSize ?? 0),
      highExtension: this.pathExtension(row.path)
    }, this.legacyStock(row.machineStock), ext, true);
  }

  /** Loads the record's preview file at m_time — playing (grid double-click) or paused (Form_Load). */
  private openRecord(record: LoadedRecord, fileStock: string, ext: string | undefined, play: boolean): void {
    this.mTime = record.inSeconds;
    this.mTime1 = record.outSeconds;
    this.mTm = this.mTime;
    this.digitizationService.downloadMedia(fileStock, ext).subscribe({
      next: blob => {
        this.releasePreview();
        this.loadedRecord.set(record);
        this.streamStart.set(null);
        this.lenMch.set(null);
        this.previewUrl.set(URL.createObjectURL(blob));
        setTimeout(() => this.whenVideoReady(el => {
          el.currentTime = this.mTime;
          if (play) el.play().catch(() => undefined);
          else el.pause();
        }));
      },
      error: () => this.message('VIDEO_QUEUE.NO_VIDEO')
    });
  }

  /** Command6 ▶ (jog forward by m_step). */
  jogForward(): void {
    this.withVideo(el => {
      if (el.currentTime > this.mTm) this.mTm = el.currentTime;
      this.mTm += this.step;
      el.currentTime = this.mTm;
      el.play().catch(() => undefined);
    });
  }

  /** Command7 ◀ (jog back by m_step). */
  jogBack(): void {
    this.withVideo(el => { this.mTm -= this.step; el.currentTime = Math.max(0, this.mTm); el.play().catch(() => undefined); });
  }

  /** Command27 "from" / Command28 "to" — the row's in point / in + duration, paused. */
  seekFrom(): void { this.withVideo(el => { el.currentTime = this.mTime; el.pause(); }); }
  seekTo(): void { this.withVideo(el => { el.currentTime = this.mTime1; el.pause(); }); }

  /** m_step_KeyDown / KeyPress: ← / → one second; j / l one frame (0.04 s); k pause. */
  onStepKey(e: KeyboardEvent): void {
    this.withVideo(el => {
      if (e.key === 'ArrowLeft') {
        this.mTm -= 1; el.currentTime = Math.max(0, this.mTm); el.play().catch(() => undefined);
      } else if (e.key === 'ArrowRight') {
        if (el.currentTime > this.mTm) this.mTm = el.currentTime;
        this.mTm += 1; el.currentTime = this.mTm; el.play().catch(() => undefined);
      } else if (e.key === 'j') {
        this.mTm -= 0.04; el.currentTime = Math.max(0, this.mTm); el.pause();
      } else if (e.key === 'l') {
        if (el.currentTime > this.mTm) this.mTm = el.currentTime;
        this.mTm += 0.04; el.currentTime = this.mTm; el.pause();
      } else if (e.key === 'k') {
        el.pause();
      } else {
        return;
      }
      e.preventDefault();
    });
  }

  // ===================== Clip panel =====================

  /** Command1 "in". */
  markIn(): void { this.withVideo(el => this.streamStart.set(el.currentTime)); }

  /** Command2 "out" — m_len_mch = position - m_streamstart, then focus الشرح. */
  markOut(): void {
    this.withVideo(el => {
      this.lenMch.set(el.currentTime - (this.streamStart() ?? 0));
      this.descInput?.nativeElement.focus();
    });
  }

  onDescEnter(): void { this.addBtn?.nativeElement.focus(); }

  /** Command10 "اضافة". */
  addScene(): void {
    const rec = this.loadedRecord();
    if (!rec) return;
    const description = this.sanitiseDesc(this.desc());
    this.desc.set(description);
    const start = this.streamStart() ?? 0;
    const len = this.lenMch() ?? 0;
    this.submitScene(rec, start, start + Math.max(0, len), description, rec.highExtension);
  }

  /** Command14 "اضافة - كامل المشهد" — the loaded record's own in / in + duration. */
  addWholeScene(): void {
    const rec = this.loadedRecord();
    if (!rec || !rec.stock) return;
    const stockNo = Number(rec.stock.trim());
    const description = this.sanitiseDesc(
      `${isNaN(stockNo) ? rec.stock.trim() : stockNo} _ ${(rec.title ?? '').substring(0, 50)}`);
    this.desc.set(description);
    this.submitScene(rec, rec.inSeconds, rec.outSeconds, description, 'avi');
  }

  private submitScene(rec: LoadedRecord, inSeconds: number, outSeconds: number, description: string, highExtension?: string): void {
    const target = this.hasDemand ? this.current() : null;
    this.digitizationService.addQueueScene({
      demandNo: target?.demandNo ?? undefined,
      machineNo: rec.machineNo,
      machineStock: rec.stock,
      description,
      inSeconds,
      outSeconds,
      highExtension
    }).subscribe({
      next: () => { this.hasDemand = true; this.refresh(); }
    });
  }

  /** Command19 "test" — every grid row with dmd_chek = 1: file present and with a duration. */
  test(): void {
    const rows = this.rows();
    if (rows.length === 0) return;
    this.digitizationService.testDemands(rows.map(r => r.id)).subscribe({
      next: r => {
        const failed = r.data.filter(x => !x.ok).map(x => this.stockLabel(rows.find(row => row.id === x.id)?.machineStock));
        this.refresh();
        if (failed.length === 0) this.message('VIDEO_QUEUE.TEST_ALL_OK');
        else this.message('VIDEO_QUEUE.TEST_FAILED', { list: failed.join(' , ') });
      }
    });
  }

  /**
   * Command9 "start" / Command4 "newstart" / Command5 "copy". Legacy asked for a file name in a
   * Save dialog; outputs are written under that name in the server archive folder. "copy"
   * walks from the current row (legacy never rewinds its recordset there); the others from the top.
   */
  process(mechanism: DemandQueueMechanism): void {
    const rows = this.rows();
    if (rows.length === 0 || this.isProcessing()) return;
    const name = prompt(this.translate.instant('VIDEO_QUEUE.SAVE_AS'));
    if (!name || !name.trim()) return;
    const from = mechanism === 'COPY' ? this.currentIndex() : 0;
    const ids = rows.slice(from).map(r => r.id);

    this.isProcessing.set(true);
    this.progress.set(0);
    this.nbCopy.set(1);
    this.statusTitle.set('');
    this.digitizationService.processQueue(ids, mechanism, this.clip(), name.trim()).subscribe({
      next: r => this.pollJob(r.data.jobId),
      error: () => this.isProcessing.set(false)
    });
  }

  private pollJob(jobId: string): void {
    this.jobSub?.unsubscribe();
    this.jobSub = interval(1000).pipe(switchMap(() => this.digitizationService.getDeliveryJob(jobId))).subscribe({
      next: r => this.onJobStatus(r.data),
      error: () => { this.jobSub?.unsubscribe(); this.isProcessing.set(false); }
    });
  }

  private onJobStatus(s: DeliveryJobStatus): void {
    this.statusTitle.set(s.currentTitle ?? this.statusTitle());
    this.progress.set(s.total > 0 ? (s.processed / s.total) * 100 : 0);
    this.nbCopy.set(1 + s.processed);
    if (s.state === 'RUNNING') return;
    this.jobSub?.unsubscribe();
    this.isProcessing.set(false);
    this.progress.set(100);
    this.refresh();
    if (s.state === 'FAILED') {
      this.snackBar.open(s.errorMessage ?? this.translate.instant('VIDEO_QUEUE.SAVE_FAILED'), this.translate.instant('VIDEO_QUEUE.OK'));
    } else if (s.failedStockNumbers.length === 0) {
      this.message('VIDEO_QUEUE.COPY_DONE');
    } else {
      this.message('VIDEO_QUEUE.NOT_EXECUTED', { list: s.failedStockNumbers.map(x => this.stockLabel(x)).join(' , ') });
    }
  }

  // ===================== Right-panel buttons =====================

  /** Command15 "عدد ومدة المشاهد" — count and summed dmd_out of the whole result. */
  showStats(): void {
    const rows = this.rows();
    if (rows.length === 0) { this.message('VIDEO_QUEUE.NO_ROWS'); return; }
    const total = rows.reduce((sum, r) => sum + Number(r.outputSize ?? 0), 0);
    const h = Math.floor(total / 3600);
    const rest = this.roundHalfEven(total) % 3600;
    this.message('VIDEO_QUEUE.STATS_MSG', { count: rows.length, h, m: Math.floor(rest / 60), s: rest % 60 });
  }

  /**
   * Command20 "طباعة الجدول" — prints the current result with the grid's columns.
   *
   * Legacy recreates tmp_demand_print with the grid's own query and shows CrystalReport10
   * (from_report.frm, jad_print = 10). That report's layout is stored only in the compressed
   * OLE blob CrystalReport10.dsx; neither it nor CrystalReport10.DCA exposes any field, table
   * or caption, so the layout cannot be reproduced from the source. The data printed here is the
   * same query; the layout is the grid's, not Report10's.
   */
  print(): void {
    const t = (k: string) => this.translate.instant(k);
    const esc = (v: unknown) => String(v ?? '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    const heads = ['COL_USER', 'COL_DEMAND_NO', 'COL_SERIAL', 'COL_DESC', 'COL_CHECK', 'COL_STOCK', 'COL_IN',
      'COL_OUT', 'COL_TIME', 'COL_TITLE', 'COL_PATH', 'COL_DATE'].map(k => `<th>${esc(t('VIDEO_QUEUE.' + k))}</th>`).join('');
    const body = this.rows().map(r => `<tr>${[r.userName, r.demandNo, r.serial, r.description, r.checked, r.machineStock,
      r.inputSize, this.formatOut(r.outputSize), this.timeFrm(r), r.catalogueTitle, r.path, this.formatDate(r.date)]
      .map(v => `<td>${esc(v)}</td>`).join('')}</tr>`).join('');
    const w = window.open('', '_blank');
    if (!w) return;
    w.document.write(`<!doctype html><html dir="rtl"><head><meta charset="utf-8"><title>${esc(t('VIDEO_QUEUE.TITLE'))}</title>
      <style>body{font-family:Tahoma,Arial,sans-serif;font-size:11px}table{border-collapse:collapse;width:100%}
      th,td{border:1px solid #444;padding:2px 4px;text-align:right}th{background:#eee}</style></head>
      <body><h3>${esc(t('VIDEO_QUEUE.TITLE'))}</h3><table><thead><tr>${heads}</tr></thead><tbody>${body}</tbody></table></body></html>`);
    w.document.close();
    w.focus();
    w.print();
  }

  /** Command8 "خروج". */
  exit(): void { this.router.navigate(['/catalogue']); }

  // ===================== Helpers =====================

  formatOut(v: number | null | undefined): string { return v == null ? '' : Number(v).toFixed(2); }

  formatDate(v: string | null): string {
    if (!v) return '';
    const d = new Date(v);
    return `${String(d.getDate()).padStart(2, '0')}/${String(d.getMonth() + 1).padStart(2, '0')}/${d.getFullYear()}`;
  }

  formatSeconds(v: number | null): string {
    if (v == null) return '--:--:--';
    const s = Math.max(0, Math.floor(v));
    return [Math.floor(s / 3600), Math.floor((s % 3600) / 60), s % 60].map(n => String(n).padStart(2, '0')).join(':');
  }

  private sanitiseDesc(value: string): string {
    return Array.from(value.trimStart()).map(c => (UNSAFE_DESC.has(c) ? ' ' : c)).join('');
  }

  /** Legacy V_MCH_STOCK = Mid("00000",1,6-Len(Trim(Str(stock)))) + Trim(Str(stock)). */
  private legacyStock(stock: string): string {
    const n = Number(stock.trim());
    if (isNaN(n)) return stock.trim();
    const digits = String(n);
    return '00000'.substring(0, Math.max(0, Math.min(5, 6 - digits.length))) + digits;
  }

  /** Legacy reports stock numbers through Str() — numeric, no leading zeros. */
  private stockLabel(stock: string | null | undefined): string {
    const t = (stock ?? '').trim();
    const n = Number(t);
    return t && !isNaN(n) ? String(n) : t;
  }

  private pathExtension(path: string | null): string | undefined {
    const trimmed = path?.trim();
    return trimmed && trimmed.length > 3 ? trimmed.substring(trimmed.length - 3) : undefined;
  }

  private roundHalfEven(x: number): number {
    const f = Math.floor(x);
    const diff = x - f;
    if (diff > 0.5) return f + 1;
    if (diff < 0.5) return f;
    return f % 2 === 0 ? f : f + 1;
  }

  private withVideo(fn: (el: HTMLVideoElement) => void): void {
    const el = this.playerComponent?.videoRef?.nativeElement;
    if (el && this.loadedRecord()) fn(el);
  }

  private whenVideoReady(fn: (el: HTMLVideoElement) => void): void {
    const el = this.playerComponent?.videoRef?.nativeElement;
    if (!el) return;
    if (el.readyState >= 1) fn(el);
    else el.addEventListener('loadedmetadata', () => fn(el), { once: true });
  }

  private message(key: string, params?: Record<string, unknown>): void {
    this.snackBar.open(this.translate.instant(key, params), this.translate.instant('VIDEO_QUEUE.OK'), { duration: 8000 });
  }

  private releasePreview(): void {
    const current = this.previewUrl();
    if (current) URL.revokeObjectURL(current);
    this.previewUrl.set(null);
  }

  /** Local calendar date (legacy Format(Date, "dd/mm/yyyy")), not the UTC date. */
  private today(): string {
    const d = new Date();
    return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
  }
}
