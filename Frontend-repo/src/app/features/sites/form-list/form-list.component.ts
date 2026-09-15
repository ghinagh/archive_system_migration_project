import { Component, OnInit, inject, signal } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { PageEvent } from '@angular/material/paginator';
import { SitesService } from '../services/sites.service';
import { FormDefinition } from '../models/sites.model';
import { FormDialogComponent } from '../form-dialog/form-dialog.component';

@Component({ standalone: false, selector: 'app-form-list', templateUrl: './form-list.component.html', styleUrls: ['./form-list.component.scss'] })
export class FormListComponent implements OnInit {
  private sitesService = inject(SitesService);
  private dialog = inject(MatDialog);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  displayedColumns = ['formNo', 'formType', 'name', 'date', 'actions'];
  items = signal<FormDefinition[]>([]);
  totalElements = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);
  filterType = signal('');

  ngOnInit(): void { this.loadData(); }

  loadData(): void {
    this.isLoading.set(true);
    this.sitesService.getForms(this.pageIndex(), this.pageSize(), undefined, this.filterType() || undefined).subscribe({
      next: r => { this.items.set(r.data.content); this.totalElements.set(r.data.totalElements); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }

  onPageChange(e: PageEvent): void { this.pageIndex.set(e.pageIndex); this.pageSize.set(e.pageSize); this.loadData(); }
  applyFilter(): void { this.pageIndex.set(0); this.loadData(); }

  openDialog(item?: FormDefinition): void {
    const ref = this.dialog.open(FormDialogComponent, { width: '500px', data: item || null });
    ref.afterClosed().subscribe(r => { if (r) { this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 }); this.loadData(); } });
  }

  onDelete(formNo: string): void {
    if (!confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;
    this.sitesService.deleteForm(formNo).subscribe({ next: () => this.loadData() });
  }
}
