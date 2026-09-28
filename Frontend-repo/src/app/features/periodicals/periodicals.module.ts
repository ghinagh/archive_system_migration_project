import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { PeriodicalFormComponent } from './periodical-form/periodical-form.component';

// The legacy PERIOD1.frm ("استمارة الدورية") has no separate list/landing screen —
// opening ARCHIVE.frm -> المعالجات -> الصحف والمجلات shows the form itself, already
// in "ready to add or search" mode. So every route here resolves to the one primary
// form screen; 'new' and ':perNo/edit' are kept only so existing deep links/bookmarks
// still work.
const routes: Routes = [
  { path: '', component: PeriodicalFormComponent },
  { path: 'new', component: PeriodicalFormComponent },
  { path: ':perNo/edit', component: PeriodicalFormComponent },
  { path: ':perNo', component: PeriodicalFormComponent }
];

@NgModule({
  declarations: [
    PeriodicalFormComponent
  ],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class PeriodicalsModule { }
