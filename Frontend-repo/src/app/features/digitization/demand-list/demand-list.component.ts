import { Component, OnInit, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { DigitizationService } from '../services/digitization.service';
import { DigitDemand } from '../models/digitization.model';

@Component({ standalone: false, selector: 'app-demand-list', templateUrl: './demand-list.component.html', styleUrls: ['./demand-list.component.scss'] })
export class DemandListComponent implements OnInit {
  private svc = inject(DigitizationService);
  private router = inject(Router);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  cols = ['demandNo', 'serial', 'userName', 'date', 'catalogueTitle', 'description', 'checked', 'cote', 'actions'];
  items = signal<DigitDemand[]>([]);
  total = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);
  filterUser = signal('');

  ngOnInit(): void { this.load(); }

  load(): void {
    this.isLoading.set(true);
    this.svc.getDemands(this.pageIndex(), this.pageSize(), { userNo: this.filterUser() || undefined }).subscribe({
      next: r => { this.items.set(r.data.content); this.total.set(r.data.totalElements); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }

  onPage(e: PageEvent): void { this.pageIndex.set(e.pageIndex); this.pageSize.set(e.pageSize); this.load(); }
  applyFilter(): void { this.pageIndex.set(0); this.load(); }
  addNew(): void { this.router.navigate(['/digitization', 'demands', 'new']); }

  onDelete(id: number): void {
    if (!confirm(this.t.instant('APP.CONFIRM_DELETE'))) return;
    this.svc.deleteDemand(id).subscribe({ next: () => { this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 }); this.load(); } });
  }
}
