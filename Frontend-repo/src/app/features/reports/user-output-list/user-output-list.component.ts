import { Component, OnInit, inject, signal } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { ReportsService } from '../services/reports.service';
import { UserOutput } from '../models/reports.model';
import { UserOutputDialogComponent } from '../user-output-dialog/user-output-dialog.component';

@Component({ standalone: false, selector: 'app-user-output-list', templateUrl: './user-output-list.component.html', styleUrls: ['./user-output-list.component.scss'] })
export class UserOutputListComponent implements OnInit {
  private svc = inject(ReportsService);
  private dialog = inject(MatDialog);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  cols = ['userNo', 'institutionNo', 'outputNum', 'outputChoice', 'userIndex', 'sign', 'actions'];
  items = signal<UserOutput[]>([]);
  total = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);
  filterUser = signal('');

  ngOnInit(): void { this.load(); }

  load(): void {
    this.isLoading.set(true);
    this.svc.getUserOutputs(this.pageIndex(), this.pageSize(), this.filterUser() || undefined).subscribe({
      next: r => { this.items.set(r.data.content); this.total.set(r.data.totalElements); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }

  onPage(e: PageEvent): void { this.pageIndex.set(e.pageIndex); this.pageSize.set(e.pageSize); this.load(); }
  applyFilter(): void { this.pageIndex.set(0); this.load(); }

  openAssign(): void {
    const ref = this.dialog.open(UserOutputDialogComponent, { width: '500px' });
    ref.afterClosed().subscribe(r => { if (r) { this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 }); this.load(); } });
  }

  onDelete(item: UserOutput): void {
    if (!confirm(this.t.instant('APP.CONFIRM_DELETE'))) return;
    this.svc.deleteUserOutput(item.institutionNo, item.userNo, item.outputNum).subscribe({
      next: () => { this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 }); this.load(); }
    });
  }
}
