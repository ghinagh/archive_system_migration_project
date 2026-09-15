import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { ArchiveListComponent } from './archive-list/archive-list.component';
import { ArchiveDetailComponent } from './archive-detail/archive-detail.component';
import { ArchiveFormComponent } from './archive-form/archive-form.component';
import { OperationsHistoryComponent } from './operations-history/operations-history.component';
import { OperationFormDialogComponent } from './operation-form-dialog/operation-form-dialog.component';
import { ChartDeleteConfirmDialogComponent } from './chart-delete-confirm-dialog/chart-delete-confirm-dialog.component';

const routes: Routes = [
  { path: '', component: ArchiveListComponent },
  { path: 'new', component: ArchiveFormComponent },
  { path: ':id', component: ArchiveDetailComponent },
  { path: ':id/edit', component: ArchiveFormComponent }
];

@NgModule({
  declarations: [
    ArchiveListComponent,
    ArchiveDetailComponent,
    ArchiveFormComponent,
    OperationsHistoryComponent,
    OperationFormDialogComponent,
    ChartDeleteConfirmDialogComponent
  ],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class ArchiveModule { }
