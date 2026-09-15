# Project: Form Documenting Platform — Migration from VB + SQL Server → Java + Angular + PostgreSQL

## Project Overview
This project migrates a legacy Visual Basic 6 / SQL Server desktop application (macnz_saydhakim)
to a modern web platform:
- **Java Spring Boot** backend (REST API)
- **Angular** frontend (SPA)
- **PostgreSQL** database

The legacy system is a **library/archive cataloguing and form-documenting platform** used to manage
documents, books, periodicals, articles, persons, borrowing (ISTARA), charts (CHARIT), sites,
positions, subjects (MACNZ taxonomy), digital assets, and reporting outputs.
It was written in Visual Basic 6, used Crystal Reports, MS Access (bnkout.mdb), and SQL Server.

The new system must replicate **all features** of the old system using the migrated schema
defined in `Form Documenting Platform NEW DBML & DB DDL/macnz_manar_postgres.sql`.

## Repository Layout
```
Project 1 - توثيق الاستمارة/
├── CLAUDE.md                                      ← this file (root context)
├── .vscode/settings.json
├── Backend-repo/                                  ← Spring Boot app
│   ├── CLAUDE.md                                  ← backend-specific rules
│   ├── src/main/java/com/startupstack/app/
│   │   ├── config/        ← async, cache (Redis), database, security, swagger
│   │   ├── modules/       ← feature modules (notifications, orders, products, users)
│   │   │   └── <module>/  ← controller / dto / entity / mapper / repository / service / specification
│   │   └── shared/        ← auditing, constants, enums, exception, mapper, response, util
│   ├── src/main/resources/
│   │   ├── application.yml
│   │   ├── application-dev.yml / -qa.yml / -staging.yml / -prod.yml
│   │   └── logback-spring.xml
│   ├── src/test/postman/  ← Postman collections for startupstack API (dev + qa envs)
│   ├── docker/
│   │   ├── Dockerfile
│   │   └── docker-compose.dev.yml  ← backend + postgres:16 + redis:7 on port 8080
│   └── .github/workflows/
│       ├── backend-dev.yml    ← triggers on push to `dev` branch: build + test
│       └── backend-cicd.yml   ← triggers on push to `qa/staging/prod`: build + docker push + SSH deploy
├── Frontend-repo/                                 ← Angular 21 app
│   ├── CLAUDE.md                                  ← frontend-specific rules
│   ├── src/
│   │   ├── app/
│   │   │   ├── core/          ← singleton services, guards, interceptors (NgModule-based)
│   │   │   ├── shared/        ← shared components, pipes, directives (NgModule-based)
│   │   │   ├── features/      ← lazy-loaded feature modules (to be created)
│   │   │   └── layouts/       ← layout components (to be created)
│   │   ├── environments/      ← environment.ts / .dev.ts / .qa.ts / .staging.ts / .prod.ts
│   │   └── styles.scss
│   ├── angular.json           ← builder: @angular/build:application, style: scss
│   └── package.json           ← Angular 21.2, npm 11, TypeScript ~5.9, vitest for tests
└── Form Documenting Platform OLD Source code & DB DDL/
    ├── macnz_manar_ddl.sql       ← original SQL Server DDL (reference only, do NOT use directly)
    ├── macnz_manar_ERD.svg       ← legacy ERD diagram
    └── macnz_saydhakim/          ← legacy VB6 source (.frm, .bas, .vbp, Crystal Reports .rpt)
        └── macnz_saydhakim/      ← VB forms: ARCHIVE, BOOK, CHARIT, CODING, config_users,
                                     end_user, find_charit, Form1-10, frm_result, frm_view, etc.
└── Form Documenting Platform NEW DBML & DB DDL/
    ├── macnz_manar.dbml          ← new schema in DBML (source of truth for relationships)
    └── macnz_manar_postgres.sql  ← PostgreSQL DDL to use for Flyway migrations
```

## Legacy Domain Model (Key Tables)
The database is named `macnz_manar`. Core domain entities migrated to PostgreSQL:

| Table | Domain Concept |
|-------|---------------|
| `main` | Master catalogue record (primary document, `MN_APP_NO` is the main PK) |
| `BOOK` | Books catalogue (extends main) |
| `ARTICLE` | Journal articles (links to PERIOD) |
| `NEWS` | Newspaper clippings |
| `PERIOD` | Periodicals / journals |
| `AUTHER` | Authors / persons as contributors |
| `PERSON` / `PERSON1` | Patrons / staff persons |
| `MACNZ` | Subject taxonomy (thesaurus codes) |
| `CHARIT` | Archive/chart items (document bundles) |
| `OPR_CHRT` | Operations on charts (circulation movements) |
| `ISTARA` | Borrowing/lending transactions |
| `DIGIT` | Digitization records |
| `form` / `form1` | Form registry (site form definitions) |
| `sites` / `posts` | Organizational sites and posts/positions |
| `POSITION` | Named positions |
| `bnkout` / `POUT` / `POUT1` | Output/report template definitions |
| `config` | User accounts and permissions (legacy auth) |
| `result` | Digitization results |
| `demand` | Digitization requests |
| `CODING` | Subject code levels |
| `ARRAYS` / `ARRAYS1` | Lookup arrays |

## Current Stack (Legacy — reference only)
- Language: Visual Basic 6
- Database: SQL Server (macnz_manar) + MS Access (bnkout.mdb)
- Reporting: Crystal Reports 8–13
- Architecture: Windows Forms, single-machine desktop app

## Target Stack
| Layer | Technology |
|-------|-----------|
| Backend | Java 25 + Spring Boot 3.2 |
| Frontend | Angular 21 |
| Database | PostgreSQL 16 (docker) → PostgreSQL 18 (production target) |
| Auth | JWT tokens (Spring Security) |
| API | RESTful |
| Caching | Redis 7 |
| DB Migration | Flyway (based on `macnz_manar_postgres.sql`) |
| Containerisation | Docker / Docker Compose |
| CI/CD | GitHub Actions (DO NOT modify workflow files) |

## Migration Rules & Hard Constraints
- **DO NOT modify** `.github/workflows/` files — they are already configured
- **DO NOT use raw SQL scripts** — use Flyway migrations only
- **DO NOT expose JPA entities** in API responses — always use DTOs
- **DO NOT create stored procedures** — use Spring Data JPA / Specifications
- **DO NOT use SQL Server-specific syntax** in any new code
- **DO NOT use VB naming conventions** (abbreviations like `ART_APP_NO` in new Java/Angular code — create clean domain names)
- **DO NOT use Angular standalone components** — this project uses NgModule-based architecture
- All API endpoints must be RESTful (no SOAP, no RPC-style)
- Use Redis for caching Application-level variables and frequently-read lookup data (ARRAYS, MACNZ, CODING, etc.)

## Coding Standards

### Backend (Java)
- Use **constructor injection** — never `@Autowired` field injection
- All responses wrapped in `ResponseEntity<>`
- Use **DTOs** for all request/response — never expose entities
- Use **Global Exception Handling** via `@ControllerAdvice`
- Use **MapStruct** for entity ↔ DTO mapping
- Layered architecture strictly inside each module: `Controller → Service → Repository → Entity`
- Package all new modules under: `com.startupstack.app.modules.<feature>/`
- Shared utilities go under: `com.startupstack.app.shared/`
- Use `JpaSpecificationExecutor` for dynamic filtering (existing pattern in `specification/` folders)

### Frontend (Angular)
- Use **Angular Signals** for state management (not NgRx, not BehaviorSubject for UI state)
- Use **HttpClient** with typed responses (generics)
- **Lazy-load** all feature modules via the router
- Support **bilingual UI** — Arabic and English (use `ngx-translate` or Angular i18n)
- Use **browser storage** (localStorage/sessionStorage) where persistence across sessions is needed
- Styling: SCSS + Angular Material
- **NgModule-based** — do NOT use standalone components

### Database (PostgreSQL)
- Table names: `snake_case` (matching the migrated schema)
- All **new** tables must have: `id` (UUID), `created_at`, `updated_at`
- Use **UUIDs** as primary keys for all new tables
- Legacy tables from `macnz_manar_postgres.sql` keep their original column names but must be
  wrapped in clean Java entity classes with proper field name mappings via `@Column`
- Run `macnz_manar_postgres.sql` as a Flyway baseline migration (`V1__baseline.sql`)

## Environment & CI/CD Notes
- **Branches**: `dev` → runs tests; `qa` / `staging` / `prod` → builds + Docker push + SSH deploy
- **Docker Compose (dev)**: backend on `:8080`, postgres:16, redis:7
- **Spring profiles**: `dev`, `qa`, `staging`, `prod` — each has its own `application-<env>.yml`
- **Build tool**: Maven — always include/update `pom.xml` when adding dependencies

## What NOT To Do
- Do not use VB patterns or naming conventions in new code
- Do not write SQL Server-specific syntax
- Do not create stored procedures (use Spring Data JPA)
- Do not touch `.github/workflows/` files
- Do not use Angular standalone components
- Do not expose JPA entities in REST responses
- Do not use `@Autowired` field injection

## Intentionally Not Migrated

The following legacy VB6 artefacts were analysed and deliberately excluded from the migration.
They must **not** be implemented in the new system.

| Legacy Artefact | Reason for Exclusion |
|-----------------|----------------------|
| `Form10.frm` | Abandoned prototype. Queries a `trans` table that does not exist in either `macnz_manar_ddl.sql` or `macnz_manar_postgres.sql`. The form is never opened from any other form (no `Form10.Show` call exists anywhere in the codebase). The only stored procedure it references (`proc_trans`) is commented out and also absent from the DDL. The form has no real caption ("Form10" is the default), confirming it was never completed. `opr_period.frm` shares the same `VB_Name = "Form10"` internally, indicating a copy-paste origin — the actual periodical-operation functionality is fully covered by `TransModule` (`/api/transactions`). |