import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { AuthorListComponent } from './author-list/author-list.component';
import { AuthorDialogComponent } from './author-dialog/author-dialog.component';

const routes: Routes = [
  { path: '', component: AuthorListComponent }
];

@NgModule({
  declarations: [
    AuthorListComponent,
    AuthorDialogComponent
  ],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class AuthorsModule { }
