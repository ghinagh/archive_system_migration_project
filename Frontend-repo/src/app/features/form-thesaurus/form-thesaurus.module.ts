import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ScrollingModule } from '@angular/cdk/scrolling';
import { DragDropModule } from '@angular/cdk/drag-drop';
import { SharedModule } from '../../shared/shared.module';
import { FormThesaurusComponent } from './form-thesaurus/form-thesaurus.component';
import { CodingListComponent } from './coding-list/coding-list.component';
import { AdditionalFilesComponent } from './additional-files/additional-files.component';

const routes: Routes = [
  { path: '', component: FormThesaurusComponent }
];

@NgModule({
  declarations: [FormThesaurusComponent, CodingListComponent, AdditionalFilesComponent],
  imports: [SharedModule, ScrollingModule, DragDropModule, RouterModule.forChild(routes)]
})
export class FormThesaurusModule { }
