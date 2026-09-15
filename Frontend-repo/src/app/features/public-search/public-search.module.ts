import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { PublicSearchComponent } from './public-search.component';

const routes: Routes = [
  { path: '', component: PublicSearchComponent }
];

@NgModule({
  declarations: [PublicSearchComponent],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class PublicSearchModule { }
