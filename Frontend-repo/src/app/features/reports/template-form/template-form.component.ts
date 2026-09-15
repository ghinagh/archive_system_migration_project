import { Component, OnInit, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { CdkDragDrop, moveItemInArray } from '@angular/cdk/drag-drop';
import { ReportsService } from '../services/reports.service';

export interface ConditionRow {
  field: string;
  operator: string;
  value: string;
  junction: 'AND' | 'OR';
}

const OPERATORS = ['=', '!=', 'LIKE', '>', '<', '>=', '<='];

@Component({ standalone: false, selector: 'app-template-form', templateUrl: './template-form.component.html', styleUrls: ['./template-form.component.scss'] })
export class TemplateFormComponent implements OnInit {
  private fb = inject(FormBuilder);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private svc = inject(ReportsService);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  isEditMode = signal(false);
  isLoading = signal(false);
  pageLoading = signal(false);
  private editId = 0;

  readonly operators = OPERATORS;

  fieldChips = signal<string[]>([]);
  conditionRows = signal<ConditionRow[]>([{ field: '', operator: '=', value: '', junction: 'AND' }]);

  form = this.fb.group({
    outputNum: [null as number | null],
    description: ['', Validators.maxLength(40)],
    name: ['', Validators.maxLength(20)],
    field: ['', Validators.maxLength(20)],
    display: [''],
    extension: ['', Validators.maxLength(5)],
    length: [null as number | null],
    length1: [null as number | null],
    condition: [''],
    selectClause: [''],
    fieldSelect: [''],
    seek: ['', Validators.maxLength(1)],
    ifCondition: ['', Validators.maxLength(1)],
    choice: [null as number | null],
    nature: ['', Validators.maxLength(1)],
    type: ['', Validators.maxLength(1)],
    category: ['', Validators.maxLength(2)]
  });

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.isEditMode.set(true);
      this.editId = Number(id);
      this.pageLoading.set(true);
      this.svc.getTemplateById(this.editId).subscribe({
        next: r => {
          this.form.patchValue(r.data);
          this.parseFieldChips(r.data.field);
          this.parseConditionRows(r.data.condition);
          this.pageLoading.set(false);
        },
        error: () => { this.pageLoading.set(false); this.router.navigate(['/reports']); }
      });
    }
  }

  onFieldDrop(event: CdkDragDrop<string[]>): void {
    const chips = [...this.fieldChips()];
    moveItemInArray(chips, event.previousIndex, event.currentIndex);
    this.fieldChips.set(chips);
    this.form.patchValue({ field: chips.join(',') });
  }

  removeFieldChip(index: number): void {
    const chips = this.fieldChips().filter((_, i) => i !== index);
    this.fieldChips.set(chips);
    this.form.patchValue({ field: chips.join(',') });
  }

  addFieldChip(input: HTMLInputElement): void {
    const val = input.value.trim();
    if (val && !this.fieldChips().includes(val)) {
      const chips = [...this.fieldChips(), val];
      this.fieldChips.set(chips);
      this.form.patchValue({ field: chips.join(',') });
    }
    input.value = '';
  }

  addConditionRow(): void {
    this.conditionRows.update(rows => [...rows, { field: '', operator: '=', value: '', junction: 'AND' }]);
  }

  removeConditionRow(index: number): void {
    if (this.conditionRows().length === 1) return;
    this.conditionRows.update(rows => rows.filter((_, i) => i !== index));
    this.serializeConditions();
  }

  updateConditionRow(index: number, patch: Partial<ConditionRow>): void {
    this.conditionRows.update(rows =>
      rows.map((row, i) => i === index ? { ...row, ...patch } : row)
    );
    this.serializeConditions();
  }

  serializeConditions(): void {
    const rows = this.conditionRows();
    const filled = rows.filter(r => r.field.trim());
    if (filled.length === 0) {
      this.form.patchValue({ condition: '' });
      return;
    }
    const parts: string[] = [];
    filled.forEach((row, i) => {
      if (i > 0) parts.push(filled[i - 1].junction);
      parts.push(`${row.field} ${row.operator} '${row.value}'`);
    });
    this.form.patchValue({ condition: parts.join(' ') });
  }

  onSubmit(): void {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.serializeConditions();
    this.isLoading.set(true);
    const raw = this.form.getRawValue();
    const req$ = this.isEditMode()
      ? this.svc.updateTemplate(this.editId, raw as any)
      : this.svc.createTemplate(raw as any);
    req$.subscribe({
      next: () => { this.isLoading.set(false); this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 }); this.router.navigate(['/reports']); },
      error: () => this.isLoading.set(false)
    });
  }

  onCancel(): void { this.router.navigate(['/reports']); }

  private parseFieldChips(fieldStr: string | null | undefined): void {
    if (!fieldStr?.trim()) { this.fieldChips.set([]); return; }
    this.fieldChips.set(fieldStr.split(',').map(f => f.trim()).filter(Boolean));
  }

  private parseConditionRows(condStr: string | null | undefined): void {
    if (!condStr?.trim()) return;
    const rows: ConditionRow[] = [];
    const regex = /(\w+)\s+(=|!=|LIKE|>=|<=|>|<)\s+'([^']*)'/gi;
    const juncRegex = /\b(AND|OR)\b/g;
    const junctions: ('AND' | 'OR')[] = [];
    let m;
    while ((m = juncRegex.exec(condStr)) !== null) {
      junctions.push(m[1].toUpperCase() as 'AND' | 'OR');
    }
    let rowIdx = 0;
    while ((m = regex.exec(condStr)) !== null) {
      rows.push({
        field: m[1],
        operator: m[2],
        value: m[3],
        junction: rowIdx < junctions.length ? junctions[rowIdx] : 'AND'
      });
      rowIdx++;
    }
    if (rows.length > 0) this.conditionRows.set(rows);
  }
}
