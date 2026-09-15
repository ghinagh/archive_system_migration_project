import { Component, Input, OnInit, inject, signal } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { PageEvent } from '@angular/material/paginator';
import { TransactionsService } from '../services/transactions.service';
import { Transaction } from '../models/periodical.model';
import { TransactionFormComponent } from '../transaction-form/transaction-form.component';

@Component({
  standalone: false,
  selector: 'app-transactions-tab',
  templateUrl: './transactions-tab.component.html',
  styleUrls: ['./transactions-tab.component.scss']
})
export class TransactionsTabComponent implements OnInit {

  @Input() periodicalId!: number;

  private svc = inject(TransactionsService);
  private dialog = inject(MatDialog);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  displayedColumns = ['trsOpno', 'trsDte', 'trsNum', 'trsNb', 'trsYear', 'trsTyp', 'trsDte1', 'actions'];
  items = signal<Transaction[]>([]);
  totalElements = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);

  ngOnInit(): void { this.loadData(); }

  loadData(): void {
    this.isLoading.set(true);
    this.svc.getByPeriodical(this.periodicalId, this.pageIndex(), this.pageSize()).subscribe({
      next: r => { this.items.set(r.data.content); this.totalElements.set(r.data.totalElements); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }

  onPageChange(e: PageEvent): void {
    this.pageIndex.set(e.pageIndex);
    this.pageSize.set(e.pageSize);
    this.loadData();
  }

  onAdd(): void {
    const ref = this.dialog.open(TransactionFormComponent, {
      width: '560px',
      data: { periodicalId: this.periodicalId }
    });
    ref.afterClosed().subscribe(result => {
      if (result) this.loadData();
    });
  }

  onDelete(item: Transaction): void {
    if (!confirm(this.t.instant('APP.CONFIRM_DELETE'))) return;
    this.svc.delete(item.trsOpno, item.trsNo).subscribe({
      next: () => {
        this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.loadData();
      }
    });
  }
}
