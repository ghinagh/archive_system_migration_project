import { Component, OnInit, inject, signal, computed } from '@angular/core';
import { Router } from '@angular/router';
import { PageEvent } from '@angular/material/paginator';
import { BorrowingService } from '../services/borrowing.service';
import { BorrowingRecord, BorrowingStatus } from '../models/borrowing.model';

@Component({
  standalone: false,
  selector: 'app-borrowing-list',
  templateUrl: './borrowing-list.component.html',
  styleUrls: ['./borrowing-list.component.scss']
})
export class BorrowingListComponent implements OnInit {

  private borrowingService = inject(BorrowingService);
  private router = inject(Router);

  displayedColumns = ['iarNo', 'personName', 'bookTitle', 'borrowDate', 'dueDate', 'returnDate', 'status', 'actions'];

  items = signal<BorrowingRecord[]>([]);
  totalElements = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);

  filterPerson = signal('');
  filterDateFrom = signal('');
  filterDateTo = signal('');
  filterStatus = signal<string>('');

  filteredItems = computed(() => {
    const status = this.filterStatus();
    if (!status) return this.items();
    return this.items().filter(item => this.getStatus(item) === status);
  });

  ngOnInit(): void {
    this.loadData();
  }

  getStatus(record: BorrowingRecord): BorrowingStatus {
    if (record.returnDate) return 'RETURNED';
    if (record.dueDate && new Date(record.dueDate) < new Date()) return 'OVERDUE';
    return 'ACTIVE';
  }

  getStatusClass(record: BorrowingRecord): string {
    switch (this.getStatus(record)) {
      case 'ACTIVE': return 'badge-active';
      case 'OVERDUE': return 'badge-overdue';
      case 'RETURNED': return 'badge-returned';
    }
  }

  loadData(): void {
    this.isLoading.set(true);

    const personNo = this.filterPerson() || undefined;
    const dateFrom = this.filterDateFrom() || undefined;
    const dateTo = this.filterDateTo() || undefined;

    this.borrowingService.getAll(this.pageIndex(), this.pageSize(), personNo, undefined, dateFrom, dateTo).subscribe({
      next: (res) => {
        this.items.set(res.data.content);
        this.totalElements.set(res.data.totalElements);
        this.isLoading.set(false);
      },
      error: () => this.isLoading.set(false)
    });
  }

  onPageChange(event: PageEvent): void {
    this.pageIndex.set(event.pageIndex);
    this.pageSize.set(event.pageSize);
    this.loadData();
  }

  applyFilter(): void {
    this.pageIndex.set(0);
    this.loadData();
  }

  clearFilter(): void {
    this.filterPerson.set('');
    this.filterDateFrom.set('');
    this.filterDateTo.set('');
    this.filterStatus.set('');
    this.pageIndex.set(0);
    this.loadData();
  }

  viewDetail(record: BorrowingRecord): void {
    this.router.navigate(['/borrowing', record.iarNo], {
      queryParams: { serial: record.serial, type: record.borrowingType }
    });
  }

  addNew(): void {
    this.router.navigate(['/borrowing', 'new']);
  }
}
