import { Component, EventEmitter, Input, OnInit, Output, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { NewsService } from '../services/news.service';
import { NewsItem, NewsRequest } from '../models/news.model';

@Component({
  standalone: false,
  selector: 'app-news-form',
  templateUrl: './news-form.component.html',
  styleUrls: ['./news-form.component.scss']
})
export class NewsFormComponent implements OnInit {

  @Input() editData: NewsItem | null = null;
  @Output() saved = new EventEmitter<void>();
  @Output() cancelled = new EventEmitter<void>();

  private fb = inject(FormBuilder);
  private newsService = inject(NewsService);
  private router = inject(Router);

  isLoading = signal(false);
  isEditMode = signal(false);

  form = this.fb.group({
    newsNo: ['', [Validators.required, Validators.maxLength(7)]],
    newsDoc: ['', Validators.maxLength(2)],
    newsDteD: [null as Date | null],
    newsDte: [null as Date | null],
    newsNum: [null as number | null],
    newsTit1: ['', [Validators.required, Validators.maxLength(75)]],
    newsTit2: ['', Validators.maxLength(75)],
    newsDesT: ['', Validators.maxLength(2)],
    newsDesD: [null as Date | null],
    newsDesP: [null as number | null],
    newsPub: [null as number | null],
    newsDesN: ['', Validators.maxLength(9)],
    newsMlh: [null as number | null]
  });

  ngOnInit(): void {
    if (this.editData) {
      this.isEditMode.set(true);
      this.form.patchValue({
        ...this.editData,
        newsDteD: this.editData.newsDteD ? new Date(this.editData.newsDteD) : null,
        newsDte: this.editData.newsDte ? new Date(this.editData.newsDte) : null,
        newsDesD: this.editData.newsDesD ? new Date(this.editData.newsDesD) : null
      });
      this.form.get('newsNo')?.disable();
    }
  }

  onSubmit(): void {
    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }

    this.isLoading.set(true);
    const rawValue = this.form.getRawValue() as NewsRequest;

    if (this.isEditMode()) {
      this.newsService.update(rawValue.newsNo, rawValue).subscribe({
        next: () => {
          this.isLoading.set(false);
          this.saved.emit();
        },
        error: () => this.isLoading.set(false)
      });
    } else {
      this.newsService.create(rawValue).subscribe({
        next: () => {
          this.isLoading.set(false);
          this.router.navigate(['/news']);
        },
        error: () => this.isLoading.set(false)
      });
    }
  }

  onCancel(): void {
    if (this.isEditMode()) {
      this.cancelled.emit();
    } else {
      this.router.navigate(['/news']);
    }
  }
}
