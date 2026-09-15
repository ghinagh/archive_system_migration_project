import { Component, inject, signal } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { UsersService } from '../services/users.service';

@Component({
  standalone: false,
  selector: 'app-migrate-passwords-dialog',
  templateUrl: './migrate-passwords-dialog.component.html'
})
export class MigratePasswordsDialogComponent {
  private dialogRef = inject(MatDialogRef<MigratePasswordsDialogComponent>);
  private svc = inject(UsersService);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  isLoading = signal(false);

  onConfirm(): void {
    this.isLoading.set(true);
    this.svc.migratePasswords().subscribe({
      next: (res) => {
        this.isLoading.set(false);
        this.snack.open(
          this.t.instant('USERS.MIGRATE_SUCCESS', { count: res.data.migratedCount }),
          this.t.instant('APP.CANCEL'),
          { duration: 5000 }
        );
        this.dialogRef.close(true);
      },
      error: () => {
        this.isLoading.set(false);
        this.snack.open(
          this.t.instant('USERS.MIGRATE_ERROR'),
          this.t.instant('APP.CANCEL'),
          { duration: 5000 }
        );
      }
    });
  }

  onCancel(): void {
    this.dialogRef.close();
  }
}
