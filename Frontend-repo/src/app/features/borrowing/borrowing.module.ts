import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { SharedModule } from '../../shared/shared.module';
import { BorrowingListComponent } from './borrowing-list/borrowing-list.component';
import { BorrowingDetailComponent } from './borrowing-detail/borrowing-detail.component';
import { BorrowingFormComponent } from './borrowing-form/borrowing-form.component';

const routes: Routes = [
  { path: '', component: BorrowingListComponent },
  { path: 'new', component: BorrowingFormComponent },
  { path: ':id', component: BorrowingDetailComponent }
];

@NgModule({
  declarations: [
    BorrowingListComponent,
    BorrowingDetailComponent,
    BorrowingFormComponent
  ],
  imports: [SharedModule, MatAutocompleteModule, RouterModule.forChild(routes)]
})
export class BorrowingModule { }
