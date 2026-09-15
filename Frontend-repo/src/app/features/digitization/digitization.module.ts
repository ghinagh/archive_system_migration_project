import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { DigitizationShellComponent } from './digitization-shell/digitization-shell.component';
import { DigitRecordListComponent } from './digit-record-list/digit-record-list.component';
import { DigitRecordFormComponent } from './digit-record-form/digit-record-form.component';
import { DemandListComponent } from './demand-list/demand-list.component';
import { DemandFormComponent } from './demand-form/demand-form.component';
import { ResultListComponent } from './result-list/result-list.component';
import { ResultFormComponent } from './result-form/result-form.component';

const routes: Routes = [
  { path: '', component: DigitizationShellComponent },
  { path: 'records/new', component: DigitRecordFormComponent },
  { path: 'demands/new', component: DemandFormComponent },
  { path: 'results/new', component: ResultFormComponent }
];

@NgModule({
  declarations: [
    DigitizationShellComponent,
    DigitRecordListComponent,
    DigitRecordFormComponent,
    DemandListComponent,
    DemandFormComponent,
    ResultListComponent,
    ResultFormComponent
  ],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class DigitizationModule { }
