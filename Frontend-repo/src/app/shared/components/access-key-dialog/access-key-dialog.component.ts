import { Component, inject } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';

/**
 * ARCHIVE.frm Frame3: Label16 "كلمة السر", m_user_password (PasswordChar "*"),
 * Command20 "تنفيذ" (Enter) and Command21 "الغاء الامر" (Esc). Closes with the typed text,
 * or undefined when cancelled.
 */
@Component({
  standalone: false,
  selector: 'app-access-key-dialog',
  templateUrl: './access-key-dialog.component.html',
  styleUrls: ['./access-key-dialog.component.scss']
})
export class AccessKeyDialogComponent {

  private dialogRef = inject(MatDialogRef<AccessKeyDialogComponent, string | undefined>);

  key = '';

  execute(): void {
    this.dialogRef.close(this.key);
  }

  cancel(): void {
    this.dialogRef.close(undefined);
  }
}
