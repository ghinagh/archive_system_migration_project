import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ScrollingModule } from '@angular/cdk/scrolling';
import { SharedModule } from '../../shared/shared.module';
import { AuthorCodingComponent } from './author-coding/author-coding.component';

const routes: Routes = [
  { path: '', component: AuthorCodingComponent }
];

@NgModule({
  declarations: [AuthorCodingComponent],
  imports: [SharedModule, ScrollingModule, RouterModule.forChild(routes)]
})
export class AuthorsModule { }
