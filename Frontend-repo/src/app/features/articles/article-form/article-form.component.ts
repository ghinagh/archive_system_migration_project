import { Component, OnInit, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { FormControl } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatAutocompleteSelectedEvent } from '@angular/material/autocomplete';
import { debounceTime, distinctUntilChanged, switchMap } from 'rxjs/operators';
import { of } from 'rxjs';
import { TranslateService } from '@ngx-translate/core';
import { ArticlesService } from '../services/articles.service';
import { AutocompleteService, PeriodicalOption } from '../../../core/services/autocomplete.service';
import { ArticleRequest } from '../models/article.model';

@Component({
  standalone: false,
  selector: 'app-article-form',
  templateUrl: './article-form.component.html',
  styleUrls: ['./article-form.component.scss']
})
export class ArticleFormComponent implements OnInit {

  private fb = inject(FormBuilder);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private svc = inject(ArticlesService);
  private autoSvc = inject(AutocompleteService);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  isEdit = signal(false);
  isLoading = signal(false);
  isSaving = signal(false);
  appNoParam = signal<string | null>(null);

  periodicalCtrl = new FormControl('');
  periodicalOptions = signal<PeriodicalOption[]>([]);
  selectedPerNo = signal<number | null>(null);

  form = this.fb.group({
    appNo: ['', Validators.required],
    year: [null as number | null],
    volume: [null as number | null],
    articleNo: [null as number | null],
    date: [null as string | null],
    subjectType: [''],
    pageNo: [''],
    cote: [''],
    serial: [''],
    filmNo: [''],
    type: [null as number | null],
    lang: [''],
    choice: [null as number | null],
    pictureCode: ['']
  });

  ngOnInit(): void {
    const appNo = this.route.snapshot.paramMap.get('appNo');
    if (appNo) {
      this.isEdit.set(true);
      this.appNoParam.set(appNo);
      this.loadArticle(appNo);
    }

    this.periodicalCtrl.valueChanges.pipe(
      debounceTime(300),
      distinctUntilChanged(),
      switchMap(val => val && val.length >= 2
        ? this.autoSvc.searchPeriodicals(val)
        : of({ data: [], success: true, timestamp: '' })
      )
    ).subscribe(r => this.periodicalOptions.set(r.data));
  }

  private loadArticle(appNo: string): void {
    this.isLoading.set(true);
    this.svc.getById(appNo).subscribe({
      next: res => {
        const a = res.data;
        this.form.patchValue({
          appNo: a.appNo,
          year: a.year,
          volume: a.volume,
          articleNo: a.articleNo,
          date: a.date,
          subjectType: a.subjectType,
          pageNo: a.pageNo,
          cote: a.cote,
          serial: a.serial,
          filmNo: a.filmNo,
          type: a.type,
          lang: a.lang,
          choice: a.choice,
          pictureCode: a.pictureCode
        });
        if (a.perNo) {
          this.selectedPerNo.set(a.perNo);
          this.periodicalCtrl.setValue(a.periodicalName || String(a.perNo), { emitEvent: false });
        }
        this.isLoading.set(false);
      },
      error: () => { this.isLoading.set(false); this.router.navigate(['/articles']); }
    });
  }

  displayPeriodical(opt: PeriodicalOption | string): string {
    if (!opt) return '';
    if (typeof opt === 'string') return opt;
    return opt.name;
  }

  onPeriodicalSelected(e: MatAutocompleteSelectedEvent): void {
    const opt = e.option.value as PeriodicalOption;
    this.selectedPerNo.set(opt.perNo);
    this.periodicalCtrl.setValue(opt.name, { emitEvent: false });
  }

  onSubmit(): void {
    if (this.form.invalid) return;
    const v = this.form.value;
    const req: ArticleRequest = {
      appNo: v.appNo ?? '',
      perNo: this.selectedPerNo(),
      year: v.year ?? null,
      volume: v.volume ?? null,
      articleNo: v.articleNo ?? null,
      date: v.date ?? null,
      subjectType: v.subjectType ?? '',
      pageNo: v.pageNo ?? '',
      cote: v.cote ?? '',
      serial: v.serial ?? '',
      filmNo: v.filmNo ?? '',
      type: v.type ?? null,
      lang: v.lang ?? '',
      choice: v.choice ?? null,
      pictureCode: v.pictureCode ?? ''
    };

    this.isSaving.set(true);
    const op$ = this.isEdit()
      ? this.svc.update(this.appNoParam()!, req)
      : this.svc.createWithMain(req);

    op$.subscribe({
      next: res => {
        this.isSaving.set(false);
        this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.router.navigate(['/articles', res.data.appNo]);
      },
      error: () => {
        this.isSaving.set(false);
        this.snack.open(this.t.instant('APP.ERROR'), '', { duration: 3000 });
      }
    });
  }

  cancel(): void { this.router.navigate(['/articles']); }
}
