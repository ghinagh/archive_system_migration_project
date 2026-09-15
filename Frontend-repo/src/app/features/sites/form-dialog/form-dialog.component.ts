import { Component, Inject, OnInit, inject, signal } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { Router } from '@angular/router';
import { SitesService } from '../services/sites.service';
import { FormDefinition, SubjectLink, RelForm, Post } from '../models/sites.model';

/** Passed when opening the dialog to create a new form with a pre-set, locked type. */
export interface FormDialogPreset {
  _preset: true;
  formType: string;
}

@Component({ standalone: false, selector: 'app-form-dialog', templateUrl: './form-dialog.component.html', styleUrls: ['./form-dialog.component.scss'] })
export class FormDialogComponent implements OnInit {
  private fb = inject(FormBuilder);
  private sitesService = inject(SitesService);
  private dialogRef = inject(MatDialogRef<FormDialogComponent>);
  private router = inject(Router);

  isLoading = signal(false);
  isEdit: boolean;

  subjects = signal<SubjectLink[]>([]);
  relatedForms = signal<RelForm[]>([]);
  posts = signal<Post[]>([]);
  isAddingSubject = signal(false);
  isAddingRelatedForm = signal(false);
  editingSubjectCode = signal<string | null>(null);
  editingRelatedFormCode = signal<string | null>(null);

  form = this.fb.group({
    formNo: ['', [Validators.required, Validators.maxLength(8)]],
    formType: ['', Validators.maxLength(2)],
    name: ['', Validators.maxLength(60)],
    date: [''],
    user: ['', Validators.maxLength(3)],
    printName: ['', Validators.maxLength(100)]
  });

  subjectAddForm = this.fb.group({
    mcnzCode: ['', [Validators.required, Validators.maxLength(9)]],
    subRel: ['', Validators.maxLength(2)],
    subDte: [''],
    subDte1: ['']
  });

  relatedFormAddForm = this.fb.group({
    form2No: ['', [Validators.required, Validators.maxLength(10)]],
    rlfRel: ['', Validators.maxLength(2)],
    rlfDte: [''],
    rlfDte1: ['']
  });

  subjectEditForm = this.fb.group({
    subRel: ['', Validators.maxLength(2)],
    subDte: [''],
    subDte1: ['']
  });

  relatedFormEditForm = this.fb.group({
    rlfRel: ['', Validators.maxLength(2)],
    rlfDte: [''],
    rlfDte1: ['']
  });

  /** Populated only in edit mode, when `data` is a `FormDefinition` rather than a create-preset. */
  private editingForm: FormDefinition | null = null;

  constructor(@Inject(MAT_DIALOG_DATA) private data: FormDefinition | FormDialogPreset | null) {
    if (data && '_preset' in data) {
      // Create-with-locked-type mode: pre-fill formType but keep formNo editable
      this.isEdit = false;
      this.form.patchValue({ formType: (data as FormDialogPreset).formType });
      this.form.get('formType')?.disable();
    } else {
      this.isEdit = !!(data as FormDefinition | null);
      this.editingForm = data as FormDefinition | null;
      if (data) { this.form.patchValue(data as FormDefinition); this.form.get('formNo')?.disable(); }
    }
  }

  ngOnInit(): void {
    if (this.isEdit && this.editingForm) {
      this.loadSubjects(this.editingForm.formNo);
      this.loadRelatedForms(this.editingForm.formNo);
      this.loadPosts(this.editingForm.formNo);
    }
  }

  private loadSubjects(formNo: string): void {
    this.sitesService.getSubjects(formNo).subscribe({ next: r => this.subjects.set(r.data), error: () => {} });
  }

  private loadRelatedForms(formNo: string): void {
    this.sitesService.getRelatedForms(formNo).subscribe({ next: r => this.relatedForms.set(r.data), error: () => {} });
  }

  private loadPosts(formNo: string): void {
    this.sitesService.getPosts(0, 50, formNo).subscribe({
      next: r => this.posts.set(r.data.content),
      error: () => {}
    });
  }

  onAddSubject(): void {
    if (this.subjectAddForm.invalid || !this.editingForm) return;
    const raw = this.subjectAddForm.getRawValue();
    this.sitesService.addSubject(this.editingForm.formNo, {
      mcnzCode: raw.mcnzCode!,
      subRel: raw.subRel || undefined,
      subDte: raw.subDte || undefined,
      subDte1: raw.subDte1 || undefined
    }).subscribe({
      next: () => { this.loadSubjects(this.editingForm!.formNo); this.subjectAddForm.reset(); this.isAddingSubject.set(false); },
      error: () => {}
    });
  }

  onDeleteSubject(mcnzCode: string): void {
    if (!this.editingForm) return;
    this.sitesService.deleteSubject(this.editingForm.formNo, mcnzCode).subscribe({
      next: () => this.loadSubjects(this.editingForm!.formNo),
      error: () => {}
    });
  }

  onEditSubject(link: SubjectLink): void {
    this.editingSubjectCode.set(link.mcnzCode);
    this.subjectEditForm.setValue({
      subRel: link.subRel ?? '',
      subDte: link.subDte ?? '',
      subDte1: link.subDte1 ?? ''
    });
  }

  onSaveSubjectEdit(): void {
    const mcnzCode = this.editingSubjectCode();
    if (!mcnzCode || !this.editingForm || this.subjectEditForm.invalid) return;
    const raw = this.subjectEditForm.getRawValue();
    this.sitesService.updateSubject(this.editingForm.formNo, mcnzCode, {
      mcnzCode,
      subRel: raw.subRel || undefined,
      subDte: raw.subDte || undefined,
      subDte1: raw.subDte1 || undefined
    }).subscribe({
      next: () => { this.loadSubjects(this.editingForm!.formNo); this.editingSubjectCode.set(null); },
      error: () => {}
    });
  }

  onCancelSubjectEdit(): void { this.editingSubjectCode.set(null); }

  onAddRelatedForm(): void {
    if (this.relatedFormAddForm.invalid || !this.editingForm) return;
    const raw = this.relatedFormAddForm.getRawValue();
    this.sitesService.addRelatedForm(this.editingForm.formNo, {
      form2No: raw.form2No!,
      rlfRel: raw.rlfRel || undefined,
      rlfDte: raw.rlfDte || undefined,
      rlfDte1: raw.rlfDte1 || undefined
    }).subscribe({
      next: () => { this.loadRelatedForms(this.editingForm!.formNo); this.relatedFormAddForm.reset(); this.isAddingRelatedForm.set(false); },
      error: () => {}
    });
  }

  onDeleteRelatedForm(form2No: string): void {
    if (!this.editingForm) return;
    this.sitesService.deleteRelatedForm(this.editingForm.formNo, form2No).subscribe({
      next: () => this.loadRelatedForms(this.editingForm!.formNo),
      error: () => {}
    });
  }

  onEditRelatedForm(rel: RelForm): void {
    this.editingRelatedFormCode.set(rel.form2No);
    this.relatedFormEditForm.setValue({
      rlfRel: rel.rlfRel ?? '',
      rlfDte: rel.rlfDte ?? '',
      rlfDte1: rel.rlfDte1 ?? ''
    });
  }

  onSaveRelatedFormEdit(): void {
    const form2No = this.editingRelatedFormCode();
    if (!form2No || !this.editingForm || this.relatedFormEditForm.invalid) return;
    const raw = this.relatedFormEditForm.getRawValue();
    this.sitesService.updateRelatedForm(this.editingForm.formNo, form2No, {
      form2No,
      rlfRel: raw.rlfRel || undefined,
      rlfDte: raw.rlfDte || undefined,
      rlfDte1: raw.rlfDte1 || undefined
    }).subscribe({
      next: () => { this.loadRelatedForms(this.editingForm!.formNo); this.editingRelatedFormCode.set(null); },
      error: () => {}
    });
  }

  onCancelRelatedFormEdit(): void { this.editingRelatedFormCode.set(null); }

  onAddPost(): void {
    if (!this.editingForm) return;
    this.dialogRef.close();
    this.router.navigate(['/sites', 'posts', 'new'], { queryParams: { formNo: this.editingForm.formNo } });
  }

  onSubmit(): void {
    if (this.form.invalid) return;
    this.isLoading.set(true);
    const raw = this.form.getRawValue();
    const req$ = this.isEdit
      ? this.sitesService.updateForm(raw.formNo!, raw as any)
      : this.sitesService.createForm(raw as any);
    req$.subscribe({ next: () => { this.isLoading.set(false); this.dialogRef.close(true); }, error: () => this.isLoading.set(false) });
  }

  onCancel(): void { this.dialogRef.close(); }
}
