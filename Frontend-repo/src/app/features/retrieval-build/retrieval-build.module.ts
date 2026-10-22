import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { retrievalBuildAccessGuard } from './retrieval-build-access.guard';
import { Form4Component } from './form4/form4.component';
import { CatOutComponent } from './cat-out/cat-out.component';
import { DbBackupComponent } from './backup/db-backup.component';

/** ARCHIVE.frm الترميز: m9 ملف بناء الاسترجاعات, M32 معالجة حقول الاسترجاع, m33 نسخ قاعدة البيانات. */
const routes: Routes = [
  { path: 'form4', component: Form4Component, canActivate: [retrievalBuildAccessGuard], data: { gate: 'FORM4' } },
  { path: 'cat-out', component: CatOutComponent, canActivate: [retrievalBuildAccessGuard], data: { gate: 'CAT_OUT' } },
  { path: 'backup', component: DbBackupComponent }
];

@NgModule({
  declarations: [Form4Component, CatOutComponent, DbBackupComponent],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class RetrievalBuildModule { }
