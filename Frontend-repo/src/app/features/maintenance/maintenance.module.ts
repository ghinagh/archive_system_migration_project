import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { adminGuard } from '../../core/guards/admin.guard';
import { MaintenanceShellComponent } from './maintenance-shell/maintenance-shell.component';
import { RetrievalFieldDialogComponent } from './retrieval-field-dialog/retrieval-field-dialog.component';

const routes: Routes = [
  { path: '', component: MaintenanceShellComponent, canActivate: [adminGuard] }
];

@NgModule({
  declarations: [
    MaintenanceShellComponent,
    RetrievalFieldDialogComponent
  ],
  imports: [SharedModule, RouterModule.forChild(routes)],
  exports: []
})
export class MaintenanceModule { }
