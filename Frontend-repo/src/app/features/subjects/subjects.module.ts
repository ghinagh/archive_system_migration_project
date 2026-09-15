import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { SharedModule } from '../../shared/shared.module';
import { SubjectBrowserComponent } from './subject-browser/subject-browser.component';
import { SubjectSearchComponent } from './subject-search/subject-search.component';
import { SubjectAssignComponent } from './subject-assign/subject-assign.component';
import { SubjectSearchDialogComponent } from './subject-search-dialog/subject-search-dialog.component';
import { CodingFormComponent } from './coding-form/coding-form.component';
import { SubjectFormComponent } from './subject-form/subject-form.component';

const routes: Routes = [
  { path: '', component: SubjectBrowserComponent }
];

@NgModule({
  declarations: [
    SubjectBrowserComponent,
    SubjectSearchComponent,
    SubjectAssignComponent,
    SubjectSearchDialogComponent,
    CodingFormComponent,
    SubjectFormComponent
  ],
  imports: [
    SharedModule,
    MatExpansionModule,
    MatAutocompleteModule,
    RouterModule.forChild(routes)
  ],
  exports: [
    SubjectSearchComponent,
    SubjectAssignComponent
  ]
})
export class SubjectsModule { }
