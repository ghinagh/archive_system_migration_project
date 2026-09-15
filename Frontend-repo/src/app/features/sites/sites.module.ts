import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { SitesShellComponent } from './sites-shell/sites-shell.component';
import { FormListComponent } from './form-list/form-list.component';
import { FormDialogComponent } from './form-dialog/form-dialog.component';
import { SiteListComponent } from './site-list/site-list.component';
import { SiteFormComponent } from './site-form/site-form.component';
import { PostListComponent } from './post-list/post-list.component';
import { PostFormComponent } from './post-form/post-form.component';
import { PositionListComponent } from './position-list/position-list.component';
import { PositionDialogComponent } from './position-dialog/position-dialog.component';
import { InstitutionListComponent } from './institution-list/institution-list.component';

const routes: Routes = [
  { path: '', component: SitesShellComponent },
  { path: 'sites/new', component: SiteFormComponent },
  { path: 'sites/:id/edit', component: SiteFormComponent },
  { path: 'posts/new', component: PostFormComponent },
  { path: 'posts/:id/edit', component: PostFormComponent }
];

@NgModule({
  declarations: [
    SitesShellComponent,
    FormListComponent,
    FormDialogComponent,
    SiteListComponent,
    SiteFormComponent,
    PostListComponent,
    PostFormComponent,
    PositionListComponent,
    PositionDialogComponent,
    InstitutionListComponent
  ],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class SitesModule { }
