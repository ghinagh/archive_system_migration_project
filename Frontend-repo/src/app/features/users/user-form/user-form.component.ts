import { Component, OnInit, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { UsersService } from '../services/users.service';
import { UserRequest } from '../models/user.model';

@Component({ standalone: false, selector: 'app-user-form', templateUrl: './user-form.component.html', styleUrls: ['./user-form.component.scss'] })
export class UserFormComponent implements OnInit {
  private fb = inject(FormBuilder);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private svc = inject(UsersService);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  isEditMode = signal(false);
  isLoading = signal(false);
  pageLoading = signal(false);

  form = this.fb.group({
    userNo: ['', [Validators.required, Validators.maxLength(3)]],
    userName: ['', Validators.maxLength(50)],
    userPassword: [''],
    userLevel: ['U', Validators.maxLength(1)],
    userPermission: [0],
    userEnt: ['', Validators.maxLength(2)],
    userDoc: ['', Validators.maxLength(2)],
    configPath: ['', Validators.maxLength(100)],
    startPage: [null as number | null],
    passwordChangeFlag: [null as number | null],
    compressedVideoPath: ['', Validators.maxLength(100)],
    videoPath: ['', Validators.maxLength(100)],
    company: [null as number | null],
    secondaryVideoPath: ['', Validators.maxLength(100)],
    wilayaScope: [null as number | null]
  });

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.isEditMode.set(true);
      this.pageLoading.set(true);
      this.svc.getById(id).subscribe({
        next: r => {
          this.form.patchValue(r.data);
          this.form.get('userNo')?.disable();
          this.form.get('userPassword')?.clearValidators();
          this.pageLoading.set(false);
        },
        error: () => { this.pageLoading.set(false); this.router.navigate(['/users']); }
      });
    }
  }

  onSubmit(): void {
    if (this.form.invalid) { this.form.markAllAsTouched(); return; }
    this.isLoading.set(true);
    const raw = this.form.getRawValue() as UserRequest;

    const req$ = this.isEditMode()
      ? this.svc.update(raw.userNo, raw)
      : this.svc.create(raw);

    req$.subscribe({
      next: () => { this.isLoading.set(false); this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 }); this.router.navigate(['/users']); },
      error: () => this.isLoading.set(false)
    });
  }

  onCancel(): void { this.router.navigate(['/users']); }
}
