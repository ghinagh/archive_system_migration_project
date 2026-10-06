import { Component, ElementRef, OnDestroy, OnInit, ViewChild, WritableSignal, inject, signal } from '@angular/core';
import { HttpErrorResponse } from '@angular/common/http';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { MatDialog, MatDialogRef } from '@angular/material/dialog';
import { AdditionalFilesComponent } from '../additional-files/additional-files.component';
import { Observable, firstValueFrom } from 'rxjs';
import { ApiResponse } from '../../../core/models/api-response.model';
import { FormThesaurusAccessService } from '../../../core/services/form-thesaurus-access.service';
import { FormThesaurusService } from '../services/form-thesaurus.service';
import {
  CodingRow, FormQuery, FormRelationRow, FormRow, MacnzQuery, MacnzRow, PositionRow, SubjectRelationRow
} from '../models/form-thesaurus.model';
import { CodingListComponent } from '../coding-list/coding-list.component';

type ListKey = 'l1' | 'l2' | 'countries' | 'names' | 'positions' | 'formRels' | 'subjRels' | 'picker';
/** The five lists coding.frm's command handlers test, in their order (DBList1, DBList2, DataList1, DataList2, DBList5). */
type MainKey = 'l1' | 'l2' | 'countries' | 'names' | 'positions';
type PickerRow = FormRow | MacnzRow;

interface ListState<T> { rows: T[]; selected: number | null; visible: boolean; enabled: boolean; loading: boolean; }
interface MessageBox { text: string; after?: () => void; }
interface InputBox { prompt: string; value: string; }

const list = <T>(visible: boolean, enabled: boolean): WritableSignal<ListState<T>> =>
  signal<ListState<T>>({ rows: [], selected: null, visible, enabled, loading: false });

/** VB Mid(s, start, length) — 1-based; Null/Empty concatenate as "". */
function mid(s: string | null | undefined, start: number, length?: number): string {
  const v = s ?? '';
  return length === undefined ? v.substring(start - 1) : v.substring(start - 1, start - 1 + length);
}
/** VB Trim: blanks only. */
const trim = (s: string | null | undefined) => (s ?? '').replace(/^ +| +$/g, '');
/** VB Val on the relation number box. */
const val = (s: string) => { const m = /^\s*[+-]?\d+/.exec(s); return m ? parseInt(m[0], 10) : 0; };

/**
 * "المكنز الشكلي" — legacy coding.frm, opened from ARCHIVE.frm menu التــرميــز → M2 (Ctrl+B) after the
 * Frame3 key (see formThesaurusAccessGuard).
 *
 * The drill-down chain CODING level 1 → level 2 → (codes "10xx") countries → names → (type "01")
 * positions → form / subject relations keeps coding.frm's own state: which lists are visible and
 * Enabled, mod_typ, typ_serh, typ_list, m_serh, coding_typ and v_typ. Every command acts on the first
 * Enabled list in the legacy order DBList1, DBList2, DataList1, DataList2, DBList5 — including the
 * hidden lists that legacy leaves Enabled — and every list keeps the RecordSource its Refresh re-runs.
 * SendKeys "{up}" after a SetFocus moves the selection up one line (none selected → the first).
 */
@Component({
  standalone: false,
  selector: 'app-form-thesaurus',
  templateUrl: './form-thesaurus.component.html',
  styleUrls: ['./form-thesaurus.component.scss']
})
export class FormThesaurusComponent implements OnInit, OnDestroy {

  private api = inject(FormThesaurusService);
  private access = inject(FormThesaurusAccessService);
  private translate = inject(TranslateService);
  private router = inject(Router);
  private dialog = inject(MatDialog);
  private filesRef: MatDialogRef<AdditionalFilesComponent> | null = null;

  @ViewChild('l1List') l1Ref?: CodingListComponent;
  @ViewChild('l2List') l2Ref?: CodingListComponent;
  @ViewChild('countriesList') countriesRef?: CodingListComponent;
  @ViewChild('namesList') namesRef?: CodingListComponent;
  @ViewChild('positionsList') positionsRef?: CodingListComponent;
  @ViewChild('formRelsList') formRelsRef?: CodingListComponent;
  @ViewChild('subjRelsList') subjRelsRef?: CodingListComponent;
  @ViewChild('pickerList') pickerRef?: CodingListComponent;
  @ViewChild('codeInput') codeInput?: ElementRef<HTMLInputElement>;
  @ViewChild('descInput') descInput?: ElementRef<HTMLInputElement>;
  @ViewChild('searchInput') searchInput?: ElementRef<HTMLInputElement>;
  @ViewChild('startInput') startInput?: ElementRef<HTMLInputElement>;
  @ViewChild('endInput') endInput?: ElementRef<HTMLInputElement>;
  @ViewChild('relInput') relInput?: ElementRef<HTMLInputElement>;
  @ViewChild('saveBtn', { read: ElementRef }) saveBtn?: ElementRef<HTMLButtonElement>;
  @ViewChild('editBtn', { read: ElementRef }) editBtn?: ElementRef<HTMLButtonElement>;
  @ViewChild('deleteBtn', { read: ElementRef }) deleteBtn?: ElementRef<HTMLButtonElement>;
  @ViewChild('msgOkBtn', { read: ElementRef }) msgOkBtn?: ElementRef<HTMLButtonElement>;
  @ViewChild('inputBoxInput') inputBoxInput?: ElementRef<HTMLInputElement>;

  // ─── lists (Visible / Enabled exactly as coding.frm sets them) ───
  l1 = list<CodingRow>(true, true);               // DBList1 / cod2
  l2 = list<CodingRow>(true, false);              // DBList2 / cod1 (Enabled = False at design time)
  countries = list<FormRow>(false, true);         // DataList1 / pays1 "الدول"
  names = list<FormRow>(false, true);             // DataList2 / name_form1 "الاسماء"
  positions = list<PositionRow>(false, true);     // DBList5 / position "المناصب"
  formRels = list<FormRelationRow>(false, true);  // DBList6 / rel_form "الربط الشكاي"
  subjRels = list<SubjectRelationRow>(false, true); // DBList7 / subject "الربط الموضوعي"
  picker = list<PickerRow>(false, true);          // DBList8 / frm_mcnz
  pickerMode = signal<'forms' | 'macnz'>('forms'); // DBList8.ListField sub_name | sub_desc

  // ─── code display boxes Text1 … Text6 ───
  text1 = signal(''); text2 = signal(''); text3 = signal(''); text4 = signal(''); text6 = signal('');
  text3Visible = signal(false); text4Visible = signal(false); text6Visible = signal(false);

  // ─── Shape3 panel: Label6 "معالجات", Label3 "الرمز" + code, Label5 "الشرح" + desc ───
  panelVisible = signal(false);
  codeVisible = signal(false);
  codeEnabled = signal(true);
  codeText = signal('');
  descText = signal('');

  // ─── Text5 search (Label12 "البحث") under DBList8 ───
  searchVisible = signal(false);
  searchText = signal('');

  // ─── Shape1 dates: Label13 "تاريخ البداية" deb_dte, Label14 "تاريخ النهاية" fin_dte ───
  datesVisible = signal(false);
  startDate = signal('');
  endDate = signal('');

  // ─── relation number m_rel with Command8 "تراجع" / Command9 "تقدم" ───
  relNo = signal('01');
  relVisible = signal(false);
  relButtonsVisible = signal(false);

  boxCompany = signal<number | null>(null);
  messageBox = signal<MessageBox | null>(null);
  inputBox = signal<InputBox | null>(null);

  // ─── form-level variables ───
  private modTyp: '0' | '1' | '2' = '0';
  private typSerh = 1;
  private typList: 1 | 2 = 1;
  private mSerh = 1;
  private codingTyp = 2;
  private vTyp = '';
  private seq: Record<string, number> = {};

  // ─── current RecordSources ───
  private l2Prefix = '';
  private countriesQuery: FormQuery = { query: 'COUNTRIES' };
  private namesQuery: FormQuery | null = null;
  private positionsNo = '';
  private relCode = '';
  private pickerQuery: { forms?: FormQuery; macnz?: MacnzQuery } = {};

  async ngOnInit(): Promise<void> {
    // Form_Load: coding_typ = 2; typ_serh = 1; mod_typ = "0"; cod2.sql = "execute proc_v_coding1"
    try {
      const ctx = await firstValueFrom(this.api.context());
      this.boxCompany.set(ctx.data?.boxCompany ?? null);
    } catch (e) {
      this.handleError(e);
      return;
    }
    await Promise.all([this.loadL1(), this.loadCountries(this.countriesQuery)]);
    // The first control in coding.frm's tab order that can take focus is Command4 "الغاء (DELETE)".
    this.afterRender(() => { const el = this.deleteBtn?.nativeElement; if (!el) return false; el.focus(); return true; });
  }

  ngOnDestroy(): void {
    this.filesRef?.close();
    this.access.release();
  }

  // ═══ list labels ═══
  labels = {
    l1: () => this.l1().rows.map(r => r.description),
    l2: () => this.l2().rows.map(r => r.description),
    countries: () => this.countries().rows.map(r => r.name),
    names: () => this.names().rows.map(r => r.name),
    positions: () => this.positions().rows.map(r => r.name),
    formRels: () => this.formRels().rows.map(r => r.name),
    subjRels: () => this.subjRels().rows.map(r => r.description),
    picker: () => this.picker().rows.map(r => this.pickerMode() === 'forms' ? (r as FormRow).name : (r as MacnzRow).description)
  };

  // ═══ Commands (Shape2) ═══

  /** Command1 "اضافة (INSERT)" */
  async add(): Promise<void> {
    this.modTyp = '1';
    this.showPanel(true);
    const active = this.activeMain();
    if (active === 'l1' || active === 'l2') {
      if (this.codingTyp !== 1) this.codingTyp = 1;      // coding.Resultset.AddNew
      this.descText.set(''); this.codeText.set('');
      this.focusInput('code');
    } else if (active === 'countries') {
      this.descText.set(''); this.codeText.set('');
      this.focusInput('code');
    } else if (active === 'names') {
      const sub = trim(this.vTyp) + mid(this.row(this.countries)?.number, 1, 3);
      const special = (sub === '01001' || sub === '04001') && (this.boxCompany() === 1 || this.boxCompany() === 4);
      if (!special) {
        if (this.names().rows.length > 0) {
          // EXECUTE OP_FORM m_sub, today; max_form m_sub → code.Text = max1
          const res = await this.call(this.api.nextNumber(sub));
          if (!res) return;
          this.codeText.set(res.data.code);
        } else {
          const code = sub + '00001';
          this.codeText.set(code);
          // exec insr_form '', Mid(code, 3, 8), Mid(code, 1, 2), today
          if (!await this.call(this.api.insertForm('', mid(code, 3, 8), mid(code, 1, 2)))) return;
        }
        this.codeEnabled.set(false);
        this.descText.set('');
        this.focusInput('desc');
      } else {
        this.codeEnabled.set(true);
        this.codeText.set(''); this.descText.set('');
        this.focusInput('code');
      }
    } else if (active === 'positions') {
      this.descText.set(''); this.codeText.set('');
      this.codeEnabled.set(false);
      this.focusInput('desc');
    }
  }

  /** Command2 "تعديل (F2)" */
  async edit(): Promise<void> {
    this.modTyp = '2';
    const active = this.activeMain();
    if (active === 'l1' || active === 'l2') {
      const row = this.row(active === 'l1' ? this.l1 : this.l2);
      if (!row) return;
      const found = await this.call(this.api.findCoding(row.code ?? ''));
      const f = found?.data?.[0];
      if (!f) return;
      this.descText.set(f.description ?? ''); this.codeText.set(f.code ?? '');
    } else if (active === 'countries' || active === 'names') {
      const row = this.row(active === 'countries' ? this.countries : this.names);
      if (!row) return;
      const found = await this.call(this.api.findForm(row.number ?? '', row.type ?? ''));
      const f = found?.data?.[0];
      if (!f) return;
      // DataList2 keeps the previous desc.Text when sub_name is NULL
      if (active === 'countries' || f.name !== null) this.descText.set(f.name ?? '');
      this.codeText.set((f.type ?? '') + (f.number ?? ''));
    } else if (active === 'positions') {
      const row = this.row(this.positions);
      if (!row) return;
      this.descText.set(row.name ?? ''); this.codeText.set(row.number ?? '');
    }
    this.showPanel(true);
    this.focusInput('desc', true);
  }

  /** Command3 "تسجيل" */
  async save(): Promise<void> {
    if (this.modTyp === '1') {
      this.hidePanel();
      const active = this.activeMain();
      const code = this.codeText();
      const desc = this.descText();
      if (active === 'l1' || active === 'l2') {
        // the pending coding.Resultset.AddNew row: sub_code, sub_desc, sub_leve, Update
        if (this.codingTyp === 1) {
          await this.call(this.api.insertCoding(code, desc, active === 'l1' ? '1' : '2'));
        }
        if (active === 'l1') {
          await this.loadL1();
          this.focusList('l1', true);
        } else {
          await this.loadL2(this.l2Prefix);
          this.focusList('l2', false);
        }
        this.codingTyp = 2;
      } else if (active === 'countries') {
        const typ = this.row(this.countries)?.type ?? '';
        await this.call(this.api.insertForm(desc, code, typ));
        await this.loadCountries(this.countriesQuery);
        await this.call(this.api.addWords(typ + code, desc));       // Call div_word(m_code, m_desc, "2")
        this.focusList('countries', true);
      } else if (active === 'names') {
        const country = this.row(this.countries)?.number;
        const sub = trim(this.vTyp) + mid(country, 1, 3);
        if ((sub === '01001' || sub === '04001') && (this.boxCompany() === 1 || this.boxCompany() === 4)) {
          await this.call(this.api.insertForm(desc, mid(country, 1, 3) + code, trim(this.vTyp)));
        } else {
          await this.call(this.api.updateForm(desc, mid(code, 3, 8), mid(code, 1, 2)));
        }
        await this.reloadNames();
        this.focusList('names', true);
        this.moveSelection('names', +1);                            // SendKeys "{up}" then "{down}"
      } else if (active === 'positions') {
        const person = this.row(this.names);
        await this.call(this.api.insertPosition(desc, (person?.type ?? '') + (person?.number ?? '')));
        await this.loadPositions(this.positionsNo);
        this.codeEnabled.set(true);
        this.focusList('positions', true);
      }
      this.modTyp = '0';
    } else if (this.modTyp === '2') {
      const desc = this.descText();
      const active = this.activeMain();
      let wordCode: string | null = null;   // m_sub_typ + m_sub_no (Empty + Empty = 0 in VB)
      if (active === 'l1' || active === 'l2') {
        const row = this.row(active === 'l1' ? this.l1 : this.l2);
        if (row) await this.call(this.api.updateCoding(row.code ?? '', desc));
        wordCode = '0';
      } else if (active === 'countries' || active === 'names') {
        const row = this.row(active === 'countries' ? this.countries : this.names);
        if (row) await this.call(this.api.updateForm(desc, row.number ?? '', row.type ?? ''));
        wordCode = (row?.type ?? '') + (row?.number ?? '');
      } else if (active === 'positions') {
        const row = this.row(this.positions);
        if (row) await this.call(this.api.updatePosition(desc, row.number ?? '', row.name ?? ''));
        this.codeEnabled.set(true);
      } else if (this.formRels().enabled && this.datesVisible() && this.typList === 1) {
        const row = this.row(this.formRels);
        // rel_form.Refresh runs BEFORE cn.Execute, so the list keeps the old dates until its next refresh
        await this.loadFormRels();
        if (row) {
          await this.call(this.api.updateRelationDates('forms', row.form1 ?? '', row.form2 ?? '', this.relNo(),
            this.startDate() || null, this.endDate() || null));
        }
        this.hideDates();
        this.focusList('formRels', false);
      } else if (this.subjRels().enabled && this.datesVisible() && this.typList === 2) {
        const row = this.row(this.subjRels);
        await this.loadSubjRels();
        if (row) {
          await this.call(this.api.updateRelationDates('subjects', row.form ?? '', row.macnz ?? '', this.relNo(),
            this.startDate() || null, this.endDate() || null));
        }
        this.hideDates();
        this.focusList('subjRels', false);
      }
      // If DataList1.Enabled Or DataList2.Enabled: del_word m_code, '2' then div_word(m_code, m_desc, "2")
      if ((this.countries().enabled || this.names().enabled) && wordCode !== null) {
        await this.call(this.api.replaceWords(wordCode, desc));
      }
      if (active === 'l1') { await this.loadL1(); this.focusList('l1', false); }
      else if (active === 'l2') { await this.loadL2(this.l2Prefix); this.focusList('l2', false); }
      else if (active === 'countries') { await this.loadCountries(this.countriesQuery); this.focusList('countries', false); }
      else if (active === 'names') { await this.reloadNames(); this.focusList('names', false); }
      else if (active === 'positions') { await this.loadPositions(this.positionsNo); this.focusList('positions', false); }
      this.modTyp = '0';
      this.hidePanel();
    }
  }

  /** Command4 "الغاء (DELETE)" — InputBox("هل تريد الغاء المقالة(ن/ك)"), "y" or "ن" deletes. */
  remove(): void {
    this.inputBox.set({ prompt: this.t('FORM_THESAURUS.DELETE_PROMPT'), value: '' });
    this.afterRender(() => { const el = this.inputBoxInput?.nativeElement; if (!el?.isConnected) return false; el.focus(); return true; });
  }

  async confirmInputBox(ok: boolean): Promise<void> {
    const box = this.inputBox();
    this.inputBox.set(null);
    const answer = ok && box ? box.value : '';
    if (answer !== 'y' && answer !== 'ن') return;
    const active = this.activeMain();
    if (active === 'l1' || active === 'l2') {
      const row = this.row(active === 'l1' ? this.l1 : this.l2);
      if (!row) return;
      await this.call(this.api.deleteCoding(row.code ?? ''));
      if (active === 'l1') await this.loadL1(); else await this.loadL2(this.l2Prefix);
      this.focusList(active, true);
    } else if (active === 'countries' || active === 'names') {
      const row = this.row(active === 'countries' ? this.countries : this.names);
      if (!row) return;
      await this.call(this.api.deleteForm(row.number ?? '', row.type ?? ''));
      if (active === 'countries') await this.loadCountries(this.countriesQuery); else await this.reloadNames();
      this.focusList(active, true);
    } else if (active === 'positions') {
      const row = this.row(this.positions);
      if (!row) return;
      await this.call(this.api.deletePosition(row.number ?? '', row.name ?? ''));
      await this.loadPositions(this.positionsNo);
      this.focusList('positions', true);
    } else if (this.formRels().enabled || this.subjRels().enabled) {
      if (this.typList === 1) {
        const row = this.row(this.formRels);
        if (!this.formRels().rows.length || !row) return;
        await this.call(this.api.deleteRelation('forms', row.form1 ?? '', row.form2 ?? '', this.relNo()));
        await this.loadFormRels();
        this.focusList('formRels', true);
      } else {
        const row = this.row(this.subjRels);
        if (!this.subjRels().rows.length || !row) return;
        await this.call(this.api.deleteRelation('subjects', row.form ?? '', row.macnz ?? '', this.relNo()));
        await this.loadSubjRels();
        this.focusList('subjRels', true);
      }
    }
  }

  /** Command5 "بحث" — first click opens desc, the second searches countries (serh_form) or names (serh1_form). */
  async search(): Promise<void> {
    if (this.typSerh === 1) {
      this.showPanel(false);
      this.focusInput('desc');
      this.typSerh = 2;
    } else if (this.typSerh === 2) {
      // Command5 tests DataList1 first, then DataList2 (not DBList1/DBList2)
      if (this.countries().enabled) {
        await this.loadCountries({ query: 'COUNTRY_SEARCH', text: this.descText(), lent: trim(this.descText()).length });
      } else if (this.names().enabled) {
        const cur = this.row(this.names);
        if (cur) this.vTyp = cur.type ?? '';
        await this.loadNames({
          query: 'NAME_SEARCH', type: this.vTyp, country: mid(cur?.number, 1, 3),
          text: this.descText(), lent: trim(this.descText()).length
        });
      }
      this.typSerh = 1;
      this.hidePanel();
    }
  }

  /** Command6 "خروج" — Unload Me. */
  exit(): void {
    this.router.navigate(['/']);
  }

  /**
   * Command7 "الملفات الاضافية للادخال" — tmp_file.Show: a separate modeless window over this screen;
   * a second click only brings the open one back (Show on a loaded form).
   */
  openAdditionalFiles(): void {
    if (this.filesRef) return;
    this.filesRef = this.dialog.open(AdditionalFilesComponent, {
      hasBackdrop: false, width: '1100px', maxWidth: '96vw', autoFocus: false, panelClass: 'additional-files-window'
    });
    this.filesRef.afterClosed().subscribe(() => this.filesRef = null);
  }

  /** Command8 "تراجع" */
  relBack(): void {
    const n = val(this.relNo());
    if (n - 1 > 0) this.setRelNo(n - 1 < 10 ? '0' + (n - 1) : String(n - 1));
  }

  /** Command9 "تقدم" */
  relForward(): void {
    const n = val(this.relNo());
    this.setRelNo(n < 9 ? '0' + (n + 1) : String(n + 1));
  }

  // ═══ list events ═══

  select(key: ListKey, index: number): void {
    const s = this.sig(key);
    const row = s().rows[index];
    if (!row) return;
    s.update(v => ({ ...v, selected: index }));
    this.ref(key)?.scrollToIndex(index);
    // the controls' Click handlers
    switch (key) {
      case 'l1': this.text1.set((row as CodingRow).code ?? ''); break;
      case 'l2': this.text2.set((row as CodingRow).code ?? ''); break;
      case 'countries': this.text3.set(((row as FormRow).type ?? '') + ((row as FormRow).number ?? '')); break;
      case 'names': this.text4.set(((row as FormRow).type ?? '') + ((row as FormRow).number ?? '')); break;
      case 'formRels': this.typList = 1; break;
      case 'subjRels': this.typList = 2; break;
      case 'picker':
        this.text6.set(this.typList === 1
          ? ((row as FormRow).type ?? '') + ((row as FormRow).number ?? '')
          : (row as MacnzRow).code ?? '');
        break;
    }
  }

  async dblClick(key: ListKey, index: number): Promise<void> {
    this.select(key, index);
    switch (key) {
      case 'l1': return this.drillL1(false);
      case 'l2': return this.drillL2(false);
      case 'countries': return this.drillCountry();
      case 'names': return this.drillName();
      case 'positions': return this.openRelations(true);
      case 'formRels': return this.openPicker(1, 'text6', true);
      case 'subjRels': return this.openPicker(2, 'text4', false);   // DBList7_DblClick: Text4, no {up}
      case 'picker': return this.pickerInsert(false);
    }
  }

  async keydown(key: ListKey, e: KeyboardEvent): Promise<void> {
    const k = e.key;
    if (key === 'names') this.descText.set('');   // datalist2_KeyDown: desc.Text = "" on every key
    // KeyDown handlers
    if (k === 'F2' && ['l1', 'l2', 'countries', 'names', 'positions'].includes(key)) { e.preventDefault(); return this.edit(); }
    if (k === 'F2' && key === 'formRels') { e.preventDefault(); return this.openDates(1); }
    if (k === 'F2' && key === 'subjRels') { e.preventDefault(); return this.openDates(2); }
    if (key === 'countries' && k === 'F8') { e.preventDefault(); return this.openSearch(2); }
    if (key === 'names' && ['F9', 'F8', 'F6', 'F7'].includes(k)) {
      e.preventDefault();
      return this.openSearch(({ F9: 3, F8: 2, F6: 4, F7: 5 } as Record<string, number>)[k]);
    }
    if (key === 'names' && k === 'F5') { e.preventDefault(); return this.openPersonForm(); }
    if (key === 'picker' && (k === 'F8' || k === 'F9')) {
      e.preventDefault();
      this.mSerh = k === 'F8' ? 1 : 2;
      this.searchText.set('');
      this.searchVisible.set(true);
      this.focusInput('search');
      return;
    }
    if (k === 'Insert' || k === 'Delete') { e.preventDefault(); return; }   // acted on at key-up
    // KeyPress handlers (Enter = 13, Esc = 27, printable characters)
    const press = k === 'Enter' || k === 'Escape' || k === 'Backspace' || (k.length === 1 && !e.ctrlKey && !e.altKey);
    if (!press) return;
    if (k === 'Enter' || k === 'Escape') e.preventDefault();
    await this.keypress(key, k);
  }

  private async keypress(key: ListKey, k: string): Promise<void> {
    const editKey = k === 'm' || k === '’';   // KeyAscii 109 / 146
    switch (key) {
      case 'l1':
        if (k === 'Enter') await this.drillL1(true);
        return;
      case 'l2':
        if (k === 'Escape') { this.patch('l1', { enabled: true }); this.focusList('l1', false); this.patch('l2', { enabled: false }); }
        else if (k === 'Enter') await this.drillL2(true);
        else if (editKey) await this.edit();
        return;
      case 'countries':
        if (k === 'Escape') {
          this.patch('l2', { enabled: true });
          this.focusList('l2', false);
          this.patch('countries', { visible: false });
          this.text3Visible.set(false);
          await this.loadCountries({ query: 'COUNTRIES' });
        } else if (k === 'Enter') await this.drillCountry();
        else if (editKey) this.editBtn?.nativeElement.focus();   // SendKeys "13" onto the button does nothing
        return;
      case 'names':
        if (k === 'Escape') {
          this.patch('names', { visible: false });
          this.patch('countries', { enabled: true });
          this.focusList('countries', false);
          this.text4Visible.set(false);
        } else if (k === 'Enter') {
          if (this.names().rows.length) await this.drillName();
        } else if (editKey) await this.edit();
        return;
      case 'positions':
        if (k === 'Escape') {
          this.patch('positions', { visible: false });
          this.patch('names', { enabled: true });
          this.focusList('names', false);
        } else if (k === 'Enter') await this.openRelations(true);
        else if (editKey) await this.edit();
        return;
      case 'formRels':
      case 'subjRels':
        if (k === 'Escape') this.closeRelations();
        else if (k === 'Enter') await this.openPicker(key === 'formRels' ? 1 : 2, 'text6', true);
        return;
      case 'picker':
        return this.pickerKeypress(k);
    }
  }

  /** Navigation keys are handled by the list itself; DataList2's KeyDown still clears desc for them. */
  navKeydown(key: ListKey): void {
    if (key === 'names') this.descText.set('');
  }

  async keyup(key: ListKey, e: KeyboardEvent): Promise<void> {
    if (e.key === 'Insert' && ['l1', 'l2', 'countries', 'names', 'positions'].includes(key)) {
      e.preventDefault();
      await this.add();
    } else if (e.key === 'Delete' && key !== 'picker') {
      e.preventDefault();
      this.remove();
    }
  }

  // ═══ drill-down ═══

  /** DBList1 DblClick / Enter: cod1.sql = "execute coding_proc Mid(sub_code, 1, 2)" */
  private async drillL1(up: boolean): Promise<void> {
    const row = this.row(this.l1);
    if (!row) return;
    await this.loadL2(mid(row.code, 1, 2));
    this.patch('l2', { enabled: true });
    this.patch('l1', { enabled: false });
    this.focusList('l2', up);
  }

  /** DBList2 DblClick / Enter: only codes "10xx" open the countries (v_typ = Mid(code, 3, 2)). */
  private async drillL2(up: boolean): Promise<void> {
    const row = this.row(this.l2);
    if (!row || mid(row.code, 1, 2) !== '10') return;
    this.patch('countries', { visible: true });
    this.patch('l2', { enabled: false });
    this.vTyp = mid(row.code, 3, 2);
    this.text3Visible.set(true);
    this.focusList('countries', up);
  }

  /** DataList1 DblClick / Enter: name_form1 = nam_form Trim(v_typ), Mid(sub_no, 1, 3) */
  private async drillCountry(): Promise<void> {
    const row = this.row(this.countries);
    if (!row) return;
    await this.loadNames({ query: 'NAMES', type: trim(this.vTyp), country: mid(row.number, 1, 3) });
    this.patch('names', { visible: true });
    this.patch('countries', { enabled: false });
    this.text4Visible.set(true);
    this.focusList('names', true);
  }

  /** DataList2 DblClick / Enter: type "01" → positions (proc_pos), any other → the relation lists. */
  private async drillName(): Promise<void> {
    const row = this.row(this.names);
    if (!row) return;
    this.patch('names', { enabled: false });
    const code = (row.type ?? '') + (row.number ?? '');
    if (row.type === '01') {
      await this.loadPositions(code);
      this.patch('positions', { visible: true, enabled: true });
      this.focusList('positions', true);
    } else {
      await this.openRelations(false);
    }
  }

  /**
   * The relation lists for the person/organisation selected in DataList2 (DBList5 DblClick/Enter,
   * or DataList2 for a non-"01" type — which does not show تراجع/تقدم).
   */
  private async openRelations(withButtons: boolean): Promise<void> {
    const person = this.row(this.names);
    this.patch('formRels', { visible: true });
    this.patch('subjRels', { visible: true });
    this.relVisible.set(true);
    if (withButtons) this.relButtonsVisible.set(true);
    this.relCode = (person?.type ?? '') + (person?.number ?? '');
    this.relNo.set('01');
    this.patch('positions', { enabled: false });
    await this.loadRelations();
    this.typList = 1;
    this.focusList('formRels', true);
  }

  /** DBList6 / DBList7 KeyPress 27 */
  private closeRelations(): void {
    this.patch('formRels', { visible: false });
    this.patch('subjRels', { visible: false });
    this.relVisible.set(false);
    this.relButtonsVisible.set(false);
    if (this.positions().visible) {
      this.patch('positions', { enabled: true });
      this.focusList('positions', false);
    } else {
      this.patch('positions', { visible: false });
      this.patch('names', { enabled: true });
      this.focusList('names', false);
    }
  }

  /** m_rel_Change: reload both relation lists for the DataList2 row and the typed relation number. */
  setRelNo(value: string): void {
    this.relNo.set(value);
    const person = this.row(this.names);
    this.relCode = (person?.type ?? '') + (person?.number ?? '');
    this.loadRelations();
  }

  onRelKeydown(e: KeyboardEvent): void {
    if (e.key === 'Enter') { e.preventDefault(); this.focusList('formRels', false); }
  }

  // ═══ DBList8 picker ═══

  /** DBList6 → "select * from pay_form" (ListField sub_name); DBList7 → "select * from macnz" (sub_desc). */
  private async openPicker(kind: 1 | 2, codeBox: 'text4' | 'text6', up: boolean): Promise<void> {
    if (kind === 1) {
      this.pickerMode.set('forms');
      await this.loadPicker({ forms: { query: 'COUNTRIES' } });
    } else {
      this.pickerMode.set('macnz');
      await this.loadPicker({ macnz: { query: 'ALL' } });
    }
    this.patch('picker', { visible: true });
    if (codeBox === 'text6') this.text6Visible.set(true); else this.text4Visible.set(true);
    this.typList = kind;
    this.focusList('picker', up);
  }

  /** DBList8 DblClick (fromList = rel_form/subject's current row when the list has rows) or Enter. */
  private async pickerInsert(enterKey: boolean): Promise<void> {
    const pick = this.row(this.picker);
    const person = this.row(this.names);
    const personCode = (person?.type ?? '') + (person?.number ?? '');
    if (!pick) return;
    if (this.typList === 1) {
      const rel = this.row(this.formRels);
      const first = !enterKey && this.formRels().rows.length && rel ? rel.form1 ?? '' : personCode;
      await this.call(this.api.insertRelation('forms', first, (pick as FormRow).code ?? '', this.relNo()));
    } else {
      const rel = this.row(this.subjRels);
      const first = !enterKey && this.subjRels().rows.length && rel ? rel.form ?? '' : personCode;
      await this.call(this.api.insertRelation('subjects', first, (pick as MacnzRow).code ?? '', this.relNo()));
    }
    this.text6Visible.set(false);
    if (!enterKey) await this.closePicker(false);
  }

  /** DBList8_KeyPress: Esc hides it; Enter inserts; after ANY key press the picker closes and the list refreshes. */
  private async pickerKeypress(k: string): Promise<void> {
    if (k === 'Escape') {
      this.patch('picker', { visible: false });
      this.text6Visible.set(false);
    } else if (k === 'Enter') {
      if (this.picker().rows.length) await this.pickerInsert(true);
      else this.showMessage(this.t('FORM_THESAURUS.MSG_EMPTY_LIST'));
    }
    await this.closePicker(true);
  }

  private async closePicker(up: boolean): Promise<void> {
    this.patch('picker', { visible: false });
    await (this.typList === 1 ? this.loadFormRels() : this.loadSubjRels());
    this.focusList(this.typList === 1 ? 'formRels' : 'subjRels', up);
  }

  /** Text5_KeyPress Enter: serh_allform / serh_macnz (F8) or serh_wrdform / serh_wrdmacnz (F9). */
  async onSearchKeydown(e: KeyboardEvent): Promise<void> {
    if (e.key !== 'Enter') return;
    e.preventDefault();
    const text = this.searchText();
    const lent = trim(text).length;
    if (this.typList === 1) {
      await this.loadPicker({ forms: { query: this.mSerh === 1 ? 'ALL_SEARCH' : 'LIKE_SEARCH', text, lent } });
    } else {
      await this.loadPicker({ macnz: { query: this.mSerh === 1 ? 'PREFIX' : 'WORD', text, lent } });
    }
    this.focusList('picker', true);
    this.searchVisible.set(false);
  }

  // ═══ dates (Shape1) ═══

  /** DBList6 F2 (mod_typ = 2 only) / DBList7 F2 (typ_list = 2, mod_typ = 2): dates of the current row. */
  private openDates(kind: 1 | 2): void {
    if (kind === 2) this.typList = 2;
    this.modTyp = '2';
    const row = kind === 1 ? this.row(this.formRels) : this.row(this.subjRels);
    if (!row) return;
    this.startDate.set(row.start ? row.start.substring(0, 10) : '');
    this.endDate.set(row.end ? row.end.substring(0, 10) : '');
    this.datesVisible.set(true);
    this.focusInput('start');
  }

  onStartKeydown(e: KeyboardEvent): void {
    if (e.key === 'Enter') { e.preventDefault(); this.focusInput('end'); }
    else if (e.key === 'Escape') { e.preventDefault(); this.hideDates(); this.focusList(this.typList === 1 ? 'formRels' : 'subjRels', false); }
  }

  onEndKeydown(e: KeyboardEvent): void {
    if (e.key === 'Enter') { e.preventDefault(); this.saveBtn?.nativeElement.focus(); }
    else if (e.key === 'Escape') { e.preventDefault(); this.hideDates(); this.focusList(this.typList === 1 ? 'formRels' : 'subjRels', false); }
  }

  private hideDates(): void {
    this.datesVisible.set(false);
  }

  // ═══ code / desc boxes ═══

  /** code_KeyPress */
  async onCodeKeydown(e: KeyboardEvent): Promise<void> {
    if (e.key === 'Escape') {
      e.preventDefault();
      this.escapePanel();
    } else if (e.key === 'Enter') {
      e.preventDefault();
      if (this.modTyp !== '1') return;
      const active = this.activeMain();
      let found: FormRow[] | CodingRow[] | undefined;
      if (active === 'l1' || active === 'l2') {
        found = (await this.call(this.api.findCoding(this.codeText())))?.data;
      } else if (active === 'countries') {
        found = (await this.call(this.api.findForm(this.codeText(), this.row(this.countries)?.type ?? '')))?.data;
      } else if (active === 'names') {
        const typ = mid(this.row(this.l2)?.code, 3, 2);
        const no = mid(this.row(this.countries)?.number, 1, 3) + this.codeText();
        found = (await this.call(this.api.findForm(no, typ)))?.data;
      } else {
        return;
      }
      if (found && found.length) {
        this.showMessage(this.t('FORM_THESAURUS.MSG_NUMBER_TAKEN'), () => this.focusInput('code'));
      } else {
        this.focusInput('desc');
      }
    }
  }

  /** desc_KeyPress */
  async onDescKeydown(e: KeyboardEvent): Promise<void> {
    if (e.key === 'Escape') {
      e.preventDefault();
      this.escapePanel();
      return;
    }
    if (e.key !== 'Enter') return;
    e.preventDefault();
    const desc = this.descText();
    const country = this.row(this.countries);
    if (this.typSerh === 2) {
      if (this.countries().enabled) {
        await this.loadCountries({ query: 'COUNTRY_SEARCH', text: desc, lent: trim(desc).length });
        this.focusList('countries', true);
      } else if (this.names().enabled) {
        this.vTyp = mid(this.row(this.l2)?.code, 3, 2);
        await this.loadNames({ query: 'NAME_SEARCH', type: this.vTyp, country: mid(country?.number, 1, 3), text: desc, lent: trim(desc).length });
        this.focusList('names', true);
      }
      this.typSerh = 1;
      this.hidePanel();
    } else if (this.typSerh === 1) {
      if (this.names().enabled && this.names().visible && this.modTyp === '1') {
        // duplicate-name check: serh1_form v_typ, v_cod, Trim(desc) + Space(60 - len), 60
        this.vTyp = mid(this.row(this.l2)?.code, 3, 2);
        const vCod = mid(country?.number, 1, 3);
        const t = trim(desc);
        const padded = t.length <= 60 ? t + ' '.repeat(60 - t.length) : t;   // Space(<0) fails → unpadded
        const dup = (await this.call(this.api.forms({ query: 'NAME_SEARCH', type: this.vTyp, country: vCod, text: padded, lent: 60 })))?.data ?? [];
        const after = async () => {
          await this.loadNames({ query: 'NAMES', type: trim(this.vTyp), country: vCod });
        };
        if (dup.length) {
          this.showMessage(this.t('FORM_THESAURUS.MSG_NAME_EXISTS'), () => this.focusInput('desc'));
        } else {
          this.saveBtn?.nativeElement.focus();
        }
        await after();
      } else {
        this.saveBtn?.nativeElement.focus();
      }
    } else if (this.typSerh === 3) {
      this.vTyp = mid(this.row(this.l2)?.code, 3, 2);
      const pays = this.vTyp + mid(country?.number, 1, 3);
      await this.loadNames({ query: 'WORD_SEARCH', text: desc, lent: trim(desc).length, pays });
      this.focusList('names', true);
      this.typSerh = 1;
      this.hidePanel();
    } else if (this.typSerh === 4) {
      // serh_allform — typ_serh is not reset and the panel stays open
      await this.loadNames({ query: 'ALL_SEARCH', text: desc, lent: trim(desc).length });
      this.focusList('names', true);
    } else if (this.typSerh === 5) {
      await this.loadNames({ query: 'LIKE_SEARCH', text: desc, lent: trim(desc).length });
      this.focusList('names', true);
    }
  }

  /** F8 on DataList1; F9/F8/F6/F7 on DataList2: the panel opens on an empty desc with typ_serh 3/2/4/5. */
  private openSearch(type: number): void {
    this.showPanel(false);
    this.descText.set('');
    this.focusInput('desc');
    this.typSerh = type;
  }

  /** DataList2 F5: person_f (type "01") / instit_F (type "03") with m_prsno = sub_typ & sub_no. */
  private openPersonForm(): void {
    const row = this.row(this.names);
    if (!row) return;
    if (row.type === '01') this.showMessage(this.t('FORM_THESAURUS.MSG_PERSON_FORM'));
    else if (row.type === '03') this.showMessage(this.t('FORM_THESAURUS.MSG_INSTITUTION_FORM'));
  }

  /** Esc in code/desc: hide Shape3 and its labels, focus the active list, SendKeys "{up}". */
  private escapePanel(): void {
    this.hidePanel();
    const active = this.activeMain();
    if (active) this.focusList(active, true);
  }

  // ═══ message boxes ═══

  closeMessage(): void {
    const box = this.messageBox();
    this.messageBox.set(null);
    box?.after?.();
  }

  onInputBoxKeydown(e: KeyboardEvent): void {
    if (e.key === 'Enter') { e.preventDefault(); this.confirmInputBox(true); }
    else if (e.key === 'Escape') { e.preventDefault(); this.confirmInputBox(false); }
  }

  // ═══ internals ═══

  /** The first Enabled list in coding.frm's order: DBList1, DBList2, DataList1, DataList2, DBList5. */
  activeMain(): MainKey | null {
    if (this.l1().enabled) return 'l1';
    if (this.l2().enabled) return 'l2';
    if (this.countries().enabled) return 'countries';
    if (this.names().enabled) return 'names';
    if (this.positions().enabled) return 'positions';
    return null;
  }

  /** Shape3 + Label6 + Label3 + Label5 + desc (and code when withCode). */
  private showPanel(withCode: boolean): void {
    this.panelVisible.set(true);
    if (withCode) this.codeVisible.set(true);
  }

  private hidePanel(): void {
    this.panelVisible.set(false);
    this.codeVisible.set(false);
  }

  private sig(key: ListKey): WritableSignal<ListState<any>> {
    return this[key] as WritableSignal<ListState<any>>;
  }

  private patch(key: ListKey, p: Partial<ListState<unknown>>): void {
    this.sig(key).update(v => ({ ...v, ...p }));
  }

  private row<T>(s: WritableSignal<ListState<T>>): T | null {
    const v = s();
    return v.selected === null ? null : v.rows[v.selected] ?? null;
  }

  private ref(key: ListKey): CodingListComponent | undefined {
    return ({
      l1: this.l1Ref, l2: this.l2Ref, countries: this.countriesRef, names: this.namesRef, positions: this.positionsRef,
      formRels: this.formRelsRef, subjRels: this.subjRelsRef, picker: this.pickerRef
    } as Record<ListKey, CodingListComponent | undefined>)[key];
  }

  /** ListN.SetFocus (+ SendKeys "{up}"). */
  private focusList(key: ListKey, up: boolean): void {
    if (up) this.moveSelection(key, -1);
    this.afterRender(() => {
      const el = this.ref(key)?.listBox?.nativeElement;
      if (!el || !el.isConnected || el.getAttribute('aria-disabled') === 'true') return false;
      el.focus();
      return true;
    });
  }

  /**
   * Run a focus action once the element it needs has been rendered: a control made Visible in the
   * same handler only exists after change detection, so retry on the next frames (≈ 1 s at most).
   */
  private afterRender(action: () => boolean, attempt = 0): void {
    const run = () => { if (!action() && attempt < 60) this.afterRender(action, attempt + 1); };
    if (attempt === 0) setTimeout(run); else requestAnimationFrame(run);
  }

  /** SendKeys "{up}" / "{down}" — with nothing selected the first line becomes selected. */
  private moveSelection(key: ListKey, step: -1 | 1): void {
    const s = this.sig(key)();
    if (!s.rows.length) return;
    const next = s.selected === null ? 0 : Math.min(s.rows.length - 1, Math.max(0, s.selected + step));
    this.select(key, next);
  }

  /** control.SetFocus — the @ViewChild is read when the element exists (it may be created by this handler). */
  private focusInput(which: 'code' | 'desc' | 'search' | 'start' | 'end', caretEnd = false): void {
    this.afterRender(() => {
      const el = ({ code: this.codeInput, desc: this.descInput, search: this.searchInput, start: this.startInput,
        end: this.endInput } as Record<string, ElementRef<HTMLInputElement> | undefined>)[which]?.nativeElement;
      if (!el || !el.isConnected || el.disabled) return false;
      el.focus();
      if (caretEnd) el.setSelectionRange(el.value.length, el.value.length);   // SendKeys "{end}"
      return true;
    });
  }

  // ─── loaders (RecordSource + Refresh) ───

  private async load<T>(key: ListKey, obs: Observable<ApiResponse<T[]>>): Promise<void> {
    const s = this.sig(key);
    const n = (this.seq[key] = (this.seq[key] ?? 0) + 1);
    s.update(v => ({ ...v, loading: true }));
    try {
      const res = await firstValueFrom(obs);
      if (n !== this.seq[key]) return;
      s.update(v => ({ ...v, rows: res.data ?? [], selected: null, loading: false }));
    } catch (e) {
      if (n !== this.seq[key]) return;
      s.update(v => ({ ...v, loading: false }));
      this.handleError(e);
    }
  }

  private loadL1(): Promise<void> {
    return this.load('l1', this.api.codingLevelOne());
  }

  private loadL2(prefix: string): Promise<void> {
    this.l2Prefix = prefix;
    return this.load('l2', this.api.codingChildren(prefix));
  }

  private loadCountries(q: FormQuery): Promise<void> {
    this.countriesQuery = q;
    return this.load('countries', this.api.forms(q));
  }

  private loadNames(q: FormQuery): Promise<void> {
    this.namesQuery = q;
    return this.load('names', this.api.forms(q));
  }

  private reloadNames(): Promise<void> {
    return this.namesQuery ? this.load('names', this.api.forms(this.namesQuery)) : Promise.resolve();
  }

  private loadPositions(no: string): Promise<void> {
    this.positionsNo = no;
    return this.load('positions', this.api.positions(no));
  }

  /** m_rel_Change / opening: rel_form.Refresh and SUBJECT.Refresh. */
  private loadRelations(): Promise<void> {
    return Promise.all([this.loadFormRels(), this.loadSubjRels()]).then(() => undefined);
  }

  private loadFormRels(): Promise<void> {
    return this.load('formRels', this.api.formRelations(this.relCode, this.relNo()));
  }

  private loadSubjRels(): Promise<void> {
    return this.load('subjRels', this.api.subjectRelations(this.relCode, this.relNo()));
  }

  private loadPicker(q: { forms?: FormQuery; macnz?: MacnzQuery }): Promise<void> {
    this.pickerQuery = q;
    return q.forms
      ? this.load('picker', this.api.forms(q.forms))
      : this.load('picker', this.api.macnz(q.macnz!));
  }

  /** One statement; a failure is shown (legacy would have raised a VB error) and returns null. */
  private async call<T>(obs: Observable<ApiResponse<T>>): Promise<ApiResponse<T> | null> {
    try {
      return await firstValueFrom(obs);
    } catch (e) {
      this.handleError(e);
      return null;
    }
  }

  private showMessage(text: string, after?: () => void): void {
    this.messageBox.set({ text, after });
    this.afterRender(() => { const el = this.msgOkBtn?.nativeElement; if (!el?.isConnected) return false; el.focus(); return true; });
  }

  /** A 403 for a missing/expired key grant closes the screen like Unload. */
  private handleError(error: unknown): void {
    if (error instanceof HttpErrorResponse && error.status === 403
      && (!this.access.hasAccess() || /كلمة السر/.test(error.error?.message ?? ''))) {
      this.router.navigate(['/']);
      return;
    }
    const message = error instanceof HttpErrorResponse ? error.error?.message : null;
    this.showMessage(message || this.t('APP.ERROR'));
  }

  t(key: string): string {
    return this.translate.instant(key);
  }
}
