import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DragDropModule } from '@angular/cdk/drag-drop';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatButtonToggleModule } from '@angular/material/button-toggle';
import { SharedModule } from '../../shared/shared.module';
import { ReportsShellComponent } from './reports-shell/reports-shell.component';
import { TemplateListComponent } from './template-list/template-list.component';
import { TemplateFormComponent } from './template-form/template-form.component';
import { UserOutputListComponent } from './user-output-list/user-output-list.component';
import { UserOutputDialogComponent } from './user-output-dialog/user-output-dialog.component';
import { ReportViewerComponent } from './report-viewer/report-viewer.component';
import { ReportExecutionComponent } from './report-execution/report-execution.component';

const routes: Routes = [
  { path: '', component: ReportsShellComponent },
  { path: 'templates/new', component: TemplateFormComponent },
  { path: 'templates/:id/edit', component: TemplateFormComponent }
];

@NgModule({
  declarations: [
    ReportsShellComponent,
    TemplateListComponent,
    TemplateFormComponent,
    UserOutputListComponent,
    UserOutputDialogComponent,
    ReportViewerComponent,
    ReportExecutionComponent
  ],
  imports: [SharedModule, MatExpansionModule, DragDropModule, MatButtonToggleModule, RouterModule.forChild(routes)]
})
export class ReportsModule { }
