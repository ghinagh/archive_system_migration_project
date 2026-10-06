import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { MatButtonModule } from '@angular/material/button';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatSortModule } from '@angular/material/sort';
import { MatDialogModule } from '@angular/material/dialog';
import { MatIconModule } from '@angular/material/icon';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatListModule } from '@angular/material/list';
import { MatCardModule } from '@angular/material/card';
import { MatSelectModule } from '@angular/material/select';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatMenuModule } from '@angular/material/menu';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatTabsModule } from '@angular/material/tabs';
import { MatChipsModule } from '@angular/material/chips';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatRadioModule } from '@angular/material/radio';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { LoadingSpinnerComponent } from './components/loading-spinner/loading-spinner.component';
import { GlobalSearchComponent } from './components/global-search/global-search.component';
import { VideoPreviewComponent } from './components/video-preview/video-preview.component';
import { AdvancedSearchComponent } from './components/advanced-search/advanced-search.component';
import { RequiresLevelDirective } from '../features/users/directives/requires-level.directive';
import { HighlightPipe } from './pipes/highlight.pipe';
import { AccessKeyDialogComponent } from './components/access-key-dialog/access-key-dialog.component';

const MATERIAL_MODULES = [
  MatButtonModule,
  MatInputModule,
  MatFormFieldModule,
  MatTableModule,
  MatPaginatorModule,
  MatSortModule,
  MatDialogModule,
  MatIconModule,
  MatToolbarModule,
  MatSidenavModule,
  MatListModule,
  MatCardModule,
  MatSelectModule,
  MatSnackBarModule,
  MatProgressSpinnerModule,
  MatMenuModule,
  MatTooltipModule,
  MatDatepickerModule,
  MatNativeDateModule,
  MatCheckboxModule,
  MatTabsModule,
  MatChipsModule,
  MatExpansionModule,
  MatAutocompleteModule,
  MatRadioModule,
  MatProgressBarModule
];

@NgModule({
  declarations: [
    LoadingSpinnerComponent,
    GlobalSearchComponent,
    VideoPreviewComponent,
    AdvancedSearchComponent,
    AccessKeyDialogComponent,
    RequiresLevelDirective,
    HighlightPipe
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    RouterModule,
    TranslateModule,
    ...MATERIAL_MODULES
  ],
  exports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    RouterModule,
    TranslateModule,
    ...MATERIAL_MODULES,
    LoadingSpinnerComponent,
    GlobalSearchComponent,
    VideoPreviewComponent,
    AdvancedSearchComponent,
    AccessKeyDialogComponent,
    RequiresLevelDirective,
    HighlightPipe
  ]
})
export class SharedModule { }
