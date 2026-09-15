import { Component, OnInit, inject, signal } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { PeriodicalsService } from '../services/periodicals.service';
import { PeriodicalRequest } from '../models/periodical.model';

@Component({
  standalone: false,
  selector: 'app-periodical-form',
  templateUrl: './periodical-form.component.html',
  styleUrls: ['./periodical-form.component.scss']
})
export class PeriodicalFormComponent implements OnInit {

  private fb = inject(FormBuilder);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private svc = inject(PeriodicalsService);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  isEdit = signal(false);
  isLoading = signal(false);
  isSaving = signal(false);
  perNoParam = signal<number | null>(null);

  form = this.fb.group({
    name: [''],
    publishLocation: [null as number | null],
    startDate: [null as string | null],
    lang: [''],
    rdmd: [''],
    type: [null as number | null],
    geo: [''],
    type1: [''],
    frequency: [''],
    address: [''],
    phone: [''],
    amount: [null as number | null],
    price: [null as number | null],
    price1: [null as number | null],
    publisher: [null as number | null],
    pub: [''],
    institution: [''],
    editor: [''],
    director: [''],
    president: [''],
    fax: [''],
    creator: [''],
    email: [''],
    website: [''],
    date: [null as string | null],
    utils: [''],
    geo1: [''],
    tah1: ['']
  });

  ngOnInit(): void {
    const perNo = this.route.snapshot.paramMap.get('perNo');
    if (perNo) {
      this.isEdit.set(true);
      this.perNoParam.set(Number(perNo));
      this.loadPeriodical(Number(perNo));
    }
  }

  private loadPeriodical(perNo: number): void {
    this.isLoading.set(true);
    this.svc.getById(perNo).subscribe({
      next: res => {
        const p = res.data;
        this.form.patchValue({
          name: p.name,
          publishLocation: p.publishLocation,
          startDate: p.startDate,
          lang: p.lang,
          rdmd: p.rdmd,
          type: p.type,
          geo: p.geo,
          type1: p.type1,
          frequency: p.frequency,
          address: p.address,
          phone: p.phone,
          amount: p.amount,
          price: p.price,
          price1: p.price1,
          publisher: p.publisher,
          pub: p.pub,
          institution: p.institution,
          editor: p.editor,
          director: p.director,
          president: p.president,
          fax: p.fax,
          creator: p.creator,
          email: p.email,
          website: p.website,
          date: p.date,
          utils: p.utils,
          geo1: p.geo1,
          tah1: p.tah1
        });
        this.isLoading.set(false);
      },
      error: () => { this.isLoading.set(false); this.router.navigate(['/periodicals']); }
    });
  }

  onSubmit(): void {
    const v = this.form.value;
    const req: PeriodicalRequest = {
      name: v.name ?? '',
      publishLocation: v.publishLocation ?? null,
      startDate: v.startDate ?? null,
      lang: v.lang ?? '',
      rdmd: v.rdmd ?? '',
      type: v.type ?? null,
      geo: v.geo ?? '',
      type1: v.type1 ?? '',
      frequency: v.frequency ?? '',
      address: v.address ?? '',
      phone: v.phone ?? '',
      amount: v.amount ?? null,
      price: v.price ?? null,
      price1: v.price1 ?? null,
      publisher: v.publisher ?? null,
      pub: v.pub ?? '',
      institution: v.institution ?? '',
      editor: v.editor ?? '',
      director: v.director ?? '',
      president: v.president ?? '',
      fax: v.fax ?? '',
      creator: v.creator ?? '',
      email: v.email ?? '',
      website: v.website ?? '',
      date: v.date ?? null,
      utils: v.utils ?? '',
      geo1: v.geo1 ?? '',
      tah1: v.tah1 ?? ''
    };

    this.isSaving.set(true);
    const op$ = this.isEdit()
      ? this.svc.update(this.perNoParam()!, req)
      : this.svc.create(req);

    op$.subscribe({
      next: res => {
        this.isSaving.set(false);
        this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.router.navigate(['/periodicals', res.data.perNo]);
      },
      error: () => {
        this.isSaving.set(false);
        this.snack.open(this.t.instant('APP.ERROR'), '', { duration: 3000 });
      }
    });
  }

  cancel(): void { this.router.navigate(['/periodicals']); }
}
