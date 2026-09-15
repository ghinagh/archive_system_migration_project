import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { BookListComponent } from './book-list/book-list.component';
import { BookDetailComponent } from './book-detail/book-detail.component';
import { BookFormComponent } from './book-form/book-form.component';

const routes: Routes = [
  { path: '', component: BookListComponent },
  { path: 'new', component: BookFormComponent },
  { path: ':appNo/edit', component: BookFormComponent },
  { path: ':appNo', component: BookDetailComponent }
];

@NgModule({
  declarations: [
    BookListComponent,
    BookDetailComponent,
    BookFormComponent
  ],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class BooksModule { }
