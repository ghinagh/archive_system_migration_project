import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { UsageRequestListComponent } from './usage-request-list/usage-request-list.component';
import { UsageRequestFormComponent } from './usage-request-form/usage-request-form.component';

// No "new" route — matches the legacy f_result.frm screen, whose own "اضافة" button has no
// click handler at all. New usage requests can only be logged from شاشة البحث's export panel.
const routes: Routes = [
  { path: '', component: UsageRequestListComponent },
  { path: ':id/edit', component: UsageRequestFormComponent }
];

@NgModule({
  declarations: [
    UsageRequestListComponent,
    UsageRequestFormComponent
  ],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class RequestsModule { }
