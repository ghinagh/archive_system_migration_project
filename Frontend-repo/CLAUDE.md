# Frontend Context — Angular 21 (Frontend-repo)

## Framework & Versions
| Component | Version |
|-----------|---------|
| Angular | 21.2 |
| Node.js | 24+ |
| npm | 11.13.0 |
| TypeScript | ~5.9 |
| Test runner | Vitest 4 |
| Builder | `@angular/build:application` |
| Styles | SCSS + Angular Material |

## Running the App Locally
```bash
npm install
npm start          # → http://localhost:4200 (dev server, HMR enabled)
npm test           # → run unit tests with Vitest
npm run build      # → production build to dist/
```

## Project Structure
```
src/
├── app/
│   ├── core/            ← NgModule — singleton services, guards, interceptors, auth
│   │   └── core.module.ts
│   ├── shared/          ← NgModule — reusable components, pipes, directives, UI widgets
│   │   └── shared.module.ts
│   ├── features/        ← Lazy-loaded feature NgModules (one per domain)
│   │   ├── auth/            ← login, register, password reset
│   │   ├── catalogue/       ← main catalogue (books, articles, news, periodicals)
│   │   ├── persons/         ← person management (PERSON table)
│   │   ├── borrowing/       ← borrowing/lending (ISTARA)
│   │   ├── archive/         ← charts/archive management (CHARIT)
│   │   ├── subjects/        ← MACNZ subject taxonomy
│   │   ├── sites/           ← sites and positions management
│   │   ├── digitization/    ← DIGIT / demand / result
│   │   ├── reports/         ← output templates (bnkout/POUT)
│   │   └── users/           ← user management (config table)
│   ├── layouts/         ← page layout components (header, sidebar, shell)
│   ├── app.routes.ts    ← root routes (lazy loads feature modules)
│   ├── app.config.ts    ← ApplicationConfig (providers, router)
│   ├── app.ts           ← root AppComponent
│   └── app.html
├── environments/
│   ├── environment.ts           ← default (points to dev API)
│   ├── environment.dev.ts
│   ├── environment.qa.ts
│   ├── environment.staging.ts
│   └── environment.prod.ts
├── styles.scss          ← global styles
└── main.ts              ← bootstrapApplication entry point
```

## Architecture Rules

### NgModule — NOT Standalone Components
This project uses **NgModule-based architecture**. Do NOT create standalone components.
```typescript
// ✅ CORRECT — NgModule component
@Component({
  selector: 'app-book-list',
  templateUrl: './book-list.component.html',
  styleUrls: ['./book-list.component.scss']
  // No `standalone: true`
})
export class BookListComponent { }

// ❌ WRONG — standalone component
@Component({
  standalone: true,
  selector: 'app-book-list',
  imports: [CommonModule, ...],
  ...
})
```

### Feature Module Routing (Lazy Loading)
All feature modules must be lazy-loaded from `app.routes.ts`:
```typescript
// app.routes.ts
export const routes: Routes = [
  {
    path: 'catalogue',
    loadChildren: () => import('./features/catalogue/catalogue.module')
      .then(m => m.CatalogueModule)
  },
  {
    path: 'borrowing',
    loadChildren: () => import('./features/borrowing/borrowing.module')
      .then(m => m.BorrowingModule)
  },
  // ...
];
```

### State Management — Angular Signals
Use Angular Signals for component and feature-level state:
```typescript
// ✅ CORRECT
export class BookListComponent {
  private bookService = inject(BookService);

  books = signal<BookResponse[]>([]);
  isLoading = signal(false);
  errorMessage = signal<string | null>(null);

  loadBooks() {
    this.isLoading.set(true);
    this.bookService.getAll().subscribe({
      next: (data) => this.books.set(data),
      error: (err) => this.errorMessage.set(err.message),
      complete: () => this.isLoading.set(false)
    });
  }
}

// ❌ WRONG — BehaviorSubject for UI state
private booksSubject = new BehaviorSubject<BookResponse[]>([]);
books$ = this.booksSubject.asObservable();
```

### HTTP Client — Typed Responses
Use `HttpClient` with full TypeScript generics. Always type the expected response:
```typescript
// service in core/ or feature/
@Injectable({ providedIn: 'root' })
export class BookService {
  private http = inject(HttpClient);
  private baseUrl = environment.apiUrl + '/api/books';

  getAll(params?: BookFilterParams): Observable<ApiResponse<BookResponse[]>> {
    return this.http.get<ApiResponse<BookResponse[]>>(this.baseUrl, { params: { ...params } });
  }

  getById(id: string): Observable<ApiResponse<BookResponse>> {
    return this.http.get<ApiResponse<BookResponse>>(`${this.baseUrl}/${id}`);
  }

  create(request: CreateBookRequest): Observable<ApiResponse<BookResponse>> {
    return this.http.post<ApiResponse<BookResponse>>(this.baseUrl, request);
  }
}
```

### Internationalization (i18n) — Arabic & English
The app must support **Arabic (RTL)** and **English (LTR)**:
- Use `ngx-translate` or Angular's built-in i18n
- All user-visible strings must be externalized — no hardcoded strings in templates
- Legacy domain has Arabic and English fields (e.g. `MN_ACT_TTL` Arabic, `MN_ADD_TTL` additional title)
- The app must support RTL layout switching when Arabic is active

```html
<!-- ✅ CORRECT — use translation key -->
<h1>{{ 'CATALOGUE.TITLE' | translate }}</h1>

<!-- ❌ WRONG — hardcoded string -->
<h1>Book Catalogue</h1>
```

### Browser Storage
Use `localStorage` / `sessionStorage` where cross-session persistence is needed:
- Auth token: `localStorage` (`access_token`, `refresh_token`)
- User preferences (language, theme): `localStorage`
- Temporary form state: `sessionStorage`
- Do NOT store sensitive data in plain browser storage

### HTTP Interceptors (in core/)
Required interceptors:
1. **Auth Interceptor** — attach `Authorization: Bearer <token>` to every outgoing request
2. **Error Interceptor** — handle 401 (redirect to login), 403 (show permission error), 500 (show generic error)
3. **Loading Interceptor** — track pending HTTP requests for a global loading indicator (optional)

### Guards (in core/)
- `AuthGuard` — redirect to `/auth/login` if no valid JWT
- `RoleGuard` (or `PermissionGuard`) — check user permissions against the `config.user_level` / `config.user_permition` fields from the legacy schema

## Domain Features to Build
Each of the following maps to a feature module and a set of backend endpoints:

| Feature Module | Legacy VB Forms | Key Tables |
|----------------|-----------------|------------|
| `catalogue` | Form1, ARCHIVE, book.frm, coding.frm | `main`, `BOOK`, `ARTICLE`, `NEWS`, `PERIOD` |
| `subjects` | charit.frm, find_charit.frm, coding.frm | `MACNZ`, `CODING`, `ANALIS`, `NAROWER`, `RELATIVE` |
| `persons` | end_user.frm, config_users.frm | `PERSON`, `PERSON1` |
| `borrowing` | frm_result.frm, frm_res2.frm, f_result.frm | `ISTARA`, `IST_BK`, `IST_OTH` |
| `archive` | ARCHIVE.frm, charit.frm | `CHARIT`, `OPR_CHRT` |
| `sites` | form7.frm, Form8.frm | `sites`, `posts`, `POSITION`, `form`, `form1` |
| `digitization` | frm_view.frm | `DIGIT`, `demand`, `result` |
| `reports` | from_report.frm, CAT_OUTFRM.frm | `bnkout`, `POUT`, `POUT1`, `user_bnkout` |
| `users` | config_users.frm | `config` |

## Environments
All API URLs must come from the environment file — never hardcode:
```typescript
// environment.ts (default/dev)
export const environment = {
  production: false,
  apiUrl: 'http://localhost:8080'
};
```
Configure `angular.json` file replacements so `environment.ts` is swapped per build config.

## API Response Shape
The backend wraps all responses in `ApiResponse<T>`. Model this in Angular:
```typescript
export interface ApiResponse<T> {
  success: boolean;
  data: T;
  message?: string;
  timestamp: string;
}

export interface PageResponse<T> {
  content: T[];
  totalElements: number;
  totalPages: number;
  size: number;
  number: number;
}
```

## Styling Conventions
- Use **SCSS** for all component styles
- Use **Angular Material** for UI components (dialogs, tables, forms, navigation)
- RTL support: use Angular Material's RTL capability (set `dir="rtl"` on `<html>` when Arabic)
- Component-level SCSS only — avoid deeply nested global overrides
- Use CSS variables for theme colors to support light/dark and RTL/LTR layouts

## Code Conventions
- Use `inject()` function instead of constructor injection in Angular 14+ style:
  ```typescript
  private service = inject(MyService);
  ```
- Use `computed()` for derived signal values
- Name signals with plain noun (not `$` suffix — that's for Observables)
- Name Observables with `$` suffix: `books$`, `loading$`
- Use `takeUntilDestroyed()` to auto-unsubscribe Observables in components

## What NOT To Do
- Do NOT use standalone components (`standalone: true`)
- Do NOT hardcode API URLs — always use `environment.apiUrl`
- Do NOT hardcode user-visible strings — use i18n keys
- Do NOT store auth tokens in sessionStorage (use localStorage for persistence)
- Do NOT use `NgRx` or `BehaviorSubject` for simple UI state — use Signals
- Do NOT import `HttpClientModule` in feature modules — provide it once in `CoreModule` or `app.config.ts`
- Do NOT use `any` type — always define typed interfaces for API models