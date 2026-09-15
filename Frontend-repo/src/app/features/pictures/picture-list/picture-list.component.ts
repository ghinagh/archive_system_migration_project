import { Component, OnInit, ViewChild, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { MatPaginator, PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { PicturesService } from '../services/pictures.service';
import { Picture } from '../models/picture.model';
import { PERM_CREATE, PERM_DELETE } from '../../../shared/models/permission-constants';

@Component({
  standalone: false,
  selector: 'app-picture-list',
  templateUrl: './picture-list.component.html',
  styleUrls: ['./picture-list.component.scss']
})
export class PictureListComponent implements OnInit {

  protected readonly PERM_CREATE = PERM_CREATE;
  protected readonly PERM_DELETE = PERM_DELETE;

  private picturesService = inject(PicturesService);
  private router = inject(Router);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  displayedColumns = ['picNo', 'picTit', 'picTyp', 'picEnt', 'picDte', 'picPrs', 'picCot', 'picGeo', 'actions'];

  items = signal<Picture[]>([]);
  totalElements = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);

  filterType = signal('');
  filterEntity = signal('');
  filterDateFrom = signal('');
  filterDateTo = signal('');

  @ViewChild(MatPaginator) paginator!: MatPaginator;

  ngOnInit(): void {
    this.loadData();
  }

  loadData(): void {
    this.isLoading.set(true);

    const type = this.filterType() ? Number(this.filterType()) : undefined;
    const entity = this.filterEntity() || undefined;
    const dateFrom = this.filterDateFrom() || undefined;
    const dateTo = this.filterDateTo() || undefined;

    this.picturesService.getAll(this.pageIndex(), this.pageSize(), type, entity, dateFrom, dateTo).subscribe({
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
    this.filterType.set('');
    this.filterEntity.set('');
    this.filterDateFrom.set('');
    this.filterDateTo.set('');
    this.pageIndex.set(0);
    this.loadData();
  }

  viewDetail(picNo: string): void {
    this.router.navigate(['/pictures', picNo]);
  }

  addNew(): void {
    this.router.navigate(['/pictures', 'new']);
  }

  onDelete(picNo: string): void {
    if (!confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;

    this.picturesService.delete(picNo).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), this.translate.instant('APP.CANCEL'), { duration: 3000 });
        this.loadData();
      }
    });
  }
}
