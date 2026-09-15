import { Component, DestroyRef, inject, signal, computed } from '@angular/core';
import { FormControl } from '@angular/forms';
import { Router } from '@angular/router';
import { debounceTime, distinctUntilChanged, switchMap, catchError, of } from 'rxjs';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { MatAutocompleteSelectedEvent } from '@angular/material/autocomplete';
import { SearchService } from '../../../core/services/search.service';
import { SearchResult } from '../../../core/models/search.models';

interface ResultGroup {
  type: string;
  items: SearchResult[];
}

@Component({
  standalone: false,
  selector: 'app-global-search',
  templateUrl: './global-search.component.html',
  styleUrls: ['./global-search.component.scss']
})
export class GlobalSearchComponent {

  private searchService = inject(SearchService);
  private router = inject(Router);
  private destroyRef = inject(DestroyRef);

  searchControl = new FormControl<string>('');
  results = signal<SearchResult[]>([]);
  isLoading = signal(false);

  groupedResults = computed<ResultGroup[]>(() => {
    const groups = new Map<string, SearchResult[]>();
    for (const r of this.results()) {
      const list = groups.get(r.typeBadge) ?? [];
      list.push(r);
      groups.set(r.typeBadge, list);
    }
    return Array.from(groups.entries()).map(([type, items]) => ({ type, items }));
  });

  displayFn = (value: SearchResult | string | null): string => {
    if (!value) return '';
    if (typeof value === 'string') return value;
    return value.title ?? '';
  };

  constructor() {
    this.searchControl.valueChanges.pipe(
      debounceTime(300),
      distinctUntilChanged(),
      switchMap(term => {
        if (!term || typeof term !== 'string' || term.trim().length < 2) {
          this.results.set([]);
          this.isLoading.set(false);
          return of(null);
        }
        this.isLoading.set(true);
        return this.searchService.search(term.trim()).pipe(
          catchError(() => of(null))
        );
      }),
      takeUntilDestroyed(this.destroyRef)
    ).subscribe(response => {
      this.isLoading.set(false);
      this.results.set(response?.data ?? []);
    });
  }

  onOptionSelected(event: MatAutocompleteSelectedEvent): void {
    const result: SearchResult = event.option.value;
    this.router.navigateByUrl(result.route);
    this.searchControl.setValue('', { emitEvent: false });
    this.results.set([]);
  }
}
