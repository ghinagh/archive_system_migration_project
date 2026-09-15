import { inject } from '@angular/core';
import { MatPaginatorIntl } from '@angular/material/paginator';
import { TranslateService } from '@ngx-translate/core';

/**
 * MatPaginator ships with English-only default labels (MatPaginatorIntl has no
 * built-in i18n hook). This factory builds a translated instance and keeps it
 * in sync with the active language via TranslateService.onLangChange.
 */
export function paginatorIntlFactory(): MatPaginatorIntl {
  const translate = inject(TranslateService);
  const intl = new MatPaginatorIntl();

  const rangeLabelKey = 'PAGINATOR.RANGE_LABEL';

  const applyTranslations = () => {
    intl.itemsPerPageLabel = translate.instant('PAGINATOR.ITEMS_PER_PAGE');
    intl.nextPageLabel = translate.instant('PAGINATOR.NEXT_PAGE');
    intl.previousPageLabel = translate.instant('PAGINATOR.PREVIOUS_PAGE');
    intl.firstPageLabel = translate.instant('PAGINATOR.FIRST_PAGE');
    intl.lastPageLabel = translate.instant('PAGINATOR.LAST_PAGE');
    intl.getRangeLabel = (page: number, pageSize: number, length: number): string => {
      if (length === 0 || pageSize === 0) {
        return translate.instant('PAGINATOR.RANGE_EMPTY', { length });
      }
      const startIndex = page * pageSize;
      const endIndex = Math.min(startIndex + pageSize, length);
      return translate.instant(rangeLabelKey, { start: startIndex + 1, end: endIndex, length });
    };
    intl.changes.next();
  };

  applyTranslations();
  translate.onLangChange.subscribe(applyTranslations);

  return intl;
}
