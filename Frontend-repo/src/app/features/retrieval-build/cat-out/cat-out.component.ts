import { Component, OnDestroy, OnInit, ViewChild, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Observable, firstValueFrom } from 'rxjs';
import { LegacyGridColumn, LegacyGridComponent, LegacyGridWriter } from '../../users/legacy-grid/legacy-grid.component';
import { Row, RetrievalBuildService } from '../retrieval-build.service';

type Filter = 'ALL' | 'DISPLAY' | 'QUESTIONS';
interface Category { sub_code: string; sub_desc: string; }

const px = (twips: number) => Math.round(twips / 15 * 1.25);

/**
 * CAT_OUTFRM — "معالجة حقول الاسترجاع" (ARCHIVE.frm M32, Frame3 key 261015).
 * DataGrid1 ← f_tmp (bnkout ⟕ CODING '37'): المتسلسل / اسم الحقل locked, ترتيب حقول العرض /
 * ترتيب الاسئلة / السؤال editable, AllowAddNew + AllowDelete. Check1 "حقول العرض" → OUT_CHIOCE > 0,
 * Check2 "اسئلة الاسترجاع" → OUT_IF > 0 (unticked: every row). Space on DataGrid1 → category list
 * (VIEW_coding37), Enter → upd_OUT_CAT. DBList1 ← VIEW_coding37: double-click → proc_catogorie into
 * DataGrid2 (auto / اسم التصنيف locked; رقم الحقل, cat_no, اسم الحقل editable); Insert → insr_catogorie.
 */
@Component({
  standalone: false,
  selector: 'app-cat-out',
  template: `
  <div class="co" dir="rtl">
    <div class="co-bar"><span class="co-title">Form1</span><button type="button" class="co-close" (click)="close()">×</button></div>

    <div class="co-top">
      <div class="co-checks">
        <label><input type="checkbox" [checked]="check1()" (change)="onCheck1($any($event.target).checked)"> حقول العرض</label>
        <label><input type="checkbox" [checked]="check2()" (change)="onCheck2($any($event.target).checked)"> اسئلة الاسترجاع</label>
      </div>
      <!-- DBList1 ← view_coding37 -->
      <ul class="co-list" tabindex="0">
        @for (c of categories(); track c.sub_code) {
          <li [class.co-sel]="selectedCategory() === c.sub_code" (click)="selectedCategory.set(c.sub_code)"
              (dblclick)="openCategory(c)">{{ c.sub_desc }}</li>
        } @empty { <li class="co-empty">—</li> }
      </ul>
    </div>

    <app-legacy-grid #grid1 gridId="co-fields" [columns]="fieldColumns" [rows]="fields()" [writer]="fieldWriter"
                     [loading]="loading()" (gridKeydown)="onFieldsKeydown($event)"></app-legacy-grid>

    @if (picker()) {
      <!-- DBList6: the category list Space opens over DataGrid1 -->
      <div class="co-picker" tabindex="0" (keydown)="onPickerKey($event)" #pickerEl>
        @for (c of categories(); track c.sub_code; let i = $index) {
          <div [class.co-sel]="pickerIndex() === i" (click)="pickerIndex.set(i)" (dblclick)="applyCategory()">{{ c.sub_desc }}</div>
        } @empty { <div class="co-empty">—</div> }
      </div>
    }

    <app-legacy-grid #grid2 gridId="co-cat" [columns]="categoryColumns" [rows]="categoryRows()" [writer]="categoryWriter"
                     [loading]="loading()" (gridKeyup)="onCategoryKeyup($event)"></app-legacy-grid>
  </div>`,
  styles: [`
    .co { padding: 8px; background: #f5f7fa; min-height: calc(100vh - 120px); display: flex; flex-direction: column; gap: 6px; }
    .co-bar { display: flex; justify-content: space-between; align-items: center; background: #22404c; color: #fff; padding: 2px 6px; border-radius: 6px; direction: ltr; }
    .co-title { font-weight: 600; }
    .co-close { background: #f5f7fa; border: 1px solid #d5dbe3; border-radius: 4px; cursor: pointer; width: 22px; }
    .co-top { display: flex; gap: 16px; align-items: flex-start; }
    .co-checks { display: flex; flex-direction: column; gap: 4px; }
    .co-list, .co-picker { list-style: none; margin: 0; padding: 0; background: #fff; border: 2px solid #e1e6ed; border-radius: 8px; min-width: 220px; max-height: 160px; overflow: auto; }
    .co-list li, .co-picker div { padding: 2px 6px; cursor: default; }
    .co-sel { background: #22404c; color: #fff; }
    .co-list li:hover, .co-picker div:hover { background: #edf3f5; }
    .co-list li.co-sel:hover, .co-picker div.co-sel:hover { background: #22404c; }
    .co-empty { color: #6b7a90; }
    .co-picker { align-self: flex-start; outline: none; }
    app-legacy-grid { display: block; max-height: 36vh; overflow: auto; }
  `]
})
export class CatOutComponent implements OnInit, OnDestroy {

  private api = inject(RetrievalBuildService);
  private router = inject(Router);
  private snack = inject(MatSnackBar);

  @ViewChild('grid1') grid1?: LegacyGridComponent;
  @ViewChild('grid2') grid2?: LegacyGridComponent;

  readonly fieldColumns: LegacyGridColumn[] = [
    { key: 'OUT_NUM', label: 'المتسلسل', locked: true, width: px(1695) },
    { key: 'OUT_DESC', label: 'اسم الحقل', locked: true, width: px(3000) },
    { key: 'OUT_INDX', label: 'ترتيب حقول العرض', width: px(1500) },
    { key: 'OUT_INDX3', label: 'ترتيب الاسئلة', width: px(1500) },
    { key: 'out_cond', label: 'السؤال', width: px(3495) }
  ];

  readonly categoryColumns: LegacyGridColumn[] = [
    { key: 'auto', label: 'auto', locked: true, width: px(915) },
    { key: 'desc_cat', label: 'اسم التصنيف', locked: true, width: px(2595) },
    { key: 'cat_num', label: 'رقم الحقل', width: px(1005) },
    { key: 'cat_no', label: 'cat_no', width: px(900) },
    { key: 'desc_out', label: 'اسم الحقل', width: px(3000) }
  ];

  fields = signal<Row[]>([]);
  categories = signal<Category[]>([]);
  categoryRows = signal<Row[]>([]);
  selectedCategory = signal<string | null>(null);
  /** m_code: Mid(sub_code, 3, 4) of the category last double-clicked in DBList1. */
  private openCode: string | null = null;
  check1 = signal(false);
  check2 = signal(false);
  private filter: Filter = 'ALL';
  loading = signal(false);
  picker = signal(false);
  pickerIndex = signal(0);

  readonly fieldWriter: LegacyGridWriter = {
    update: (r, c, t) => this.write(() => this.api.updateField(this.num(this.fields()[r]), c, t), () => this.loadFields()),
    insert: v => this.write(() => this.api.insertField(v), () => this.loadFields()),
    remove: r => this.write(() => this.api.deleteField(this.num(this.fields()[r])), () => this.loadFields())
  };

  readonly categoryWriter: LegacyGridWriter = {
    update: (r, c, t) => this.write(() => this.api.updateCategoryField(Number(this.categoryRows()[r]['auto']), c, t), () => this.loadCategoryRows()),
    // AllowAddNew: the "*" line, written into the category open in DataGrid2
    insert: v => this.openCode
      ? this.write(() => this.api.insertCategoryRow(this.openCode!, v), () => this.loadCategoryRows())
      : Promise.resolve(false),
    remove: r => this.write(() => this.api.deleteCategoryField(Number(this.categoryRows()[r]['auto'])), () => this.loadCategoryRows())
  };

  ngOnInit(): void {
    this.loadFields();
    this.api.categories().subscribe({ next: r => this.categories.set(r.data ?? []) });
  }

  ngOnDestroy(): void {
    this.api.release('CAT_OUT');
  }

  close(): void {
    this.router.navigate(['/']);
  }

  /** Check1_Click / Check2_Click: each re-sets f_tmp's query by its own value. */
  onCheck1(checked: boolean): void {
    this.check1.set(checked);
    this.filter = checked ? 'DISPLAY' : 'ALL';
    this.loadFields();
  }

  onCheck2(checked: boolean): void {
    this.check2.set(checked);
    this.filter = checked ? 'QUESTIONS' : 'ALL';
    this.loadFields();
  }

  /** datagrid1_KeyPress Space → DBList6 (the category list). */
  onFieldsKeydown(e: KeyboardEvent): void {
    if (e.key !== ' ') return;
    if (this.grid1?.currentValue('OUT_NUM') == null || this.grid1?.currentValue('OUT_NUM') === '') return;
    e.preventDefault();
    this.pickerIndex.set(0);
    this.picker.set(true);
    setTimeout(() => (document.querySelector('.co-picker') as HTMLElement | null)?.focus());
  }

  /** DBList6_KeyPress: Enter → upd_OUT_CAT(out_num, Mid(BoundText, 3, 2)); Esc → hide. */
  onPickerKey(e: KeyboardEvent): void {
    const n = this.categories().length;
    if (e.key === 'ArrowDown') { e.preventDefault(); this.pickerIndex.set(Math.min(n - 1, this.pickerIndex() + 1)); }
    else if (e.key === 'ArrowUp') { e.preventDefault(); this.pickerIndex.set(Math.max(0, this.pickerIndex() - 1)); }
    else if (e.key === 'Enter') { e.preventDefault(); this.applyCategory(); }
    else if (e.key === 'Escape') { e.preventDefault(); this.picker.set(false); this.grid1?.focus(); }
  }

  applyCategory(): void {
    const cat = this.categories()[this.pickerIndex()];
    const outNum = Number(this.grid1?.currentValue('OUT_NUM'));
    this.picker.set(false);
    if (!cat || Number.isNaN(outNum)) return;
    this.write(() => this.api.setFieldCategory(outNum, cat.sub_code.substring(2, 4)), () => this.loadFields())
      .then(() => this.grid1?.focus());
  }

  /** DBList1_DblClick: m_code = Mid(sub_code, 3, 4) → proc_catogorie(m_code) into DataGrid2. */
  openCategory(c: Category): void {
    this.selectedCategory.set(c.sub_code);
    this.openCode = c.sub_code.substring(2, 6);
    this.loadCategoryRows();
    setTimeout(() => this.grid2?.focus());
  }

  /** DataGrid2_KeyUp Insert: insr_catogorie(Mid(view_coding37 current sub_code, 3, 4)). */
  onCategoryKeyup(e: KeyboardEvent): void {
    if (e.key !== 'Insert') return;
    const code = this.openCode;
    if (!code) return;
    this.write(() => this.api.insertCategoryField(code), () => this.loadCategoryRows());
  }

  private num(row: Row | undefined): number {
    return Number(row?.['OUT_NUM']);
  }

  private loadFields(): void {
    this.loading.set(true);
    this.api.fields(this.filter).subscribe({
      next: r => { this.fields.set(r.data ?? []); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }

  private loadCategoryRows(): void {
    if (!this.openCode) { this.categoryRows.set([]); return; }
    this.api.categoryFields(this.openCode).subscribe({ next: r => this.categoryRows.set(r.data ?? []) });
  }

  private async write(call: () => Observable<unknown>, reload: () => void): Promise<boolean> {
    try {
      await firstValueFrom(call());
      reload();
      return true;
    } catch (e: any) {
      this.snack.open(e?.error?.message || 'تعذر حفظ القيمة', '', { duration: 4000 });
      return false;
    }
  }
}
