import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { GraphicalRetrievalComponent } from './graphical-retrieval/graphical-retrieval.component';
import { RetrievalResultsComponent } from './retrieval-results/retrieval-results.component';

const routes: Routes = [
  // Same sort_form UI for all three legacy menu items; the scope picks each one's own data source.
  { path: '', component: GraphicalRetrievalComponent, data: { scope: 'BANK' } },
  { path: 'results', component: RetrievalResultsComponent, data: { scope: 'BANK' } },
  { path: 'additional-files', component: GraphicalRetrievalComponent, data: { scope: 'ADDITIONAL_FILES' } },
  { path: 'additional-files/results', component: RetrievalResultsComponent, data: { scope: 'ADDITIONAL_FILES' } },
  { path: 'periodicals', component: GraphicalRetrievalComponent, data: { scope: 'PERIODICALS' } },
  { path: 'periodicals/results', component: RetrievalResultsComponent, data: { scope: 'PERIODICALS' } }
];

@NgModule({
  declarations: [
    GraphicalRetrievalComponent,
    RetrievalResultsComponent
  ],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class RetrievalModule { }
