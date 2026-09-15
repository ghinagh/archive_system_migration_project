import { Component, EventEmitter, Input, OnInit, Output, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { PicturesService } from '../services/pictures.service';
import { Picture, PictureRequest } from '../models/picture.model';

@Component({
  standalone: false,
  selector: 'app-picture-form',
  templateUrl: './picture-form.component.html',
  styleUrls: ['./picture-form.component.scss']
})
export class PictureFormComponent implements OnInit {

  @Input() editData: Picture | null = null;
  @Output() saved = new EventEmitter<void>();
  @Output() cancelled = new EventEmitter<void>();

  private fb = inject(FormBuilder);
  private picturesService = inject(PicturesService);
  private router = inject(Router);

  isLoading = signal(false);
  isEditMode = signal(false);

  form = this.fb.group({
    picNo: ['', [Validators.required, Validators.maxLength(7)]],
    picNgNo: ['', Validators.maxLength(6)],
    picPosNo: ['', Validators.maxLength(6)],
    picDoc: ['', Validators.maxLength(3)],
    picDocDte: [null as Date | null],
    picEnt: ['', Validators.maxLength(3)],
    picEntDte: [null as Date | null],
    picPrs: ['', Validators.maxLength(3)],
    picDte: [null as Date | null],
    picTit: ['', Validators.maxLength(100)],
    picCot: ['', Validators.maxLength(10)],
    picGeo: ['', Validators.maxLength(10)],
    picTyp: [null as number | null],
    picForm: [null as number | null],
    picLen: [null as number | null],
    picLarge: [null as number | null],
    picQualty: [null as number | null],
    picSub: [null as number | null],
    picRmrk: ['', Validators.maxLength(70)],
    picCopy: [null as number | null],
    picLbn: ['', Validators.maxLength(5)],
    picPage: ['', Validators.maxLength(5)],
    picLine: ['', Validators.maxLength(5)],
    picTyp1: [null as number | null],
    picBrind: [null as number | null],
    picChoice: [null as number | null]
  });

  ngOnInit(): void {
    if (this.editData) {
      this.isEditMode.set(true);
      this.form.patchValue({
        ...this.editData,
        picDocDte: this.editData.picDocDte ? new Date(this.editData.picDocDte) : null,
        picEntDte: this.editData.picEntDte ? new Date(this.editData.picEntDte) : null,
        picDte: this.editData.picDte ? new Date(this.editData.picDte) : null
      });
      this.form.get('picNo')?.disable();
    }
  }

  onSubmit(): void {
    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }

    this.isLoading.set(true);
    const rawValue = this.form.getRawValue() as PictureRequest;

    if (this.isEditMode()) {
      this.picturesService.update(rawValue.picNo, rawValue).subscribe({
        next: () => {
          this.isLoading.set(false);
          this.saved.emit();
        },
        error: () => this.isLoading.set(false)
      });
    } else {
      this.picturesService.create(rawValue).subscribe({
        next: () => {
          this.isLoading.set(false);
          this.router.navigate(['/pictures']);
        },
        error: () => this.isLoading.set(false)
      });
    }
  }

  onCancel(): void {
    if (this.isEditMode()) {
      this.cancelled.emit();
    } else {
      this.router.navigate(['/pictures']);
    }
  }
}
