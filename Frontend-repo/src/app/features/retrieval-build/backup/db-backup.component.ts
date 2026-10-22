import { Component, OnInit, inject } from '@angular/core';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { RetrievalBuildService } from '../retrieval-build.service';

/**
 * ARCHIVE.frm m33 "نسخ قاعدة البيانات": no key and no user check — BACKUP DATABASE, then
 * MsgBox "انتهى الاقفال......." (the legacy text, copied from the lock item). A menu action, not a
 * screen: it returns to the catalogue list when done.
 */
@Component({ standalone: false, selector: 'app-db-backup', template: '' })
export class DbBackupComponent implements OnInit {
  private api = inject(RetrievalBuildService);
  private router = inject(Router);
  private snack = inject(MatSnackBar);

  ngOnInit(): void {
    this.api.backup().subscribe({
      next: () => { this.snack.open('انتهى الاقفال.......', '', { duration: 4000 }); this.router.navigate(['/catalogue']); },
      error: e => { this.snack.open(e?.error?.message || 'تعذر النسخ', '', { duration: 4000 }); this.router.navigate(['/catalogue']); }
    });
  }
}
