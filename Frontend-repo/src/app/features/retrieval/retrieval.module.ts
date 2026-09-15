import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { GraphicalRetrievalComponent } from './graphical-retrieval/graphical-retrieval.component';
import { RetrievalResultsComponent } from './retrieval-results/retrieval-results.component';

const routes: Routes = [
  { path: '', component: GraphicalRetrievalComponent },
  { path: 'results', component: RetrievalResultsComponent }
];

@NgModule({
  declarations: [
    GraphicalRetrievalComponent,
    RetrievalResultsComponent
  ],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class RetrievalModule { }
