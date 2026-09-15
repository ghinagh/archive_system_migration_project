import { Component, EventEmitter, Input, OnInit, Output, signal } from '@angular/core';
import {
  OPERATORS_BY_TYPE,
  SearchCondition,
  SearchConjunction,
  SearchFieldDef,
  SearchFieldType,
  SearchOperator
} from '../../models/search-condition.model';

interface ConditionRow {
  field: string;
  operator: SearchOperator;
  value: string;
  value2: string;
  conjunction: SearchConjunction;
}

/**
 * Generic AND/OR "cumulative questions" query builder, reused across every domain's
 * advanced-search screen instead of each module hand-rolling its own filter form —
 * the migrated equivalent of the legacy sort_from.frm builder that fed every
 * "Retrievals" menu item off one shared engine.
 */
@Component({
  standalone: false,
  selector: 'app-advanced-search',
  templateUrl: './advanced-search.component.html',
  styleUrls: ['./advanced-search.component.scss']
})
export class AdvancedSearchComponent implements OnInit {

  @Input() fields: SearchFieldDef[] = [];
  @Output() search = new EventEmitter<SearchCondition[]>();
  @Output() cleared = new EventEmitter<void>();

  expanded = signal(false);
  rows = signal<ConditionRow[]>([]);

  ngOnInit(): void {
    this.rows.set([this.emptyRow()]);
  }

  operatorsFor(fieldValue: string) {
    const type = this.fieldType(fieldValue);
    return OPERATORS_BY_TYPE[type];
  }

  fieldType(fieldValue: string): SearchFieldType {
    return this.fields.find(f => f.value === fieldValue)?.type ?? 'STRING';
  }

  isBetween(row: ConditionRow): boolean {
    return row.operator === 'BETWEEN';
  }

  isDate(row: ConditionRow): boolean {
    return this.fieldType(row.field) === 'DATE';
  }

  isNumber(row: ConditionRow): boolean {
    return this.fieldType(row.field) === 'NUMBER';
  }

  onFieldChange(index: number, field: string): void {
    const ops = this.operatorsFor(field);
    this.updateRow(index, { field, operator: ops[0]?.value ?? 'CONTAINS' });
  }

  updateRow(index: number, patch: Partial<ConditionRow>): void {
    const rows = [...this.rows()];
    rows[index] = { ...rows[index], ...patch };
    this.rows.set(rows);
  }

  addRow(): void {
    this.rows.update(r => [...r, this.emptyRow()]);
  }

  removeRow(index: number): void {
    const remaining = this.rows().filter((_, i) => i !== index);
    this.rows.set(remaining.length ? remaining : [this.emptyRow()]);
  }

  onSearch(): void {
    const conditions: SearchCondition[] = this.rows()
      .filter(r => r.field && r.value)
      .map((r, i) => ({
        field: r.field,
        operator: r.operator,
        value: this.toWireValue(r, r.value),
        value2: r.operator === 'BETWEEN' ? this.toWireValue(r, r.value2) : undefined,
        conjunction: i === 0 ? 'AND' : r.conjunction
      }));
    this.search.emit(conditions);
  }

  onClear(): void {
    this.rows.set([this.emptyRow()]);
    this.cleared.emit();
  }

  private toWireValue(row: ConditionRow, raw: string): string {
    return this.isDate(row) && raw ? `${raw}T00:00:00` : raw;
  }

  private emptyRow(): ConditionRow {
    const first = this.fields[0];
    const ops = first ? OPERATORS_BY_TYPE[first.type] : OPERATORS_BY_TYPE.STRING;
    return {
      field: first?.value ?? '',
      operator: ops[0]?.value ?? 'CONTAINS',
      value: '',
      value2: '',
      conjunction: 'AND'
    };
  }
}
