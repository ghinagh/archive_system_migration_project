import { Component, OnInit, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatAutocompleteSelectedEvent } from '@angular/material/autocomplete';
import { FormControl } from '@angular/forms';
import { debounceTime, distinctUntilChanged, switchMap } from 'rxjs/operators';
import { of } from 'rxjs';
import { TranslateService } from '@ngx-translate/core';
import { BooksService } from '../services/books.service';
import { AutocompleteService, AuthorOption } from '../../../core/services/autocomplete.service';
import { Book, BookRequest } from '../models/book.model';

@Component({
  standalone: false,
  selector: 'app-book-form',
  templateUrl: './book-form.component.html',
  styleUrls: ['./book-form.component.scss']
})
export class BookFormComponent implements OnInit {

  private fb = inject(FormBuilder);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private svc = inject(BooksService);
  private autoSvc = inject(AutocompleteService);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  isEdit = signal(false);
  isLoading = signal(false);
  isSaving = signal(false);
  appNoParam = signal<string | null>(null);

  publisherCtrl = new FormControl('');
  publisherOptions = signal<AuthorOption[]>([]);
  selectedPublisherId = signal<number | null>(null);

  translatorCtrl = new FormControl('');
  translatorOptions = signal<AuthorOption[]>([]);
  selectedTranslatorId = signal<number | null>(null);

  form = this.fb.group({
    appNo: ['', Validators.required],
    activeTitleAr: [''],
    additionalCatalogueTitle: [''],
    selectNo: [''],
    documentType: [''],
    publishLocation: [''],
    publishType: [''],
    publishDate: [null as string | null],
    edition: [null as number | null],
    pageCount: [null as number | null],
    materialCount: [''],
    volume: [null as number | null],
    price: [null as number | null],
    lang: [''],
    lang1: [''],
    lang3: [''],
    cover: [''],
    isSeries: [false],
    seriesTitle: [''],
    seriesNo: [null as number | null],
    partNo: [null as number | null],
    regNo: [null as number | null],
    khalif: [''],
    rdmk: [''],
    quarter: [''],
    save: [null as number | null],
    free: [null as number | null],
    acquisitionDate: [null as string | null],
    content: [''],
    memo: [''],
    result: [''],
    copyCount: [null as number | null],
    volume1: [null as number | null],
    bindingFrom: [null as number | null],
    bindingTo: [null as number | null],
    partFrom: [null as number | null],
    partTo: [null as number | null],
    yearPublished: [null as number | null],
    yearType: [null as number | null],
    borrowingNo: [''],
    status: ['']
  });

  ngOnInit(): void {
    const appNo = this.route.snapshot.paramMap.get('appNo');
    if (appNo) {
      this.isEdit.set(true);
      this.appNoParam.set(appNo);
      this.loadBook(appNo);
    }

    this.publisherCtrl.valueChanges.pipe(
      debounceTime(300),
      distinctUntilChanged(),
      switchMap(val => val && val.length >= 2
        ? this.autoSvc.searchAuthors(val)
        : of({ data: [], success: true, timestamp: '' })
      )
    ).subscribe(r => this.publisherOptions.set(r.data));

    this.translatorCtrl.valueChanges.pipe(
      debounceTime(300),
      distinctUntilChanged(),
      switchMap(val => val && val.length >= 2
        ? this.autoSvc.searchAuthors(val)
        : of({ data: [], success: true, timestamp: '' })
      )
    ).subscribe(r => this.translatorOptions.set(r.data));
  }

  private loadBook(appNo: string): void {
    this.isLoading.set(true);
    this.svc.getById(appNo).subscribe({
      next: res => {
        const b: Book = res.data;
        this.form.patchValue({
          appNo: b.appNo,
          activeTitleAr: b.catalogueTitle,
          additionalCatalogueTitle: b.additionalTitle,
          selectNo: b.selectNo,
          documentType: b.documentType,
          publishLocation: b.publishLocation,
          publishType: b.publishType,
          publishDate: b.publishDate,
          edition: b.edition,
          pageCount: b.pageCount,
          materialCount: b.materialCount,
          volume: b.volume,
          price: b.price,
          lang: b.lang,
          lang1: b.lang1,
          lang3: b.lang3,
          cover: b.cover,
          isSeries: b.isSeries,
          seriesTitle: b.seriesTitle,
          seriesNo: b.seriesNo,
          partNo: b.partNo,
          regNo: b.regNo,
          khalif: b.khalif,
          rdmk: b.rdmk,
          quarter: b.quarter,
          save: b.save,
          free: b.free,
          acquisitionDate: b.acquisitionDate,
          content: b.content,
          memo: b.memo,
          result: b.result,
          copyCount: b.copyCount,
          volume1: b.volume1,
          bindingFrom: b.bindingFrom,
          bindingTo: b.bindingTo,
          partFrom: b.partFrom,
          partTo: b.partTo,
          yearPublished: b.yearPublished,
          yearType: b.yearType,
          borrowingNo: b.borrowingNo,
          status: b.status
        });
        if (b.publisher) {
          this.selectedPublisherId.set(b.publisher);
          this.publisherCtrl.setValue(String(b.publisher), { emitEvent: false });
        }
        if (b.translator) {
          this.selectedTranslatorId.set(b.translator);
          this.translatorCtrl.setValue(String(b.translator), { emitEvent: false });
        }
        this.isLoading.set(false);
      },
      error: () => { this.isLoading.set(false); this.router.navigate(['/books']); }
    });
  }

  displayAuthor(opt: AuthorOption | string): string {
    if (!opt) return '';
    if (typeof opt === 'string') return opt;
    return opt.name;
  }

  onPublisherSelected(e: MatAutocompleteSelectedEvent): void {
    const opt = e.option.value as AuthorOption;
    this.selectedPublisherId.set(opt.id);
    this.publisherCtrl.setValue(opt.name, { emitEvent: false });
  }

  onTranslatorSelected(e: MatAutocompleteSelectedEvent): void {
    const opt = e.option.value as AuthorOption;
    this.selectedTranslatorId.set(opt.id);
    this.translatorCtrl.setValue(opt.name, { emitEvent: false });
  }

  onSubmit(): void {
    if (this.form.invalid) return;
    const v = this.form.value;
    const req: BookRequest = {
      appNo: v.appNo ?? '',
      activeTitleAr: v.activeTitleAr ?? '',
      additionalCatalogueTitle: v.additionalCatalogueTitle ?? '',
      selectNo: v.selectNo ?? '',
      documentType: v.documentType ?? '',
      publishLocation: v.publishLocation ?? '',
      publisher: this.selectedPublisherId(),
      publishType: v.publishType ?? '',
      publishDate: v.publishDate ?? null,
      edition: v.edition ?? null,
      pageCount: v.pageCount ?? null,
      materialCount: v.materialCount ?? '',
      volume: v.volume ?? null,
      price: v.price ?? null,
      lang: v.lang ?? '',
      lang1: v.lang1 ?? '',
      lang3: v.lang3 ?? '',
      cover: v.cover ?? '',
      isSeries: v.isSeries ?? false,
      seriesTitle: v.seriesTitle ?? '',
      seriesNo: v.seriesNo ?? null,
      partNo: v.partNo ?? null,
      regNo: v.regNo ?? null,
      khalif: v.khalif ?? '',
      rdmk: v.rdmk ?? '',
      quarter: v.quarter ?? '',
      save: v.save ?? null,
      free: v.free ?? null,
      acquisitionDate: v.acquisitionDate ?? null,
      translator: this.selectedTranslatorId(),
      content: v.content ?? '',
      memo: v.memo ?? '',
      result: v.result ?? '',
      copyCount: v.copyCount ?? null,
      volume1: v.volume1 ?? null,
      bindingFrom: v.bindingFrom ?? null,
      bindingTo: v.bindingTo ?? null,
      partFrom: v.partFrom ?? null,
      partTo: v.partTo ?? null,
      yearPublished: v.yearPublished ?? null,
      yearType: v.yearType ?? null,
      borrowingNo: v.borrowingNo ?? '',
      status: v.status ?? '',
      additionalTitle: v.additionalCatalogueTitle ?? ''
    };

    this.isSaving.set(true);
    const op$ = this.isEdit()
      ? this.svc.update(this.appNoParam()!, req)
      : this.svc.createWithMain(req);

    op$.subscribe({
      next: res => {
        this.isSaving.set(false);
        this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.router.navigate(['/books', res.data.appNo]);
      },
      error: () => {
        this.isSaving.set(false);
        this.snack.open(this.t.instant('APP.ERROR'), '', { duration: 3000 });
      }
    });
  }

  cancel(): void { this.router.navigate(['/books']); }
}
