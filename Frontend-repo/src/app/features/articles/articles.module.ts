import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { ArticleListComponent } from './article-list/article-list.component';
import { ArticleDetailComponent } from './article-detail/article-detail.component';
import { ArticleFormComponent } from './article-form/article-form.component';

const routes: Routes = [
  { path: '', component: ArticleListComponent },
  { path: 'new', component: ArticleFormComponent },
  { path: ':appNo/edit', component: ArticleFormComponent },
  { path: ':appNo', component: ArticleDetailComponent }
];

@NgModule({
  declarations: [
    ArticleListComponent,
    ArticleDetailComponent,
    ArticleFormComponent
  ],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class ArticlesModule { }
