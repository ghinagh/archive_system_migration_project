import { Component, EventEmitter, Output, inject, signal } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { TranslateService } from '@ngx-translate/core';

export interface NewsFilterCriteria {
  title?: string;
  docType?: string;
  dateFrom?: string;
  dateTo?: string;
  publication?: number;
  sort?: string;
}

@Component({
  standalone: false,
  selector: 'app-news-sort-filter',
  templateUrl: './news-sort-filter.component.html',
  styleUrls: ['./news-sort-filter.component.scss']
})
export class NewsSortFilterComponent {

  @Output() filterChanged = new EventEmitter<NewsFilterCriteria>();
  @Output() filterCleared = new EventEmitter<void>();

  private fb = inject(FormBuilder);
  private translate = inject(TranslateService);

  expanded = signal(false);

  form = this.fb.group({
    title: [''],
    docType: [''],
    dateFrom: [null as Date | null],
    dateTo: [null as Date | null],
    publication: [null as number | null],
    sort: ['newsDte']
  });

  sortOptions = [
    { value: 'newsTit1', labelKey: 'NEWS.ARABIC_TITLE' },
    { value: 'newsDte', labelKey: 'NEWS.DATE' },
    { value: 'newsDoc', labelKey: 'NEWS.DOC_TYPE' }
  ];

  onApply(): void {
    const val = this.form.value;
    this.filterChanged.emit({
      title: val.title || undefined,
      docType: val.docType || undefined,
      dateFrom: val.dateFrom ? new Date(val.dateFrom).toISOString() : undefined,
      dateTo: val.dateTo ? new Date(val.dateTo).toISOString() : undefined,
      publication: val.publication ?? undefined,
      sort: val.sort || undefined
    });
  }

  onClear(): void {
    this.form.reset({ sort: 'newsDte' });
    this.filterCleared.emit();
  }
}
