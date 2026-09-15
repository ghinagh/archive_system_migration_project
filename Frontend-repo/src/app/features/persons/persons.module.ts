import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatTabsModule } from '@angular/material/tabs';
import { SharedModule } from '../../shared/shared.module';
import { PersonsShellComponent } from './persons-shell/persons-shell.component';
import { PersonListComponent } from './person-list/person-list.component';
import { PersonDetailComponent } from './person-detail/person-detail.component';
import { PersonFormComponent } from './person-form/person-form.component';
import { ConfirmDialogComponent } from './confirm-dialog/confirm-dialog.component';
import { StaffListComponent } from './staff-list/staff-list.component';
import { StaffDetailComponent } from './staff-detail/staff-detail.component';

const routes: Routes = [
  { path: '',             component: PersonsShellComponent },
  { path: 'new',         component: PersonFormComponent },
  // 'staff/:id' must precede ':id' so the router doesn't treat 'staff' as a patron ID
  { path: 'staff/:id',   component: StaffDetailComponent },
  { path: ':id',         component: PersonDetailComponent },
  { path: ':id/edit',    component: PersonFormComponent }
];

@NgModule({
  declarations: [
    PersonsShellComponent,
    PersonListComponent,
    PersonDetailComponent,
    PersonFormComponent,
    ConfirmDialogComponent,
    StaffListComponent,
    StaffDetailComponent
  ],
  imports: [SharedModule, MatExpansionModule, MatTabsModule, RouterModule.forChild(routes)]
})
export class PersonsModule { }
