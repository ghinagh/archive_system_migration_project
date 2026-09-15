import { Component, OnInit, inject, signal, computed } from '@angular/core';
import { FormBuilder, FormControl, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { Observable, of, debounceTime, switchMap, catchError } from 'rxjs';
import { BorrowingService } from '../services/borrowing.service';
import { BorrowingRequest } from '../models/borrowing.model';
import { PersonsService } from '../../persons/services/persons.service';
import { CatalogueService } from '../../catalogue/services/catalogue.service';
import { Person } from '../../persons/models/person.model';
import { CatalogueItem } from '../../catalogue/models/catalogue.models';

@Component({
  standalone: false,
  selector: 'app-borrowing-form',
  templateUrl: './borrowing-form.component.html',
  styleUrls: ['./borrowing-form.component.scss']
})
export class BorrowingFormComponent implements OnInit {

  private fb = inject(FormBuilder);
  private router = inject(Router);
  private borrowingService = inject(BorrowingService);
  private personsService = inject(PersonsService);
  private catalogueService = inject(CatalogueService);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  isLoading = signal(false);

  personSearch = new FormControl('');
  catalogueSearch = new FormControl('');
  filteredPersons$: Observable<Person[]> = of([]);
  filteredCatalogues$: Observable<CatalogueItem[]> = of([]);

  form = this.fb.group({
    iarNo: ['', [Validators.required, Validators.maxLength(6)]],
    serial: [1, Validators.required],
    borrowingType: [1, Validators.required],
    personNo: ['', Validators.required],
    bookNo: ['', Validators.required],
    cause: ['', Validators.maxLength(2)],
    period: [30, [Validators.required, Validators.min(1)]],
    borrowDate: [new Date().toISOString().slice(0, 10), Validators.required],
    entity: ['', Validators.maxLength(3)]
  });

  dueDate = computed(() => {
    const borrow = this.form.get('borrowDate')?.value;
    const period = this.form.get('period')?.value;
    if (!borrow || !period) return '';
    const due = new Date(borrow);
    due.setDate(due.getDate() + period);
    return due.toISOString().slice(0, 10);
  });

  ngOnInit(): void {
    this.filteredPersons$ = this.personSearch.valueChanges.pipe(
      debounceTime(300),
      switchMap(term => {
        if (!term || term.length < 2) return of([]);
        return this.personsService.getAll(0, 10, term).pipe(
          switchMap(res => of(res.data.content)),
          catchError(() => of([]))
        );
      })
    );

    this.filteredCatalogues$ = this.catalogueSearch.valueChanges.pipe(
      debounceTime(300),
      switchMap(term => {
        if (!term || term.length < 2) return of([]);
        return this.catalogueService.getAll(0, 10).pipe(
          switchMap(res => of(res.data.content.filter(
            c => c.activeTitleAr?.toLowerCase().includes(term.toLowerCase()) || c.appNo.includes(term)
          ))),
          catchError(() => of([]))
        );
      })
    );
  }

  onPersonSelected(person: Person): void {
    this.form.get('personNo')?.setValue(person.prsNo);
  }

  onCatalogueSelected(item: CatalogueItem): void {
    this.form.get('bookNo')?.setValue(item.appNo);
  }

  displayPerson(person: Person): string {
    return person ? `${person.prsNo} - ${person.name}` : '';
  }

  displayCatalogue(item: CatalogueItem): string {
    return item ? `${item.appNo} - ${item.activeTitleAr}` : '';
  }

  onSubmit(): void {
    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }

    this.isLoading.set(true);
    const raw = this.form.getRawValue();

    const request: BorrowingRequest = {
      iarNo: raw.iarNo!,
      serial: raw.serial!,
      borrowingType: raw.borrowingType!,
      borrowDate: raw.borrowDate + 'T00:00:00',
      dueDate: this.dueDate() + 'T00:00:00',
      type: raw.borrowingType!,
      personNo: raw.personNo!,
      bookNo: raw.bookNo!,
      cause: raw.cause || '',
      period: raw.period!,
      entity: raw.entity || ''
    };

    this.borrowingService.create(request).subscribe({
      next: () => {
        this.isLoading.set(false);
        this.snackBar.open(
          this.translate.instant('APP.SUCCESS'),
          this.translate.instant('APP.CANCEL'),
          { duration: 3000 }
        );
        this.router.navigate(['/borrowing']);
      },
      error: () => this.isLoading.set(false)
    });
  }

  onCancel(): void {
    this.router.navigate(['/borrowing']);
  }
}
