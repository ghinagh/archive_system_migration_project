import { Component, OnInit, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { PersonsService } from '../services/persons.service';
import { PersonRequest } from '../models/person.model';

@Component({
  standalone: false,
  selector: 'app-person-form',
  templateUrl: './person-form.component.html',
  styleUrls: ['./person-form.component.scss']
})
export class PersonFormComponent implements OnInit {

  private fb = inject(FormBuilder);
  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private personsService = inject(PersonsService);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  isEditMode = signal(false);
  isLoading = signal(false);
  pageLoading = signal(false);

  form = this.fb.group({
    prsNo: ['', [Validators.required, Validators.maxLength(10)]],
    name: ['', [Validators.required, Validators.maxLength(50)]],
    institution: ['', Validators.maxLength(10)],
    address: ['', Validators.maxLength(100)],
    institutionPhone: ['', Validators.maxLength(30)],
    institutionBox: ['', Validators.maxLength(15)],
    institutionDirectorate: ['', Validators.maxLength(50)],
    institutionEmail: ['', [Validators.maxLength(50), Validators.email]],
    registrationId: ['', Validators.maxLength(10)],
    birthDate: [null as Date | null],
    village: ['', Validators.maxLength(10)],
    residence: ['', Validators.maxLength(10)],
    secondaryAddress: ['', Validators.maxLength(100)],
    phone: ['', Validators.maxLength(50)],
    email: ['', [Validators.maxLength(50), Validators.email]],
    poBox: ['', Validators.maxLength(50)],
    qualification: ['', Validators.maxLength(3)],
    specialtyDate: [null as Date | null],
    entity: ['', Validators.maxLength(2)],
    denomination: ['', Validators.maxLength(3)],
    politicalAffiliation: ['', Validators.maxLength(3)],
    socialMedia: ['', Validators.maxLength(100)],
    previousJob: ['', Validators.maxLength(3)],
    sex: ['']
  });

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');

    if (id) {
      this.isEditMode.set(true);
      this.pageLoading.set(true);

      this.personsService.getById(id).subscribe({
        next: (res) => {
          this.form.patchValue({
            ...res.data,
            birthDate: res.data.birthDate ? new Date(res.data.birthDate) : null,
            specialtyDate: res.data.specialtyDate ? new Date(res.data.specialtyDate) : null
          });
          this.form.get('prsNo')?.disable();
          this.pageLoading.set(false);
        },
        error: () => {
          this.pageLoading.set(false);
          this.router.navigate(['/persons']);
        }
      });
    }
  }

  onSubmit(): void {
    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }

    this.isLoading.set(true);
    const rawValue = this.form.getRawValue() as PersonRequest;

    const request$ = this.isEditMode()
      ? this.personsService.update(rawValue.prsNo, rawValue)
      : this.personsService.create(rawValue);

    request$.subscribe({
      next: () => {
        this.isLoading.set(false);
        this.snackBar.open(
          this.translate.instant('APP.SUCCESS'),
          this.translate.instant('APP.CANCEL'),
          { duration: 3000 }
        );
        this.router.navigate(['/persons']);
      },
      error: () => this.isLoading.set(false)
    });
  }

  onCancel(): void {
    this.router.navigate(['/persons']);
  }
}
