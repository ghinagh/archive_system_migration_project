import { Component, OnInit, inject, signal } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ArticlesService } from '../services/articles.service';
import { Article, ArticleSubject, ArticleDescriptor } from '../models/article.model';

@Component({
  standalone: false,
  selector: 'app-article-detail',
  templateUrl: './article-detail.component.html',
  styleUrls: ['./article-detail.component.scss']
})
export class ArticleDetailComponent implements OnInit {

  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private svc = inject(ArticlesService);

  item = signal<Article | null>(null);
  subjects = signal<ArticleSubject[]>([]);
  descriptors = signal<ArticleDescriptor[]>([]);
  isLoading = signal(true);

  ngOnInit(): void {
    const appNo = this.route.snapshot.paramMap.get('appNo');
    if (!appNo) { this.router.navigate(['/articles']); return; }

    this.svc.getById(appNo).subscribe({
      next: res => {
        this.item.set(res.data);
        this.isLoading.set(false);
        this.loadRelated(appNo);
      },
      error: () => { this.isLoading.set(false); this.router.navigate(['/articles']); }
    });
  }

  private loadRelated(appNo: string): void {
    this.svc.getSubjects(appNo).subscribe({ next: r => this.subjects.set(r.data), error: () => {} });
    this.svc.getDescriptors(appNo).subscribe({ next: r => this.descriptors.set(r.data), error: () => {} });
  }

  goBack(): void { this.router.navigate(['/articles']); }
  edit(): void { this.router.navigate(['/articles', this.item()!.appNo, 'edit']); }
}
