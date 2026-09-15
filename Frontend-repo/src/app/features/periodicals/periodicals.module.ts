import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { PeriodicalListComponent } from './periodical-list/periodical-list.component';
import { PeriodicalDetailComponent } from './periodical-detail/periodical-detail.component';
import { PeriodicalFormComponent } from './periodical-form/periodical-form.component';
import { TransactionsTabComponent } from './transactions-tab/transactions-tab.component';
import { TransactionFormComponent } from './transaction-form/transaction-form.component';

const routes: Routes = [
  { path: '', component: PeriodicalListComponent },
  { path: 'new', component: PeriodicalFormComponent },
  { path: ':perNo/edit', component: PeriodicalFormComponent },
  { path: ':perNo', component: PeriodicalDetailComponent }
];

@NgModule({
  declarations: [
    PeriodicalListComponent,
    PeriodicalDetailComponent,
    PeriodicalFormComponent,
    TransactionsTabComponent,
    TransactionFormComponent
  ],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class PeriodicalsModule { }
