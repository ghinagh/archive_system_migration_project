import { Component, OnInit, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { DigitizationService } from '../services/digitization.service';
import { DigitRecord } from '../models/digitization.model';
import { PERM_CREATE, PERM_DELETE } from '../../../shared/models/permission-constants';

@Component({ standalone: false, selector: 'app-digit-record-list', templateUrl: './digit-record-list.component.html', styleUrls: ['./digit-record-list.component.scss'] })
export class DigitRecordListComponent implements OnInit {
  protected readonly PERM_CREATE = PERM_CREATE;
  protected readonly PERM_DELETE = PERM_DELETE;

  private svc = inject(DigitizationService);
  private router = inject(Router);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  cols = ['docNo', 'digitNo', 'type', 'size', 'chartNo', 'chartType', 'chartGeo', 'materialType', 'actions'];
  items = signal<DigitRecord[]>([]);
  total = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);
  filterType = signal('');

  ngOnInit(): void { this.load(); }

  load(): void {
    this.isLoading.set(true);
    this.svc.getRecords(this.pageIndex(), this.pageSize(), undefined, this.filterType() || undefined).subscribe({
      next: r => { this.items.set(r.data.content); this.total.set(r.data.totalElements); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }

  onPage(e: PageEvent): void { this.pageIndex.set(e.pageIndex); this.pageSize.set(e.pageSize); this.load(); }
  applyFilter(): void { this.pageIndex.set(0); this.load(); }
  addNew(): void { this.router.navigate(['/digitization', 'records', 'new']); }

  onDelete(r: DigitRecord): void {
    if (!confirm(this.t.instant('APP.CONFIRM_DELETE'))) return;
    this.svc.deleteRecord(r.docNo, r.serial).subscribe({ next: () => { this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 }); this.load(); } });
  }
}
