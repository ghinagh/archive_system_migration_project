import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MatExpansionModule } from '@angular/material/expansion';
import { SharedModule } from '../../shared/shared.module';
import { PictureListComponent } from './picture-list/picture-list.component';
import { PictureDetailComponent } from './picture-detail/picture-detail.component';
import { PictureFormComponent } from './picture-form/picture-form.component';
import { VideoPreviewDialogComponent } from './video-preview-dialog/video-preview-dialog.component';

const routes: Routes = [
  { path: '', component: PictureListComponent },
  { path: 'new', component: PictureFormComponent },
  { path: ':id', component: PictureDetailComponent },
  { path: ':id/edit', component: PictureFormComponent }
];

@NgModule({
  declarations: [
    PictureListComponent,
    PictureDetailComponent,
    PictureFormComponent,
    VideoPreviewDialogComponent
  ],
  imports: [SharedModule, MatExpansionModule, RouterModule.forChild(routes)]
})
export class PicturesModule { }
