import { Component, ElementRef, OnDestroy, OnInit, ViewChild, inject, signal } from '@angular/core';
import { HttpErrorResponse } from '@angular/common/http';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { Observable, firstValueFrom } from 'rxjs';
import { ConfigUsersService } from '../services/config-users.service';
import { ConfigUsersAccessService } from '../../../core/services/config-users-access.service';
import { ConfigRow, FieldRow, FormType, RangeRow } from '../models/config-users.model';
import { LegacyGridColumn, LegacyGridComponent, LegacyGridWriter } from '../legacy-grid/legacy-grid.component';

interface MessageBox { text: string; }
interface InputBox { prompt: string; value: string; resolve: (answer: string) => void; }
/** VB twips → CSS px (15 twips per px), scaled for the larger web font. */
const px = (twips: number) => Math.round(twips / 15 * 1.25);

/** t_bnkout.RecordSource: Form_Load's view, or the proc of the last double-clicked user. */
type FieldsSource = { all: true } | { all: false; userNo: string; formType: string };

/**
 * " معالجة المستخدمين" — legacy config_users.frm, opened from ARCHIVE.frm m31 after the Frame3 key 261015.
 *
 * No buttons: Label1 "نوع الاستمارة" with the m_ist_no DataCombo (VIEW_CODING38, Form_Load BoundText
 * "3801"); DataGrid1 on config (all columns editable, add, delete) — DblClick shows the user's
 * display fields in DataGrid3, F4 creates them, F3 deletes them; DataGrid3 on the display fields;
 * DataGrid2 on ranjpath (Insert requeries).
 */
@Component({
  standalone: false,
  selector: 'app-config-users',
  templateUrl: './config-users.component.html',
  styleUrls: ['./config-users.component.scss']
})
export class ConfigUsersComponent implements OnInit, OnDestroy {

  private api = inject(ConfigUsersService);
  private access = inject(ConfigUsersAccessService);
  private router = inject(Router);
  private translate = inject(TranslateService);

  @ViewChild('grid1') grid1?: LegacyGridComponent;
  @ViewChild('grid3') grid3?: LegacyGridComponent;
  @ViewChild('grid2') grid2?: LegacyGridComponent;
  @ViewChild('inputBoxField') inputBoxField?: ElementRef<HTMLInputElement>;
  @ViewChild('msgOkBtn') msgOkBtn?: ElementRef<HTMLButtonElement>;

  /** DataGrid1 Column00 … Column09: DataField = Caption; widths = Split0 ColumnWidth (Column02 has none: default). */
  readonly userColumns: LegacyGridColumn[] = ([
    ['user_no', 615], ['user_name', 1740], ['user_password', 1500], ['user_cnf_path', 3000], ['user_start', 915],
    ['USER_PWD', 945], ['user_cmpvd', 1740], ['user_video_path', 3000], ['user_company', 1050], ['user_video_path1', 3000]
  ] as [string, number][]).map(([k, w]) => ({ key: k, label: k, width: px(w) }));

  /** DataGrid3 (t_bnkout): user_no and المتسلسل Locked. */
  readonly fieldColumns: LegacyGridColumn[] = [
    { key: 'user_no', label: 'user_no', locked: true, width: px(1005) },
    { key: 'user_out_num', label: 'المتسلسل', locked: true, width: px(1020) },
    { key: 'user_out_desc', label: 'اسم الحقل ', locked: true, width: px(3000) },
    { key: 'user_out_choice', label: 'الاختيار', width: px(1200) },
    { key: 'user_out_index', label: 'الترتيب', width: px(1095) }
  ];

  /** DataGrid2 (ranj): rjp_no is Visible = False. */
  readonly rangeColumns: LegacyGridColumn[] = [
    { key: 'rjp_nofrom', label: 'من رقم video', width: px(1500) },
    { key: 'rjp_noto', label: 'الى رقم video', width: px(1500) },
    { key: 'rjp_path', label: 'المسار', width: px(4005) },
    { key: 'rjp_typ', label: 'نوع المسارات', width: px(915) }
  ];

  formTypes = signal<FormType[]>([]);
  formTypesLoaded = signal(false);
  formType = signal('3801');            // Form_Load: m_ist_no.BoundText = "3801"
  users = signal<ConfigRow[]>([]);
  fields = signal<FieldRow[]>([]);
  ranges = signal<RangeRow[]>([]);
  loading = signal({ users: false, fields: false, ranges: false });
  messageBox = signal<MessageBox | null>(null);
  inputBox = signal<InputBox | null>(null);
  private fieldsSource: FieldsSource = { all: true };
  /** Only the latest request of each grid may fill it (an older, slower response is dropped). */
  private seq = { users: 0, fields: 0, ranges: 0 };

  readonly userWriter: LegacyGridWriter = {
    update: (row, column, text) => this.write(() => this.api.updateUser(this.users()[row], column, text), () => this.loadUsers()),
    insert: values => this.write(() => this.api.insertUser(values), () => this.loadUsers()),
    remove: row => this.write(() => this.api.deleteUser(this.users()[row]), () => this.loadUsers())
  };

  readonly fieldWriter: LegacyGridWriter = {
    update: (row, column, text) => this.write(() => this.api.updateField(this.fields()[row], column, text), () => this.loadFields())
  };

  readonly rangeWriter: LegacyGridWriter = {
    update: (row, column, text) => this.write(() => this.api.updateRange(this.ranges()[row].rjpNo, column, text), () => this.loadRanges()),
    insert: values => this.write(() => this.api.insertRange(values), () => this.loadRanges()),
    remove: row => this.write(() => this.api.deleteRange(this.ranges()[row].rjpNo), () => this.loadRanges())
  };

  ngOnInit(): void {
    this.api.formTypes().subscribe({
      next: r => { this.formTypes.set(r.data ?? []); this.formTypesLoaded.set(true); },
      error: e => this.handleError(e)
    });
    this.loadUsers();
    this.loadFields();
    this.loadRanges();
  }

  ngOnDestroy(): void {
    this.access.release();
  }

  /** Window close (Unload config_users). */
  close(): void {
    this.router.navigate(['/']);
  }

  /** The text the DataCombo shows for its BoundText (blank when the code is not in VIEW_CODING38). */
  formTypeKnown(): boolean {
    return this.formTypes().some(f => f.code === this.formType());
  }

  // ═══ rows shaped as the grids' DataFields ═══

  fieldRows(): Record<string, unknown>[] {
    return this.fields().map(f => ({
      user_no: f.userNo, user_out_num: f.outNum, user_out_desc: f.outDesc,
      user_out_choice: f.outChoice, user_out_index: f.outIndex
    }));
  }

  rangeRows(): Record<string, unknown>[] {
    return this.ranges().map(r => ({ rjp_nofrom: r.rjpNofrom, rjp_noto: r.rjpNoto, rjp_path: r.rjpPath, rjp_typ: r.rjpTyp }));
  }

  // ═══ DataGrid1 events ═══

  /**
   * datagrid1_DblClick: m_user_no = DataGrid1.Columns(0) (the current record) and the form type selected
   * now — proc_user_bnkout when Mid(m_ist_no.BoundText, 3, 2) = "01", else proc_user_pout.
   */
  onUserDblClick(): void {
    const userNo = this.grid1?.currentValue('user_no');
    if (userNo === null || userNo === undefined) return;
    this.fieldsSource = { all: false, userNo, formType: this.formType() };
    this.loadFields();
  }

  /** DataGrid1_KeyUp: F4 creates the user's display fields, F3 deletes them. */
  async onUserKeyup(e: KeyboardEvent): Promise<void> {
    if (e.key !== 'F4' && e.key !== 'F3') return;
    e.preventDefault();
    const userNo = this.grid1?.currentValue('user_no');
    if (userNo === null || userNo === undefined) return;
    if (e.key === 'F4') {
      await this.write(() => this.api.createFields(userNo, this.formType()), () => this.loadFields());
    } else {
      const ok = await this.ask(this.t('CONFIG_USERS.ASK_DELETE_FIELDS'));
      if (ok === 'y' || ok === 'ن') {
        await this.write(() => this.api.deleteFields(userNo, this.formType()), () => this.loadFields());
      }
    }
  }

  onUserKeydown(e: KeyboardEvent): void {
    if (e.key === 'F3' || e.key === 'F4') e.preventDefault();
  }

  /** DataGrid2_KeyDown Insert: ranj.Refresh */
  onRangeKeydown(e: KeyboardEvent): void {
    if (e.key === 'Insert') {
      e.preventDefault();
      this.loadRanges();
    }
  }

  // ═══ loading ═══

  async loadUsers(): Promise<void> {
    const n = ++this.seq.users;
    this.setLoading('users', true);
    try {
      const res = await firstValueFrom(this.api.users());
      if (n !== this.seq.users) return;
      this.users.set(res.data ?? []);
      this.grid1?.keepCurrent();
    } catch (e) {
      this.handleError(e);
    } finally {
      if (n === this.seq.users) this.setLoading('users', false);
    }
  }

  /** t_bnkout.Refresh — re-runs the current RecordSource. */
  async loadFields(): Promise<void> {
    const n = ++this.seq.fields;
    this.setLoading('fields', true);
    try {
      const s = this.fieldsSource;
      const res = await firstValueFrom(s.all ? this.api.allFields() : this.api.userFields(s.userNo, s.formType));
      if (n !== this.seq.fields) return;
      this.fields.set(res.data ?? []);
      this.grid3?.keepCurrent();
    } catch (e) {
      this.handleError(e);
    } finally {
      if (n === this.seq.fields) this.setLoading('fields', false);
    }
  }

  async loadRanges(): Promise<void> {
    const n = ++this.seq.ranges;
    this.setLoading('ranges', true);
    try {
      const res = await firstValueFrom(this.api.ranges());
      if (n !== this.seq.ranges) return;
      this.ranges.set(res.data ?? []);
      this.grid2?.keepCurrent();
    } catch (e) {
      this.handleError(e);
    } finally {
      if (n === this.seq.ranges) this.setLoading('ranges', false);
    }
  }

  // ═══ InputBox / MsgBox ═══

  private ask(prompt: string): Promise<string> {
    return new Promise(resolve => {
      this.inputBox.set({ prompt, value: '', resolve });
      this.focusLater(() => this.inputBoxField?.nativeElement);
    });
  }

  answer(ok: boolean): void {
    const box = this.inputBox();
    this.inputBox.set(null);
    box?.resolve(ok ? box.value : '');      // Cancel returns ""
    this.grid1?.focus();
  }

  closeMessage(): void {
    this.messageBox.set(null);
  }

  // ═══ internals ═══

  private async write(action: () => Observable<unknown>, reload: () => Promise<void>): Promise<boolean> {
    let ok = true;
    try {
      await firstValueFrom(action());
    } catch (e) {
      this.handleError(e);
      ok = false;
    }
    await reload();
    return ok;
  }

  private setLoading(which: 'users' | 'fields' | 'ranges', value: boolean): void {
    this.loading.set({ ...this.loading(), [which]: value });
  }

  private handleError(err: unknown): void {
    const message = err instanceof HttpErrorResponse ? err.error?.message : null;
    this.messageBox.set({ text: message || this.t('APP.ERROR') });
    this.focusLater(() => this.msgOkBtn?.nativeElement);
  }

  private focusLater(el: () => HTMLElement | undefined): void {
    const tryFocus = (n: number) => {
      const e = el();
      if (e?.isConnected) e.focus(); else if (n < 30) requestAnimationFrame(() => tryFocus(n + 1));
    };
    setTimeout(() => tryFocus(0));
  }

  private t(key: string): string {
    return this.translate.instant(key);
  }
}
