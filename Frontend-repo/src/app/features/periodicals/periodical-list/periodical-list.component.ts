import { Component, OnInit, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { PeriodicalsService } from '../services/periodicals.service';
import { Periodical } from '../models/periodical.model';
import { PERM_CREATE, PERM_UPDATE, PERM_DELETE } from '../../../shared/models/permission-constants';
import { SearchCondition, SearchFieldDef } from '../../../shared/models/search-condition.model';

@Component({
  standalone: false,
  selector: 'app-periodical-list',
  templateUrl: './periodical-list.component.html',
  styleUrls: ['./periodical-list.component.scss']
})
export class PeriodicalListComponent implements OnInit {

  protected readonly PERM_CREATE = PERM_CREATE;
  protected readonly PERM_UPDATE = PERM_UPDATE;
  protected readonly PERM_DELETE = PERM_DELETE;

  private svc = inject(PeriodicalsService);
  private router = inject(Router);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  displayedColumns = ['perNo', 'name', 'publishLocation', 'lang', 'type', 'frequency', 'startDate', 'actions'];
  items = signal<Periodical[]>([]);
  totalElements = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);
  filterName = signal('');
  filterLang = signal('');
  filterType = signal<number | null>(null);
  filterFrequency = signal('');

  advancedSearchFields: SearchFieldDef[] = [
    { value: 'name', labelKey: 'PERIODICALS.NAME', type: 'STRING' },
    { value: 'lang', labelKey: 'PERIODICALS.LANG', type: 'STRING' },
    { value: 'frequency', labelKey: 'PERIODICALS.FREQUENCY', type: 'STRING' },
    { value: 'startDate', labelKey: 'PERIODICALS.START_DATE', type: 'DATE' }
  ];
  private advancedConditions = signal<SearchCondition[]>([]);

  ngOnInit(): void { this.loadData(); }

  loadData(): void {
    this.isLoading.set(true);

    if (this.advancedConditions().length > 0) {
      this.svc.advancedSearch(this.advancedConditions(), this.pageIndex(), this.pageSize()).subscribe({
        next: r => { this.items.set(r.data.content); this.totalElements.set(r.data.totalElements); this.isLoading.set(false); },
        error: () => this.isLoading.set(false)
      });
      return;
    }

    this.svc.getAll(
      this.pageIndex(),
      this.pageSize(),
      this.filterName() || undefined,
      this.filterLang() || undefined,
      this.filterType() ?? undefined,
      this.filterFrequency() || undefined
    ).subscribe({
      next: r => { this.items.set(r.data.content); this.totalElements.set(r.data.totalElements); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }

  onAdvancedSearch(conditions: SearchCondition[]): void {
    this.advancedConditions.set(conditions);
    this.pageIndex.set(0);
    this.loadData();
  }

  onAdvancedSearchCleared(): void {
    this.advancedConditions.set([]);
    this.pageIndex.set(0);
    this.loadData();
  }

  onPageChange(e: PageEvent): void { this.pageIndex.set(e.pageIndex); this.pageSize.set(e.pageSize); this.loadData(); }
  applyFilter(): void { this.pageIndex.set(0); this.loadData(); }

  clearFilter(): void {
    this.filterName.set('');
    this.filterLang.set('');
    this.filterType.set(null);
    this.filterFrequency.set('');
    this.pageIndex.set(0);
    this.loadData();
  }

  viewDetail(perNo: number): void { this.router.navigate(['/periodicals', perNo]); }
  addNew(): void { this.router.navigate(['/periodicals', 'new']); }

  onDelete(perNo: number): void {
    if (!confirm(this.t.instant('APP.CONFIRM_DELETE'))) return;
    this.svc.delete(perNo).subscribe({
      next: () => { this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 }); this.loadData(); }
    });
  }
}
