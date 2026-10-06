import { Component, ElementRef, EventEmitter, Input, Output, ViewChild } from '@angular/core';
import { CdkVirtualScrollViewport } from '@angular/cdk/scrolling';
import { ThesaurusTerm } from '../models/subject-thesaurus.model';

/**
 * One Form5 MSDataListLib.DataList (ListField SUB_DESC). Arrow/Page/Home/End move the selection
 * (raising the DataList Click), every other key goes to the owning form's handlers.
 */
@Component({
  standalone: false,
  selector: 'app-thesaurus-list',
  templateUrl: './thesaurus-list.component.html',
  styleUrls: ['./thesaurus-list.component.scss']
})
export class ThesaurusListComponent {

  @Input() rows: ThesaurusTerm[] = [];
  @Input() selectedIndex: number | null = null;
  /** DataList.Enabled — a disabled list neither takes focus nor reacts to the mouse. */
  @Input() enabled = true;
  @Input() loading = false;
  @Input() idPrefix = 'thesaurus';
  @Input() ariaLabel = '';

  /** DataList Click (mouse or keyboard selection). */
  @Output() selectIndex = new EventEmitter<number>();
  @Output() rowDblClick = new EventEmitter<number>();
  @Output() listKeydown = new EventEmitter<KeyboardEvent>();
  @Output() listKeyup = new EventEmitter<KeyboardEvent>();
  /** DataList GotFocus; {@code byMouse} tells a click apart from SetFocus / Tab. */
  @Output() gotFocus = new EventEmitter<{ byMouse: boolean }>();

  @ViewChild('viewport') viewport?: CdkVirtualScrollViewport;
  @ViewChild('listBox') listBox?: ElementRef<HTMLElement>;

  readonly itemSize = 30;
  private mouseDown = false;

  focus(): void {
    if (!this.enabled) return;
    this.listBox?.nativeElement.focus();
  }

  hasFocus(): boolean {
    return !!this.listBox && document.activeElement === this.listBox.nativeElement;
  }

  onMouseDown(event: MouseEvent): void {
    event.preventDefault();
    if (!this.enabled) return;
    this.mouseDown = true;
    this.listBox?.nativeElement.focus();
    this.mouseDown = false;
  }

  onFocus(): void {
    this.gotFocus.emit({ byMouse: this.mouseDown });
  }

  onClick(index: number): void {
    if (this.enabled) this.selectIndex.emit(index);
  }

  onDblClick(index: number): void {
    if (this.enabled) this.rowDblClick.emit(index);
  }

  onKeydown(event: KeyboardEvent): void {
    const count = this.rows.length;
    const current = this.selectedIndex;
    const page = Math.max(1, Math.floor((this.viewport?.getViewportSize() ?? 300) / this.itemSize) - 1);
    let next: number | null = null;
    switch (event.key) {
      case 'ArrowDown': next = current === null ? 0 : Math.min(count - 1, current + 1); break;
      case 'ArrowUp': next = current === null ? 0 : Math.max(0, current - 1); break;
      case 'PageDown': next = current === null ? 0 : Math.min(count - 1, current + page); break;
      case 'PageUp': next = current === null ? 0 : Math.max(0, current - page); break;
      case 'Home': next = 0; break;
      case 'End': next = count - 1; break;
      default:
        this.listKeydown.emit(event);
        return;
    }
    event.preventDefault();
    if (count > 0 && next !== null && next !== current) {
      this.selectIndex.emit(next);
    }
  }

  scrollToIndex(index: number | null): void {
    const viewport = this.viewport;
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

  activeDescendant(): string | null {
    return this.selectedIndex === null ? null : `${this.idPrefix}-row-${this.selectedIndex}`;
  }
}
