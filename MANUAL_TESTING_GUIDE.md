# Manual Testing Guide — بنك المعلومات (legacy VB6 → Angular / Spring Boot / PostgreSQL)

Prepared 2026‑10‑11. Companion to `APPLICATION_WORKFLOW_MAP.md` (same abbreviations: `LEGACY/`, `DDL:n`, `FE/`, `BE/`, `MIG/`).

**What this guide is:** the order in which to test the whole application, with executable steps derived from the legacy source code (the authority) and the migrated code.
**What it is not:** a test result. **No step in this guide has been executed in a browser.** Every "Expected (migrated)" line is what the *code* says should happen. Your browser run is the first real check.

Evidence tags used on every step:

| Tag | Meaning |
|---|---|
| **L** | Legacy behaviour proven from `.frm`/DDL source (file:line given) |
| **M** | Migrated behaviour read from Angular/Spring source (file:line given) |
| **API/DB** | Confirmed by a read-only call to the running stack / read-only `SELECT` on 2026‑10‑11 |
| **BROWSER?** | Must be confirmed by you in the browser |
| **Gn** | Known gap (see §7). G1–G20 are from `APPLICATION_WORKFLOW_MAP.md`; G21–G27 were found while writing this guide |

---

## 0. Before anything else: test safely

### 0.1 Rules for your test session

1. **Take a backup of the Docker database first** (you run it; I did not). See §0.1a below for the exact Windows-safe commands, verification and restore procedure. Do not start WF1 until the backup has been verified.
2. **Only create, edit and delete records that you created in this session.** Give everything a recognisable marker so you can find and remove it:
   - Text values start with **`اختبار`** (e.g. `اختبار-وثيقة-01`).
   - Codes you choose yourself use the **`97`/`98` prefixes** where the format allows (CODING value `97`, user numbers `971`, `972` …). Earlier test sessions used the same prefixes; check they are free first (queries below).
   These are *suggested tester values*, not existing data. Always run the "is it free?" query before using one.
3. **Never run the destructive steps** (الغاء الاستمارة, delete periodical/author/user, cancel request, إعادة الترقيم) on records you did not create.
4. Verify database effects with **read-only** `SELECT`s. In this guide `Q "<sql>"` means:
   `docker exec macnz-manar-full-stack-db-1 psql -U postgres -d macnz_manar -c "<sql>"`
   `Q` is used **only** for `SELECT` statements. The one intentional database write in this guide (TC‑14.2) is written as **`W "<sql>"`** — same command, but it changes data and has its own confirmation checklist.
   (Host port 5432 is a different PostgreSQL — always use the container.) Legacy table names that are upper-case must be double-quoted: `"ARTICLE"`, `"CODING"`, `"DIGIT"`, `"PERIOD"`, `"RES"`, `"AUTHER"`, `"MACNZ"`, `"ANALIS"`, `"GEO"`, `"NAROWER"`, `"RELATIVE"`, `"FILE_ADD"`, `"TIME"`, `"POSITION"`, `"REL_FORM"`, `"SUBJECT"`, `"WORD"`; lower-case ones are not: `main`, `form`, `config`, `result`, `demand`, `tmp_fileadd`, `text1`, `date_subject`. Columns of upper-case tables are upper-case too (`"MN_APP_NO"`), except a few lower-case ones (`main.mn_trans`, `"DIGIT".dig_choice`).
5. Keep **DevTools → Network** open. For each action, note the request, status code and response message. A sudden return to the login page means a 401 (see G17).
6. **When a workflow is blocked, do not stop the test plan.** Mark the blocked test cases **BLOCKED** with the blocker ID (B1–B8), mark every test case that depends on them BLOCKED as well, and continue with the next workflow whose prerequisites are satisfied (§1.1). Come back to blocked items once their prerequisite is resolved.

### 0.1a Database backup, verification and restore (Windows + Docker)

**Why not `pg_dump … > file`:** a custom-format dump (`-Fc`) is binary. Redirecting `docker exec` output with `>` in Windows PowerShell 5.1 re-encodes the stream as text and corrupts the file. The commands below never pipe the dump through the Windows shell: `pg_dump` writes the file **inside** the database container, and `docker cp` copies it out byte for byte. They work in both PowerShell and Git Bash.

Container: `macnz-manar-full-stack-db-1` (PostgreSQL 16.15, `pg_dump` 16.15 inside the container). Database: `macnz_manar`. Choose a host folder outside the repository, e.g. `C:\db-backups` (create it first).

**Create the backup**
```
docker exec macnz-manar-full-stack-db-1 pg_dump -U postgres -d macnz_manar -Fc -f /tmp/macnz_manar_before_manual_test.dump
docker cp macnz-manar-full-stack-db-1:/tmp/macnz_manar_before_manual_test.dump C:\db-backups\macnz_manar_before_manual_test.dump
```

**Verify the backup before testing** (all three must succeed)
1. The archive is readable and contains your data — list its table-of-contents and look for the core tables:
   `docker exec macnz-manar-full-stack-db-1 pg_restore -l /tmp/macnz_manar_before_manual_test.dump`
   Expect entries such as `TABLE DATA public main`, `TABLE DATA public "ARTICLE"`, `TABLE DATA public config`, `TABLE DATA public flyway_schema_history`. An error such as "input file does not appear to be a valid archive" means the dump is unusable.
2. The host copy is identical to the container copy — compare checksums:
   `docker exec macnz-manar-full-stack-db-1 sha256sum /tmp/macnz_manar_before_manual_test.dump`
   PowerShell: `Get-FileHash C:\db-backups\macnz_manar_before_manual_test.dump -Algorithm SHA256` (Git Bash: `sha256sum /c/db-backups/macnz_manar_before_manual_test.dump`). The two hashes must be equal (case-insensitive).
3. Note the size (`dir C:\db-backups`) — it should not be 0 bytes.

The copy in the container's `/tmp` disappears when the container is recreated; the host copy is the real backup.

**Restore (only if you want to undo all test changes)**
1. Stop the backend so it holds no connections and writes nothing during the restore (run in the folder containing `docker-compose.yml`):
   `docker compose stop backend`
2. Copy the backup into the database container:
   `docker cp C:\db-backups\macnz_manar_before_manual_test.dump macnz-manar-full-stack-db-1:/tmp/restore.dump`
3. Restore in one transaction (all-or-nothing):
   `docker exec macnz-manar-full-stack-db-1 pg_restore -U postgres -d macnz_manar --clean --if-exists --single-transaction --no-owner /tmp/restore.dump`
   `--clean --if-exists` drops and recreates every object contained in the dump, then reloads its data; `--single-transaction` rolls everything back if any statement fails.
4. Check one known value, e.g. `Q "select count(*) from main"` → `24` and `Q "select count(*) from config"` → `1` (the 2026‑10‑11 baseline, §0.2).
5. Start the backend again: `docker compose start backend` (first start can take a few minutes; then log in again — all tokens issued for test users that no longer exist will fail with 401).

**What the database dump does NOT contain**
- **Uploaded and generated files.** Files written by the application live in the Docker volume `macnz-manar-full-stack_media_data`, mounted at `/media` in the backend (`docker-compose.yml`: `media_data:/media`; `MEDIA_BASE_PATH=/media`, `MEDIA_ARCHIVE_PATH=/media/archive`, `MEDIA_PICTURE_PATH=/media/pictures`). This includes digital files uploaded in TC‑6.5 (`/media/pictures/…`) and video/delivery outputs (WF13). On 2026‑10‑11 the volume held 12 files (84 KB). A restored database does **not** remove files you uploaded, and does not bring back files you deleted.
  Optional file backup (copies out of the running container, changes nothing): `docker cp macnz-manar-full-stack-backend-1:/media C:\db-backups\media_before_manual_test`
- **Application backups created in TC‑16.3.** They are written to `/app/backups` inside the backend container (working directory `/app`, default `app.backup.directory: ./backups`); that path is **not** on a volume and is lost when the backend container is rebuilt.
- Redis cache contents and Docker/container configuration.

After a restore, files uploaded during testing remain in `/media` as orphans (no `DIGIT` row points to them). Because the migrated upload skips numbers whose file already exists on disk (TC‑6.5), these orphans can shift future `DIG_DIG_NO` values; restore the media copy as well if you need an exact return to the baseline.

### 0.1b Configured access keys (read-only investigation, 2026‑10‑11)

| Screen | Legacy key (source) | Configured in the running backend | Your stated requirement | Status |
|---|---|---|---|---|
| المكنز الموضوعي | `891045` (`ARCHIVE.frm:577-578`, `M6_Click`: `password1 = "891045"`) | **`891045`** — `application.yml:67` `app.subject-thesaurus.access-key: ${SUBJECT_THESAURUS_ACCESS_KEY:891045}`; the running container defines no `SUBJECT_THESAURUS_ACCESS_KEY` (`docker inspect` env) and `docker-compose.yml` sets none; the deployed jar's `application.yml` has the same default; no profile file overrides it | **`1234`** | **MISMATCH** — the configured key is `891045`, not `1234` |
| المكنز الشكلي | `891045` (`ARCHIVE.frm:496-497`, `M2_Click`) | **`891045`** — `application.yml:70` `${FORM_THESAURUS_ACCESS_KEY:891045}`; no override present | `891045` | Matches |

Notes:
- The legacy source supports `891045` for **both** screens; the `1234` requirement for the subject thesaurus is therefore a new business rule, not legacy behaviour. Earlier session notes record that the original instructions contained both values and that `891045` was implemented and flagged.
- The key is checked only by the server (`POST /api/subject-thesaurus/access`, `POST /api/form-thesaurus/access`); no key is hard-coded in the frontend.
- Changing it would mean setting `SUBJECT_THESAURUS_ACCESS_KEY=1234` for the backend container — **not done**; this guide does not change configuration. Until that decision is made, test with the configured value **`891045`** and record TC‑0.6 for المكنز الموضوعي as "configured key ≠ stated requirement (1234)".

### 0.2 Baseline of the local database (read-only, 2026‑10‑11) [DB]

| Data | Present | Consequence |
|---|---|---|
| Users (`config`) | 1: `ADM` / `admin`, level `A`, permission 255, `user_start` NULL | Need extra users before most workflows (WF1) |
| `CODING` | 12 rows: `0301-0303` (L2), `1201-1203` (stored as L1!), `1301-1303` (stored as L1!), `2402-2404` (L2). No level‑1 header rows for 03/24 | Domains 01, 02, 04, 26, 29, 32, 33, 34, 37, 38, 09 empty → many dropdowns empty |
| `form` (names) | 5 rows, all type `01`, numbers `00000001`–`00000005` (ministries) | **No "country" rows** (`SUB_NO` ending `00000`) → المكنز الشكلي country list empty; periodical place lists empty (see WF3, B1) |
| `MACNZ` | 22 rows, codes 2/4/6 chars (levels 1/2/3) | Usable as descriptors (level 3 = 6‑char codes), but not legacy 9‑char format |
| `AUTHER` | 3 (`90001`–`90003`) | usable |
| `PERIOD` | 0 | create in WF5 |
| `main`/`ARTICLE` | 24 numeric numbers (e.g. `9911020`), **none starts with `ق`**; all `mn_trans` NULL | F2 "open form" from search needs `ق` numbers (legacy rule) → use records you create in WF6 |
| `DIGIT` | 12 rows on old numbers (types 02/03 only, no video 04) | Video workflows blocked until video rows + files exist |
| `result` | 1 old row (`res_no 0001234`) | — |
| `demand`, `tmp_fileadd`, `text1`, `TIME`, `POSITION`, `WORD`, `PERSON`, `ranjpath`, `bnkout`, `POUT`, `user_bnkout` | 0 | — |
| `retrieval_field` | 41 rows (migrated catalogue) | — |

Useful "is it free?" queries:
```
Q "select user_no, user_name from config order by 1"
Q "select \"SUB_CODE\",\"SUB_LEVE\",\"SUB_DESC\" from \"CODING\" order by 1"
Q "select \"SUB_TYP\",\"SUB_NO\",\"SUB_NAME\" from form order by 1,2"
Q "select \"SUB_CODE\",\"SUB_LEVEL\",\"SUB_DESC\" from \"MACNZ\" order by 1"
Q "select \"AUT_NO\",\"AUT_NAM\" from \"AUTHER\" order by 1"
Q "select \"PER_PER_NO\",\"PER_PER_NA\" from \"PERIOD\" order by 1"
Q "select \"MN_APP_NO\",\"MN_ACT_TTL\",mn_trans from main order by 1"
```

### 0.3 Things that make a workflow untestable until prepared (blockers)

| ID | Blocker | Why (evidence) | Affects |
|---|---|---|---|
| B1 | No **country** row in `form` (`SUB_NO` = `NNN00000`), and none of type `04` | Countries list = view `pay_form` (`DDL:3380`: `SUBSTRING(SUB_NO,4,5)='00000'`); periodical places = `pays_form` (`DDL:3398`: also `SUB_TYP='04'`). Adding a country copies `SUB_TYP` from the *selected* country (`coding.frm:2347-2357`; migrated `form-thesaurus.component.ts:265-266`), so the first country cannot get a type through the UI in either system. | WF3 names/positions, WF5 مكان الصدور, WF7 geo lists browsing |
| B2 | No user number **244** | Subject-thesaurus writes only for 244 (`Form5.frm:655,722,833`; `SubjectThesaurusService.java:298-303`), no admin bypass | WF4, WF13 "see all users" |
| B3 | No user with `user_start = 1` | Video queue start/F5 (`new_vdpreview.frm:2800,2913`; `DemandQueueService.java:71-74`) | WF13 |
| B4 | Empty CODING domains (01, 02, 04, 26, 29, 32, 33, 34 …) | §0.2 | WF6, WF9, WF10 |
| B5 | No video `DIGIT` rows (type `04`), no media files, no `ranjpath` rows, no CODING `09` paths | §0.2; media resolution via `/api/media/*` | WF12–WF13 |
| B6 | No way to lock a document in the migrated app (G1) | §7 | WF14 |
| B7 | Legacy retrieval field catalogue (`bnkout`/`pout` rows) not available anywhere (0 rows; `bnkout.mdb` only has an old Access schema) | field-by-field parity of retrieval cannot be established | WF11 |
| B8 | No `TRANS` (periodical arrivals) UI in the shipped legacy build (`trs_period.frm` = `Form11`, only reachable from the dead handler `m12`) | Periodicals retrieval roots on `PERIOD ⋈ TRANS` | WF11c |

---

## 1. Master workflow sequence

The order follows the data dependencies proven in the legacy code (who reads what someone else wrote). Each workflow lists what it needs and what it unlocks.

| # | Workflow | Main screens (Arabic menu path) | Needs | Unlocks |
|---|---|---|---|---|
| **WF0** | Start, login, menu, access keys | بطاقة الدخول → main menu | running stack | everything |
| **WF1** | Test users and permissions | التــرميــز › معالجة المستخدمين | WF0 (admin) | B2, B3; per-user defaults; permission tests |
| **WF2** | Reference codes (CODING domains) | التــرميــز › المكنز الشكلي (levels 1/2) — key 891045 | WF1 | B4; every coded dropdown |
| **WF3** | Names, countries, positions | التــرميــز › المكنز الشكلي (الدول / الاسماء / المناصب) | WF2, **B1 prepared** | names in analysis, periodicals, search |
| **WF4** | Subject thesaurus | التــرميــز › المكنز الموضوعي (Ctrl+A) — configured key 891045 (requirement says 1234 — mismatch, §0.1b), **user 244** | WF1 (244) | descriptors for analysis and search |
| **WF3b** | Form relations (الربط الشكلي / الموضوعي) | المكنز الشكلي | WF3 + WF4 | additional-files retrieval data |
| **WF5a** | Authors & publishers | التــرميــز › المؤلفين ودور النشر (Ctrl+K) | WF0 | authors grid, periodical publisher, search |
| **WF5b** | Periodicals | المعالجات › الصحف والمجلات (Ctrl+D) | WF2 (12/13), WF3 (places, people), WF5a | document source fields; periodicals retrieval |
| **WF6** | Register a document | المعالجات › استمارة التوثيق (Ctrl+C) | WF1 (user_ent/doc), WF2 (01,02,03,04,24,26,29,34), WF5a, WF5b | everything downstream |
| **WF7** | Analysis of the document | استمارة التوثيق › التحليل | WF6, WF4 (level‑3 terms), WF3 (names) | search by subject/place |
| **WF8** | Additional-files worklist | التحليل › ملفات اضافية للترميز; المكنز الشكلي › الملفات الاضافية للادخال | WF7 | — |
| **WF9** | Search, mark, log request | شاشة البحث | WF6/WF7 data with `DIGIT` rows; CODING 32/33 | WF10 |
| **WF10** | Usage requests | شاشة الطلبات | WF9 | — |
| **WF11** | Retrieval (bank / additional files / periodicals) | الاسترجاعات › … (Ctrl+S / Ctrl+E / Ctrl+F) | WF6–WF7 data; WF3b; WF5b | — |
| **WF12** | Video+audio search and scene ordering | شاشة البحث فيديو + صوتي | **B5** | WF13 |
| **WF13** | Video orders queue | الاسترجاعات › طلبيات الفيديو | WF12 or F6 from WF9; B2, B3 | — |
| **WF14** | Locking and unlocking | التــرميــز › اقفال الوثائق المفتوحة; استمارة التوثيق › فتح صلاحية | WF6 record; **B6 (DB prep)** | — |
| **WF15** | Delete / cancel paths (destructive, own test data only) | استمارة التوثيق › الغاء; other screens' delete | all earlier | cleanup |
| **WF16** | Retrieval-field maintenance, backup, unreachable utilities | التــرميــز › ملف بناء الاسترجاعات / معالجة حقول الاسترجاع / نسخ قاعدة البيانات | WF0 admin | — |
| **WF17** | Logout, session expiry, navigation regressions | toolbar | — | — |

**Why WF1 comes before reference data:** in legacy a user must exist in `config` to log in at all (`users.frm:169-200`), and two reference screens are restricted by *user number* (244) and `user_start`, which only exist once you create those users. The user record also carries `user_ent`/`user_doc`, which are 2‑character codes of CODING domains 02/01 created in WF2 — so you create the users in WF1, then set those two fields after WF2 (WF2 step 2.9).

### 1.1 What to do when a workflow is blocked

Blocked does not mean stop. Mark the affected test cases **BLOCKED (Bn)** and continue in the master order with every workflow whose own prerequisites are met. Expected effect of the current blockers on this database:

| Blocker | Mark BLOCKED | Still run (prerequisites satisfied) |
|---|---|---|
| **B1** (no country rows) | WF3: TC‑3.2, TC‑3.3 (TC‑3.4 needs a name too); WF3b: TC‑3b.1; WF5b: only the مكان الصدور 1/2 fields; WF11: TC‑11.4; WF11 TC‑11.5: only the مكان الصدور condition; any step that needs a name **you** created (use the 5 seed ministry names `01|00000001`–`00000005` instead where a name is only *searched for*, e.g. TC‑7.4 geo/files, TC‑9.2 المكان الجغرافي) | WF1, WF2, WF4, WF5a, WF5b (without places), WF6, WF7 (with seed names), WF8, WF9, WF10, WF11 bank scope, WF13 (partly), WF14–WF17 |
| **B2** (no user 244) | resolved by WF1 | — |
| **B3** (no `user_start = 1`) | resolved by WF1 | — |
| **B4** (empty CODING domains) | resolved by WF2 | — |
| **B5** (no video rows / media / `ranjpath`) | TC‑12.3, TC‑13.3 path list, TC‑13.5, the video part of TC‑6.5 (class 04) | TC‑12.1, TC‑12.2, TC‑13.1, TC‑13.2, TC‑13.4 |
| **B6** (cannot lock) | TC‑14.3–14.5 unless you choose the TC‑14.2 write | TC‑14.1 |
| **B7** (legacy field catalogue unavailable) | field-by-field comparison only | all WF11 functional steps |
| **B8** (no TRANS UI) | arrival-date conditions in TC‑11.5 | TC‑11.5 by periodical name |

When a blocker is later resolved, return to its BLOCKED items in master order (e.g. after B1: WF3 → WF3b → the place fields of WF5b → TC‑11.4).

---

## 2. Detailed test cases in execution order

Format of every test case:

- **Legacy** — what the VB6 program did (source).
- **Do** — exact actions in the migrated app.
- **Data** — values to enter (tester-chosen, marked `اختبار`/`97`).
- **Expect (UI)** — what the migrated code should show.
- **Expect (DB)** — rows created/changed.
- **Verify** — read-only query and/or reopen check.
- **Next** — what depends on it.
- **Diff** — known legacy/migrated differences (Gn).

All migrated steps are **BROWSER?** unless stated otherwise.

### WF0 — Start, login, main menu, access keys

**TC-0.1 Open the application**
- Legacy: program starts on `users` (`project2.vbp: Startup="users"`), caption "بطاقة الدخول".
- Do: open `http://localhost:4200/`.
- Expect (UI): `authGuard` sends you to `/auth/login` (`FE/core/guards/auth.guard.ts`; `FE/app.routes.ts:16-20`). Fields اسم المستخدم / كلمة المرور, link to `/public`.

**TC-0.2 Login — valid**
- Legacy: type **user number** (3 chars); `SERCH_users` (`users.frm:169-200`, `DDL:8133`) loads the row; Enter in password compares plain text (`users.frm:229-251`) → `ARCHIVE.Show`.
- Do: user name `admin`, your admin password → دخول.
- Expect (UI): `POST /api/auth/login` → 200 (API verified 2026‑10‑11) → navigates to `/catalogue` (catalogue list, migrated-only landing page) with the side menu (`login.component.ts:42-49`).
- Verify: DevTools → Application → localStorage has `access_token` and `current_user` `{"username":"admin…","level":"A","permission":255}`.

**TC-0.3 Login — invalid (negative)**
- Legacy: unknown number → "هذا الرقم غير موجود !!!!", after 5 → program closes (`users.frm:192-196`); wrong password → "كلمة المرور غير صحيحة !!!!", after 4 → closes (`:257-262`).
- Do: (a) both fields empty → دخول; (b) `admin` + wrong password; (c) unknown user name.
- Expect (UI): (a) "مطلوب" errors under both fields, no request; (b)(c) 401 → "اسم المستخدم أو كلمة المرور غير صحيحة" (`AUTH.LOGIN_ERROR`); you can retry indefinitely.
- Diff: no attempt limit, no program exit; login by name not number (G13).

**TC-0.4 Menu structure**
- Legacy: `ARCHIVE.frm:162-231` (§2.4 of the workflow map).
- Do: hover each side-menu group.
- Expect (UI): الترميز (8 items; 5 of them only for admins), المعالجات (2), الاسترجاعات (5 incl. migrated-only "طلبات سحب الملفات الاضافية"), شاشة البحث, شاشة الطلبات, شاشة البحث فيديو + صوتي, إضافات (8) (`main-layout.component.ts:45-92`).
- Check: labels match the legacy Arabic captions.

**TC-0.5 Keyboard shortcuts**
- Legacy: Ctrl+A, Ctrl+B, Ctrl+K, Ctrl+C, Ctrl+D, Ctrl+S, Ctrl+E, Ctrl+F (`ARCHIVE.frm:164-220`).
- Do: on the catalogue list (focus *not* in a text box) press Ctrl+K, Ctrl+A, Ctrl+B; then Ctrl+C, Ctrl+D, Ctrl+S, Ctrl+E, Ctrl+F.
- Expect (UI): Ctrl+K → `/authors`; Ctrl+A → key dialog for المكنز الموضوعي; Ctrl+B → key dialog for المكنز الشكلي (`main-layout.component.ts:186-199`). The other five do **not** navigate; the browser performs its own action (copy, bookmark, save page, find) — **G11**.

**TC-0.6 Access key — المكنز الموضوعي / المكنز الشكلي**
- Legacy: Frame3 "كلمة السر"; key `891045`; wrong key just hides the frame (`ARCHIVE.frm:255-299, 427-471, 489-505, 571-583`).
- Configured keys (§0.1b): المكنز الموضوعي **`891045`** (your stated requirement is `1234` — **mismatch, flag it**); المكنز الشكلي **`891045`** (matches).
- Do: menu الترميز › المكنز الموضوعي → (a) الغاء الامر; (b) wrong key `000000`; (c) `1234` (your requirement — expected to be **refused** with the current configuration); (d) `891045` (configured). Repeat (a), (b), (d) for المكنز الشكلي. Then press F5 (reload) on `/subject-thesaurus`.
- Record for المكنز الموضوعي: "accepts 891045, refuses 1234 → configuration does not match requirement" (or the opposite if the observed behaviour differs).
- Expect (UI): (a) stays on current screen; (b) and (c) snackbar with the server message or "كلمة السر غير صحيحة"; (d) screen opens; reload → key asked again (`subject-thesaurus-access.guard.ts:319-347`).
- Expect (API): without the key, `/api/subject-thesaurus/context` and `/api/form-thesaurus/context` return 403 "يجب ادخال كلمة السر لفتح المكنز …" (verified 2026‑10‑11).

**TC-0.7 Language and logout**
- Do: toolbar EN/AR toggle; then logout icon.
- Expect: direction flips RTL/LTR, preference saved in `localStorage.app_lang`; logout clears token and returns to `/auth/login` (`main-layout.component.ts:206-225`).

### WF1 — Test users and permissions (التــرميــز › معالجة المستخدمين)

**Why first:** legacy restricts the subject thesaurus to user number 244 and the video queue to 244 / `user_start = 1`; those users must exist. Migrated `/users` is admin-only (`users.module.ts:12-14` `adminGuard`; `UserController` `@Permission(PERM_ADMIN)`).

- Legacy screen: `config_users.frm` after key **261015** (`ARCHIVE.frm:534-550`): editable grid over `config` (`config_users.frm:15`), `ranjpath` grid (`:312`), per-user display fields grid (`:484`), F4/F3 (`:838-886`).
- Migrated: `/users` → `UserListComponent` (إضافة مستخدم جديد, تعديل, إعادة تعيين كلمة المرور, حذف, level filter) → `/users/new` `UserFormComponent` → `POST /api/users` → `UserService.create` (`UserService.java:57-67`) → `config`.

**TC-1.1 Inspect the form**
- Do: الترميز › معالجة المستخدمين › إضافة مستخدم جديد.
- Expect (UI): fields userNo (required, ≤3), userName (≤50), password, المستوى (A مدير / U مستخدم / G ضيف, default U), userEnt (≤2), userDoc (≤2), الصلاحية (number) and nine fields whose labels show **raw keys** (`USERS.START_PAGE` = `user_start`, `USERS.PASSWORD_CHANGE_FLAG` = `USER_PWD`, `USERS.CONFIG_PATH` = `user_cnf_path`, `USERS.COMPRESSED_VIDEO_PATH` = `user_cmpvd`, `USERS.VIDEO_PATH`, `USERS.SECONDARY_VIDEO_PATH`, `USERS.COMPANY`, `USERS.WILAYA_SCOPE` = `SITE_WLY`, section titles) — **G24** (missing translations; field→column mapping from `UserMapper.java:19-47`).

**TC-1.2 Create the test users** (check free first: `Q "select user_no,user_name from config"`)

| Purpose | userNo | userName (login) | Level | Permission | `USERS.START_PAGE` (user_start) | Why |
|---|---|---|---|---|---|---|
| Thesaurus writer / sees all video orders | **244** (fixed by legacy code) | e.g. `test244` | U | 15 (view+create+update+delete) | 0 | B2 |
| Video operator | e.g. `971` | e.g. `testop` | U | 15 | **1** | B3 |
| Limited user | e.g. `972` | e.g. `testview` | U | **1** (view only) | 0 | permission negatives |
| (optional) capped video user | e.g. `973` | e.g. `testcap` | U | 15 | **2** | 400‑second rule |

- Do: fill, حفظ. Leave userEnt/userDoc empty for now (codes created in WF2).
- Expect (UI): back to the list; new rows shown.
- Expect (DB): `INSERT config` with `user_password` BCrypt (`$2a$…`).
- Verify: `Q "select user_no,user_name,user_level,user_permition,user_start,left(user_password,4) from config order by 1"`.
- Invalid: (a) same userNo again → 409 "User number already exists: …" (`UserService.java:59-61`); (b) no password → 409 "Password is required for a new user" (`:62-64`); (c) userNo of 4 chars → field error, no request.
- Diff: legacy had no password hashing, no level/permission semantics (VB never reads `user_level`/`user_permition` — G13); login is by **name**, so give each user a unique name (a duplicate name is not prevented by the form; behaviour of login with duplicate names: **not established** — `findByUserName` returns an `Optional`, a duplicate would most likely raise an error; do not test on real data).

**TC-1.3 Admin-only screens as a non-admin**
- Do: log out, log in as `testview`. Look at the الترميز menu; then type `/users` and `/maintenance` in the address bar.
- Expect (UI): menu hides ملف بناء الاسترجاعات, اقفال الوثائق المفتوحة, معالجة المستخدمين, معالجة حقول الاسترجاع, نسخ قاعدة البيانات (`adminOnly`); direct URL → snackbar "هذه الصفحة متاحة للمسؤولين فقط" and redirect to `/catalogue` (`admin.guard.ts`).
- Diff: legacy gated these by keys 261015/a5g5/891045, not by user (G13).

**TC-1.4 Forced password change (migrated-only)**
- Do: as admin edit `testview`, set `USERS.PASSWORD_CHANGE_FLAG` = 1, save; log in as `testview`.
- Expect: redirected to `/auth/change-password`; after changing, normal login; `USER_PWD` back to 0 (`UserService.java:109-139`).
- Verify: `Q "select user_no,\"USER_PWD\" from config where user_no='972'"`.

**TC-1.5 Per-user retrieval fields (legacy F4/F3) — not migrated**
- Legacy: F4 on a user copies eligible `bnkout`/`pout` fields into `user_bnkout` (`config_users.frm:838-876`); F3 deletes them (`:877-886`, proc `del_user_bnkout` missing from DDL).
- Migrated: no equivalent; marks are created when the user toggles fields in the retrieval builder (WF11). **Record as not applicable / G12.**

**TC-1.6 Video path ranges (`ranjpath`) — not migrated in UI**
- Legacy: grid 2 of `config_users`.
- Migrated: backend `/api/admin/media-ranges` exists, no screen. **G12; blocks B5 setup through the UI.**

### WF2 — Reference codes (التــرميــز › المكنز الشكلي, levels 1 and 2)

**Legacy fact that drives this workflow:** the first two lists of المكنز الشكلي are the generic `CODING` editor. Level‑1 list = `PROC_V_CODING1` = every `CODING` row with `SUB_LEVE='1'` (`DDL:4824`); double-click a level‑1 row → level‑2 list = `coding_proc` = every row whose code starts with the same two characters (`DDL:5104`; `coding.frm:2650-2676`). اضافة on level 1 or 2 adds a `CODING` row with `SUB_LEVE` 1 or 2 (`coding.frm:2170-2195, 2322-2346`). Every coded dropdown in the application reads these rows by their 2‑character prefix (§3 below). `SUB_CODE` is 4 characters (`DDL:2205-2209`).
Migrated: `/form-thesaurus` → `FormThesaurusController` `GET/POST/PUT/DELETE /api/form-thesaurus/coding` → `FormThesaurusRepository.insertCoding` (`:85-88`).

**TC-2.1 Open and inspect**
- Do: Ctrl+B → key `891045`.
- Expect (UI): المستوى الاول list shows the 6 seed rows `1201-1203`, `1301-1303` (they are stored as level 1 in the seed — unlike legacy data, where a domain has one level‑1 header row). Domains `03` and `24` are **not reachable** here (no level‑1 row). [DB]

**TC-2.2 Create a level‑1 header for each domain you need**
- Do: click the المستوى الاول list → **اضافة (INSERT)** (or Insert key) → type code (4 chars) in الرمز → Enter → type description in الشرح → **تسجيل**.
- Data (check free first with the CODING query): one header per needed domain, e.g. `0100` "اختبار-الموثق", `0200` "اختبار-مدخل البيانات", `0400` "اختبار-نوع المسؤولية", `2400` "اختبار-شكل الوثيقة", `2600`, `2900`, `3200`, `3300`, `3400` (suffix `00` is a tester choice; legacy imposes no format).
- Expect (UI): row appears in level‑1 list; Enter in الرمز on an existing code → "هذا الرقم تابع لاستمارة اخرى!!!!!" (duplicate check `find_coding`, `coding.frm:2125-2128`).
- Expect (DB): `INSERT "CODING"("SUB_CODE","SUB_DESC","SUB_LEVE"='1')`.
- Verify: `Q "select * from \"CODING\" where \"SUB_CODE\" like '__00' order by 1"`.

**TC-2.3 Create level‑2 values**
- Do: double-click the header (e.g. `0100`) → المستوى الثاني list → اضافة → code (4 chars, same first 2) → description → تسجيل.
- Data (suggested; all prefixed `اختبار`): `0101` الموثق‑1; `0201` مدخل‑1; `0401` مؤلف, `0402` مترجم (author roles); `2401` scan / `2405` private (only if you will test those file classes; `2402-2404` exist); `2601` نوع شريط; `2901` نوع مادة; `3201` جهة مستفيدة; `3301` جهة موافقة; `3401` عربي (legacy default language for new documents is `3401`, `Form6.frm:3137`).
- Expect (DB): `SUB_LEVE='2'` rows. Note the header row (`0100`) is also returned by prefix-only dropdowns, in legacy (views filter by prefix only, e.g. `view_coding2` `DDL:3850`) and migrated (`CodingRepository.findBySubCodeStartingWith…`) — it will appear as a selectable option with suffix `00`.
- Verify: `Q "select * from \"CODING\" order by 1"`.

**TC-2.4 Edit and delete a code (own test codes only)**
- Do: select your code → **تعديل (F2)** → change الشرح → تسجيل; then **الغاء (DELETE)** → confirm with `ن`.
- Expect: legacy `upd_coding` / `del_coding` (`coding.frm:2425-2429, 2558-2569`); migrated PUT/DELETE `/api/form-thesaurus/coding`.
- Caution: deleting a code that documents already use leaves orphan codes (legacy had no FK). Only delete unused test codes.

**TC-2.5 Dependency check — dropdowns now filled**
- Do: open استمارة التوثيق (`/catalogue/new`) and open الموثق, مدخل البيانات, اللغة, نوع المسؤولية dropdowns.
- Expect: الموثق lists domain 01, مدخل البيانات domain 02, اللغة domain 34; **نوع المسؤولية lists domain 29, not 04 — G2** (`documentation-form.component.ts:177-186` vs legacy `DBList2` row source `coding5` = `VIEW_CODING5` `'04'`, `Form6.frm:894` + `.frx` binding, `DDL:3167`).

**TC-2.9 Give the test users their defaults**
- Do: `/users` → edit `test244`, `testop`, `testview`: userEnt = `01` (your domain‑02 value), userDoc = `01` (your domain‑01 value) → حفظ. **Log out and in again** (defaults are JWT claims set at login, `UserService.java:115-116`).
- Next: WF6 new-record defaults.

### WF3 — Names, countries, positions (المكنز الشكلي, lists الدول / الاسماء / المناصب)

**Blocked by B1** unless a country row exists. If TC‑3.1 confirms the blocker, mark TC‑3.2, TC‑3.3, TC‑3.4 and WF3b **BLOCKED — B1** and **continue with WF4** (and the rest of the plan, §1.1); do not stop testing. Legacy steps (proven):
1. Level 2 row selects the **type** of names: `v_typ = Mid(L2 code, 3, 2)` (`coding.frm:2691, 2712`) — e.g. L2 `1001` → type `01`.
2. Double-click L2 → الدول list = `pay_form` (`DDL:3380`).
3. Double-click a country → الاسماء = `nam_form(v_typ, first 3 chars of country SUB_NO)` (`DDL:7155`).
4. اضافة on الاسماء → `OP_FORM(v_typ + country prefix, today)` creates the next number (`DDL:7356`) → type the name → تسجيل (`upd_form`) (`coding.frm:2201-2236, 2366-2397`).
5. For a type‑01 name, double-click → المناصب; اضافة → `insr_pos(name, type+number, today)` (`coding.frm:2238-2243, 2398-2415`; `DDL:5931`).

**TC-3.1 Observe the blocker**
- Do: double-click any level‑2 row.
- Expect: الدول list empty (no `form` row with `SUB_NO` ending `00000`) [DB]. Record "BLOCKED — B1". Adding a country here would take its type from the selected (non-existent) country (`form-thesaurus.component.ts:265-266`) → empty `SUB_TYP`; a country of type `04` (needed by periodicals, `pays_form`) cannot be produced through the UI. **Decide with the data owner** how to obtain real country rows; do not invent them in shared data.

**TC-3.2 (after B1 is resolved) Add a name, edit it, search it**
- Do: L1 → L2 (e.g. type `01`) → country → الاسماء → اضافة → name `اختبار-شخص-01` → تسجيل. Then F8 (prefix search) / F9 (word search) on الاسماء; F2 تعديل; Esc to go back up a list.
- Expect (DB): `form` row `(SUB_TYP=v_typ, SUB_NO=<country 3>+<5-digit>, SUB_NAME, SUB_DTE=today)`; word index rows in `"WORD"` (`div_word`, `coding.frm:1388-1442`).
- Verify: `Q "select * from form where \"SUB_NAME\" like 'اختبار%'"`; `Q "select * from \"WORD\" where \"SUB_TYP6\"='2' order by 1"` (`WORD(SUB_CODE6 = type+number, SUB_DESC6 = word, SUB_TYP6 = '2' for names)`).
- Next: WF5b people fields, WF7 places/files, WF9 name criteria.

**TC-3.3 Positions (type 01 names only)**
- Do: double-click your person → المناصب → اضافة → `اختبار-منصب` → تسجيل.
- Expect (DB): `"POSITION"(POS_NO=type+number, POS_NAM, DAT_REC)`.
- Next: F2 "positions" in analysis geo list (legacy `form2.frm` DBList12 F2 → `proc_pos`, `:3314-3321`).

**TC-3.4 F5 person/institution card**
- Legacy: F5 on a type‑01 name → `person_f`, type‑03 → `instit_F` (`coding.frm:1646-1667`).
- Migrated: F5 → `openPersonForm()` (`form-thesaurus.component.ts:489`) shows a message (not migrated) — **G16**.

### WF4 — Subject thesaurus (التــرميــز › المكنز الموضوعي, Ctrl+A) — log in as **test244**

- Legacy: `Form5.frm`; 3 lists; writes only for user 244 (`:655, :722, :833`). Code rules: level 1 = typed code (MaxLength 9); level 2 = first 2 chars of the *selected level‑2 row* + typed 7 chars (`:747-764`); level 3 = `OP_macnz(first 6 chars of selected level‑2 row)` inserts a placeholder `…NNN` row and fills the code (`:674-689`, `DDL:7407`), then تسجيل updates its description. Every save also indexes words (`div_word` → `"WORD"`).
- Migrated: `/subject-thesaurus` → `/api/subject-thesaurus/terms`, `/terms/level3-code` (`SubjectThesaurusController`).

**TC-4.1 Non-244 cannot write**
- Do: as `admin`, open with key; press اضافة.
- Expect: buttons show "متاح للمستخدم 244 فقط"; server refuses with "هذه العملية متاحة للمستخدم 244 فقط" (`SubjectThesaurusService.java:298`). **Admin is not exempt** (legacy has no admin concept).

**TC-4.2 Add level‑2 and level‑3 terms (as test244)**
- Do: double-click seed level‑1 `01` → level‑2 list → select any row → اضافة → code `9700000` (7 chars) → الواصفة `اختبار-مستوى2` → تسجيل. Then double-click your new term → level‑3 list → اضافة (code is generated) → الواصفة `اختبار-واصفة` → تسجيل.
- Expect (DB): `"MACNZ"` rows `019700000` (level 2) and `019700001` (level 3); `"WORD"` rows for each word.
- Verify: `Q "select * from \"MACNZ\" where \"SUB_CODE\" like '0197%'"`.
- Invalid: Enter in الواصفة with an existing prefix → duplicate warning; level‑3 add when nothing selected → message.
- Diff: adding the first level‑2 term under a level‑1 term that has no children works in migrated (uses the parent prefix) but crashed legacy (`subject-thesaurus.component.ts:183-190`) — **G26**. Seed codes are 2/4/6 chars, so mixed formats will appear side by side.
- Next: WF7 descriptors (level > 2 only), WF9 الموضوع/الاضيق/المترابط, WF3b الربط الموضوعي.

**TC-4.3 Search, edit, delete**
- Do: بحث (F10) / F8 / F9 with `اختبار`; تعديل (F2) → change → تسجيل; الغاء (Delete) on your level‑3 term → `ن`.
- Expect: `serh_macnz` / `serh_wrdmacnz` results; `upd_macnz`; `del_macnz` (`Form5.frm:832-925`). Delete only your own terms (documents may reference codes; no FK).

### WF3b — Form relations (الربط الشكلي / الربط الموضوعي) — after WF3 and WF4

- Legacy: on a selected name, رقم الربط (relation number) with تقدم/تراجع (`coding.frm:1494-1513`), lists `rel_form_proc` and `subject_proc` (`DDL:7907, 9066`); Enter/double-click in DBList8 picker → `insr_rel_form` / `insr_subject` (`:1913-2048`); F2 on a relation → dates panel (تاريخ البداية/النهاية) → `upd_rfl_dte` / `upd_sub_dte` (`:2455-2471`).
- Migrated: `/api/form-thesaurus/relations/forms|subjects` (+ `/dates`); keys F2 dates, F8/F9 in picker (`form-thesaurus.component.ts:482-491`).

**TC-3b.1** Do: select your name → set رقم الربط `01` → focus الربط الشكلي → Enter (picker) → F8 type another name → Enter. Repeat for الربط الموضوعي with your MACNZ term. F2 → enter dates → Enter.
- Expect (DB): `"REL_FORM"(RLF_FORM1=type+no, RLF_FORM2, RLF_REL='01', dates)`, `"SUBJECT"(SUB_FORM, SUB_MCNZ, SUB_REL)`.
- Verify: `Q "select * from \"REL_FORM\""`; `Q "select * from \"SUBJECT\""`.
- Next: WF11b (additional-files retrieval: related form fields, subject).

### WF5a — Authors & publishers (التــرميــز › المؤلفين ودور النشر, Ctrl+K)

- Legacy `Form8.frm`: اضافة (number = last row of the *current list* + 1, `:266-284`), تعديل, تسجيل (`insr_auther`/`upd_auther`, `:304-344`), الغاء ("هل تريد الغاء المقالة(ن/ك)", `:346-371`), بحث (F10) prefix, بحث كلمة word, Enter-in-name duplicate check "هذا الاسم موجود سابقا...!!!" (`:480-549`).
- Migrated: `/authors` → `/api/authors/coding` (`AuthorCodingController`).

**TC-5a.1 Add** — اضافة → (number appears) → name `اختبار-مؤلف-01` → Enter → تسجيل.
- Expect (DB): `"AUTHER"(AUT_NO, AUT_NAM)`. Verify: `Q "select * from \"AUTHER\" order by 1"`. Note: list sorted by number; the new number is last row + 1 **of the list currently shown** (after a search it can collide → 409 because PG has `UNIQUE(AUT_NO)`).
**TC-5a.2 Duplicate name** — اضافة → type `دار الفكر` (prefix of seed `دار الفكر للنشر`) → Enter → "هذا الاسم موجود سابقا...!!!".
**TC-5a.3 Search** — بحث (F10) `دار` → only names starting with دار; بحث كلمة `الشروق` → word match.
**TC-5a.4 Edit / delete** — on your own author only; deleting an author used in `RES` → 409 (FK; legacy allowed) — test after WF6 to see it.
- Next: WF6 authors grid; WF5b دار النشر; WF9 المسؤول البياني.

### WF5b — Periodicals (المعالجات › الصحف والمجلات, Ctrl+D)

- Legacy `PERIOD1.frm` (object `PERIOD`). Dropdown sources (from `.frx` bindings): مكان الصدور 1/2 → `pays_form` (`SUB_TYP='04'` countries); وتيرة الصدور → `VIEW_CODING12`; second coded combo `m_per_typ1` → `VIEW_CODING13`; دار النشر → `AUTHER`; six people fields → type-to-search `serh_allform` over `form`.
- Migrated: `/periodicals` → `/api/periodicals` (`PeriodicalController`).

**TC-5b.1 Add** — اضافة → رقم الدورية shows next number (`GET /next-no` → 1 on this DB, API verified) → اسم الدورية `اختبار-دورية-01` → وتيرة الصدور (domain 12) → كيفية الاقتناء (13) → دار النشر (author) → optional people fields (names from WF3) → تسجيل.
- Expect (DB): `INSERT "PERIOD"`. Verify: `Q "select \"PER_PER_NO\",\"PER_PER_NA\",\"PER_FREQ\",\"PER_TYP1\",\"PER_PBLSHR\",\"PER_GEO\" from \"PERIOD\""`.
- Diff **G23**: legacy passes the full 4‑char frequency code (`PERIOD1.frm:1492`, `m_per_freq.BoundText`) into `@m_per_freq nvarchar(2)` (`DDL:6551`), which SQL Server truncates to the domain prefix `12` — legacy effectively stored no frequency value. Migrated stores the 2‑char value (`periodical-form.component.html:160-165`). Which is "right" is a business decision; record what you see.
- Blocked part: مكان الصدور lists are empty until B1 (type‑04 country rows).
**TC-5b.2 Navigate** — سابق / لاحق: exact number −1/+1; missing → "لا توجد دورية سابقة/لاحقة" (`PeriodicalService.findNext` exact match like legacy `SERCH_period`).
**TC-5b.3 Search** — بحث → number → تنفيذ; unknown → "هذا الرقم غير موجود". البحث بالعنوان → `اختبار` → pick from list.
**TC-5b.4 Persistence** — leave via خروج (goes to `/catalogue`), reopen, بحث your number → all fields reload.
**TC-5b.5 Dependency** — open استمارة التوثيق → مصدر الوثيقة → your periodical is listed (list loaded when the form opens; legacy also refreshed an already-open Form6, `PERIOD1.frm:1523-1525`).
**TC-5b.6 Delete (later, WF15)** — on a periodical used by a document → error (FK `ARTICLE.ART_PER_NO`, `MIG/V1…:975`) — G15.

### WF6 — Register a document (المعالجات › استمارة التوثيق, Ctrl+C) — log in as **testop** (or test244) after TC‑2.9

Prerequisites: WF2 (domains 01, 02, 03, 24, 34; 04 **and** 29 to observe G2), WF5a authors, WF5b one periodical, users with userEnt/userDoc and permission ≥ 15.

**TC-6.1 Open the empty form**
- Legacy: `M5_Click` sets `m_form_load = 1` → Form6 opens empty (`ARCHIVE.frm:586-593`, `Form6.frm:4189-4199`).
- Do: menu المعالجات › استمارة التوثيق (Ctrl+C is **not** bound — G11).
- Expect (UI): `/catalogue/new`; toolbar سجل جديد, تسجيل, بحث, الغاء, سابق, لاحق, البحث بالعنوان, خروج, فتح صلاحية, التحليل, الاخير; both grids visible. Click "إضافة مؤلف" or "إضافة ملف رقمي" → "رقم الاستمارة فارغ يجب ان تضغط على سجل جديد" (legacy text, `Form6.frm:3644/3717/3795`).
- Check every dropdown is filled from the right source — use the table in §3.1.

**TC-6.2 سجل جديد**
- Legacy: `Command2_Click` (`Form6.frm:3113-3153`) → `op_article` (`DDL:7229`): next number = `MAX(SUBSTRING(MN_APP_NO,2,6))+1` over **all** `main` rows, prefixed `ق`; inserts `ARTICLE(ART_APP_NO)` and `main(MN_APP_NO, mn_trans=0)` immediately; defaults: date today, مدخل البيانات = user_ent, الموثق = user_doc, language `3401`, طبيعة `ع`.
- Do: سجل جديد.
- Expect (UI): number `ق000001` on this database (migrated counts only numbers matching `^ق[0-9]{6}$`, `ArticleService.java:123-142`); entry date = now; الموثق/مدخل البيانات = your user's codes; اللغة = `01`; طبيعة = علني (`documentation-form.component.ts:533-553`).
- Expect (DB): `main` and `"ARTICLE"` rows exist **before** you press تسجيل.
- Verify: `Q "select \"MN_APP_NO\",mn_trans,\"MN_TYP\",mn_doc_nature from main where \"MN_APP_NO\" like 'ق%'"` → `mn_trans = 0`, `MN_TYP = 'A'` (migrated discriminator, see G32); `Q "select \"ART_APP_NO\" from \"ARTICLE\" where \"ART_APP_NO\" like 'ق%'"`.
- Diff **G28**: legacy would compute the maximum over every number (the leftover numeric test numbers such as `9998887` would make legacy produce `ق998888`); migrated ignores non-`ق` numbers. With real legacy data (all `ق######`) both agree.
- Note: the defaults are only shown on screen — the DB row stays empty until تسجيل (same in legacy).

**TC-6.3 Fill and تسجيل**
- Data: مصدر الوثيقة = your periodical; تاريخ الوثيقة; مصدر الترجمة (optional); العنوان الفعلي `اختبار-وثيقة-01`; العنوان الثانوي; نوع الوثيقة (domain 03); اللغة; عدد الصفحات `12`; رقم العدد `3`; طبيعة الوثيقة; المستخلص `اختبار مستخلص`.
- Do: تسجيل.
- Legacy: `upd_main` + `upd_article2` (`Form6.frm:2799-2845`, `DDL:10814, 10218`); stores 2‑char codes (`Mid(BoundText,3,2)`).
- Expect (UI): snackbar "تمت العملية بنجاح"; form re-filled from the server response.
- Expect (DB): `PUT /api/articles/{no}/documentation` (`ArticleService.updateDocumentationForm`, `:185-220`).
- Verify:
  `Q "select \"MN_APP_NO\",\"MN_ACT_TTL\",\"MN_ADD_TTL\",\"MN_DATA_EN\",\"MN_APP_DOC\",\"MN_ENT_DTE\",\"MN_TYP\",mn_doc_nature,\"MN_RESULT\" from main where \"MN_APP_NO\"='ق000001'"` → طبيعة (ع/س) is in `mn_doc_nature`; legacy wrote it to `MN_TYP` (`DDL:10826`) — **G32**.
  `Q "select * from \"ARTICLE\" where \"ART_APP_NO\"='ق000001'"` → `ART_PER_NO` = periodical number, `ART_SUB_TY`/`ART_LANG1` = 2‑char codes.
- Persist: خروج → reopen استمارة التوثيق → بحث → `ق000001` → all values back; dropdowns show the *names* for the stored codes.
- Invalid: (a) العنوان longer than 125 chars cannot be typed (maxlength); (b) type a periodical name that is not in the list → the source is cleared on save (`bindTypedPeriodical`, `:237-243`) — legacy DataCombo behaved the same.
- Diff **G20**: legacy also saved on Enter in العنوان الثانوي / نوع الوثيقة and saved the abstract on Esc (`Form6.frm:4050-4093, 4272-4285, 4465-4516`); migrated saves only with تسجيل.

**TC-6.4 جدول المسؤولية البيانية (authors grid)**
- Legacy: `DataGrid2` over `view_res3`/`res_proc1` (role names from CODING **04**); Space on role column → `DBList2` (`coding5`) → `upd_res1`; Space on name → `DBList1` (`AUTHER`, F8 search box `serh_auther` = **prefix**) → `upd_res`; Insert or `i` → `insr_res`; Delete → `del_res1` (`Form6.frm:3727-3799, 4098-4176, 4373-4399`).
- Do: إضافة مؤلف → type ≥2 letters of an author → pick → choose نوع المسؤولية → ✓. Then edit (pencil) to change role; then delete (bin) → confirm "هل تريد الغاء هذه السجل (ن / ك)".
- Expect (UI/API): `POST/PUT/DELETE /api/catalogue/{no}/authors` (`DescriptorService` → `"RES"`); the role list shows **domain 29** values (G2). Author search matches *contains*, 10 results max (`AuthorService.search`, `autocomplete.service.ts:40-45`) — legacy F8 was prefix (G31).
- Expect (DB): `Q "select * from \"RES\" where \"RES_APP_NO\"='ق000001'"` → `RES_APP_TY` holds the 2‑char suffix of the *29* code you chose.
- Shortcut: F8 focuses the author box (`documentation-form.component.ts:318-325`).
- Next: WF9 المسؤول البياني; deleting this author in WF5a now returns 409.

**TC-6.5 جدول ربط الوثائق الرقمية بالبيانات (digital files)**
- Legacy: Insert → empty row (`insr_digit1`); Space per column to pick شكل الوثيقة (CODING 24, `coding24`), نوع المادة (29, `view_coding29`), نوع الشريط (26, `coding26`), مكان التصوير/النشر (`pay_form`/`serh_allform`); Space on رقم digital → choose a local file → `op_digit` allocates the number for that file class and copies the file into `<user_cnf_path>\scan|waves|photos|private\NN\NN\` (`Form6.frm:3538-3649`); F5 = allocate number only; Delete → refuses if the file still exists in the archive tree (`:3037-3090`); double-click opens the file (01/03/05) or the player (02/04).
- Do: إضافة ملف رقمي (or F5) → dialog: شكل الوثيقة (domain 24), choose a small test file (class 01/02/03/05 only), نوع المادة, نوع الشريط, من/الى times, مكان التصوير (type ≥2 letters) → save. Then double-click/open the row; then delete it.
- Expect (UI): row with allocated رقم digital; open downloads/opens the file via `/api/media/asset/{digitNo}`; video class 04 shows "file not found" (G9).
- Expect (DB): `Q "select * from \"DIGIT\" where \"DIG_NO\"='ق000001'"`; the file stored under the server media directory (`app.media.*`).
- Numbering: legacy `op_digit` = max+1 **within the file class** (`DDL:7332`), duplicates across classes allowed. PostgreSQL has `UNIQUE("DIG_DIG_NO")` (constraint `uq_digit_dig_no`), so the migrated upload computes a *candidate* = max numeric `DIG_DIG_NO` of the same class + 1 (`DigitRepository.findMaxNumericDigitNoByType1`, `:32-35`), then **increments the candidate while that number is already used by any class, or a file with that number already exists on disk for that class and extension** (`DigitizationService.java:207-226`, `MediaService.assetExists`). Consequences:
  - The number you get **depends on what was uploaded before, in any class, and on files already in `/media`** — it cannot be predicted as a fixed value for a test step.
  - Starting point on 2026‑10‑11 [DB]: class 02 uses `000001`–`000005` (max `000005`), class 03 max `654329`, classes 01/04/05 have no rows. Illustration only: if the first upload of the session is class 01, its candidate `000001` is taken, so it would get `000006` (if no file blocks it); a class‑02 upload *after that* would compute `000006`, find it taken, and get `000007`. In the opposite order the numbers swap. A class‑03 upload would get `654330`. Two uploads can never receive the same number.
  - Legacy would have given a first class‑01 file `000001` (duplicate across classes allowed).
- How to verify the actual number after **each** insertion (read-only):
  1. Note the رقم digital shown in the grid row.
  2. `Q "select \"DIG_NO\",\"DIG_SER\",\"DIG_DIG_NO\",\"DIG_TYP1\",\"DIG_TYP\" from \"DIGIT\" where \"DIG_NO\"='ق000001' order by \"DIG_SER\""` — the new row's `DIG_DIG_NO` must equal the grid value.
  3. `Q "select \"DIG_DIG_NO\",count(*) from \"DIGIT\" group by 1 having count(*)>1"` — must return **no rows** (global uniqueness).
  4. Optional file check (read-only): `docker exec macnz-manar-full-stack-backend-1 find /media -name "<DIG_DIG_NO>.*"` — exactly one file for the new number.
  Record the number you got and the upload order in your test notes; don't compare against a fixed expected value.
- Diff **G25**: نوع المادة and نوع الشريط lists show **every** CODING row (`digit-record-dialog.component.ts:82-96`) instead of domains 29 and 26 (proven by `Form6.frx` bindings `DBList6 → view_coding29`, `DBList5 → coding26`). Delete does not check whether the archived file still exists.

**TC-6.6 Navigation سابق / لاحق / الاخير**
- Legacy: number −1/+1 until an existing record; end → "لا يوجد استمارة لاحقة"; before the first → wraps to the last (`Form6.frm:3303-3362`); الاخير → `max_article`.
- Do: on `ق000001` press لاحق, سابق, الاخير; repeat as `testview` (non-admin).
- Expect (M): uses `GET /api/articles?size=200&sort=appNo` and jumps within that page (`documentation-form.component.ts:720-741`) — at the end it wraps to the first record (G5). For **non-admin users the list only contains records whose مدخل البيانات and الموثق equal the user's own codes** (`ArticleService.findAll` `:57-71`, `ArticleSpecification.belongsToUserEntity/hasDocumentType`) — **G21**; legacy had no such filter.

**TC-6.7 بحث (by number) and البحث بالعنوان**
- Legacy: Frame4 number → `SERCH_main` → "لا يوجد استمارة لهذا الرقم !!!!" when missing (`Form6.frm:2908-2923`); title → `SERH_main` **prefix** on `MN_ACT_TTL`, `ق` numbers only, pick list (`:3382-3404`, `DDL:8504`).
- Do: بحث → `ق000001`; بحث → `ق999999`; البحث بالعنوان → `اختبار`; → `zzzz`.
- Expect (M): found → loads. Not found → **no message at all** (`loadRecord` error handler only stops the spinner, `:743-752`; 404 not handled by `ErrorInterceptor`) — **G27**. Title: contains-match, first match loaded directly; none → "لا يوجد استمارة لهذا العنوان". Non-admins: title search filtered (G21).

**TC-6.8 التحليل (go to analysis)**
- Legacy: new record → save then open Form2; existing → Frame5 "هل تريد الانتقال الى الصفحة الثانية ؟" مع تسجيل / بدون تسجيل / الغاء الامر (`Form6.frm:3222-3301, 2951-3020`); Form2 opens **on top** and reads `Form6.m_mn_app_no` (`form2.frm:4266-4270`).
- Do: التحليل → مع تسجيل.
- Expect (M): prompt (always, D6.6) → save → navigate to `/catalogue/ق000001` (`:686-717`). The documentation form is closed (D6.5).
- Next: WF7.

**TC-6.9 خروج**
- Legacy: `Unload Form6` → back to the main window.
- Expect (M): navigate to `/catalogue` (catalogue list).

**TC-6.10 Permissions**
- Do: as `testview` (permission 1) press سجل جديد, then try تسجيل on an existing record.
- Expect: `POST /api/articles/next` and `PUT …/documentation` → 403 → snackbar "غير مصرح لك بالوصول" (`@Permission(PERM_CREATE/UPDATE)`, `ArticleController.java:51-80`; `error.interceptor.ts`). Legacy had no such restriction (G29).

(فتح صلاحية and الغاء are tested in WF14/WF15.)

### WF7 — Analysis (`/catalogue/:appNo`, legacy Form2 "برنامج معالجة التحليل")

Prerequisites: WF6 record; WF4 level‑3 terms (code with `SUB_LEVEL > 2`; seed 6‑char codes qualify); WF3 names (for geo/files; otherwise only the 5 seed ministries can be found).

Legacy rules (`form2.frm`): descriptor list `ANALIS` via `ass` (`DDL:5066`); Insert → thesaurus list (`DBList11`, MACNZ, F8 prefix / F9 word) → only `sub_level > 2` accepted ("انتبه لا تستطيع الادخال الا الواصفات ....!", `:2979, 3110`) → `insr_analis(no, code, serial = last+1 two digits)` (`:2969-3004`); selecting a descriptor reloads its relation lists; relation lists: الجغرافي `GEO` (20), المترابط `RELATIVE` type 1 (01), الاضيق `NAROWER` type 1 (02), ملف اضافي له / عنه `FILE_ADD` (03/04); relation-specific lists (30/40/50/60) are scoped by رقم العلاقة (`Text3`); adding any relation before choosing a descriptor → "لايمكن ادخل العلاقات الا بعد تحديد الواصفة!!!!"; Delete on a descriptor → "هل تريد الغاء المقالة(ن/ك)" and cascades to its GEO/RELATIVE/NAROWER/FILE_ADD/TIME rows (`:2847-2900`); all inserts/deletes blocked when the document is locked (`is_trans`).

**TC-7.1 Page layout**
- Expect (M): summary/edit block, linked authors, then the analysis panel (`analysis-panel.component.html`): toolbar فتح النص, ملفات اضافية للترميز; search-mode radios بحث بالبداية / بحث بكلمة معينة; descriptor list with "اضافة واصف"; relation stepper (سابق / رقم العلاقة / لاحق); sections الجغرافي, المصطلحات المرتبطة, المصطلحات الأضيق, ملف اضافي له, ملف اضافي عنه (overall and relation-specific), المدد الزمنية للواصف, date range, النص.

**TC-7.2 Add a descriptor**
- Do: اضافة واصف → type part of `اختبار-واصفة` → pick → ✓.
- Expect: picker only offers MACNZ rows with level > 2 (`analysis-panel.component.ts:205-228`); `POST /api/catalogue/{no}/subjects` with next serial.
- Verify: `Q "select * from \"ANALIS\" where \"AN_APP_NO\"='ق000001'"` → `AN_DESC_NO` = term code, `AN_SER_NO` = `01`.
- Invalid: try a level‑1/2 term name → not offered (legacy showed the warning instead).

**TC-7.3 Relations require a selected descriptor**
- Do: before selecting the descriptor, try الجغرافي "+" .
- Expect: add buttons disabled until a descriptor is selected (`[disabled]="!selectedSubject()"`) — legacy message replaced by disabled buttons.

**TC-7.4 Overall relations (no relation number)**
- Do: select the descriptor → add الجغرافي (name search, type ≥2 letters), المترابط (MACNZ), الأضيق (MACNZ), ملف اضافي له, ملف اضافي عنه (names).
- Expect (DB):
  `Q "select * from \"GEO\" where \"GEO_APP_NO\"='ق000001'"` (`GEO_GEO_NO` = type+number of the name)
  `Q "select * from \"RELATIVE\" where \"REL_APP_NO\"='ق000001'"` (type 1)
  `Q "select * from \"NAROWER\" where \"NAR_APP_NO\"='ق000001'"` (type 1)
  `Q "select * from \"FILE_ADD\" where \"FAD_APP_NO\"='ق000001'"` (له vs عنه distinguished by `FAD_FAD_T2`).
- Diff: legacy geo/file lists start from `pay_form` and search `serh_allform`/`serh_wrdform` (all names); migrated searches `/api/forms?name=` (contains, 20 per page).

**TC-7.5 Relation-specific lists (رقم العلاقة)**
- Do: لاحق on the stepper → relation `02` → add المترابط / الأضيق / ملف له / ملف عنه in the relation section.
- Expect (DB): `RELATIVE`/`NAROWER` rows with type `2` and relation number `02`; `FILE_ADD` rows with `FAD_FAD_T1='2'`.

**TC-7.6 Time marks and date range**
- Legacy: in/out buttons on the embedded player or `vd_preview` (`form2.frm:2395-2481`; `vd_preview.frm:290-394`); date range Enter → `insr/upd_dte_subject` (`:4291-4369`).
- Do: المدد الزمنية → type start/end h:m:s → save; date range from/to → save.
- Expect (DB): `Q "select * from \"TIME\" where \"TM_APP_NO\"='ق000001'"` (`TM_DESC_NO`, `TM_SER_NO`, `TM_RLTV_NO`, `TM_O/M/S`, `TM_O1/M1/S1`); `Q "select * from date_subject where dte_app_no='ق000001'"`.
- Diff: no player; manual entry only (G9, D2.2).

**TC-7.7 Text (فتح النص)**
- Do: فتح النص → serial + text → حفظ; then reopen استمارة التوثيق on the record → label "يوجد نص".
- Expect (DB): `Q "select * from text1 where txt_no='ق000001'"` (columns `txt_desc_n`, `txt_ser_no`, `txt_rltv_n`, `txt_text`).

**TC-7.8 Delete cascade**
- Do: delete the descriptor → confirm.
- Expect: descriptor and its geo/related/narrower/file/time rows removed (re-run the queries above). Legacy proc `del_time1` used for TIME is missing from the DDL, so the legacy cascade on TIME cannot be proven.

**TC-7.9 Return path**
- Legacy: اغلاق الصفحة → Form6 is still open on the same record (`form2.frm:2276-2279`).
- Do: press the back arrow.
- Expect (M): `/catalogue` list; to continue editing the header you must reopen استمارة التوثيق and بحث the number (D2.4).

**TC-7.10 Lock not enforced (G4)** — tested in WF14.

### WF8 — Additional-files worklist (`tmp_file`)

Legacy (`tmp_file.frm`): opened from Form2 "ملفات اضافية للترميز" or المكنز الشكلي "الملفات الاضافية للادخال"; criteria من/الى تاريخ, رقم المعد, كلمة معينة, منجز/غيرمنجز → النتيجة; Insert → `op_tmp(Form2.Text1, user_no, today)` (`DDL:7549`: serial = max of *that user* + 1, `tmp_final = 0`); Delete; double-click or F12 → Form6 on the row's document (`:644-683`).

**TC-8.1 From the analysis page**
- Do: on `/catalogue/ق000001` → ملفات اضافية للترميز → إضافة ملف معلق.
- Expect: `POST /api/temp-files {tmpFadNo:'ق000001'}`; row with your user number, today, منجز = 0.
- Verify: `Q "select * from tmp_fileadd order by tmp_ser desc"`.
- Then إنجاز → `tmp_final` = 1; حذف → browser confirm → row deleted. Caution: delete/finalize address a row by (document, serial); serials restart per user, so two users can share the same pair — test with one user only.

**TC-8.2 From المكنز الشكلي (full legacy window)**
- Do: المكنز الشكلي › الملفات الاضافية للادخال → criteria → النتيجة; select a row → double-click (or F12).
- Expect: window = `AdditionalFilesComponent` dialog (criteria lock after Enter, بحث جديد unlocks, عدد العمليات, navigation first/prev/next/last); double-click/F12 → `/catalogue/new?appNo=<row document>` loads the documentation form on that record. Insert here creates a row **with no document** (Form2 is not open in this context) [PRIOR].

**TC-8.3 Migrated-only list** — الاسترجاعات › طلبات سحب الملفات الاضافية (`/catalogue/files-retrieval`): filters رقم الملف / رقم المستخدم / الحالة, إنجاز, حذف. No legacy screen; check it shows the same rows as TC‑8.1.

### WF9 — Search, mark, log a usage request (شاشة البحث) — log in as **testop**

Prerequisites: WF6–WF7 record `ق000001` with at least one `DIGIT` row (TC‑6.5) — `DIGIT` rows are what F9 marks; CODING 32/33 values (WF2) to compare with G22; permission bit CREATE for logging.

Legacy (`user_inetrface.frm`): 22 criteria, each **disabled after it is committed** (Enter / pick), بحث جديد re-enables (`:2318-2419`); النتيجة appends `order by art_dte`, drops and re-creates proc `tmp_result` from a base query over `main ⟕ ARTICLE ⟕ RES ⟕ AUTHER ⟕ PERIOD ⟕ digit ⟕ CODING(24)` (`:2875-2922, 2188-2199`); no criterion → "يجب طرح السؤال اولا....."; grid keys F9 / F2 / F3 / F6 and double-click (`:2549-2659`); F3 panel: folder, مع تسجيل الطلب, المستفيد, الجهة المستفيدة (`m_res_cote`, CODING 32), الجهة الموافقة (`m_res_permit`, CODING 33), الموضوع → نسخ الاختيار / نسخ الجدول (`:2212-2547`).
Migrated: `/catalogue/search` → `POST /api/search-screen/search` (`SearchScreenController`, no permission needed), `PUT /api/search-screen/results/{digitNo}/choice`, `POST /api/digitization/results/log-usage` (`PERM_CREATE`).

**TC-9.1 No criteria**
- Do: open شاشة البحث → النتيجة.
- Expect: snackbar `SEARCH_SCREEN.NO_CRITERIA` (legacy "يجب طرح السؤال اولا.....").

**TC-9.2 Each criterion finds the test record and locks**
- Do, one at a time (بحث جديد between): كلمة من العناوين `اختبار-وثيقة`; كلمة من المستخلص `مستخلص`; الموضوع = your level‑3 term; المكان الجغرافي = the name you added in TC‑7.4; المسؤول البياني = your author; جهة الصدور = your periodical; نوع الوثيقة (03); اللغة (34); مدخل البيانات (02); رقم digital = the number from TC‑6.5; من/الى تاريخ around your document date. Press Enter (text) or pick (lists), then النتيجة.
- Expect: the field greys out after commit (`lockControl`/`commitField`); `ق000001` appears; بحث جديد clears and unlocks.
- Note: the subject/related/narrower pickers load the full MACNZ list and filter in the browser; name pickers call `/api/forms?name=` (contains). Legacy used prefix (F8) / word (F9) procs — the radio "البحث ببداية الاسم / البحث بكلمة معينة" selects the mode in both.

**TC-9.3 عدد المقالات** — after a search: message with the row count (legacy "عدد المقالات = n"; empty → "لايوجد مقالات لهذا السؤال").

**TC-9.4 Open the file (double-click)** — on the row with your test file: file opens/downloads via `/api/media/asset/{digitNo}`; a missing file → "هذا الملف غير موجود في الارشيف…".

**TC-9.5 F2 — open the record**
- Legacy: only for numbers starting with `ق`; opens **استمارة التوثيق** with that record (`:2606-2616`).
- Do: focus the `ق000001` row → F2; then a row with a numeric number (`9911020`, if returned) → F2.
- Expect (M): `ق` row → navigates to `/catalogue/ق000001` (**analysis page, not the form — G7**); numeric row → nothing happens (matches legacy rule).

**TC-9.6 F9 — mark الاختيار**
- Do: F9 (or the checkbox) on the row twice.
- Expect: `PUT …/results/{digitNo}/choice`; `Q "select \"DIG_DIG_NO\",dig_choice from \"DIGIT\" where \"DIG_NO\"='ق000001'"` → 1 then 0. Rows without a digital number cannot be marked (checkbox disabled), as in legacy.
- Note: the mark is a column on `DIGIT`, shared by all users (same as legacy).

**TC-9.7 F3 — log the request**
- Do: mark the row (F9) → F3 → panel: المستفيد `اختبار-مستفيد` (required), field labelled **"الجهة الموافقة"**, field labelled **"الجهة المستفيدة"**, الموضوع → "تسجيل طلب استفادة".
- Expect (UI): "تم تسجيل الطلب بنجاح (1 سطر)"; marks reset to 0.
- Expect (DB): `Q "select res_no,res_ser,res_no_ist,res_dig_no,res_typ,res_typ1,res_prs,res_cote,res_permit,res_dte,res_user_no,res_subject from result order by res_no desc"` → new `res_no` = previous max + 1 as **7 digits** (legacy 6, `DDL:7483`) — G33; one row per marked file, `res_ser` 1…n.
- **G22 (verify carefully):** the two entity fields are **free-text inputs** (legacy: CODING 32/33 dropdowns), and their labels are **swapped**: the input bound to `res_cote` is labelled الجهة الموافقة, the one bound to `res_permit` is labelled الجهة المستفيدة (`unified-search.component.html:226-238`; `ar.json SEARCH_SCREEN.APPROVING_BODY/BENEFICIARY_ENTITY`). Legacy pairing (by screen coordinates in `user_inetrface.frm`): `m_res_cote` (32) ↔ "الجهة المستفيدة", `m_res_permit` (33) ↔ "الجهة الموافقة". Type a *code* (e.g. `01`) in each and check which column receives it and how شاشة الطلبات labels it.
- **G8:** no file is copied anywhere; only the request rows are written.
- Legacy quirk (for reference, **G30**): legacy wrote file 1 with `upd_result` (correct) and files 2…n with `insr_result`, whose VALUES list swaps `res_cote`/`res_permit` (`DDL:6732-6736`). The migrated code writes all rows the same way (correct).
- Invalid: empty المستفيد → panel stays, field marked.
- Next: WF10.

**TC-9.8 F6 — send the clip to طلبيات الفيديو** — on a row with times: navigates to `/video-orders` with the clip preloaded (router state `videoOrderPreload`, `unified-search.component.ts:220-233`). Continue in TC‑13.4.

**TC-9.9 طباعة الملف / خروج** — طباعة opens `/reports` in a new tab (legacy: a Crystal report chosen by `box_company`, G19); خروج → `/catalogue`.

**TC-9.10 State on return** — open a record from the results, then go back with the browser Back button: the search page is re-created (criteria and results gone) — legacy kept the window open (G14).

### WF10 — Usage requests (شاشة الطلبات)

Legacy (`f_result.frm`): criteria lock after Enter; النتيجة builds proc `tmp_dmd_result` over `result ⟕ main ⟕ CODING(32,33,24)` (`:1294-1334, 1009-1167`); grid columns رقم الطلب, العنوان, جهة الاستفادة (desc of 32), رقم الوثيقة, …; معالجة طلبات معينة → panel: رقم الطلب, المستفيد, الجهة المستفيدة (32), الجهة الموافقة (33), الموضوع → تعديل (`upd_result1` on **all** rows of that request number, `:1271-1286`) / الغاء الطلب (`del_result`, **only user 244**, otherwise nothing happens, `:1248-1259`) / اضافة (no handler) / الغاء الامر; طباعة الملف → report 6.
Migrated: `/requests` → `GET /api/digitization/results`, `PUT/DELETE /api/digitization/results/by-number/{resultNo}` (UPDATE / DELETE permissions; delete additionally admin level, `DigitizationService.java:850-892`).

**TC-10.1 List and filter** — النتيجة with no criteria → `USAGE_REQUESTS.NO_SEARCH_CRITERIA`; then filter by your request number / المستفيد → your rows; check الجهة المستفيدة column shows the description of the code stored in `res_cote` (blank when free text was typed in TC‑9.7).
**TC-10.2 Edit** — معالجة طلبات معينة → رقم الطلب → change المستفيد / الجهتين (dropdowns 32/33 here) / الموضوع → تعديل → all rows of that number updated: re-run the `result` query.
**TC-10.3 Cancel as non-admin** — as `test244` (number 244, level U): الغاء الطلب → "لا تملك صلاحية الغاء الطلبات" (migrated requires admin; legacy allowed 244 only) — G13.
**TC-10.4 Cancel as admin** — as `admin`, on **your own** request only → rows deleted. (Legacy: admin `ADM` would have been refused — only 244.)
**TC-10.5 Count / print / exit** — عدد المقالات; طباعة الملف downloads a **CSV** (`exportCsv`) instead of report 6; خروج → `/catalogue`.
**TC-10.6 Dead button** — اضافة does nothing in both (legacy has no handler; `submitManageAdd(){}`).

### WF11 — Retrieval (الاسترجاعات)

Legacy (`sort_from.frm`, object `sort_form`): question list (`DBList3` over `bnkout`/`pout`), value box with F8/F9 lookups per field type, اضافة / و / او / ( / ) / الغاء, accumulated question, display-field list (double-click toggles `upd_user_bnkout`, F10 order `upd_user_choi1`, F2 global "#"), category combo + تعليم حقول العرض, نتائـــج البحـث → creates proc `tmp_resultN` → `frm_result`; اغلاق (`:1063-1531, 1640-1715, 2031-2182, 2211-2562`). Messages: "لا يوجد جواب لانه لم تطلب سوال ", "لايمكن اضافة /و/ قبل اختيار السؤال", "لايمكن اضافة سؤال اخر الا بعد اضافة /و/ ,/او/".
Migrated: `/retrieval[?scope]` → `/api/retrieval/*` (all need `PERM_VIEW`, G29). Field catalogue = `retrieval_field` (§0.2); field-by-field parity with legacy cannot be established (B7).

**TC-11.1 Bank retrieval (Ctrl+S not bound — use the menu)**
- Do: الاسترجاعات › الاسترجاع البياني لبنك المعلومات → choose category الوثيقة → field العنوان الرئيسي → value `اختبار` (F8 = starts with / F9 = contains) → اضافة → in حقول العرض mark العنوان الرئيسي and رقم الوارد (double-click / toggle) → نتائج البحث.
- Expect: results page lists `ق000001` with the two columns; open action → `/catalogue/ق000001`.
- Verify per-user marks persisted: `Q "select * from retrieval_user_field"` (keyed by user **name**); log out/in → marks still there.
- Negative: نتائج البحث with no condition → "لا يوجد جواب لانه لم تطلب سوال"; و before any condition → refused; unbalanced ( → "الأقواس غير متطابقة"; no display field → "اختر حقل عرض واحداً على الأقل".
- Combine: condition A و condition B, A أو B, with brackets → check result counts make sense.
- **G6:** press "العودة الى الاسترجاع" → the builder is empty again (legacy kept the question).
- **G10:** results have no F2/F9/copy/print/F6.

**TC-11.2 Category marking** — choose a category → تعليم حقول العرض → all its fields marked (`POST /my-field-state/mark-category`).
**TC-11.3 Hash mark (F2 "#")** — toggles `retrieval_field.hash_marked` for **all users** (global, like legacy `bnkout.out_chioce`). Test only if you can reset it.
**TC-11.4 Additional-files retrieval (Ctrl+E not bound)** — scope ADDITIONAL_FILES (6 fields: اسم الاستمارة, الوظيفة, الموضوع, رمز/اسم الاستمارة المرتبطة, تاريخ). Needs WF3/WF3b data (blocked by B1 otherwise). Rows are `form` records → no open action.
**TC-11.5 Periodicals retrieval (Ctrl+F not bound)** — scope PERIODICALS (5 fields). With your WF5b periodical: اسم الدورية `اختبار` → result row. Arrival fields (`TRANS`) cannot be populated through any shipped legacy screen (B8); migrated LEFT-joins `TRANS` (legacy `tmp_result2` INNER-joined in older builds; current builder LEFT — see workflow map §4.15). مكان الصدور needs B1.
**TC-11.6 Permission** — as a user with permission 0 → every retrieval call 403 (legacy: no restriction) — G29.

### WF12 — Video + audio search and scene ordering (شاشة البحث فيديو + صوتي) — **blocked by B5**

What can be tested without media:
- **TC-12.1** Open → search by كلمة من العناوين `اختبار` → results (`POST /api/archive-search`). Lookup lists: نوع المقالة / نوع الوثيقة (`/api/archive-search/article-types|document-types`), names (positions button per name = legacy F2 `proc_pos`), descriptors, المسؤول عن العمل.
- **TC-12.2** ملاحظات المستفيد (remark) → تسجيل → `POST /api/archive-search/{no}/remark` (legacy `upd_mchd_rmrk` — procedure missing from DDL, so the exact legacy column is unknown).
- **TC-12.3 (needs B5)** play a video row → in / out → إضافة المشهد → scene appears in "طلب مواد من الارشيف"; a scene ≥ 400 s: allowed for `user_start` 0/1, refused for `user_start ≥ 2` ("A scene may not be longer than 400 seconds"); **a user with `user_start` NULL is treated as capped** (`DigitizationService.java:549-554, 628-642`; legacy `USER_INTERFACE1.frm:3528`). Use `testcap` (2) and `testop` (1).
- Verify: `Q "select dmd_no,dmd_ser,dmd_user,dmd_dte,dmd_in,dmd_out,dmd_mch_no,dmd_mch_stock,dmd_desc,dmd_chek,dmd_path from demand order by 1,2"`.
- EDLC / extract / EDL buttons depend on server tools and media — record as not testable locally unless configured.

### WF13 — Video orders queue (الاسترجاعات › طلبيات الفيديو)

Legacy (`new_vdpreview.frm`): user 244 sees everyone (`:1468-1525, 3006-3010`); others only their own; F1/F2 select/unselect (`upd_demand1`), F5 path (only `user_start = 1`, `:2800`), Delete; start/newstart/copy/test; تنفيذ مشهد/الكل (`upd_path`); اضافة / اضافة - كامل المشهد.
Migrated: `/video-orders` → `/api/digitization/demand-queue/*` (`context`: `canSeeAllUsers` only for user number 244, `canOperate` only for `user_start = 1` — `DemandQueueService.java:68-75`).

- **TC-13.1** As `admin`: open → المستخدم filter locked to yourself, **start disabled** (admin has `user_start` NULL — legacy-strict, no admin bypass).
- **TC-13.2** As `test244`: user filter editable (sees all users).
- **TC-13.3** As `testop` (`user_start = 1`): start enabled; F5 opens the path panel (needs CODING `09` level‑2 rows — none exist).
- **TC-13.4** From TC‑9.8 (F6): clip preloaded → اضافة → demand row created → النتيجة lists it; F1/F2 toggle `dmd_chek`; Delete removes it (own rows only).
- **TC-13.5 (needs B5)** test / copy / newstart / start → files produced on the server; completed rows marked done.

### WF14 — Locking and unlocking

Legacy lifecycle (proven): new documents are open (`op_article` sets `mn_trans = 0`); the administrator runs **اقفال الوثائق المفتوحة** (key 891045) → `upd_main_trans1` sets **every** open document to `mn_trans = 1` (`ARCHIVE.frm:278-281`, `DDL:10900`); afterwards `is_trans` blocks تسجيل, الغاء, grid edits in Form6 and every insert/delete in Form2 with "لاتستطيع التعدل او الالغاء ....لان الوثيقة مقفلة." (`bok.bas`); **فتح صلاحية** on one document with key 891045 → `upd_main_trans` (`mn_trans = 0`) (`Form6.frm:3092-3168`).

**TC-14.1 The lock menu item**
- Do: as admin, الترميز › اقفال الوثائق المفتوحة.
- Expect (M): Maintenance tab **فتح قفل الوثائق** listing locked documents (empty now). No "lock" action exists anywhere (G1). Record as **FAIL vs legacy**.

**TC-14.2 Prepare a locked test record — ⚠ INTENTIONAL DATABASE WRITE (not a read-only `Q` query)**

Because the migrated app cannot lock a document (G1/B6), the only way to obtain a locked record is a direct `UPDATE`. This is the **only** database write in this guide. Skip TC‑14.2 to TC‑14.5 (mark them BLOCKED — B6) if you do not want to modify the database.

Before running it, confirm **all** of the following and note the answers in your test log:
1. The backup in §0.1a exists **and passed all three verification checks**.
2. The target is a document **you created in this session** (WF6). Identify it exactly:
   `Q "select \"MN_APP_NO\",\"MN_ACT_TTL\",mn_trans from main where \"MN_APP_NO\"='ق000001'"`
   → exactly **one** row, the title is your `اختبار…` title. If the number differs, replace `ق000001` everywhere below with your number.
3. Record the **original** `mn_trans` value from that row (expected `0` for a record created by سجل جديد; it may also be NULL). You need it to undo the change.

Run (one row only):
`W "update main set mn_trans=1 where \"MN_APP_NO\"='ق000001' and \"MN_ACT_TTL\" like 'اختبار%'"`
→ psql must print `UPDATE 1`. If it prints `UPDATE 0`, nothing changed (check the number/title); if it prints anything greater than 1, restore from the backup (§0.1a) and stop.

Confirm: `Q "select \"MN_APP_NO\",mn_trans from main where \"MN_APP_NO\"='ق000001'"` → `1`.

Undo (to put back the original value without a full restore):
- original `0`: `W "update main set mn_trans=0 where \"MN_APP_NO\"='ق000001'"`
- original NULL: `W "update main set mn_trans=null where \"MN_APP_NO\"='ق000001'"`
→ `UPDATE 1`, then re-run the confirm query. TC‑14.4/14.5 normally unlock it through the application (sets `0`); if the original was NULL and you need an exact baseline, run the NULL undo afterwards. A full restore (§0.1a) also returns it to the original state.

**TC-14.3 Behaviour of a locked record**
- Do: open `ق000001` in استمارة التوثيق and try: (a) الغاء; (b) author add/edit/delete; (c) change the title → تسجيل; (d) add a digital file; (e) التحليل → add a descriptor / geo; (f) on `/catalogue/ق000001` press تعديل → حفظ and حذف.
- Expect (M): (a) "لا تستطيع التعديل او الالغاء ....لان الوثيقة مقفلة." (`documentation-form.component.ts:629-636`); (b) buttons disabled, server also refuses (`DescriptorService.validateNotLocked`); **(c) save succeeds — G4**; **(d) allowed — G4**; **(e) allowed — G4**; (f) 409 → "CATALOGUE.RECORD_LOCKED" message (`CatalogueService.checkTransferLock`).
- Verify (c)/(e) actually changed data with the WF6/WF7 queries.

**TC-14.4 فتح صلاحية**
- Do: as `testop` (non-admin): فتح صلاحية → dialog shows "الوثيقة مقفلة" → type `891045` → OK. Then as `admin`: type `x` → OK.
- Expect (M): non-admin → "كلمة السر خطأ أو لا تملك الصلاحية" even with the correct key; admin → "تم فتح الصلاحية بنجاح" with **any** text (`password-gate-dialog.component.ts:24-27`, `CatalogueService.java:182-193`) — **G3**. Legacy: correct key for any user, wrong key "كلمة السر خطا....؟".
- Verify: `Q "select \"MN_APP_NO\",mn_trans from main where \"MN_APP_NO\"='ق000001'"` → 0.

**TC-14.5 Unlock from Maintenance** — re-lock with the TC‑14.2 `W` update (same confirmation checklist; the backup is still valid), open the فتح قفل الوثائق tab → row listed → فتح القفل → "تم فتح قفل الوثيقة بنجاح"; list refreshes.

### WF15 — Delete / cancel paths (destructive — own test data only, run last)

**TC-15.1 الغاء الاستمارة (cancel a document)**
- Legacy: Frame1 "هل تريد الغاء هذه الاستمارة (ن / ك)" → `del_main`, `del_article`, `del_res`, `del_digit1`, `del_analis2`, `del_geo2`, `del_rel2`, `del_nar2`, `del_fad2` (`Form6.frm:2853-2906`); legacy had **no foreign keys**, so it always succeeded and left `TIME`, `date_subject`, `text1`, `tmp_fileadd`, `result`, `demand` rows orphaned.
- Migrated: deletes `RES, DIGIT, ANALIS, GEO, RELATIVE, NAROWER, FILE_ADD`, then `main`, `ARTICLE` (`ArticleService.java:226-250`).
- **G34:** PostgreSQL has foreign keys to `main` from `date_subject`, `text1`, `"TEXT"`, `demand`, `"SERIES"`, `"ISTARA"`, and `result.res_dig_no → "DIGIT"."DIG_DIG_NO"` [DB]. So cancelling a document that has a date range (TC‑7.6), a text (TC‑7.7), a video order (WF13) or a logged usage request on one of its files (TC‑9.7) **fails with an error** ("حدث خطأ", HTTP 500). Test both: first a fresh record with only header + authors + a file (should succeed), then `ق000001` after WF7/WF9 (expect the error; nothing deleted because the transaction rolls back).
- Verify: `Q "select count(*) from main where \"MN_APP_NO\"='<no>'"` and the child queries.

**TC-15.2 Delete a digital file referenced by a request** — expected error (same FK) — legacy allowed.
**TC-15.3 Delete an author used in RES** — 409 message (FK) — legacy allowed (G15-like).
**TC-15.4 Delete a periodical used by a document** — error (FK) — G15.
**TC-15.5 Delete a thesaurus term used by a document** — `ANALIS/NAROWER/RELATIVE/SUBJECT → MACNZ` FKs → error — legacy allowed.
**TC-15.6 Delete your test users** — `/users` › حذف (admin) → the user's `demand` rows (FK `demand.dmd_user → config`) block deletion if any exist.

### WF16 — Retrieval fields, backup and the unreachable utilities (admin)

- **TC-16.1 ملف بناء الاسترجاعات** — legacy `InputBox` key `a5g5`/`ش5ل5` → `Form4` raw grids over `pout`/`bnkout` (`ARCHIVE.frm:630-642`). Migrated: `/maintenance?tab=fields` (no key, admin only): list of `retrieval_field`, إضافة حقل استرجاع (dialog), edit, delete (`/api/retrieval-fields`, `PERM_ADMIN`). Test: add a field with a test label → appears in the retrieval builder of its module → delete it.
- **TC-16.2 معالجة حقول الاسترجاع** — legacy key 261015 → `CAT_OUTFRM` (categories, display/question order). Migrated: the **same** tab as TC‑16.1. Category editing (`catogorie`) not available — G12.
- **TC-16.3 نسخ قاعدة البيانات** — legacy `BACKUP DATABASE` to `d:\backup\…` with the message "انتهى الاقفال......." (`ARCHIVE.frm:564-569`). Migrated: tab النسخ الاحتياطي → إنشاء نسخة احتياطية → `POST /api/admin/backup`; the list shows the new file (stored at `/app/backups` inside the backend container unless `BACKUP_DIRECTORY` is set — not on a volume, so lost when the container is rebuilt; it is **not** a substitute for the §0.1a backup). Optional; it writes a file but does not change data.
- **TC-16.4 Maintenance-only tabs** (إعادة الترقيم, نسخ إلى الأرشيف, ربط الملفات) — interpretations of the never-opened legacy utilities `correct.frm` / `corect1.frm`; there is no reachable legacy behaviour to compare. إعادة الترقيم rewrites record numbers across tables — **do not run** except on a disposable copy of the database.

### WF17 — Session and navigation regressions

- **TC-17.1** Leave the browser idle > 24 h or delete `access_token` in DevTools → next action → back to login (401).
- **TC-17.2** Reload (F5) on each screen: documentation form → empty (route has no number) unless opened with `?appNo=`; retrieval results → "no query"; thesauri → key asked again.
- **TC-17.3** Browser Back/Forward between screens: state is not preserved (G14).
- **TC-17.4** Trigger G17 deliberately is not recommended; if you are logged out unexpectedly, note the request that returned 401.

---

## 3. Screen-by-screen control and dropdown checklist

Legacy row sources were resolved from the `.frx` binding blocks (the `.frm` stores `Bindings = "X.frx":offset`; the first name at that offset is the bound data control). Migrated sources from component code. "Value" = what is stored; "Shown" = what the user sees.

### 3.1 استمارة التوثيق (Form6 ↔ DocumentationFormComponent)

| Control | Legacy source (`Form6.frm` line → data control → SQL) | Shown → stored | Migrated source | Match? |
|---|---|---|---|---|
| الموثق `m_mn_app_doc` | L518 → `coding2` → `VIEW_CODING2` (`'01'`, `DDL:3850`) | SUB_DESC → `Mid(SUB_CODE,3,2)` → `MN_APP_DOC` | `getCodingByCodePrefix('01')` → `GET /api/lookups/coding?codePrefix=01` → `CodingRepository` `LIKE '01%' ORDER BY SUB_DESC` | Yes (order: legacy unordered view) |
| مدخل البيانات `m_mn_data_en` | L533 → `coding3` → `view_coding3` (`'02'`, ordered by desc) | → `MN_DATA_EN` | prefix `02` | Yes |
| مصدر الوثيقة `m_art_per_no` | L548 → `period1` → `select * from period order by per_per_na` | PER_PER_NA → PER_PER_NO → `ART_PER_NO` | `getAllPeriodicals()` `/api/periodicals/all` (by name) + typing → `/api/periodicals/search?q=` (contains) | Yes (typing: contains) |
| مصدر الترجمة `m_art_per1` | L563 → `period1` | → `ART_PER1` | same | Yes |
| نوع الوثيقة `m_art_sub_ty` | L503 → `coding_typ1` → `VIEW_coding` (`'03'`) | → `ART_SUB_TY` | prefix `03` | Yes |
| اللغة `m_art_lang` | L2129 → `coding34` → `coding where substring(sub_code,1,2)='34'` | → `ART_LANG1` (default `3401`) | prefix `34` (default `01`) | Yes |
| طبيعة الوثيقة `m_mn_typ` | text box (ع/س) | → `MN_TYP` | select ع/س → `mn_doc_nature` | **No — G32** |
| Authors grid name `DBList1` | L21 → `AUTHER` → `SELECT * FROM AUTHER`; F8 → `serh_auther` (prefix) | AUT_NAM → AUT_NO → `RES_RES_NO` | `/api/authors/search?q=&size=10` (contains) | Partial — G31 |
| Authors grid role `DBList2` | L894 → `coding5` → `VIEW_CODING5` (`'04'`) | → `RES_APP_TY` | prefix **`29`** | **No — G2** |
| شكل الوثيقة `DBList4` | L578 → `coding24` → `view_coding24` (`'24'`) | → `DIG_TYP1` | prefix `24` | Yes |
| نوع المادة `DBList6` | L487 → `view_coding29` (`'29'`) | → `dig_typmat` | **all CODING** | **No — G25** |
| نوع الشريط `DBList5` | L631 → `coding26` → `view_coding26` (`'26'`) | → `dig_typchrt` | **all CODING** | **No — G25** |
| مكان التصوير/النشر `DBList12` | L594 → `view_form` → `pay_form`; typing → `serh_allform` (prefix) | SUB_NAME → `sub_cod` (type+no) → `DIG_GEOCHRT` | `searchForms` → `/api/forms?name=` (contains) | Partial |
| Search-by-title list `DBList3` | L788 → `MSRDC1` ← `SERH_main` (prefix, `ق` only) | | `/api/articles?title=` (contains, first match loaded) | Partial |

Buttons/keys checklist: سجل جديد · تسجيل · بحث · الغاء · سابق · لاحق · الاخير · البحث بالعنوان · خروج · فتح صلاحية · التحليل · إضافة مؤلف / edit / delete · إضافة ملف رقمي / edit / delete / open · F5 · F8 · (legacy-only: Enter-save, Esc-save abstract, Space-per-column, Insert/Delete grid keys).

### 3.2 التحليل (Form2 ↔ AnalysisPanelComponent)

| Control | Legacy source | Migrated source | Match? |
|---|---|---|---|
| Descriptor list `DBList1` | `ANALIS` ← `exec ass` (`DDL:5066`) | `GET /api/catalogue/{no}/subjects` | Yes |
| Thesaurus picker `DBList11` | L582 → `macnz` → `select * from macnz`; F8 `serh_macnz`, F9 `serh_wrdmacnz`; level > 2 enforced on insert | `getAllMacnz()` `/api/lookups/subjects` filtered level > 2, prefix/word by radio | Yes (filter applied before picking) |
| Geo / file names `DBList12` | L461 → `view_form` → `pay_form`; F8 `serh_allform`, F9 `serh_wrdform`; F2 positions `proc_pos` | `searchForms` (`/api/forms?name=`, contains, 20/page); no F2 positions | Partial |
| Positions `DBList13` | `position` ← `proc_pos` | — | Missing |
| Relation lists `DBList2–10` | `GEO_PROC`, `NAROWER(1)_PROC`, `RELATIVE(1)_PROC`, `file_add_PROC` | computed client-side from `/geo`, `/narrower`, `/related`, `/files` | Yes (code) |
| رقم العلاقة `Text3` + تقدم/تراجع | `form2.frm:2291-2573` | prevRelative/nextRelative | Yes |
| Time in/out | player + `insr_time1`/`upd_time1` | manual fields → `/time-descriptors` | Partial (G9) |
| من/الى تاريخ | `insr/upd_dte_subject` | `/date-subjects` | Yes |
| النص / البحث عن كلمة (highlight) | `insr/upd_text1`, `del_text2`, HighlightWords | `/text1`; no highlight search | Partial |

### 3.3 Reference screens

| Screen | Control | Legacy source | Migrated source |
|---|---|---|---|
| المكنز الموضوعي | 3 lists | `view_macnz1`/`proc_macnz1`, `proc_macnz` (`Form5.frm` L63/L365/L427) | `/api/subject-thesaurus/terms` |
| المكنز الشكلي | المستوى الاول / الثاني | `cod2` ← `PROC_V_CODING1`; `cod1` ← `coding_proc` (L941/L923) | `/api/form-thesaurus/coding[?prefix]` |
| | الدول | `pays1` → `pay_form` (L1023) | `/api/form-thesaurus/forms` (COUNTRIES) |
| | الاسماء | `name_form1` ← `nam_form` (L18) | `/forms` (NAMES) |
| | المناصب | `position` ← `proc_pos` (L710) | `/positions` |
| | الربط الشكلي / الموضوعي | `rel_form` ← `rel_form_proc` (L406), `subject` ← `subject_proc` (L381) | `/relations/forms`, `/relations/subjects` |
| | picker `DBList8` | `frm_mcnz` (names or MACNZ) | `/forms/find`, `/macnz` |
| المؤلفين | list | `auther` → `select * from auther order by aut_no` (`Form8.frm` L144) | `/api/authors/coding` |
| الصحف والمجلات | مكان الصدور 1/2 | `FORM1` → `pays_form` (type 04, L577/L592) | `searchPaysForm` → `/api/pays-form` |
| | وتيرة الصدور | `CODING12` → `VIEW_CODING12` (L516) — **stored full code into nvarchar(2)** | prefix `12`, stores suffix (G23) |
| | `m_per_typ1` | `CODING13` → `VIEW_CODING13` (L501) | prefix `13` |
| | دار النشر | `auther1` → `auther order by aut_nam` (L192) | `searchAuthors` (contains) |
| | people fields | `view_form` → `pay_form`, typing `serh_allform` | `searchForms` |
| | title search list | `period_t` ← `serh_period1` (prefix) | `/api/periodicals/search?q=` (contains) |
| | اللغة | free text (1 char) | select A/F/E |

### 3.4 Search, requests, retrieval, video

| Screen | Control | Legacy source | Migrated source | Match? |
|---|---|---|---|---|
| شاشة البحث | الموضوع/الاضيق/المترابط | `DBList2` → `macnz` (`serh_macnz`/`serh_wrdmacnz`) | full MACNZ list filtered in browser | Yes |
| | الملف الاضافي/المكان الجغرافي/مكان التصوير | `DBList1` → `view_form` (`serh_allform`/`serh_wrdform`) | `searchForms` | Partial |
| | نوع الوثيقة digital `m_dig_typ1` | L122 → `v_coding24` | prefix `24` | Yes |
| | المسؤول البياني `m_res_no` | L137 → `auther1` (by name) | `searchAuthors` | Yes |
| | نوع الوثيقة `m_art_sub_ty` | L789 → `VIEW_coding` (03) | prefix `03` | Yes |
| | جهة الصدور `m_art_per_no` | L851 → `period1` | periodical autocomplete | Yes |
| | مدخل البيانات `m_mn_data_en` | L1007 → `view_coding3` (02) | prefix `02` | Yes |
| | اللغة `m_art_lang` | L1559 → `coding34` | prefix `34` | Yes |
| | الجهة المستفيدة `m_res_cote` | L306 → `v_coding32` | **free text, label swapped** | **No — G22** |
| | الجهة الموافقة `m_res_permit` | L291 → `v_coding33` | **free text, label swapped** | **No — G22** |
| شاشة الطلبات | الجهة الموافقة / المستفيدة (criteria and panel) | L93/L108/L602/L617 → `v_coding33` / `v_coding32` | prefixes `33` / `32` | Yes |
| | نوع DIGITAL | L632 → `v_coding24` | prefix `24` | Yes |
| الاسترجاع | categories `M_OUT_CAT` | L28 → `VIEW_coding37` | categories from `retrieval_field.category` | Different source |
| | display fields `DBList2` | L108 → `BNKOUT2` → user's `view_user_bnkout`/`view_user_pout` | `/api/retrieval/my-field-state` (`retrieval_user_field`) | Different table |
| | questions `DBList3` | L316 → `bnkout` (`out_if`…) / `pout` | `/api/retrieval/fields?scope=` (`retrieval_field`) | Different table (B7) |
| طلبيات الفيديو | users `DBList1` | `view_form` ← `serh_config` (proc missing) | `/demand-queue/users` | Unprovable |
| | paths `m_view_path` | `view_coding09` → `view_coding14` (`'09'`, level 2) | `/demand-queue/path-options` → `findViewCoding14` | Yes |
| فيديو + صوتي | نوع المقالة `m_mch_typ` | L1126 → `VIEW_coding` (03) | `/api/archive-search/article-types` | check BROWSER? |
| | نوع الوثيقة `m_dig_typ1` | L1199 → `v_coding24` | `/document-types` | check |
| | المسؤول `m_res_no` | L1184 → `auther1` | `/responsible-persons` | check |
| | names / descriptors | `DBList1` `pay_form`, `DBList2` `macnz`, positions `DBList3` | autocompletes + positions button | Yes (code) |
| معالجة المستخدمين | نوع الاستمارة `m_ist_no` | L751 → `VIEW_CODING38` (default `3801`) | — | Missing (G12) |

---

## 4. Screen transitions: legacy vs migrated

| From | Trigger | Legacy (what opens, what is passed, what happens on return) | Migrated | Verified |
|---|---|---|---|---|
| بطاقة الدخول | Enter on password | `ARCHIVE` (menu window); globals `box_user_*` set (`users.frm:174-190, 250-251`) | `/catalogue` list; JWT + `current_user` | L, M |
| Menu | استمارة التوثيق | Form6 empty (`m_form_load = 1`) | `/catalogue/new` | L, M |
| Form6 | التحليل | Form2 **on top**; Form2 reads `Form6.m_mn_app_no`, title, abstract; closing Form2 returns to the same Form6 record (`m_form_load = 1` prevents reload) | `/catalogue/{no}`; Form6 destroyed; back → `/catalogue` | L, M (D6.5) |
| Form6 grid | double-click audio/video | `vd_preview` (modeless) with `v_mch_*` times; in/out writes Form2's TIME rows | download/open file; no player | L, M (G9) |
| Form2 | ملفات اضافية للترميز | `tmp_file` on top; Insert uses `Form2.Text1` | in-page `TempFilesComponent` | L, M |
| المكنز الشكلي | الملفات الاضافية للادخال | `tmp_file` on top | modeless dialog `AdditionalFilesComponent` | L, M |
| tmp_file | double-click / F12 | Form6 on row's document (`m_bk_no`, `m_form_load = 2`) on top | `/catalogue/new?appNo=` (dialog stays?) BROWSER? | L, M |
| المكنز الشكلي | F5 on name | `person_f` / `instit_F` with `m_prsno` | message | L, M (G16) |
| الصحف والمجلات | تسجيل | refreshes Form6's periodical list if Form6 is open | none; form reloads list when opened | L, M |
| sort_form | نتائج البحث | `frm_result` on top, query kept in proc `tmp_resultN`; closing returns to builder with the question intact | `…/results`; back → empty builder | L, M (G6) |
| frm_result | F2 | Form6 on the record (`ق` only) | open action → `/catalogue/{no}` (BANK only) | L, M (G7) |
| frm_result | F6/F7 | `new_vdpreview` with clip | — | L (G10) |
| شاشة البحث | F2 | Form6 on the record (`ق` only) | `/catalogue/{no}` | L, M (G7) |
| شاشة البحث | F6 | `new_vdpreview` with clip (`v_mch_*`), window stays | `/video-orders` with router state; search page destroyed | L, M |
| شاشة البحث / frm_result / f_result / new_vdpreview | طباعة | `form_report` with `jad_print` | `/reports` new tab; requests: CSV | L, M (G19) |
| new_vdpreview | start | `progress` modal | job polling | L, M |
| any screen | خروج / Esc | `Unload` → window underneath (usually the main window) | `/catalogue` | L, M (G14) |
| ARCHIVE | Esc | program ends (`ARCHIVE.frm:387-391`) | nothing | L, M |

---

## 5. Minimum data and permissions per workflow

| WF | Login as | Permission bits needed (migrated) | Data needed | Can start now? |
|---|---|---|---|---|
| WF0 | admin | — | — | Yes |
| WF1 | admin (level A) | ADMIN (admin passes) | — | Yes |
| WF2 | any + key 891045 | none (no `@Permission` on form-thesaurus API) | — | Yes |
| WF3 | any + key | none | **B1** country rows | **No** (B1) |
| WF4 | **user 244** + key | none | WF1 | After WF1 |
| WF3b | any + key | none | WF3, WF4 | After B1 |
| WF5a | any | none (`AuthorCodingController` has no `@Permission`) | — | Yes |
| WF5b | any | CREATE/UPDATE/DELETE for writes | WF2 (12/13 exist), WF3 for places (B1) | Partly (no places) |
| WF6 | user with userEnt/userDoc | CREATE + UPDATE (+ DELETE for cancel) | WF2, WF5a, WF5b | After WF2/5 |
| WF7 | same | CREATE/DELETE on descriptors | WF6, WF4 | After WF6 |
| WF8 | same | CREATE/UPDATE/DELETE | WF7 | After WF7 |
| WF9 | same | none for search; CREATE for logging | WF6–7 with a `DIGIT` row | After WF6 |
| WF10 | 244 and admin | UPDATE / DELETE (+ admin level for cancel) | WF9 | After WF9 |
| WF11 | same | **VIEW** | WF6–7 data | After WF6 |
| WF12 | testop / testcap | CREATE | **B5** | **No** (B5) |
| WF13 | admin, 244, testop | UPDATE | demand rows (WF12 or F6) | Partly |
| WF14 | admin + testop | ADMIN for unlock list | **B6** DB prep | Only with DB prep |
| WF15 | admin | DELETE | own test data | Last |
| WF16 | admin | ADMIN | — | Yes |

How to find suitable existing records instead of creating new ones: use the queries in §0.2. On this database the existing `main` records are numeric leftovers from earlier testing (no `ق` prefix), so they cannot exercise the F2 rule or the `ق` numbering; prefer records you create in WF6.

---

## 6. Behaviour that cannot be established (missing evidence)

| Item | What is missing | Effect on testing |
|---|---|---|
| Legacy retrieval field catalogue | `bnkout`/`pout` rows from the production SQL Server (0 rows here; `bnkout.mdb` holds only an old Access `BNKOUT` schema) | Cannot compare the list of retrieval questions/fields one-to-one (B7) |
| Procedures called but absent from the DDL | `upd_mn_result`, `del_time1`, `serh_text`, `serh_text5`, `upd_user_choi1`, `del_user_bnkout`, `serh_config`, `upd_mchd_rmrk`, `upd_dmd_user_do`, `INSERT_TBL_FILES`, `serh_wrdmacnz3`, `insr/upd/del_instit`, `serh_instit(1)` | Exact legacy effect of: Esc-saves-abstract, descriptor-delete on TIME, F4/F5 texts in results, F10 order mark, user list in video orders, remarks, EDLC file table, institution card |
| Institution table | not in the DDL | `instit_F` cannot be reconstructed |
| Crystal report layouts | `.dsx` compressed; `box_company` value unknown | Print outputs cannot be compared |
| Real reference data | production `CODING`, `MACNZ` (9‑char codes), `form` countries, `ranjpath`, media files | B1, B4, B5; level‑3 thesaurus format |
| Legacy login with NULL `user_start` | VB assigns a NULL column to an `Integer` global (`users.frm:179`) — likely a runtime error, not provable without running VB | Legacy behaviour of users with empty `user_start` unknown; migrated treats NULL as "not operator" and "capped" |
| Duplicate user names | legacy keyed by number; migrated logs in by name (`findByUserName`) | Login result with two equal names not established |
| Legacy periodical frequency | stored value truncated to `12` by `nvarchar(2)` (G23) | Correct expected value is a business decision |

---

## 7. Gap register (to mark while testing)

G1–G20 are from `APPLICATION_WORKFLOW_MAP.md` §9 (re-verified against code for this guide); G21–G34 are new.

| ID | Summary | Exposed by | Evidence |
|---|---|---|---|
| G1 | Lock-all (اقفال الوثائق المفتوحة) not implemented; menu opens unlock list | TC‑14.1 | `ARCHIVE.frm:278-281`; `main-layout.component.ts:53` |
| G2 | Author role list uses CODING 29 instead of 04 | TC‑2.5, TC‑6.4 | `Form6.frx` binding `DBList2 → coding5`; `documentation-form.component.ts:177-186` |
| G3 | فتح صلاحية: any text accepted, admin-only | TC‑14.4 | `password-gate-dialog.component.ts:24-27`; `CatalogueService.java:182-193` |
| G4 | Lock not enforced on save, digital files, analysis | TC‑14.3 | `ArticleService.updateDocumentationForm`; `DescriptorService.java:107-111` |
| G5 | سابق/لاحق limited to first 200, wraps | TC‑6.6 | `documentation-form.service.ts:37-40` |
| G6 | Retrieval question lost on return | TC‑11.1 | `graphical-retrieval.component.ts:87, 461-471` |
| G7 | F2/open goes to analysis page, not the form | TC‑9.5 | `unified-search.component.ts:271-275` |
| G8 | Bulk copy delivers no files | TC‑9.7 | `unified-search.component.ts:192-196` |
| G9 | No media player / video open / player time marks | TC‑6.5, TC‑7.6 | `digital-files-grid.component.ts` header |
| G10 | Retrieval results read-only | TC‑11.1 | `retrieval-results.component.ts:7-16` |
| G11 | Ctrl+C/D/S/E/F not bound | TC‑0.5 | `main-layout.component.ts:186-199` |
| G12 | No ranjpath/F4/F3/category editors | TC‑1.5, 1.6, 16.2 | — |
| G13 | Permission model changed (keys → admin; 244 only in some places) | TC‑1.3, 10.3 | §6.4 of the map |
| G14 | خروج → `/catalogue`; no stacked windows | TC‑6.9, 9.10, 17.3 | — |
| G15 | Periodical delete blocked by FK | TC‑15.4 | `MIG/V1…:975-977` |
| G16 | Person/institution cards (F5) missing | TC‑3.4 | `form-thesaurus.component.ts:489` |
| G17 | IllegalArgumentException → 401 → logout | TC‑17.4 | `GlobalExceptionHandler.java:43-45` |
| G18 | Parallel implementations (tmp_file ×3, two record editors, invented tables) | WF8 | — |
| G19 | Print opens generic reports / CSV | TC‑9.9, 10.5 | — |
| G20 | Enter/Esc auto-save on Form6 not reproduced | TC‑6.3 | `Form6.frm:4050-4093, 4272-4285, 4465-4516` |
| **G21** | Non-admin users only see records matching their own مدخل البيانات/الموثق in navigation and title search | TC‑6.6, 6.7 | `ArticleService.java:57-71`; `ArticleSpecification.java:12-20` |
| **G22** | Search-screen request panel: entity fields are free text and their labels are swapped (cote↔permit) | TC‑9.7 | `unified-search.component.html:226-238`; legacy coordinates `user_inetrface.frm` |
| **G23** | Periodical frequency: legacy truncated to `12`; migrated stores the value | TC‑5b.1 | `PERIOD1.frm:1492`; `DDL:6551` |
| **G24** | Users form shows raw translation keys for 10 labels (incl. user_start) | TC‑1.1 | `ar.json` missing `USERS.*` keys |
| **G25** | نوع المادة / نوع الشريط lists show all CODING instead of 29 / 26 | TC‑6.5 | `Form6.frx` bindings; `digit-record-dialog.component.ts:82-96` |
| **G26** | Subject thesaurus allows first level‑2 child under an empty level‑1 term (legacy crashed) | TC‑4.2 | `subject-thesaurus.component.ts:183-190` |
| **G27** | بحث by unknown number shows no message (legacy "لا يوجد استمارة لهذا الرقم !!!!") | TC‑6.7 | `documentation-form.component.ts:743-752` |
| **G28** | New-number basis: legacy max over all numbers; migrated only `ق######` | TC‑6.2 | `DDL:7229`; `ArticleService.java:123-142` |
| **G29** | Permission bits required where legacy had none (retrieval VIEW, logging CREATE, document CREATE/UPDATE…) | TC‑6.10, 11.6 | controllers' `@Permission` |
| **G30** | Legacy defect: `insr_result` swaps cote/permit for files 2…n; migrated writes correctly | TC‑9.7 | `DDL:6732-6736` |
| **G31** | Author/periodical/name lookups match *contains*; legacy F8 = prefix | TC‑6.4 | `AuthorService.search`; `serh_auther` `DDL:8252` |
| **G32** | طبيعة الوثيقة stored in new `mn_doc_nature`; `MN_TYP` set to `'A'` (legacy stored ع/س in `MN_TYP`) | TC‑6.2, 6.3 | `V6__main_document_nature.sql`; `DDL:10826` |
| **G33** | Request numbers 7 digits (legacy 6) | TC‑9.7 | `DigitizationService.logUsageRequest`; `DDL:7483` |
| **G34** | Cancelling a document fails when it has date ranges, text, video orders or logged requests (FKs; legacy had none) | TC‑15.1, 15.2 | PostgreSQL `pg_constraint` (2026‑10‑11) |

---

## 8. Execution checklist

Tick each line as you complete it in the browser. Write PASS / FAIL / BLOCKED and the gap ID next to it.

**Preparation**
- [ ] Database backup created inside the container and copied out with `docker cp` (§0.1a)
- [ ] Backup verified: `pg_restore -l` lists the core tables, SHA‑256 of host and container copies match, size > 0
- [ ] (Optional) `/media` copied out — the database dump does not include uploaded/generated files
- [ ] Access-key decision noted: subject thesaurus configured `891045` vs requirement `1234` (§0.1b)
- [ ] DevTools Network panel open
- [ ] Baseline queries saved (§0.2)

**WF0 Start and login**
- [ ] TC‑0.1 login page appears
- [ ] TC‑0.2 admin login → `/catalogue`
- [ ] TC‑0.3 empty / wrong password / unknown user
- [ ] TC‑0.4 menu groups and labels
- [ ] TC‑0.5 Ctrl+K, Ctrl+A, Ctrl+B work; Ctrl+C/D/S/E/F do not (G11)
- [ ] TC‑0.6 access key cancel / wrong / right / reload
- [ ] TC‑0.7 language toggle, logout

**WF1 Users**
- [ ] TC‑1.1 form fields (G24 raw labels)
- [ ] TC‑1.2 users 244, 971 (user_start 1), 972 (perm 1), 973 (user_start 2) created; duplicate / no password / 4‑char negatives
- [ ] TC‑1.3 non-admin cannot reach admin screens
- [ ] TC‑1.4 forced password change
- [ ] TC‑1.5 / 1.6 recorded as not migrated (G12)

**WF2 Reference codes**
- [ ] TC‑2.1 level lists inspected
- [ ] TC‑2.2 level‑1 headers 01, 02, 04, 24, 26, 29, 32, 33, 34 (as needed)
- [ ] TC‑2.3 level‑2 values; duplicate code message
- [ ] TC‑2.4 edit / delete own code
- [ ] TC‑2.5 dropdowns filled; role list shows 29 (G2)
- [ ] TC‑2.9 users' userEnt/userDoc set; re-login

**WF3 Names** (if blocked by B1: mark the items below BLOCKED — B1 and continue with WF4, §1.1)
- [ ] TC‑3.1 blocker recorded
- [ ] TC‑3.2 add / search / edit a name
- [ ] TC‑3.3 position
- [ ] TC‑3.4 F5 (G16)

**WF4 Subject thesaurus**
- [ ] TC‑4.1 admin cannot write
- [ ] TC‑4.2 level‑2 and level‑3 terms as 244 (G26)
- [ ] TC‑4.3 search / edit / delete

**WF3b Relations**
- [ ] TC‑3b.1 الربط الشكلي, الربط الموضوعي, dates

**WF5 Authors and periodicals**
- [ ] TC‑5a.1–5a.4 authors
- [ ] TC‑5b.1 periodical added (G23)
- [ ] TC‑5b.2 navigation
- [ ] TC‑5b.3 search by number / title
- [ ] TC‑5b.4 persistence
- [ ] TC‑5b.5 appears in استمارة التوثيق

**WF6 Documentation form**
- [ ] TC‑6.1 empty form, dropdown sources (§3.1)
- [ ] TC‑6.2 سجل جديد → `ق000001` (G28, G32)
- [ ] TC‑6.3 save and reopen (G20, G32)
- [ ] TC‑6.4 authors grid (G2, G31)
- [ ] TC‑6.5 digital file add / open / delete; number expectations (G25, G9)
- [ ] TC‑6.6 navigation (G5, G21)
- [ ] TC‑6.7 search by number / title (G27, G21)
- [ ] TC‑6.8 التحليل
- [ ] TC‑6.9 خروج
- [ ] TC‑6.10 permission negatives (G29)

**WF7 Analysis**
- [ ] TC‑7.1 layout
- [ ] TC‑7.2 descriptor (level > 2 only)
- [ ] TC‑7.3 relations need a descriptor
- [ ] TC‑7.4 overall relations
- [ ] TC‑7.5 relation-specific lists
- [ ] TC‑7.6 time marks and date range (G9)
- [ ] TC‑7.7 text → "يوجد نص" on the form
- [ ] TC‑7.8 delete cascade
- [ ] TC‑7.9 return path (D2.4)

**WF8 Additional files**
- [ ] TC‑8.1 from the analysis page
- [ ] TC‑8.2 from المكنز الشكلي; double-click/F12 opens the form
- [ ] TC‑8.3 طلبات سحب الملفات الاضافية

**WF9 Search**
- [ ] TC‑9.1 no criteria
- [ ] TC‑9.2 each criterion finds and locks
- [ ] TC‑9.3 count
- [ ] TC‑9.4 open file
- [ ] TC‑9.5 F2 (G7)
- [ ] TC‑9.6 F9
- [ ] TC‑9.7 F3 log request (G22, G8, G33, G30)
- [ ] TC‑9.8 F6 → video orders
- [ ] TC‑9.9 print / exit
- [ ] TC‑9.10 state on return (G14)

**WF10 Requests**
- [ ] TC‑10.1 list / filter
- [ ] TC‑10.2 edit
- [ ] TC‑10.3 cancel as 244 refused
- [ ] TC‑10.4 cancel as admin (own request)
- [ ] TC‑10.5 count / CSV / exit
- [ ] TC‑10.6 اضافة does nothing

**WF11 Retrieval**
- [ ] TC‑11.1 bank retrieval + negatives (G6, G10)
- [ ] TC‑11.2 category marking
- [ ] TC‑11.3 hash mark (optional)
- [ ] TC‑11.4 additional-files scope (B1)
- [ ] TC‑11.5 periodicals scope (B8)
- [ ] TC‑11.6 permission 0 → 403 (G29)

**WF12–13 Video**
- [ ] TC‑12.1 search
- [ ] TC‑12.2 remark
- [ ] TC‑12.3 scene add and 400 s rule (B5)
- [ ] TC‑13.1 admin view
- [ ] TC‑13.2 244 view
- [ ] TC‑13.3 operator view
- [ ] TC‑13.4 preload from F6 → add scene → F1/F2/Delete
- [ ] TC‑13.5 production (B5)

**WF14 Locking**
- [ ] TC‑14.1 menu item (G1)
- [ ] TC‑14.2 lock prepared on own record (optional)
- [ ] TC‑14.3 behaviour when locked (G4)
- [ ] TC‑14.4 فتح صلاحية (G3)
- [ ] TC‑14.5 unlock from Maintenance

**WF15 Destructive (own data)**
- [ ] TC‑15.1 cancel fresh record succeeds; cancel analysed/requested record fails (G34)
- [ ] TC‑15.2 delete referenced file fails
- [ ] TC‑15.3 delete referenced author → 409
- [ ] TC‑15.4 delete referenced periodical fails (G15)
- [ ] TC‑15.5 delete referenced thesaurus term fails
- [ ] TC‑15.6 delete test users

**WF16 Admin**
- [ ] TC‑16.1 retrieval field add / edit / delete
- [ ] TC‑16.2 categories (G12)
- [ ] TC‑16.3 backup (optional)
- [ ] TC‑16.4 utilities not run (record only)

**WF17 Session**
- [ ] TC‑17.1 expired token
- [ ] TC‑17.2 reload behaviour
- [ ] TC‑17.3 back/forward
- [ ] TC‑17.4 unexpected logout noted (G17)

**Cleanup**
- [ ] Remove or restore test data (restore the backup, or delete own `اختبار` / `97x` rows in reverse dependency order)

