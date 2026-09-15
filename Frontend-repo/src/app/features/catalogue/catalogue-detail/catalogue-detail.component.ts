import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit, inject, signal } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { CatalogueService } from '../services/catalogue.service';
import { CatalogueItem, CorrectionLog, CatalogueLinkedAuthor, Main2Item } from '../models/catalogue.models';
import { Main2FormDialogComponent, Main2FormDialogData } from '../main2-form-dialog/main2-form-dialog.component';

@Component({
  standalone: false,
  selector: 'app-catalogue-detail',
  templateUrl: './catalogue-detail.component.html',
  styleUrls: ['./catalogue-detail.component.scss']
})
export class CatalogueDetailComponent implements OnInit {

  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private catalogueService = inject(CatalogueService);
  private dialog = inject(MatDialog);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  item = signal<CatalogueItem | null>(null);
  linkedAuthors = signal<CatalogueLinkedAuthor[]>([]);
  extendedInfo = signal<Main2Item | null>(null);
  extendedLoaded = signal(false);
  extendedLoading = signal(false);
  corrections = signal<CorrectionLog[]>([]);
  correctionsLoaded = signal(false);
  correctionsLoading = signal(false);
  correctionsCols = ['fieldName', 'oldValue', 'newValue', 'correctedByUser', 'correctedAt', 'correctionReason'];
  isLoading = signal(true);
  isEditing = signal(false);

  ngOnInit(): void {
    const appNo = this.route.snapshot.paramMap.get('appNo');
    if (!appNo) return;

    this.catalogueService.getById(appNo).subscribe({
      next: (res) => {
        this.item.set(res.data);
        this.isLoading.set(false);
        this.catalogueService.getLinkedAuthors(appNo).subscribe({ next: r => this.linkedAuthors.set(r.data), error: () => {} });
      },
      error: () => {
        this.isLoading.set(false);
        this.router.navigate(['/catalogue']);
      }
    });
  }

  toggleEdit(): void {
    this.isEditing.update(v => !v);
  }

  onSaved(): void {
    this.isEditing.set(false);
    const appNo = this.item()?.appNo;
    if (appNo) {
      this.catalogueService.getById(appNo).subscribe({
        next: (res) => this.item.set(res.data)
      });
    }
    this.snackBar.open(this.translate.instant('APP.SUCCESS'), this.translate.instant('APP.CANCEL'), { duration: 3000 });
  }

  onDelete(): void {
    const appNo = this.item()?.appNo;
    if (!appNo || !confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;

    this.catalogueService.delete(appNo).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), this.translate.instant('APP.CANCEL'), { duration: 3000 });
        this.router.navigate(['/catalogue']);
      },
      error: (err: HttpErrorResponse) => {
        if (err.status === 409) {
          this.onLockError();
        }
      }
    });
  }

  onLockError(): void {
    this.isEditing.set(false);
    this.snackBar.open(
      this.translate.instant('CATALOGUE.RECORD_LOCKED'),
      this.translate.instant('APP.CANCEL'),
      { duration: 5000 }
    );
  }

  loadExtendedInfo(): void {
    if (this.extendedLoaded()) return;
    const appNo = this.item()?.appNo;
    if (!appNo) return;
    this.extendedLoading.set(true);
    this.catalogueService.getExtendedInfo(appNo).subscribe({
      next: (res) => {
        this.extendedInfo.set(res.data);
        this.extendedLoaded.set(true);
        this.extendedLoading.set(false);
      },
      error: (err) => {
        // 404 means no extended record exists yet — that's normal
        this.extendedLoaded.set(true);
        this.extendedLoading.set(false);
        if (err.status !== 404) { /* handled by global error handler */ }
      }
    });
  }

  loadCorrections(): void {
    if (this.correctionsLoaded()) return;
    const appNo = this.item()?.appNo;
    if (!appNo) return;
    this.correctionsLoading.set(true);
    this.catalogueService.getCorrections(appNo).subscribe({
      next: (res) => {
        this.corrections.set(res.data);
        this.correctionsLoaded.set(true);
        this.correctionsLoading.set(false);
      },
      error: () => {
        this.correctionsLoaded.set(true);
        this.correctionsLoading.set(false);
      }
    });
  }

  openExtendedDialog(): void {
    const appNo = this.item()?.appNo;
    if (!appNo) return;
    const data: Main2FormDialogData = { appNo, item: this.extendedInfo() };
    this.dialog.open(Main2FormDialogComponent, { width: '560px', data })
      .afterClosed()
      .subscribe(saved => {
        if (saved) {
          this.extendedLoaded.set(false);
          this.loadExtendedInfo();
        }
      });
  }

  goBack(): void {
    this.router.navigate(['/catalogue']);
  }
}
