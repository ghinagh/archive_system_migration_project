import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ScrollingModule } from '@angular/cdk/scrolling';
import { SharedModule } from '../../shared/shared.module';
import { SubjectThesaurusComponent } from './subject-thesaurus/subject-thesaurus.component';
import { ThesaurusListComponent } from './thesaurus-list/thesaurus-list.component';

const routes: Routes = [
  { path: '', component: SubjectThesaurusComponent }
];

@NgModule({
  declarations: [SubjectThesaurusComponent, ThesaurusListComponent],
  imports: [SharedModule, ScrollingModule, RouterModule.forChild(routes)]
})
export class SubjectThesaurusModule { }
