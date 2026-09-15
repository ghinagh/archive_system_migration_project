import { Component, OnInit, inject, signal } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { PageEvent } from '@angular/material/paginator';
import { SitesService } from '../services/sites.service';
import { FormDefinition } from '../models/sites.model';
import { FormDialogComponent, FormDialogPreset } from '../form-dialog/form-dialog.component';

@Component({
  standalone: false,
  selector: 'app-institution-list',
  templateUrl: './institution-list.component.html',
  styleUrls: ['./institution-list.component.scss']
})
export class InstitutionListComponent implements OnInit {

  private sitesService = inject(SitesService);
  private dialog       = inject(MatDialog);
  private snackBar     = inject(MatSnackBar);
  private translate    = inject(TranslateService);

  displayedColumns = ['formNo', 'name', 'printName', 'date', 'user', 'actions'];
  items            = signal<FormDefinition[]>([]);
  totalElements    = signal(0);
  pageSize         = signal(10);
  pageIndex        = signal(0);
  isLoading        = signal(false);

  ngOnInit(): void { this.loadData(); }

  loadData(): void {
    this.isLoading.set(true);
    this.sitesService.getInstitutions(this.pageIndex(), this.pageSize()).subscribe({
      next: r => {
        this.items.set(r.data.content);
        this.totalElements.set(r.data.totalElements);
        this.isLoading.set(false);
      },
      error: () => this.isLoading.set(false)
    });
  }

  onPageChange(e: PageEvent): void {
    this.pageIndex.set(e.pageIndex);
    this.pageSize.set(e.pageSize);
    this.loadData();
  }

  openDialog(item?: FormDefinition): void {
    // For a new institution the dialog receives a preset so formType='03' is
    // pre-filled and the field is locked. For edits the existing item is passed.
    const data: FormDefinition | FormDialogPreset = item ?? { _preset: true, formType: '03' };
    const ref = this.dialog.open(FormDialogComponent, { width: '500px', data });
    ref.afterClosed().subscribe(saved => {
      if (saved) {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.loadData();
      }
    });
  }

  onDelete(formNo: string): void {
    if (!confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;
    this.sitesService.deleteForm(formNo).subscribe({ next: () => this.loadData() });
  }
}
