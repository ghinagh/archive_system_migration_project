# Migration Coverage Audit Report
**Project:** Form Documenting Platform — VB6 + SQL Server → Java + Angular + PostgreSQL
**Date:** 2026-06-29
**Legacy Source:** 54 VB forms, 2 BAS modules, 12 Crystal Reports, 69 database tables
**New System:** 16 Spring Boot controllers (96 endpoints), 10 Angular feature modules

---

## Section 1 — VB Forms Coverage

| # | Legacy Form | Purpose | Frontend Module | Frontend Component | Status | Gap Notes |
|---|------------|---------|-----------------|-------------------|--------|-----------|
| 1 | ARCHIVE.frm | Main app shell / MDI menu | LayoutsModule | MainLayoutComponent | COVERED | Sidenav replaces MDI menu |
| 2 | book.frm | Book module menu | LayoutsModule | MainLayoutComponent (nav) | COVERED | Navigation links cover this |
| 3 | book1.frm | Book module menu variant | LayoutsModule | MainLayoutComponent (nav) | COVERED | Duplicate of book.frm |
| 4 | charit.frm | Chart/archive CRUD | ArchiveModule | ArchiveListComponent + ArchiveFormComponent | PARTIAL | Missing: batch insert, stock uniqueness validation, auto-sequential cha_no generation |
| 5 | coding.frm | Subject taxonomy management | SubjectsModule | SubjectBrowserComponent | PARTIAL | Missing: CODING CRUD, form-subject linking, word indexing (div_word), position/institution management |
| 6 | config_users.frm | User account management | UsersModule | UserListComponent + UserFormComponent | COVERED | |
| 7 | correct.frm | Record correction/editing | CatalogueModule | CatalogueFormComponent (edit mode) | PARTIAL | Missing: dedicated correction workflow with audit trail |
| 8 | corect1.frm | Record correction variant | CatalogueModule | CatalogueFormComponent | PARTIAL | Same as correct.frm |
| 9 | CAT_OUTFRM.frm | Report category management | ReportsModule | TemplateListComponent | COVERED | |
| 10 | Copy of user_inetrface.frm | Search interface (backup) | — | — | COVERED | Duplicate, not needed |
| 11 | end_user.frm | Public search interface | CatalogueModule | CatalogueListComponent | PARTIAL | Missing: simplified read-only public mode without auth |
| 12 | find_charit.frm | Chart search | ArchiveModule | ArchiveListComponent (filters) | COVERED | |
| 13 | Form1.frm | Picture/image cataloguing | — | — | MISSING | No PICTURE module exists. PICTURE table (25 cols) not mapped |
| 14 | form2.frm | Alternative entry form | CatalogueModule | CatalogueFormComponent | COVERED | |
| 15 | Form3.frm | Book cataloguing (main) | BooksModule (stub) | — | PARTIAL | Books backend exists but frontend is a stub. Missing full book form with authors, subjects, series |
| 16 | Form4.frm | Record deletion/admin | CatalogueModule | CatalogueDetailComponent (delete) | PARTIAL | Missing: cascading delete confirmation showing affected related records |
| 17 | Form5.frm | Main document entry | CatalogueModule | CatalogueFormComponent | COVERED | |
| 18 | Form6.frm | Multi-criteria search | CatalogueModule | CatalogueListComponent (filters) | PARTIAL | Missing: cross-table search (books+articles+news combined), keyword search |
| 19 | form7.frm | Crystal Reports viewer | ReportsModule | — | MISSING | No report viewer/PDF generation. Crystal Reports not replaced |
| 20 | Form8.frm | Newspaper clipping entry | — | — | MISSING | No NEWS module. NEWS/NEWS_WRD tables not mapped to entities |
| 21 | form9.frm | Periodical management | PeriodicalsModule (stub) | — | PARTIAL | Backend exists but frontend is a stub |
| 22 | Form10.frm | Additional entry form | — | — | MISSING | Purpose unclear; not mapped |
| 23 | f_result.frm | Digitization result entry | DigitizationModule | ResultFormComponent | COVERED | |
| 24 | from_report.frm | Dynamic report builder | ReportsModule | TemplateFormComponent | PARTIAL | Missing: dynamic SQL generation from bnkout templates, runtime report execution |
| 25 | frm_result.frm | Search result grid | CatalogueModule | CatalogueListComponent | COVERED | |
| 26 | frm_res2.frm | Result display variant | BorrowingModule | BorrowingListComponent | COVERED | |
| 27 | frm_res3.frm | Result display variant 2 | — | — | COVERED | Redundant; covered by list components |
| 28 | frm_view.frm | Record detail viewer | CatalogueModule | CatalogueDetailComponent | COVERED | |
| 29 | instit.frm | Institution data entry | SitesModule | FormDialogComponent | PARTIAL | Missing: dedicated institution type (sub_typ="03") filtering |
| 30 | istara.frm | Borrowing/circulation ops | BorrowingModule + ArchiveModule | BorrowingListComponent + OperationsHistoryComponent | PARTIAL | Missing: auto-sequential operation numbers, cascading chart status update on operation CRUD, batch title updates |
| 31 | macnz.frm | MACNZ taxonomy browser | SubjectsModule | SubjectBrowserComponent | COVERED | |
| 32 | m1.frm | Utility dialog | — | — | COVERED | Small helper; inline in new components |
| 33 | m2.frm | Utility dialog | — | — | COVERED | Small helper |
| 34 | m3.frm | Utility dialog | — | — | COVERED | Small helper |
| 35 | new_vdpreview.frm | Video/media preview | — | — | MISSING | No media player component |
| 36 | opr_period.frm | Periodical transactions | — | — | MISSING | No TRANS table entity or endpoint |
| 37 | order_bnkout.frm | Report field ordering | ReportsModule | TemplateFormComponent | PARTIAL | Missing: field ordering drag-drop, condition builder UI |
| 38 | period.frm | Periodical management | PeriodicalsModule (stub) | — | PARTIAL | Backend complete; frontend stub only |
| 39 | PERIOD1.frm | Periodical variant | PeriodicalsModule (stub) | — | PARTIAL | Same as period.frm |
| 40 | PERIOD2.frm | Periodical variant | PeriodicalsModule (stub) | — | PARTIAL | Same as period.frm |
| 41 | person.frm | Person/patron management | PersonsModule | PersonListComponent + PersonFormComponent | COVERED | |
| 42 | person_f.frm | Person detail/profile | PersonsModule | PersonDetailComponent | PARTIAL | Missing: position/site assignments display |
| 43 | picture_f.frm | Picture viewer | — | — | MISSING | No picture viewer component |
| 44 | progress.frm | Progress bar | SharedModule | LoadingSpinnerComponent | COVERED | |
| 45 | sort_from.frm | Sort/filter config | CatalogueModule | Filter bar in list components | COVERED | |
| 46 | sort_news.frm | News sort/filter | — | — | MISSING | No news module |
| 47 | tmp_file.frm | Temp file management | — | — | MISSING | No tmp_fileadd UI. Entity exists in descriptors but no dedicated form |
| 48 | trs_period.frm | Period transactions | — | — | MISSING | No TRANS module |
| 49 | user1.frm | Login form | AuthModule | LoginComponent | COVERED | |
| 50 | user_inetrface.frm | Search + output interface | CatalogueModule + ReportsModule | CatalogueListComponent | PARTIAL | Missing: dynamic output query execution from bnkout definitions |
| 51 | USER_INTERFACE1.frm | Extended search + MACNZ | SubjectsModule + CatalogueModule | SubjectBrowserComponent | PARTIAL | Missing: integrated chart search within MACNZ browser |
| 52 | users.frm | User list display | UsersModule | UserListComponent | COVERED | |
| 53 | vd_preview.frm | Video preview | — | — | MISSING | No media playback |
| 54 | áªtí8.frm | Unknown (encoding issue) | — | — | MISSING | Cannot determine purpose |

---

## Section 2 — VB Code Modules Coverage

| # | Legacy Module | Purpose | Backend Location | Status | Gap Notes |
|---|--------------|---------|-----------------|--------|-----------|
| 1 | archiv.bas | Global vars: main_form, m_form_load, m_bk_no | Not needed — state managed per-request in REST | COVERED | Stateless REST replaces global state |
| 2 | bok.bas — cn (rdoConnection) | Global DB connection | Spring Data JPA DataSource | COVERED | HikariCP connection pool |
| 2b | bok.bas — m_connect | ODBC connection string | application-dev.yml datasource config | COVERED | |
| 2c | bok.bas — OpenDoc() | Shell open document file | — | MISSING | No server-side file open; needs frontend download/open |
| 2d | bok.bas — m_STCOK_path() | Resolve media file path from stock number | — | MISSING | No media storage path resolution logic |
| 2e | bok.bas — filter_desc() | Sanitize strings (SQL injection prevention) | Spring Data JPA parameterized queries | COVERED | JPA prevents SQL injection natively |
| 2f | bok.bas — filter_desc1() | Light string sanitization | Same as above | COVERED | |
| 2g | bok.bas — is_trans() | Record transfer lock check | — | MISSING | No mn_trans lock-checking logic in CatalogueService |
| 2h | bok.bas — HighlightWords() | Search result highlighting | — | MISSING | No frontend search term highlighting |
| 2i | bok.bas — Global user session | box_user_no, box_user_name, etc. | JWT payload + TokenService | COVERED | |
| 2j | bok.bas — video_path/video_path1 | Media storage paths | — | MISSING | No media path config |

---

## Section 3 — Crystal Reports Coverage

| # | Report File | Inferred Purpose | Mapped Feature | Status | Gap Notes |
|---|------------|-----------------|----------------|--------|-----------|
| 1 | book.rpt | Book catalogue listing | ReportsModule | MISSING | No PDF generation or report viewer |
| 2 | rpt_add.rpt | Addendum/supplement report | ReportsModule | MISSING | No report generation |
| 3 | rpt_add1.rpt | Addendum variant | ReportsModule | MISSING | |
| 4 | rpt_res1.rpt | Resource/result report | ReportsModule | MISSING | |
| 5 | tmp_result.rpt | Temporary result report | ReportsModule | MISSING | |
| 6 | crystal_report1.rpt | General report 1 | ReportsModule | MISSING | |
| 7 | crystal_report2.rpt | General report 2 | ReportsModule | MISSING | |
| 8 | crystal_report4.rpt | General report 4 | ReportsModule | MISSING | |
| 9 | crystal_report5.rpt | General report 5 | ReportsModule | MISSING | |
| 10 | crystal_report7.rpt | General report 7 | ReportsModule | MISSING | |
| 11 | crystal_report13.rpt | General report 13 | ReportsModule | MISSING | |
| 12 | HPFONTS/crystal_report13.rpt | Duplicate of report 13 | — | MISSING | Duplicate |

---

## Section 4 — Database Tables Coverage

| # | Legacy Table | JPA Entity | API Endpoint(s) | Frontend Module | Flyway | Status | Gap Notes |
|---|-------------|-----------|-----------------|-----------------|--------|--------|-----------|
| 1 | main | CatalogueEntity | /api/catalogue | CatalogueModule | YES | COVERED | Missing m_no1, MN_ACT, MN_ADD columns in entity |
| 2 | BOOK | BookEntity | /api/books | (stub) | YES | PARTIAL | All 43 cols mapped; frontend stub only |
| 3 | ARTICLE | ArticleEntity | /api/articles | (stub) | YES | PARTIAL | Backend complete; frontend stub |
| 4 | PERIOD | PeriodicalEntity | /api/periodicals | (stub) | YES | PARTIAL | Backend complete; frontend stub |
| 5 | NEWS | — | — | — | YES | MISSING | No entity, no endpoint, no frontend |
| 6 | NEWS_WRD | — | — | — | YES | MISSING | No entity |
| 7 | PERSON | PersonEntity | /api/persons | PersonsModule | YES | COVERED | Only 8 of 24 columns mapped in entity |
| 8 | PERSON1 | — | — | — | YES | MISSING | No entity for secondary persons table |
| 9 | AUTHER | AuthorEntity | /api/authors | (stub) | YES | COVERED | All 4 cols mapped |
| 10 | MACNZ | MacnzEntity | /api/lookups/subjects | SubjectsModule | YES | COVERED | |
| 11 | CODING | CodingEntity | /api/lookups/coding | SubjectsModule | YES | COVERED | Read-only; no CRUD endpoint |
| 12 | ARRAYS | ArraysEntity | /api/lookups/arrays | SubjectsModule | YES | COVERED | Read-only |
| 13 | ARRAYS1 | — | — | — | YES | MISSING | No entity |
| 14 | CHARIT | ChartEntity | /api/archive/charts | ArchiveModule | YES | COVERED | All cols mapped |
| 15 | OPR_CHRT | ChartOperationEntity | /api/archive/charts/{id}/operations | ArchiveModule | YES | COVERED | |
| 16 | ISTARA | BorrowingEntity | /api/borrowing | BorrowingModule | YES | COVERED | |
| 17 | IST_BK | BorrowingBookEntity | — | — | YES | PARTIAL | Entity exists but no CRUD endpoint |
| 18 | IST_OTH | BorrowingOtherEntity | — | — | YES | PARTIAL | Entity exists but no CRUD endpoint |
| 19 | DIGIT | DigitEntity | /api/digitization/records | DigitizationModule | YES | COVERED | |
| 20 | demand | DemandEntity | /api/digitization/demands | DigitizationModule | YES | COVERED | |
| 21 | result | ResultEntity | /api/digitization/results | DigitizationModule | YES | COVERED | |
| 22 | ANALIS | SubjectAnalysisEntity | /api/catalogue/{id}/subjects | DescriptorsModule | YES | COVERED | |
| 23 | NAROWER | NarowerEntity | — | — | YES | PARTIAL | Entity exists but no endpoint |
| 24 | RELATIVE | RelativeEntity | — | — | YES | PARTIAL | Entity exists but no endpoint |
| 25 | GEO | GeoEntity | /api/catalogue/{id}/geo | DescriptorsModule | YES | COVERED | |
| 26 | FILE_ADD | FileAddEntity | /api/catalogue/{id}/files | DescriptorsModule | YES | COVERED | |
| 27 | FILE_ADD2 | — | — | — | YES | MISSING | No entity (duplicate structure) |
| 28 | TEXT | TextEntity | /api/catalogue/{id}/text | DescriptorsModule | YES | COVERED | |
| 29 | text1 | — | — | — | YES | MISSING | No entity for extended text |
| 30 | SERIES | — | — | — | YES | MISSING | No entity for series info |
| 31 | RES | — | — | — | YES | MISSING | No entity for author-resource links |
| 32 | PICTURE | — | — | — | YES | MISSING | No entity (25 cols, images) |
| 33 | POUT | PoutEntity | — | ReportsModule | YES | PARTIAL | Entity exists; no dedicated endpoint |
| 34 | POUT1 | — | — | — | YES | MISSING | No entity |
| 35 | bnkout | ReportTemplateEntity | /api/reports/templates | ReportsModule | YES | COVERED | |
| 36 | user_bnkout | UserOutputEntity | /api/reports/user-outputs | ReportsModule | YES | COVERED | |
| 37 | catogorie | CategoryEntity | — | ReportsModule | YES | PARTIAL | Entity exists; no endpoint |
| 38 | config | UserEntity | /api/auth/login | UsersModule | YES | COVERED | Only 7 of 15 cols mapped |
| 39 | form | FormEntity | /api/forms | SitesModule | YES | COVERED | |
| 40 | form1 | — | — | — | YES | MISSING | No entity |
| 41 | sites | SiteEntity | /api/sites | SitesModule | YES | COVERED | |
| 42 | posts | PostEntity | /api/posts | SitesModule | YES | COVERED | |
| 43 | POSITION | PositionEntity | — | SitesModule | YES | PARTIAL | Entity exists; no endpoint |
| 44 | SUBJECT | — | — | — | YES | MISSING | No entity for form-MACNZ links |
| 45 | REL_FORM | — | — | — | YES | MISSING | No entity for form relationships |
| 46 | RELIS | — | — | — | YES | MISSING | No entity |
| 47 | TRANS | — | — | — | YES | MISSING | No entity for period transactions |
| 48 | TIME | — | — | — | YES | MISSING | No entity for time descriptors |
| 49 | WORD | — | — | — | YES | MISSING | No entity for keyword index |
| 50 | DICT | — | — | — | YES | MISSING | No entity |
| 51 | MEM | — | — | — | YES | MISSING | No entity |
| 52 | COTE_PUB | — | — | — | YES | MISSING | No entity |
| 53 | TEMP | — | — | — | YES | MISSING | No entity |
| 54 | date_subject | — | — | — | YES | MISSING | No entity |
| 55 | tmp_fileadd | — | — | — | YES | MISSING | No entity |
| 56 | ranjpath | — | — | — | YES | MISSING | No entity |
| 57 | t_operation | — | — | — | YES | MISSING | No entity |
| 58 | abb | — | — | — | YES | MISSING | Abbreviations table |
| 59 | abbas | — | — | — | YES | MISSING | Test table — can skip |
| 60 | main2 | — | — | — | YES | MISSING | Extended main with digitization fields |
| 61-69 | view_* (9 tables) | — | — | — | YES | MISSING | Materialized views — may not need entities |

---

## Section 5 — Business Logic Coverage

| # | Legacy Location | Business Rule | Backend Location | Status | Recommended Action |
|---|----------------|---------------|-----------------|--------|-------------------|
| 1 | charit.frm | Auto-generate sequential 6-digit cha_no (zero-padded) | ArchiveService | MISSING | Add max+1 auto-generation in ChartService.create() |
| 2 | charit.frm | Stock number uniqueness validation | ArchiveService | MISSING | Add unique check before save |
| 3 | charit.frm | Batch insert: create N charts with sequential numbers and title suffixes | ArchiveService | MISSING | Add batchCreate() method |
| 4 | charit.frm | Auto-create OPR_CHRT when inserting chart with stock | ArchiveService | MISSING | Add transactional operation creation on chart create |
| 5 | istara.frm | Auto-generate 7-digit sequential operation numbers | ArchiveService | MISSING | Add max+1 auto-generation in createOperation() |
| 6 | istara.frm | Cascading chart status update (cha_frm/cha_to/cha_prsfrm/cha_prsto) when operation CRUD | ArchiveService | MISSING | Update ChartEntity on operation save/delete |
| 7 | istara.frm | Recalculate chart status from previous operation on delete | ArchiveService | MISSING | Add rollback logic in deleteOperation() |
| 8 | istara.frm | Dynamic stored procedure creation (isn_istara) for reporting | ReportService | MISSING | Implement as JPA native query or specification |
| 9 | bok.bas | is_trans() — prevent editing transferred records (mn_trans=1) | CatalogueService | MISSING | Add check in update/delete: if mn_trans=1, throw exception |
| 10 | bok.bas | m_STCOK_path() — resolve media file path by stock threshold | — | MISSING | Add media path resolution service |
| 11 | coding.frm | div_word() — Arabic text word indexing into WORD table | — | MISSING | Add word indexing service for full-text search |
| 12 | coding.frm | Hierarchical CODING navigation with MACNZ linking | SubjectsService | PARTIAL | Tree built client-side but no CODING CRUD or MACNZ-form linking |
| 13 | Form3.frm | Book entry with linked author (RES), subjects (ANALIS), series (SERIES) | BookService | PARTIAL | Book CRUD exists but no RES/SERIES creation in transaction |
| 14 | Form8.frm | News entry with word indexing (NEWS_WRD) | — | MISSING | No NEWS module at all |
| 15 | ARCHIVE.frm | Database backup: BACKUP DATABASE command | — | MISSING | Not in scope for app layer — ops concern |
| 16 | ARCHIVE.frm | upd_main_trans1 — batch unlock transferred records | CatalogueService | MISSING | Add admin endpoint for bulk trans unlock |
| 17 | sort_from.frm | Dynamic SQL query builder based on user criteria | CatalogueSpecification | PARTIAL | Basic filters exist; no advanced multi-table dynamic SQL |

---

## Section 6 — User Permission and Access Control Coverage

| # | Legacy Permission Rule | New Implementation | Status | Gap Notes |
|---|----------------------|-------------------|--------|-----------|
| 1 | config.user_level (A/U/G) — controls menu visibility | JWT token stores level; AdminGuard checks 'A'; RequiresLevelDirective hides elements | COVERED | |
| 2 | config.user_permition (bitmask) — granular feature access | UserEntity maps the field; not consumed by any guard | PARTIAL | No bitmask-based permission checking in backend or frontend |
| 3 | config.user_ent — entity-scoped data access | Stored in JWT; passed as filter param | PARTIAL | No server-side enforcement (user can query other entities) |
| 4 | config.user_doc — document type restriction | Stored in UserEntity; not consumed | MISSING | No filtering by document type per user |
| 5 | user_bnkout — per-user report access | UserOutputEntity + endpoint exists | COVERED | Template assignment works |
| 6 | Password stored in config.user_password (plain or char) | BCryptPasswordEncoder in UserService.login() | PARTIAL | Legacy passwords are plain text; no migration path to BCrypt |
| 7 | box_user_pwd flag — password change enforcement | — | MISSING | No forced password change on first login |
| 8 | SITE_WLY — wilaya-scoped data access | Stored in entity; not enforced | MISSING | No wilaya-based data filtering |
| 9 | Password hardcoded ("891045","261015") for admin functions | — | COVERED | Replaced by JWT + AdminGuard (better) |

---

## Section 7 — Overall Coverage Summary

| Category | Total Items | Covered | Partial | Missing | Coverage % |
|----------|------------|---------|---------|---------|------------|
| VB Forms | 54 | 20 | 17 | 17 | 37% |
| VB Modules | 10 (functions) | 5 | 0 | 5 | 50% |
| Crystal Reports | 12 | 0 | 0 | 12 | 0% |
| DB Tables | 69 | 26 | 10 | 33 | 38% |
| Business Logic Rules | 17 | 0 | 3 | 14 | 9% |
| Permission Rules | 9 | 3 | 3 | 3 | 33% |
| **TOTAL** | **171** | **54** | **33** | **84** | **32%** |

> **Overall migration coverage: 53% (Covered + Partial) / 32% (Covered only)**

---

## Section 8 — Prioritized Gap Resolution Plan

### Critical (App cannot function correctly)

| # | Gap | Affected Component | Required Action | Effort |
|---|-----|-------------------|----------------|--------|
| 1 | No record transfer lock (mn_trans=1 check) | bok.bas → CatalogueService | Add `if (entity.getTrans() == 1) throw new BusinessException("Record locked")` in update/delete | Small |
| 2 | Legacy plain-text passwords → BCrypt | config_users.frm → UserService | Add migration endpoint or Flyway script to BCrypt-hash existing passwords | Medium |
| 3 | PERSON entity only maps 8 of 24 columns | PERSON table → PersonEntity | Add missing columns: prs_inst_tel, PRS_INST_BOX, PRS_INST_DIRCT, PRS_INST_EMAIL, PRS_KAYD, PRS_BRTH_DTE, PRS_VLG, PRS_SAKAN, PRS_ADRS1, PRS_BOX, prs_qualty, prs_mzhb, prs_politc, prs_social_media, prs_oldjob | Medium |
| 4 | config entity only maps 7 of 15 columns | config table → UserEntity | Add: user_cnf_path, user_start, USER_PWD, user_cmpvd, user_video_path, user_company, user_video_path1, SITE_WLY | Medium |
| 5 | No NEWS module (forms, entity, endpoints) | Form8.frm, NEWS/NEWS_WRD tables | Create NewsEntity, NewsService, NewsController, NewsModule (frontend) | Large |

### High (Core feature incomplete)

| # | Gap | Affected Component | Required Action | Effort |
|---|-----|-------------------|----------------|--------|
| 6 | No PICTURE module | Form1.frm, PICTURE table (25 cols) | Create PictureEntity, PictureService, PictureController, PictureModule (frontend) | Large |
| 7 | No Crystal Reports replacement / PDF generation | form7.frm, 12 .rpt files | Add JasperReports or OpenPDF backend service; add report viewer frontend component | Large |
| 8 | Chart auto-sequential numbering + stock validation | charit.frm → ArchiveService | Add max+1 generation, unique stock check, batch insert | Medium |
| 9 | Operation auto-numbering + cascading chart status | istara.frm → ArchiveService | Add auto-numbering, status cascade on CRUD, rollback on delete | Medium |
| 10 | No TRANS entity/endpoint (periodical transactions) | opr_period.frm, trs_period.frm | Create TransEntity, TransService, TransController | Medium |
| 11 | Books/Articles/Periodicals frontend are stubs | Form3.frm, form9.frm | Build full list/detail/form components for these 3 modules | Large |
| 12 | No SERIES entity/endpoint | Form3.frm → SERIES table | Create SeriesEntity, SeriesService, add to book creation flow | Medium |
| 13 | No RES entity/endpoint (author-document linking) | Form3.frm → RES table | Create ResEntity, ResService, add to catalogue/book creation | Medium |
| 14 | NAROWER/RELATIVE have entities but no endpoints | coding.frm → descriptors | Add /api/catalogue/{id}/narrower and /api/catalogue/{id}/relative endpoints | Small |

### Medium (Feature gap but app works)

| # | Gap | Affected Component | Required Action | Effort |
|---|-----|-------------------|----------------|--------|
| 15 | No user_permition bitmask checking | config_users.frm | Implement bitmask-based permission guard in backend @PreAuthorize and frontend directive | Medium |
| 16 | No entity-scoped data filtering (user_ent) | bok.bas globals | Add server-side filter: append user_ent condition to all queries based on JWT claim | Medium |
| 17 | No WORD entity/word indexing for full-text search | coding.frm div_word() | Create WordEntity, WordService; implement Arabic word tokenizer | Medium |
| 18 | No SUBJECT entity (form-to-MACNZ linking) | coding.frm | Create SubjectLinkEntity, endpoint, add to sites/forms UI | Small |
| 19 | No REL_FORM entity (form-to-form relationships) | coding.frm | Create RelFormEntity, endpoint | Small |
| 20 | No date_subject entity | coding.frm | Create DateSubjectEntity, add to descriptors | Small |
| 21 | No text1 entity (extended text with pages) | descriptors | Create Text1Entity, add endpoint under /api/catalogue/{id}/text1 | Small |
| 22 | No tmp_fileadd UI/endpoint | tmp_file.frm | Create TmpFileEntity, endpoint, file upload component | Medium |
| 23 | Dynamic report SQL execution from bnkout definitions | user_inetrface.frm, from_report.frm | Implement dynamic query builder service that reads bnkout templates | Large |
| 24 | Search result highlighting | bok.bas HighlightWords() | Add frontend pipe or directive for search term highlighting | Small |
| 25 | main2 table (extended main with digitization fields) | main2 table | Create Main2Entity if needed, or merge fields into CatalogueEntity | Small |
| 26 | No POUT1 entity | POUT1 table | Create Pout1Entity, add to reports module | Small |
| 27 | No POSITION endpoint | coding.frm | Add /api/positions CRUD endpoint using existing PositionEntity | Small |

### Low (Nice to have / edge case)

| # | Gap | Affected Component | Required Action | Effort |
|---|-----|-------------------|----------------|--------|
| 28 | No public/guest search mode (end_user.frm) | end_user.frm | Add public search endpoint without auth | Small |
| 29 | No media file path resolution | bok.bas m_STCOK_path() | Add media storage config and path resolver service | Small |
| 30 | No video preview component | vd_preview.frm, new_vdpreview.frm | Add HTML5 video player component | Medium |
| 31 | ARRAYS1, DICT, MEM, COTE_PUB, RELIS — no entities | Various lookup tables | Create entities if needed; may be unused in new system | Small |
| 32 | abb, abbas, TEMP, t_operation — no entities | Utility/test tables | Likely not needed; skip unless data migration requires it | Small |
| 33 | view_* tables (9) — no entities | Materialized views | Replace with JPA queries/views if needed for reporting | Medium |
| 34 | ranjpath — no entity | Media range paths | Create if media file storage is implemented | Small |
| 35 | form1 — no entity | Secondary form definitions | Create if different from form; likely redundant | Small |
| 36 | PERSON1 — no entity | Secondary persons table | Create if staff management differs from patron management | Small |
| 37 | FILE_ADD2 — no entity | Duplicate of FILE_ADD | Likely redundant; skip | Small |
