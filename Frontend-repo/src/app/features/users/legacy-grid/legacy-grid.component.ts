import { Component, ElementRef, EventEmitter, Input, Output, QueryList, ViewChild, ViewChildren, signal } from '@angular/core';

export interface LegacyGridColumn {
  key: string;
  label: string;
  /** Split0 ColumnNN Locked = True */
  locked?: boolean;
  /** Split0 ColumnNN ColumnWidth, in px */
  width?: number;
}

/** What the grid asks its owner to write; the owner reloads the rows afterwards. */
export interface LegacyGridWriter {
  update(row: number, column: string, text: string): Promise<boolean>;
  insert?(values: Record<string, string>): Promise<boolean>;
  remove?(row: number): Promise<boolean>;
}

/**
 * A VB6 MSDataGrid bound to an Adodc: AllowUpdate (type or F2 to edit the current cell, Enter / Tab
 * to write it, Esc to cancel), AllowAddNew (the "*" line; the new record is written when the user
 * leaves it) and AllowDelete (pick the record selector, then Delete). Arrow keys move the current
 * cell. Key and double-click events are passed to the owner, like the form's DataGrid event procs.
 */
@Component({
  standalone: false,
  selector: 'app-legacy-grid',
  templateUrl: './legacy-grid.component.html',
  styleUrls: ['./legacy-grid.component.scss']
})
export class LegacyGridComponent {

  @Input() columns: LegacyGridColumn[] = [];
  @Input() rows: Record<string, unknown>[] = [];
  @Input() writer?: LegacyGridWriter;
  @Input() allowAddNew = true;
  @Input() allowDelete = true;
  @Input() loading = false;
  @Input() backColor = '#ffffff';
  @Input() gridId = '';

  /** DataGrid_DblClick — anywhere in the grid (cell, record selector, header); the owner reads the current record. */
  @Output() gridDblClick = new EventEmitter<void>();
  @Output() gridKeydown = new EventEmitter<KeyboardEvent>();
  @Output() gridKeyup = new EventEmitter<KeyboardEvent>();

  @ViewChild('grid') grid?: ElementRef<HTMLElement>;
  @ViewChildren('cellEditor') cellEditors?: QueryList<ElementRef<HTMLInputElement>>;

  current = signal<number | null>(null);
  currentCol = signal<string>('');
  rowSelected = signal(false);
  onNewRow = signal(false);
  editing = signal<{ row: number | 'new'; col: string; value: string } | null>(null);
  newRow = signal<Record<string, string>>({});

  /** DataGrid.Columns(0) of the current record (the add-new line gives ""). */
  currentValue(key: string): string | null {
    if (this.onNewRow()) return this.newRow()[key] ?? '';
    const i = this.current();
    if (i === null || !this.rows[i]) return null;
    const v = this.rows[i][key];
    return v === null || v === undefined ? '' : String(v);
  }

  cellText(row: Record<string, unknown>, key: string): string {
    const v = row[key];
    return v === null || v === undefined ? '' : String(v);
  }

  focus(): void {
    this.grid?.nativeElement.focus();
  }

  async setCurrent(i: number, col?: string): Promise<void> {
    await this.leaveNewRow();
    this.current.set(i);
    this.onNewRow.set(false);
    this.rowSelected.set(false);
    if (col) this.currentCol.set(col);
    else if (!this.currentCol() && this.columns.length) this.currentCol.set(this.columns[0].key);
  }

  async selectRow(i: number): Promise<void> {
    await this.setCurrent(i);
    this.rowSelected.set(true);
    this.focus();
  }

  goNewRow(col: string): void {
    if (!this.allowAddNew) return;
    this.onNewRow.set(true);
    this.current.set(null);
    this.rowSelected.set(false);
    this.currentCol.set(col);
    this.beginEdit('new', col);
  }

  /** Keys typed between beginEdit and the editor receiving focus (see onKeydown). */
  private preFocus = { replace: false, buffered: false };

  beginEdit(row: number | 'new', col: string, initial?: string): void {
    const column = this.columns.find(c => c.key === col);
    if (!column || column.locked || !this.writer) return;
    const value = initial !== undefined ? initial
      : row === 'new' ? (this.newRow()[col] ?? '') : this.cellText(this.rows[row], col);
    this.editing.set({ row, col, value });
    this.preFocus = { replace: initial === undefined, buffered: false };
    const tryFocus = (n: number) => {
      const el = this.cellEditors?.first?.nativeElement;
      if (el?.isConnected) {
        el.focus();
        if (this.preFocus.buffered) { el.value = this.editing()?.value ?? el.value; el.setSelectionRange(el.value.length, el.value.length); }
        else if (initial === undefined) el.select();
        this.preFocus = { replace: false, buffered: false };
      }
      else if (n < 30) requestAnimationFrame(() => tryFocus(n + 1));
    };
    setTimeout(() => tryFocus(0));
  }

  async commitEdit(): Promise<void> {
    const e = this.editing();
    if (!e) return;
    this.editing.set(null);
    if (e.row === 'new') {
      // the add-new record collects its fields; it is written when the user leaves the line.
      // Opening a cell of the "*" line without typing changes nothing — no record is started.
      if (e.value === (this.newRow()[e.col] ?? '')) { this.focus(); return; }
      this.newRow.set({ ...this.newRow(), [e.col]: e.value });
      this.focus();
      return;
    }
    if (this.cellText(this.rows[e.row], e.col) !== e.value) {
      await this.writer!.update(e.row, e.col, e.value);
    }
    this.focus();
  }

  cancelEdit(): void {
    this.editing.set(null);
    this.focus();
  }

  /** Leaving the add-new line writes the new record (AllowAddNew). */
  async leaveNewRow(): Promise<void> {
    if (!this.onNewRow()) return;
    this.onNewRow.set(false);
    const values = this.newRow();
    this.newRow.set({});
    if (Object.keys(values).length && this.writer?.insert) {
      await this.writer.insert(values);
    }
  }

  async onGridFocusOut(e: FocusEvent): Promise<void> {
    const next = e.relatedTarget as Node | null;
    if (this.editing() || (next && this.grid?.nativeElement.contains(next))) return;
    await this.leaveNewRow();
  }

  onEditorKeydown(e: KeyboardEvent): void {
    e.stopPropagation();
    if (e.key === 'Enter' || e.key === 'Tab') { e.preventDefault(); this.commitEdit(); }
    else if (e.key === 'Escape') { e.preventDefault(); this.cancelEdit(); }
  }

  async onKeydown(e: KeyboardEvent): Promise<void> {
    const ed = this.editing();
    if (ed) {
      // Keys typed while the cell editor is still opening reach the grid, not the editor:
      // keep them in the cell instead of losing them.
      const fromEditor = (e.target as HTMLElement).closest?.('.cell-editor');
      if (!fromEditor && e.key.length === 1 && !e.ctrlKey && !e.altKey) {
        e.preventDefault();
        // F2 opens with the whole text selected, so the first key typed replaces it.
        const value = this.preFocus.replace ? e.key : ed.value + e.key;
        this.preFocus = { replace: false, buffered: true };
        this.editing.set({ ...ed, value });
      }
      return;
    }
    this.gridKeydown.emit(e);
    if (e.defaultPrevented) return;
    const n = this.rows.length;
    const c = this.current();
    const ci = this.columns.findIndex(x => x.key === this.currentCol());
    switch (e.key) {
      case 'ArrowDown':
        e.preventDefault();
        if (this.onNewRow()) return;
        if (c === null) { if (n) await this.setCurrent(0); }
        else if (c < n - 1) await this.setCurrent(c + 1);
        else if (this.allowAddNew) this.goNewRow(this.currentCol() || this.columns[0].key);
        return;
      case 'ArrowUp':
        e.preventDefault();
        if (this.onNewRow()) { if (n) await this.setCurrent(n - 1); }
        else if (n) await this.setCurrent(c === null ? 0 : Math.max(0, c - 1));
        return;
      case 'ArrowLeft': e.preventDefault(); if (ci < this.columns.length - 1) this.currentCol.set(this.columns[ci + 1].key); return;
      case 'ArrowRight': e.preventDefault(); if (ci > 0) this.currentCol.set(this.columns[ci - 1].key); return;
      case 'Home': e.preventDefault(); if (n) await this.setCurrent(0); return;
      case 'End': e.preventDefault(); if (n) await this.setCurrent(n - 1); return;
      case 'F2':
        e.preventDefault();
        if (this.onNewRow()) this.beginEdit('new', this.currentCol());
        else if (c !== null) this.beginEdit(c, this.currentCol());
        return;
      case 'Delete':
        e.preventDefault();
        if (this.allowDelete && this.rowSelected() && c !== null && this.writer?.remove) {
          this.rowSelected.set(false);
          await this.writer.remove(c);
        }
        return;
    }
    if (e.key.length === 1 && !e.ctrlKey && !e.altKey) {
      if (this.onNewRow()) { e.preventDefault(); this.beginEdit('new', this.currentCol(), e.key); }
      else if (c !== null) { e.preventDefault(); this.beginEdit(c, this.currentCol(), e.key); }
    }
  }

  onDblClick(e: MouseEvent): void {
    if ((e.target as HTMLElement).closest('.cell-editor')) return;   // selecting text while editing
    this.gridDblClick.emit();
  }

  onKeyup(e: KeyboardEvent): void {
    if (this.editing()) return;
    this.gridKeyup.emit(e);
  }

  /** After the owner reloads: keep the current record where it was. */
  keepCurrent(): void {
    const c = this.current();
    if (c !== null && c >= this.rows.length) this.current.set(this.rows.length ? this.rows.length - 1 : null);
  }
}
