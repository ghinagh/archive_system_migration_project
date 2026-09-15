import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MatExpansionModule } from '@angular/material/expansion';
import { SharedModule } from '../../shared/shared.module';
import { NewsListComponent } from './news-list/news-list.component';
import { NewsDetailComponent } from './news-detail/news-detail.component';
import { NewsFormComponent } from './news-form/news-form.component';
import { NewsSortFilterComponent } from './news-sort-filter/news-sort-filter.component';

const routes: Routes = [
  { path: '', component: NewsListComponent },
  { path: 'new', component: NewsFormComponent },
  { path: ':id', component: NewsDetailComponent },
  { path: ':id/edit', component: NewsFormComponent }
];

@NgModule({
  declarations: [
    NewsListComponent,
    NewsDetailComponent,
    NewsFormComponent,
    NewsSortFilterComponent
  ],
  imports: [SharedModule, MatExpansionModule, RouterModule.forChild(routes)]
})
export class NewsModule { }
