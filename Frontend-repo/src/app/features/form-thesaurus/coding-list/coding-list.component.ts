import { Component, ElementRef, EventEmitter, Input, Output, ViewChild } from '@angular/core';
import { CdkVirtualScrollViewport } from '@angular/cdk/scrolling';

/**
 * One coding.frm list (MSDBCtls.DBList / MSDataListLib.DataList). Arrow/Page/Home/End move the
 * selection (raising the control's Click); a printable character jumps to the next line starting
 * with it (the controls' default MatchEntry); every other key — and the printable ones too, for the
 * form's KeyPress handlers — goes to the owning screen.
 */
@Component({
  standalone: false,
  selector: 'app-coding-list',
  templateUrl: './coding-list.component.html',
  styleUrls: ['./coding-list.component.scss']
})
export class CodingListComponent {

  /** The ListField text of each row. */
  @Input() labels: (string | null)[] = [];
  @Input() selectedIndex: number | null = null;
  /** Control.Enabled — a disabled list neither takes focus nor reacts to the mouse. */
  @Input() enabled = true;
  @Input() loading = false;
  @Input() idPrefix = 'coding';
  @Input() ariaLabel = '';
  @Input() height = 260;

  @Output() selectIndex = new EventEmitter<number>();
  @Output() rowDblClick = new EventEmitter<number>();
  @Output() listKeydown = new EventEmitter<KeyboardEvent>();
  @Output() listKeyup = new EventEmitter<KeyboardEvent>();
  /** Arrow/Page/Home/End — moved by the list itself, reported for the form's KeyDown handlers. */
  @Output() navKeydown = new EventEmitter<KeyboardEvent>();

  @ViewChild('viewport') viewport?: CdkVirtualScrollViewport;
  @ViewChild('listBox') listBox?: ElementRef<HTMLElement>;

  readonly itemSize = 28;

  focus(): void {
    if (this.enabled) this.listBox?.nativeElement.focus();
  }

  onMouseDown(event: MouseEvent): void {
    event.preventDefault();
    if (this.enabled) this.listBox?.nativeElement.focus();
  }

  onClick(index: number): void {
    if (this.enabled) this.selectIndex.emit(index);
  }

  onDblClick(index: number): void {
    if (this.enabled) this.rowDblClick.emit(index);
  }

  onKeydown(event: KeyboardEvent): void {
    const count = this.labels.length;
    const current = this.selectedIndex;
    const page = Math.max(1, Math.floor(this.height / this.itemSize) - 1);
    let next: number | null = null;
    switch (event.key) {
      case 'ArrowDown': next = current === null ? 0 : Math.min(count - 1, current + 1); break;
      case 'ArrowUp': next = current === null ? 0 : Math.max(0, current - 1); break;
      case 'PageDown': next = current === null ? 0 : Math.min(count - 1, current + page); break;
      case 'PageUp': next = current === null ? 0 : Math.max(0, current - page); break;
      case 'Home': next = 0; break;
      case 'End': next = count - 1; break;
      default:
        if (event.key.length === 1 && !event.ctrlKey && !event.altKey && !event.metaKey && count > 0) {
          this.matchEntry(event.key);
        }
        this.listKeydown.emit(event);
        return;
    }
    event.preventDefault();
    this.navKeydown.emit(event);
    if (count > 0 && next !== null && next !== current) this.selectIndex.emit(next);
  }

  /** MatchEntry basic: the next line (wrapping) whose text starts with the typed character. */
  private matchEntry(ch: string): void {
    const n = this.labels.length;
    const start = this.selectedIndex === null ? 0 : this.selectedIndex + 1;
    const c = ch.toLowerCase();
    for (let k = 0; k < n; k++) {
      const i = (start + k) % n;
      if ((this.labels[i] ?? '').toLowerCase().startsWith(c)) {
        if (i !== this.selectedIndex) this.selectIndex.emit(i);
        return;
      }
    }
  }

  scrollToIndex(index: number | null): void {
    const viewport = this.viewport;
    if (index === null || !viewport) return;
    const top = index * this.itemSize;
    const offset = viewport.measureScrollOffset('top');
    const height = viewport.getViewportSize();
    if (top < offset) viewport.scrollToOffset(top);
    else if (top + this.itemSize > offset + height) viewport.scrollToOffset(top + this.itemSize - height);
  }

  activeDescendant(): string | null {
    return this.selectedIndex === null ? null : `${this.idPrefix}-row-${this.selectedIndex}`;
  }
}
