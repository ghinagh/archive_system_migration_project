# Migration Coverage Audit Report — v4
**Project:** Form Documenting Platform — VB6 + SQL Server → Java + Angular + PostgreSQL  
**v1:** 2026-07-01 · **v2:** 2026-07-02 · **v3:** 2026-07-03 · **v4 (this report):** 2026-07-03

> **Coverage definitions**  
> — **Covered:** backend entity + endpoint + wired frontend component all present and functional.  
> — **Partial:** one or two tiers present; feature is incomplete for end users.  
> — **Missing:** no implementation found (or intentionally excluded from scope).  
> — Crystal Reports target: Covered + Partial both count; JasperReports PDF generation and frontend PDF viewer operational end-to-end.

---

## Section 1 — Purpose of This Revision

This report re-audits every item listed in v3 Section 10 (the 4 PARTIAL VB Forms, 2 PARTIAL Business Logic Rules, and 1 PARTIAL Permission Rule), verifies their current implementation state from actual source files, and adds one new finding: a reclassification of `áªtí8.frm` from *Missing* to *Excluded (dead code)* based on direct file inspection.

---

## Section 2 — Work Implemented Since v3

All seven PARTIAL items from v3 Section 10 were implemented in the session immediately following v3:

| ID | Item | v3 Status | Work Done |
|----|------|-----------|-----------|
| C1 | Form6.frm — Unified Search page | PARTIAL | `UnifiedSearchComponent` created at `catalogue/unified-search/`. `FormControl` + `debounceTime(300)` + `distinctUntilChanged()`. `searchResults` signal. `filteredResults` computed signal via `activeFilters` Set. `mat-chip-listbox` filter chips with per-type counts. Per-type routing: BOOK→`/books/{appNo}`, ARTICLE→`/articles/{appNo}`, NEWS→`/news/{appNo}`, PERIODICAL→`/periodicals/{appNo}`, CATALOGUE→`/catalogue/{appNo}`. `SearchService.searchUnified()` hitting `GET /api/search/unified?q=`. Route `{ path: 'search', … }` added to `CatalogueModule`. `manage_search` icon button added to `MainLayoutComponent` toolbar pointing to `/catalogue/search`. `UnifiedSearchResult` interface (`appNo, title, type, date, matchedWord`) added to `core/models/search.models.ts`. |
| C2a | from_report.frm — Drag-drop field ordering | PARTIAL | `TemplateFormComponent` extended with `fieldChips` signal (parsed from comma-separated `field` form value), `cdkDropList` / `cdkDrag` chip list, `onFieldDrop()` calling `moveItemInArray`, `removeFieldChip()`, `addFieldChip()`. `DragDropModule` added to `ReportsModule`. `field` form control serialized back on every mutation. |
| C2b | order_bnkout.frm — Visual condition builder | PARTIAL | `ConditionRow` interface (`field, operator, value, junction: AND\|OR`). `conditionRows` signal with default empty row. `addConditionRow()`, `removeConditionRow()`, `updateConditionRow()`. `serializeConditions()` writes `FIELD OP 'value' AND/OR …` into `condition` form control before submit. `parseConditionRows()` deserializes existing condition string on edit-mode load via regex. `mat-button-toggle-group` AND/OR toggle per row. `MatButtonToggleModule` added to `ReportsModule`. |
| C3 | person_f.frm — POSITION records in person view | PARTIAL | Backend: `PositionRepository` injected into `PersonService`; `getAssignments()` looks up `positionRepository.findById(post.getLevelNo().trim())` and maps `PosNo`/`Name` to `PostAssignmentResponse`. Record updated to 9 fields (`positionNo`, `positionName` added). Frontend: `PersonAssignment` interface extended. `assignmentColumns` extended to 9 columns. Two new `<ng-container matColumnDef>` blocks in template: `positionNo` shows value or dash; `positionName` is a `routerLink` to `/sites?positionNo=…`. |
| BL4 | Rule 4: Auto-create OPR_CHRT on chart create | PARTIAL | `ArchiveService.createChart()` (verified current source): when `request.getStock() != null`, creates `ChartOperationEntity`, sets `date`, `fromSite`, `toSite`, `fromPerson`, `toPerson`, `title`, `transferred=false`, and saves via `operationRepository.save(bootstrap)` in the same `@Transactional` method. |
| BL13 | Rule 13: BookService single-transaction save | PARTIAL | `BookService.create()` annotated `@Transactional`. Exact save sequence: (1) `catalogueService.createMainRecord()` → `catalogueRepository.save()`; (2) `bookRepository.save(book)`; (3) loop `resRepository.save(res)` per author; (4) loop `subjectAnalysisRepository.save(analysis)` per subject; (5) conditional `seriesRepository.save(series)`. Integration test (`BookServiceIntegrationTest`) asserts full rollback when `SubjectAnalysisRepository.save()` throws. |
| PR8 | Rule 8: Wilaya enforcement for catalogue | PARTIAL | `CatalogueSpecification.hasWilaya(Integer wilayaNo)`: LEFT JOIN `CatalogueEntity → SiteEntity` on `"site"` association; `cb.equal(siteJoin.get("wilyaNo"), wilayaNo)`; returns `null` when `wilayaNo` is null (admins bypass). `CatalogueEntity.site`: `@ManyToOne(fetch=LAZY) @JoinColumn(name="MN_DATA_EN", referencedColumnName="sit_no", insertable=false, updatable=false)`. `CatalogueService.findAll()`: `Integer userWilaya = isAdmin ? null : SecurityUtils.getCurrentUserWilaya()` then `.and(CatalogueSpecification.hasWilaya(userWilaya))`. Integration test (`CatalogueWilayaIntegrationTest`) captures SQL via Hibernate `StatementInspector` and asserts JOIN to `sites` + `sit_wly_no` predicate for non-admin users. |

---

## Section 3 — New Finding: `áªtí8.frm` Reclassified as Excluded

Direct file inspection of `áªtí8.frm` reveals:

- **VB_Name:** `Form7`  
- **Total file length:** 18 lines  
- **Controls defined:** zero  
- **Event handlers:** zero  
- **SQL / recordset references:** zero  
- **`Form7.Show` calls elsewhere in codebase:** zero  

The file contains only the `Begin VB.Form Form7 … End` block and the five standard `Attribute VB_*` header lines. It is a blank skeleton never wired into any navigation or startup path — identical in status to `Form10.frm`, which was excluded in v3.

**Disposition:** Excluded from scope as dead code. Denominator decreases from 54 → **53** in-scope VB Forms.

---

## Section 4 — Re-audit of v3 Section 10 Items

### 4-A  VB Forms (4 PARTIAL → COVERED)

| Form | v3 Status | v4 Status | Evidence |
|------|-----------|-----------|----------|
| Form6.frm | PARTIAL | **COVERED** | `UnifiedSearchComponent` declared in `CatalogueModule`; route `{ path: 'search', component: UnifiedSearchComponent }` at line 13; `SearchService.searchUnified()` at `GET /api/search/unified`; `debounceTime(300)` + `distinctUntilChanged()` in constructor pipe; `searchResults` Signal; `filteredResults` computed; `countForType()` for chip counts; `navigate()` with per-type routes; toolbar icon in `MainLayoutComponent`. |
| from_report.frm | PARTIAL | **COVERED** | `template-form.component.ts`: `fieldChips = signal<string[]>([])` (line 34); `CdkDragDrop` import (line 6); `onFieldDrop()` with `moveItemInArray` (lines 75–80); `addFieldChip()` / `removeFieldChip()`; `cdkDropList` / `cdkDrag` in template; `DragDropModule` in `ReportsModule`. |
| order_bnkout.frm | PARTIAL | **COVERED** | `template-form.component.ts`: `ConditionRow` interface; `conditionRows = signal<ConditionRow[]>(…)` (line 35); `addConditionRow()` / `removeConditionRow()` / `updateConditionRow()` / `serializeConditions()` / `parseConditionRows()`; `mat-button-toggle-group` with `$any($event).value` junction toggle; `MatButtonToggleModule` in `ReportsModule`. |
| person_f.frm | PARTIAL | **COVERED** | Backend: `PostAssignmentResponse` record has 9 components including `String positionNo` and `String positionName`; `PersonService.getAssignments()` calls `positionRepository.findById(post.getLevelNo().trim())` and maps both fields; `PositionRepository` injected via constructor. Frontend: `PersonAssignment` has `positionNo: string \| null` and `positionName: string \| null`; `assignmentColumns` includes `'positionNo'` and `'positionName'`; HTML has two `ng-container matColumnDef` blocks; `positionName` renders as `routerLink` to `/sites?positionNo=…`. |

### 4-B  Business Logic Rules (2 PARTIAL → COVERED)

| Rule | v3 Status | v4 Status | Evidence |
|------|-----------|-----------|----------|
| Rule 4: Auto-create OPR_CHRT | PARTIAL | **COVERED** | `ArchiveService.createChart()` is `@Transactional`. When `request.getStock() != null`: constructs `ChartOperationEntity`, sets `serial` via `operationRepository.findMaxSerialByChaNo(saved.getChaNo()) + 1`, sets `date = LocalDateTime.now()`, `fromSite`, `toSite`, `fromPerson`, `toPerson`, `title`, `transferred = false`; saves via `operationRepository.save(bootstrap)`. Then `applyCascadeToChart(saved, savedOp)` propagates cascade fields back to chart. All within the same transaction. |
| Rule 13: Book single transaction | PARTIAL | **COVERED** | `BookService.create()` annotated `@Transactional`. Save sequence verified: `catalogueService.createMainRecord()` → `bookRepository.save()` → `resRepository.save()` (per author loop) → `subjectAnalysisRepository.save()` (per subject loop) → `seriesRepository.save()` (if non-null). `BookServiceIntegrationTest` (`@MockitoBean SubjectAnalysisRepository` throws `RuntimeException`) asserts `bookRepository.count() == 0` and `resRepository.count() == 0` after rollback. |

### 4-C  Permission Rules (1 PARTIAL → COVERED)

| Rule | v3 Status | v4 Status | Evidence |
|------|-----------|-----------|----------|
| Rule 8: SITE_WLY wilaya for catalogue | PARTIAL | **COVERED** | `CatalogueSpecification.hasWilaya()` (lines 47–53): LEFT JOIN `"site"` (→ `SiteEntity`), `cb.equal(siteJoin.get("wilyaNo"), wilayaNo)`, returns `null` for admins. Called in `CatalogueService.findAll()` (line 61): `Integer userWilaya = isAdmin ? null : SecurityUtils.getCurrentUserWilaya()` then `.and(CatalogueSpecification.hasWilaya(userWilaya))`. `CatalogueEntity.site` ManyToOne: `@JoinColumn(name="MN_DATA_EN", referencedColumnName="sit_no", insertable=false, updatable=false)`. `CatalogueWilayaIntegrationTest` uses Hibernate `StatementInspector` to assert SQL contains JOIN + `sit_wly_no` predicate for `siteWly=3` user, and no `sit_wly_no` for admin user. |

---

## Section 5 — The 4 Remaining Missing VB Forms

All four are directly investigated from the VB6 source. They form a cohesive module around the `result` table (digitization results management), which is the only significant domain area not yet surfaced in the Angular frontend.

| File | VB_Name | Caption | Core Domain | What It Does | Gap |
|------|---------|---------|-------------|-------------|-----|
| `frm_result.frm` | `frm_result` | (none) | `result` + `main` + `view_user_bnkout`/`pout` | **Main result browsing & editing module.** 1,900+ lines. Routes by `main_form` variable to one of 7 institution-scoped stored procs (`tmp_result` through `tmp_result7`). Per-user configurable column headers/widths from `view_user_bnkout`/`view_user_pout`. Inline DataGrid CRUD via `insr_result`, `upd_result`, `del_result`. Full-text search via `serh_text`/`serh_text5`. Double-click opens `vd_preview`/`new_vdpreview` for document preview. | No Angular result-browsing screen; no institution-scoped routing; no per-user column config from `bnkout`/`pout`. |
| `f_result.frm` | `f_result` | "أعداد نتيجة الطلب" | `result` + `main` + `CODING` (codes 24/32/33) | **Advanced search / filter for result records.** Builds and executes a dynamic `tmp_dmd_result` stored proc from user-selected criteria: date range, document number (LIKE), result type, person, permit code (bound to `view_coding33`), notation code (`view_coding32`), subject code (`view_coding24`). Joins `result → main → CODING ×3`. `res_no_ist = MN_APP_NO` is the direct ISTARA linkage. Delete via `del_result`; update via `upd_result1`. | No Angular multi-criteria search/filter screen for result records. |
| `frm_res2.frm` | `frm_res2` | "Form1" | `bnkout`/`pout` + `result` via Crystal Reports | **Report printing launcher.** Selects one of 5 Crystal Report templates (`tmp_result.rpt`, `rpt_res1.rpt`, `book.rpt`, `rpt_add1.rpt`) by institution. Reads `pout` table (filtered by `out_ist = var_ist`) for column config. Executes `tmp_result` or `tmp_result3` to pre-populate a DBGrid. Has file-browser for saving to disk. | Frontend report printing for result-module templates not wired; ReportViewerComponent covers PDF streaming but not institution-scoped result template selection. |
| `frm_res3.frm` | `Form8`¹ | "Form8" | `VIEW_RL` → `tmp_result1` + Crystal Reports | **Minimal result viewer.** 4-line `Form_Load`: `execute tmp_result1` bound to a DBGrid; Crystal Report printing to printer via `tmp_result.rpt`. Simplest of the four. | No dedicated Angular result viewer for institution-"02"-scoped results. |

¹ `frm_res3.frm` and the unrelated `Form8.frm` (AUTHER CRUD form, already covered) share the internal `VB_Name = "Form8"` — a developer error in the VB6 project. Both are counted separately in the 53-form denominator; the AUTHER CRUD functionality is already covered by the `AuthorEntity` / `ResController` module.

---

## Section 6 — Final Coverage Summary (v4)

> Denominator changes from v3:  
> VB Forms: 54 → **53** (áªtí8.frm excluded as dead code).  
> All other denominators unchanged from v3.  
> Rule 15 (database backup) remains out of application scope.

| Category | In-scope | Covered | Partial | Missing | Coverage % | C+P % | Go-live Target | Met? |
|----------|:--------:|:-------:|:-------:|:-------:|----------:|------:|---------------|------|
| VB Forms | **53** (−1) | **49** (+4) | **0** (−4) | **4** (−1 excl.) | **92.5 %** | 92.5 % | ≥ 95 % | **✗** |
| VB Modules | 10 | 10 | 0 | 0 | **100 %** | 100 % | — | ✓ |
| Crystal Reports | 12 | 12 | 0 | 0 | **100 %** | 100 % | 100 % (C+P) | **✓** |
| DB Tables | 67 | 67 | 0 | 0 | **100 %** | 100 % | 100 % | **✓** |
| Business Logic | 16¹ | **16** (+2) | **0** (−2) | 0 | **100 %** | 100 % | ≥ 95 % (C+P ≥ 16) | **✓** |
| Permission Rules | 9 | **9** (+1) | **0** (−1) | 0 | **100 %** | 100 % | 100 % (C+P) | **✓** |
| **TOTAL** | **167** | **163** | **0** | **4** | **97.6 %** | 97.6 % | — | — |

¹ Rule 15 (database backup) excluded from denominator — OS/infrastructure concern outside application scope.

---

## Section 7 — Go-Live Gate Detail

| Gate | Threshold | v3 State | v4 State | Status |
|------|-----------|----------|----------|--------|
| VB Forms ≥ 95 % | ≥ 51 / 53 Covered | 45 / 53 (84.9 %) | **49 / 53 (92.5 %)** | **NOT MET** — need 2 more forms Covered |
| DB Tables = 100 % | 67 / 67 Covered | 67 / 67 (100 %) | 67 / 67 (100 %) | **MET ✓** |
| Business Logic ≥ 95 % | C+P ≥ 16 of 16 | C+P = 14 / 16 (87.5 %) | **C+P = 16 / 16 (100 %)** | **MET ✓** (gate closed this session) |
| Permission Rules = 100 % | 9 / 9 C+P | C+P = 9 / 9 (100 %) | **Covered = 9 / 9 (100 %)** | **MET ✓** (now fully Covered, not just C+P) |
| Crystal Reports = 100 % | 12 / 12 C+P | 12 / 12 (100 %) | 12 / 12 (100 %) | **MET ✓** |

> **Overall: 4 of 5 go-live gates cleared.** VB Forms (92.5 %) is the sole remaining blocker.

---

## Section 8 — Remaining Gap: VB Forms Gate

**Current:** 49 / 53 Covered = 92.5 %  
**Required:** ≥ 51 / 53 Covered = ≥ 96.2 %  
**Gap:** 2 more forms must reach Covered status.

All 4 remaining Missing forms belong to the same domain — **digitization result records** (`result` table, `res_*` columns). Implementing any **2 of the 4** closes the gate; implementing all 4 reaches 100 %.

### Minimum viable sprint (closes gate at 51/53 = 96.2 %):

| Priority | Form | Backend effort | Frontend effort | Why this order |
|----------|------|---------------|-----------------|----------------|
| 1 | **frm_result.frm** | Endpoint `GET /api/results` (paginated, institution-scoped via `user_inst_no` JWT claim) + `GET/PUT/DELETE /api/results/{id}` already partially served by existing `result` entity/repo | `ResultListComponent` with per-institution routing + inline edit/delete; `ResultDetailComponent` with document-preview link to `DigitizationViewerComponent` | Core CRUD for the result module; required by both other forms as a dependency |
| 2 | **f_result.frm** | `ResultSpecification` with date-range, type, permit, notation, person, subject predicates using `JpaSpecificationExecutor`; filter parameters exposed via `GET /api/results` query params | `ResultSearchComponent` — multi-field filter form (date range, code dropdowns from `view_coding33`/`32`/`24`, free-text fields); integrates with `ResultListComponent` | Closes the gate; covers the advanced search path which is the most data-critical part of the module |

### If all 4 are implemented (53/53 = 100 %):

| Priority | Form | Summary |
|----------|------|---------|
| 3 | **frm_res2.frm** | Report selection screen: institution-aware template picker from `pout` table; wires into existing `ReportViewerComponent`; add `GET /api/results/report?institution=&templateNum=` endpoint |
| 4 | **frm_res3.frm** | Thin read-only grid viewer for institution-"02" results; mergeable into `ResultListComponent` with `institution=02` filter param; lowest standalone value of the four |

---

## Section 9 — Verification Evidence Reference

All findings in this report are based on direct file reads of the current source tree, not prior assumptions. Key files verified:

| File | Verified fact |
|------|--------------|
| `ArchiveService.java` | `createChart()`: `operationRepository.save(bootstrap)` inside `@Transactional` when stock non-null |
| `BookService.java` | `create()`: 5-step save sequence under single `@Transactional` |
| `CatalogueSpecification.java` | `hasWilaya()`: LEFT JOIN + `cb.equal(siteJoin.get("wilyaNo"), wilayaNo)` |
| `CatalogueService.java` | `findAll()`: `SecurityUtils.getCurrentUserWilaya()` → `.and(hasWilaya(userWilaya))` |
| `CatalogueEntity.java` | `site` field: `@ManyToOne @JoinColumn(name="MN_DATA_EN", insertable=false, updatable=false)` |
| `PostAssignmentResponse.java` | 9-component record including `positionNo`, `positionName` |
| `PersonService.java` | `getAssignments()`: `positionRepository.findById(post.getLevelNo().trim())` → maps `PosNo`/`Name` |
| `person-detail.component.ts` | `assignmentColumns` includes `'positionNo'`, `'positionName'` |
| `unified-search.component.ts` | `debounceTime(300)`, `searchResults` signal, `filteredResults` computed, `navigate()` per-type routes |
| `catalogue.module.ts` | `{ path: 'search', component: UnifiedSearchComponent }` route declared |
| `template-form.component.ts` | `fieldChips` signal, `CdkDragDrop` import, `conditionRows` signal, `serializeConditions()` |
| `reports.module.ts` | `DragDropModule`, `MatButtonToggleModule` imported |
| `áªtí8.frm` | 18 lines, zero controls, zero code, VB_Name = Form7 — dead code confirmed |

---

*Report generated 2026-07-03. Supersedes migration-audit-report-v3.md.*
