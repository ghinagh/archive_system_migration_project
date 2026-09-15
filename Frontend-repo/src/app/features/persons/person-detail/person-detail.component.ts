import { Component, OnInit, inject, signal } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatTabChangeEvent } from '@angular/material/tabs';
import { TranslateService } from '@ngx-translate/core';
import { PersonsService } from '../services/persons.service';
import { Person, PersonAssignment } from '../models/person.model';
import { ConfirmDialogComponent } from '../confirm-dialog/confirm-dialog.component';

@Component({
  standalone: false,
  selector: 'app-person-detail',
  templateUrl: './person-detail.component.html',
  styleUrls: ['./person-detail.component.scss']
})
export class PersonDetailComponent implements OnInit {

  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private personsService = inject(PersonsService);
  private dialog = inject(MatDialog);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  person = signal<Person | null>(null);
  isLoading = signal(true);

  assignments = signal<PersonAssignment[]>([]);
  assignmentsLoading = signal(false);
  assignmentsLoaded = signal(false);
  readonly assignmentColumns = ['siteDescription', 'postType', 'startDate', 'endDate', 'status', 'level', 'wilayaNo', 'positionNo', 'positionName'];

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (!id) return;

    this.personsService.getById(id).subscribe({
      next: (res) => {
        this.person.set(res.data);
        this.isLoading.set(false);
      },
      error: () => {
        this.isLoading.set(false);
        this.router.navigate(['/persons']);
      }
    });
  }

  onTabChange(event: MatTabChangeEvent): void {
    if (event.index === 1) {
      this.loadAssignments();
    }
  }

  onEdit(): void {
    this.router.navigate(['/persons', this.person()!.prsNo, 'edit']);
  }

  onDelete(): void {
    const dialogRef = this.dialog.open(ConfirmDialogComponent, { width: '350px' });

    dialogRef.afterClosed().subscribe(confirmed => {
      if (!confirmed) return;

      this.personsService.delete(this.person()!.prsNo).subscribe({
        next: () => {
          this.snackBar.open(
            this.translate.instant('APP.SUCCESS'),
            this.translate.instant('APP.CANCEL'),
            { duration: 3000 }
          );
          this.router.navigate(['/persons']);
        }
      });
    });
  }

  private loadAssignments(): void {
    if (this.assignmentsLoaded()) return;
    const prsNo = this.person()?.prsNo;
    if (!prsNo) return;

    this.assignmentsLoading.set(true);
    this.personsService.getAssignments(prsNo).subscribe({
      next: (res) => {
        this.assignments.set(res.data ?? []);
        this.assignmentsLoaded.set(true);
        this.assignmentsLoading.set(false);
      },
      error: () => {
        this.assignmentsLoading.set(false);
      }
    });
  }

  goBack(): void {
    this.router.navigate(['/persons']);
  }
}
