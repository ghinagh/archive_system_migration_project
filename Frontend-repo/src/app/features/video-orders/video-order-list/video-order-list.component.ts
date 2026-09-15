import { Component, OnInit, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { VideoOrderService } from '../services/video-order.service';
import { VideoOrder } from '../models/video-order.model';
import { PERM_CREATE, PERM_UPDATE, PERM_DELETE } from '../../../shared/models/permission-constants';

const STATUS_TRANSITIONS: Record<string, string[]> = {
  PENDING: ['APPROVED', 'CANCELLED'],
  APPROVED: ['COMPLETED', 'CANCELLED'],
  COMPLETED: [],
  CANCELLED: []
};

@Component({
  standalone: false,
  selector: 'app-video-order-list',
  templateUrl: './video-order-list.component.html',
  styleUrls: ['./video-order-list.component.scss']
})
export class VideoOrderListComponent implements OnInit {

  protected readonly PERM_CREATE = PERM_CREATE;
  protected readonly PERM_UPDATE = PERM_UPDATE;
  protected readonly PERM_DELETE = PERM_DELETE;

  private videoOrderService = inject(VideoOrderService);
  private router = inject(Router);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  displayedColumns = ['orderNo', 'stockNo', 'requestedBy', 'requestDate', 'status', 'mediaAvailable', 'actions'];

  items = signal<VideoOrder[]>([]);
  totalElements = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);

  filterStatus = signal('');
  filterStockNo = signal('');

  ngOnInit(): void { this.loadData(); }

  loadData(): void {
    this.isLoading.set(true);
    const status = this.filterStatus() || undefined;
    const stockNo = this.filterStockNo() || undefined;

    this.videoOrderService.getAll(this.pageIndex(), this.pageSize(), status, stockNo).subscribe({
      next: res => { this.items.set(res.data.content); this.totalElements.set(res.data.totalElements); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }

  onPageChange(e: PageEvent): void { this.pageIndex.set(e.pageIndex); this.pageSize.set(e.pageSize); this.loadData(); }
  applyFilter(): void { this.pageIndex.set(0); this.loadData(); }
  clearFilter(): void { this.filterStatus.set(''); this.filterStockNo.set(''); this.pageIndex.set(0); this.loadData(); }
  addNew(): void { this.router.navigate(['/video-orders', 'approvals', 'new']); }
  onEdit(id: string): void { this.router.navigate(['/video-orders', 'approvals', id, 'edit']); }

  statusClass(status: string): string {
    switch (status) {
      case 'PENDING': return 'status-pending';
      case 'APPROVED': return 'status-approved';
      case 'COMPLETED': return 'status-completed';
      case 'CANCELLED': return 'status-cancelled';
      default: return '';
    }
  }

  statusLabel(status: string): string {
    return this.translate.instant('VIDEO_ORDERS.STATUS_' + status);
  }

  nextStatuses(status: string): string[] {
    return STATUS_TRANSITIONS[status] ?? [];
  }

  onChangeStatus(order: VideoOrder, newStatus: string): void {
    this.videoOrderService.updateStatus(order.id, newStatus).subscribe({
      next: () => { this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 }); this.loadData(); }
    });
  }

  onDelete(id: string): void {
    if (!confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;
    this.videoOrderService.delete(id).subscribe({
      next: () => { this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 }); this.loadData(); }
    });
  }
}
