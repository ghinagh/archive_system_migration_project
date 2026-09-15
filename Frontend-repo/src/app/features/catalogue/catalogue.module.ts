import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { CatalogueListComponent } from './catalogue-list/catalogue-list.component';
import { CatalogueDetailComponent } from './catalogue-detail/catalogue-detail.component';
import { CatalogueFormComponent } from './catalogue-form/catalogue-form.component';
import { TempFilesComponent } from './temp-files/temp-files.component';
import { TempFileDialogComponent } from './temp-file-dialog/temp-file-dialog.component';
import { Main2FormDialogComponent } from './main2-form-dialog/main2-form-dialog.component';
import { UnifiedSearchComponent } from './unified-search/unified-search.component';
import { FilesRetrievalComponent } from './files-retrieval/files-retrieval.component';
import { DocumentationFormComponent } from './documentation-form/documentation-form.component';
import { ConfirmPromptDialogComponent } from './documentation-form/dialogs/confirm-prompt-dialog.component';
import { PasswordGateDialogComponent } from './documentation-form/dialogs/password-gate-dialog.component';
import { GotoRecordDialogComponent } from './documentation-form/dialogs/goto-record-dialog.component';
import { Page2PromptDialogComponent } from './documentation-form/dialogs/page2-prompt-dialog.component';
import { SearchByTitleDialogComponent } from './documentation-form/dialogs/search-by-title-dialog.component';
import { DigitalFilesGridComponent } from './digital-files-grid/digital-files-grid.component';
import { DigitRecordDialogComponent } from './digital-files-grid/digit-record-dialog.component';
import { AnalysisPanelComponent } from './analysis-panel/analysis-panel.component';

const routes: Routes = [
  { path: 'search', component: UnifiedSearchComponent },
  { path: 'files-retrieval', component: FilesRetrievalComponent },
  { path: '', component: CatalogueListComponent },
  { path: 'new', component: DocumentationFormComponent },
  { path: ':appNo', component: CatalogueDetailComponent }
];

@NgModule({
  declarations: [
    CatalogueListComponent,
    CatalogueDetailComponent,
    CatalogueFormComponent,
    TempFilesComponent,
    TempFileDialogComponent,
    Main2FormDialogComponent,
    UnifiedSearchComponent,
    FilesRetrievalComponent,
    DocumentationFormComponent,
    ConfirmPromptDialogComponent,
    PasswordGateDialogComponent,
    GotoRecordDialogComponent,
    Page2PromptDialogComponent,
    SearchByTitleDialogComponent,
    DigitalFilesGridComponent,
    DigitRecordDialogComponent,
    AnalysisPanelComponent
  ],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class CatalogueModule { }
