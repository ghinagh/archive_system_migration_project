import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { ArchiveSearchCockpitComponent } from './archive-search-cockpit/archive-search-cockpit.component';

const routes: Routes = [
  { path: '', component: ArchiveSearchCockpitComponent }
];

@NgModule({
  declarations: [
    ArchiveSearchCockpitComponent
  ],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class ArchiveSearchModule { }
