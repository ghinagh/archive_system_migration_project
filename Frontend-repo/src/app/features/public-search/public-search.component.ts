import { Component, OnInit, inject, signal, computed } from '@angular/core';
import { Router } from '@angular/router';
import { PublicSearchService } from './services/public-search.service';
import { PublicSearchResult, SearchType } from './models/public-search.model';
import { PageEvent } from '@angular/material/paginator';

interface TypeFilter {
  value: SearchType;
  labelKey: string;
}

@Component({
  standalone: false,
  selector: 'app-public-search',
  templateUrl: './public-search.component.html',
  styleUrls: ['./public-search.component.scss']
})
export class PublicSearchComponent implements OnInit {
  private searchService = inject(PublicSearchService);
  private router = inject(Router);

  readonly typeFilters: TypeFilter[] = [
    { value: 'all',     labelKey: 'PUBLIC_SEARCH.TYPE_ALL' },
    { value: 'book',    labelKey: 'PUBLIC_SEARCH.TYPE_BOOK' },
    { value: 'article', labelKey: 'PUBLIC_SEARCH.TYPE_ARTICLE' },
    { value: 'news',    labelKey: 'PUBLIC_SEARCH.TYPE_NEWS' }
  ];

  queryInput = signal('');
  selectedType = signal<SearchType>('all');
  results = signal<PublicSearchResult[]>([]);
  totalElements = signal(0);
  pageIndex = signal(0);
  pageSize = signal(10);
  isLoading = signal(false);
  hasSearched = signal(false);

  isEmpty = computed(() => this.hasSearched() && !this.isLoading() && this.results().length === 0);

  ngOnInit(): void {}

  onSearch(): void {
    this.pageIndex.set(0);
    this.doSearch();
  }

  selectType(type: SearchType): void {
    this.selectedType.set(type);
    if (this.hasSearched()) {
      this.pageIndex.set(0);
      this.doSearch();
    }
  }

  onPageChange(event: PageEvent): void {
    this.pageIndex.set(event.pageIndex);
    this.pageSize.set(event.pageSize);
    this.doSearch();
  }

  goToLogin(): void {
    this.router.navigate(['/auth/login']);
  }

  private doSearch(): void {
    const q = this.queryInput().trim();
    this.isLoading.set(true);
    this.hasSearched.set(true);

    this.searchService.search(q, this.selectedType(), this.pageIndex(), this.pageSize()).subscribe({
      next: (res) => {
        this.results.set(res.data?.content ?? []);
        this.totalElements.set(res.data?.totalElements ?? 0);
        this.isLoading.set(false);
      },
      error: () => {
        this.results.set([]);
        this.totalElements.set(0);
        this.isLoading.set(false);
      }
    });
  }

  typeLabel(type: string): string {
    const map: Record<string, string> = {
      book: 'PUBLIC_SEARCH.TYPE_BOOK',
      article: 'PUBLIC_SEARCH.TYPE_ARTICLE',
      news: 'PUBLIC_SEARCH.TYPE_NEWS',
      catalogue: 'PUBLIC_SEARCH.TYPE_CATALOGUE'
    };
    return map[type] ?? type;
  }
}
