import { Routes } from '@angular/router';
import { MainLayoutComponent } from './layouts/main-layout/main-layout.component';
import { authGuard } from './core/guards/auth.guard';
import { subjectThesaurusAccessGuard } from './core/guards/subject-thesaurus-access.guard';
import { formThesaurusAccessGuard } from './core/guards/form-thesaurus-access.guard';

export const routes: Routes = [
  {
    path: 'auth',
    loadChildren: () => import('./features/auth/auth.module').then(m => m.AuthModule)
  },
  {
    path: 'public',
    loadChildren: () => import('./features/public-search/public-search.module').then(m => m.PublicSearchModule)
  },
  {
    path: '',
    component: MainLayoutComponent,
    canActivate: [authGuard],
    children: [
      { path: '', redirectTo: 'catalogue', pathMatch: 'full' },
      {
        path: 'catalogue',
        loadChildren: () => import('./features/catalogue/catalogue.module').then(m => m.CatalogueModule)
      },
      {
        path: 'books',
        loadChildren: () => import('./features/books/books.module').then(m => m.BooksModule)
      },
      {
        path: 'articles',
        loadChildren: () => import('./features/articles/articles.module').then(m => m.ArticlesModule)
      },
      {
        path: 'news',
        loadChildren: () => import('./features/news/news.module').then(m => m.NewsModule)
      },
      {
        path: 'pictures',
        loadChildren: () => import('./features/pictures/pictures.module').then(m => m.PicturesModule)
      },
      {
        path: 'periodicals',
        loadChildren: () => import('./features/periodicals/periodicals.module').then(m => m.PeriodicalsModule)
      },
      {
        path: 'subjects',
        loadChildren: () => import('./features/subjects/subjects.module').then(m => m.SubjectsModule)
      },
      {
        // المكنز الموضوعي (legacy Form5) — opens only after the ARCHIVE.frm Frame3 key.
        path: 'subject-thesaurus',
        canActivate: [subjectThesaurusAccessGuard],
        loadChildren: () => import('./features/subject-thesaurus/subject-thesaurus.module').then(m => m.SubjectThesaurusModule)
      },
      {
        // المكنز الشكلي (legacy coding.frm) — opens only after the ARCHIVE.frm Frame3 key.
        path: 'form-thesaurus',
        canActivate: [formThesaurusAccessGuard],
        loadChildren: () => import('./features/form-thesaurus/form-thesaurus.module').then(m => m.FormThesaurusModule)
      },
      {
        path: 'persons',
        loadChildren: () => import('./features/persons/persons.module').then(m => m.PersonsModule)
      },
      {
        path: 'authors',
        loadChildren: () => import('./features/authors/authors.module').then(m => m.AuthorsModule)
      },
      {
        path: 'borrowing',
        loadChildren: () => import('./features/borrowing/borrowing.module').then(m => m.BorrowingModule)
      },
      {
        path: 'archive',
        loadChildren: () => import('./features/archive/archive.module').then(m => m.ArchiveModule)
      },
      {
        path: 'sites',
        loadChildren: () => import('./features/sites/sites.module').then(m => m.SitesModule)
      },
      {
        path: 'digitization',
        loadChildren: () => import('./features/digitization/digitization.module').then(m => m.DigitizationModule)
      },
      {
        path: 'reports',
        loadChildren: () => import('./features/reports/reports.module').then(m => m.ReportsModule)
      },
      {
        path: 'users',
        loadChildren: () => import('./features/users/users.module').then(m => m.UsersModule)
      },
      {
        path: 'video-orders',
        loadChildren: () => import('./features/video-orders/video-orders.module').then(m => m.VideoOrdersModule)
      },
      {
        path: 'requests',
        loadChildren: () => import('./features/requests/requests.module').then(m => m.RequestsModule)
      },
      {
        path: 'maintenance',
        loadChildren: () => import('./features/maintenance/maintenance.module').then(m => m.MaintenanceModule)
      },
      {
        path: 'archive-search',
        loadChildren: () => import('./features/archive-search/archive-search.module').then(m => m.ArchiveSearchModule)
      },
      {
        path: 'retrieval',
        loadChildren: () => import('./features/retrieval/retrieval.module').then(m => m.RetrievalModule)
      }
    ]
  },
  { path: '**', redirectTo: '' }
];
