import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { VideoOrderListComponent } from './video-order-list/video-order-list.component';
import { VideoOrderFormComponent } from './video-order-form/video-order-form.component';
import { VideoOrderQueueComponent } from './video-order-queue/video-order-queue.component';

// '' now serves the real legacy "طلبيات الفيديو" order queue (bound to the demand table).
// video-order-list/-form (the unrelated video_order/CHARIT approval workflow this route used
// to serve) are kept reachable at /approvals for whatever independent value they still have.
const routes: Routes = [
  { path: '', component: VideoOrderQueueComponent },
  { path: 'approvals', component: VideoOrderListComponent },
  { path: 'approvals/new', component: VideoOrderFormComponent },
  { path: 'approvals/:id/edit', component: VideoOrderFormComponent }
];

@NgModule({
  declarations: [
    VideoOrderListComponent,
    VideoOrderFormComponent,
    VideoOrderQueueComponent
  ],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class VideoOrdersModule { }
