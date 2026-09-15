import { Component, OnInit, DestroyRef, inject, signal, computed } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatAutocompleteSelectedEvent } from '@angular/material/autocomplete';
import { TranslateService } from '@ngx-translate/core';
import { Observable, of } from 'rxjs';
import { debounceTime, filter, switchMap, catchError } from 'rxjs/operators';
import { BorrowingService } from '../services/borrowing.service';
import {
  BorrowingRecord, BorrowingStatus,
  BorrowingBook, BorrowingOther, BookResult
} from '../models/borrowing.model';

@Component({
  standalone: false,
  selector: 'app-borrowing-detail',
  templateUrl: './borrowing-detail.component.html',
  styleUrls: ['./borrowing-detail.component.scss']
})
export class BorrowingDetailComponent implements OnInit {

  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private borrowingService = inject(BorrowingService);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);
  private fb = inject(FormBuilder);
  private destroyRef = inject(DestroyRef);

  // Main record state
  record = signal<BorrowingRecord | null>(null);
  isLoading = signal(true);
  isReturning = signal(false);

  // Sub-resource state
  books = signal<BorrowingBook[]>([]);
  others = signal<BorrowingOther[]>([]);
  booksLoading = signal(false);
  othersLoading = signal(false);
  addBookLoading = signal(false);
  addOtherLoading = signal(false);

  // Book autocomplete
  bookSearch = new FormControl('');
  bookSuggestions$!: Observable<BookResult[]>;
  selectedBookNo = signal<string | null>(null);

  // Other items inline form
  otherForm!: FormGroup;

  // Table column definitions
  readonly bookColumns = ['serial', 'bookNo', 'actions'];
  readonly otherColumns = ['serial', 'title', 'type', 'count', 'actions'];

  private currentIarNo = '';

  canReturn = computed(() => {
    const r = this.record();
    return r != null && r.returnDate == null;
  });

  status = computed<BorrowingStatus>(() => {
    const r = this.record();
    if (!r) return 'ACTIVE';
    if (r.returnDate) return 'RETURNED';
    if (r.dueDate && new Date(r.dueDate) < new Date()) return 'OVERDUE';
    return 'ACTIVE';
  });

  ngOnInit(): void {
    const iarNo = this.route.snapshot.paramMap.get('id')!;
    const serial = Number(this.route.snapshot.queryParamMap.get('serial') || 1);
    const type = Number(this.route.snapshot.queryParamMap.get('type') || 1);

    this.currentIarNo = iarNo;

    this.loadRecord(iarNo, serial, type);
    this.loadBooks(iarNo);
    this.loadOthers(iarNo);

    this.otherForm = this.fb.group({
      title: [''],
      type: [null as number | null],
      count: [null as number | null]
    });

    this.bookSuggestions$ = this.bookSearch.valueChanges.pipe(
      debounceTime(300),
      filter(v => typeof v === 'string' && v.trim().length >= 1),
      switchMap(term => this.borrowingService.searchBooks(term as string).pipe(
        catchError(() => of([]))
      ))
    );

    // Clear the pending selection when the user types again after picking
    this.bookSearch.valueChanges.pipe(
      filter(v => typeof v === 'string'),
      takeUntilDestroyed(this.destroyRef)
    ).subscribe(() => this.selectedBookNo.set(null));
  }

  displayBook = (book: BookResult | null): string =>
    book ? `${book.appNo} – ${book.activeTitleAr}` : '';

  onBookSelected(event: MatAutocompleteSelectedEvent): void {
    const book = event.option.value as BookResult;
    this.selectedBookNo.set(book.appNo);
  }

  addBook(): void {
    const bookNo = this.selectedBookNo();
    if (!bookNo) return;

    this.addBookLoading.set(true);
    this.borrowingService.addBook(this.currentIarNo, { bookNo }).subscribe({
      next: (res) => {
        this.books.update(list => [...list, res.data]);
        this.bookSearch.reset();
        this.selectedBookNo.set(null);
        this.addBookLoading.set(false);
      },
      error: () => this.addBookLoading.set(false)
    });
  }

  removeBook(serial: number): void {
    this.borrowingService.removeBook(this.currentIarNo, serial).subscribe({
      next: () => {
        this.books.update(list => list.filter(b => b.serial !== serial));
        this.snackBar.open(
          this.translate.instant('BORROWING.BOOK_REMOVED'),
          '',
          { duration: 2000 }
        );
      }
    });
  }

  addOther(): void {
    const value = this.otherForm.getRawValue();
    this.addOtherLoading.set(true);
    this.borrowingService.addOther(this.currentIarNo, value).subscribe({
      next: (res) => {
        this.others.update(list => [...list, res.data]);
        this.otherForm.reset();
        this.addOtherLoading.set(false);
      },
      error: () => this.addOtherLoading.set(false)
    });
  }

  removeOther(serial: number): void {
    this.borrowingService.removeOther(this.currentIarNo, serial).subscribe({
      next: () => {
        this.others.update(list => list.filter(o => o.serial !== serial));
        this.snackBar.open(
          this.translate.instant('BORROWING.OTHER_REMOVED'),
          '',
          { duration: 2000 }
        );
      }
    });
  }

  returnItem(): void {
    const r = this.record();
    if (!r) return;

    this.isReturning.set(true);
    const returnDate = new Date().toISOString().slice(0, 19);

    this.borrowingService.returnItem(r.iarNo, r.serial, r.borrowingType, { returnDate }).subscribe({
      next: (res) => {
        this.record.set(res.data);
        this.isReturning.set(false);
        this.snackBar.open(
          this.translate.instant('BORROWING.RETURN_SUCCESS'),
          this.translate.instant('APP.CANCEL'),
          { duration: 3000 }
        );
      },
      error: () => this.isReturning.set(false)
    });
  }

  goBack(): void {
    this.router.navigate(['/borrowing']);
  }

  private loadRecord(iarNo: string, serial: number, borrowingType: number): void {
    this.borrowingService.getById(iarNo, serial, borrowingType).subscribe({
      next: (res) => {
        this.record.set(res.data);
        this.isLoading.set(false);
      },
      error: () => {
        this.isLoading.set(false);
        this.router.navigate(['/borrowing']);
      }
    });
  }

  private loadBooks(iarNo: string): void {
    this.booksLoading.set(true);
    this.borrowingService.getBooks(iarNo).subscribe({
      next: (res) => {
        this.books.set(res.data);
        this.booksLoading.set(false);
      },
      error: () => this.booksLoading.set(false)
    });
  }

  private loadOthers(iarNo: string): void {
    this.othersLoading.set(true);
    this.borrowingService.getOthers(iarNo).subscribe({
      next: (res) => {
        this.others.set(res.data);
        this.othersLoading.set(false);
      },
      error: () => this.othersLoading.set(false)
    });
  }
}
