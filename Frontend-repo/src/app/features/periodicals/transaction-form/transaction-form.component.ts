import { Component, Inject, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { TransactionsService } from '../services/transactions.service';
import { TransactionRequest } from '../models/periodical.model';

@Component({
  standalone: false,
  selector: 'app-transaction-form',
  templateUrl: './transaction-form.component.html'
})
export class TransactionFormComponent {
  private fb = inject(FormBuilder);
  private dialogRef = inject(MatDialogRef<TransactionFormComponent>);
  private svc = inject(TransactionsService);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  isLoading = signal(false);

  form = this.fb.group({
    trsOpno: [null as number | null, Validators.required],
    trsDte: [null as Date | null],
    trsNum: ['', Validators.maxLength(5)],
    trsNb: [null as number | null],
    trsYear: [null as number | null],
    trsTyp: [null as number | null],
    trsDte1: [null as Date | null]
  });

  constructor(@Inject(MAT_DIALOG_DATA) public data: { periodicalId: number }) {}

  onSubmit(): void {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }

    this.isLoading.set(true);
    const val = this.form.value;

    const request: TransactionRequest = {
      trsOpno: val.trsOpno!,
      trsNo: this.data.periodicalId,
      trsDte: val.trsDte ? new Date(val.trsDte).toISOString() : null,
      trsNum: val.trsNum || '',
      trsNb: val.trsNb ?? null,
      trsYear: val.trsYear ?? null,
      trsTyp: val.trsTyp ?? null,
      trsDte1: val.trsDte1 ? new Date(val.trsDte1).toISOString() : null
    };

    this.svc.create(request).subscribe({
      next: () => {
        this.isLoading.set(false);
        this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 });
        this.dialogRef.close(true);
      },
      error: () => this.isLoading.set(false)
    });
  }

  onCancel(): void { this.dialogRef.close(); }
}
