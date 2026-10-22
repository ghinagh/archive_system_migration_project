import { Component, OnInit, inject } from '@angular/core';
import { HttpErrorResponse } from '@angular/common/http';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { AccessKeyDialogComponent } from '../../../shared/components/access-key-dialog/access-key-dialog.component';
import { CatalogueService } from '../services/catalogue.service';

/**
 * ARCHIVE.frm m30 "اقفال الوثائق المفتوحة": Frame3 asks for the key (891045), then
 * upd_main_trans1 locks every open document and MsgBox "انتهى الاقفال.......".
 * A menu action, not a screen: it returns to the catalogue list when done or cancelled.
 */
@Component({
  standalone: false,
  selector: 'app-lock-all',
  template: ''
})
export class LockAllComponent implements OnInit {
  private dialog = inject(MatDialog);
  private snack = inject(MatSnackBar);
  private router = inject(Router);
  private t = inject(TranslateService);
  private catalogueService = inject(CatalogueService);

  ngOnInit(): void {
    this.dialog.open(AccessKeyDialogComponent, { panelClass: 'doc-form-dialog' }).afterClosed().subscribe((key?: string) => {
      if (key === undefined) { this.router.navigate(['/catalogue']); return; }
      this.catalogueService.lockAll(key).subscribe({
        next: () => {
          this.snack.open(this.t.instant('DOC_FORM.LOCK_ALL_DONE'), '', { duration: 4000 });
          this.router.navigate(['/catalogue']);
        },
        error: (err: HttpErrorResponse) => {
          // m_user_password_KeyPress / Command20: a wrong key just hides Frame3 — no message.
          const msg = err?.error?.message;
          if (typeof msg !== 'string' || !msg.startsWith('كلمة السر')) {
            this.snack.open(typeof msg === 'string' && msg ? msg : this.t.instant('APP.ERROR'), '', { duration: 4000 });
          }
          this.router.navigate(['/catalogue']);
        }
      });
    });
  }
}
