import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit, inject, signal } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { NewsService } from '../services/news.service';
import { NewsItem } from '../models/news.model';

@Component({
  standalone: false,
  selector: 'app-news-detail',
  templateUrl: './news-detail.component.html',
  styleUrls: ['./news-detail.component.scss']
})
export class NewsDetailComponent implements OnInit {

  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private newsService = inject(NewsService);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  item = signal<NewsItem | null>(null);
  isLoading = signal(true);
  isEditing = signal(false);
  addingKeyword = signal(false);
  newKeyword = signal('');

  ngOnInit(): void {
    const newsNo = this.route.snapshot.paramMap.get('id');
    if (!newsNo) return;

    this.newsService.getById(newsNo).subscribe({
      next: (res) => {
        this.item.set(res.data);
        this.isLoading.set(false);
      },
      error: () => {
        this.isLoading.set(false);
        this.router.navigate(['/news']);
      }
    });
  }

  toggleEdit(): void {
    this.isEditing.update(v => !v);
  }

  onSaved(): void {
    this.isEditing.set(false);
    const newsNo = this.item()?.newsNo;
    if (newsNo) {
      this.newsService.getById(newsNo).subscribe({
        next: (res) => this.item.set(res.data)
      });
    }
    this.snackBar.open(this.translate.instant('APP.SUCCESS'), this.translate.instant('APP.CANCEL'), { duration: 3000 });
  }

  onDelete(): void {
    const newsNo = this.item()?.newsNo;
    if (!newsNo || !confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;

    this.newsService.delete(newsNo).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), this.translate.instant('APP.CANCEL'), { duration: 3000 });
        this.router.navigate(['/news']);
      },
      error: (err: HttpErrorResponse) => {
        this.snackBar.open(this.translate.instant('NEWS.DELETE_ERROR'), this.translate.instant('APP.CANCEL'), { duration: 3000 });
      }
    });
  }

  onAddKeyword(): void {
    const newsNo = this.item()?.newsNo;
    const word = this.newKeyword().trim();
    if (!newsNo || !word) return;

    this.newsService.addKeyword(newsNo, word).subscribe({
      next: (res) => {
        const current = this.item();
        if (current) {
          this.item.set({ ...current, keywords: res.data });
        }
        this.newKeyword.set('');
        this.addingKeyword.set(false);
      }
    });
  }

  onRemoveKeyword(word: string): void {
    const newsNo = this.item()?.newsNo;
    if (!newsNo) return;

    this.newsService.removeKeyword(newsNo, word).subscribe({
      next: () => {
        const current = this.item();
        if (current) {
          this.item.set({ ...current, keywords: current.keywords.filter(k => k !== word) });
        }
      }
    });
  }

  goBack(): void {
    this.router.navigate(['/news']);
  }
}
