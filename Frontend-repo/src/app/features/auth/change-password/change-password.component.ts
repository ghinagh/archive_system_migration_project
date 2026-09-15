import { Component, inject, signal } from '@angular/core';
import { AbstractControl, FormBuilder, ValidationErrors, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../../core/services/auth.service';

function passwordsMatch(group: AbstractControl): ValidationErrors | null {
  const newPwd = group.get('newPassword')?.value;
  const confirm = group.get('confirmPassword')?.value;
  return newPwd && confirm && newPwd !== confirm ? { passwordMismatch: true } : null;
}

@Component({
  standalone: false,
  selector: 'app-change-password',
  templateUrl: './change-password.component.html',
  styleUrls: ['./change-password.component.scss']
})
export class ChangePasswordComponent {

  private fb = inject(FormBuilder);
  private authService = inject(AuthService);
  private router = inject(Router);

  changeForm = this.fb.group(
    {
      newPassword: ['', [Validators.required, Validators.minLength(6)]],
      confirmPassword: ['', Validators.required]
    },
    { validators: passwordsMatch }
  );

  isLoading = signal(false);
  errorMessage = signal<string | null>(null);
  hideNew = signal(true);
  hideConfirm = signal(true);

  onSubmit(): void {
    if (this.changeForm.invalid) {
      this.changeForm.markAllAsTouched();
      return;
    }

    this.isLoading.set(true);
    this.errorMessage.set(null);

    const { newPassword, confirmPassword } = this.changeForm.value;

    this.authService.changePassword(newPassword!, confirmPassword!).subscribe({
      next: () => {
        this.isLoading.set(false);
        this.router.navigate(['/catalogue']);
      },
      error: () => {
        this.isLoading.set(false);
        this.errorMessage.set('AUTH.CHANGE_PASSWORD_ERROR');
      }
    });
  }
}
