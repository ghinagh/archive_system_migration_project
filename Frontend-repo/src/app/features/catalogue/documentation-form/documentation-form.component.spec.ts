import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpErrorResponse, provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';
import { importProvidersFrom } from '@angular/core';
import { provideRouter } from '@angular/router';
import { provideNoopAnimations } from '@angular/platform-browser/animations';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateModule, TranslateService } from '@ngx-translate/core';
import { of, throwError } from 'rxjs';
import { vi } from 'vitest';
// @ts-ignore — JSON import without resolveJsonModule; the test bundler loads JSON natively.
import ar from '../../../../../public/assets/i18n/ar.json';
import { CatalogueModule } from '../catalogue.module';
import { DocumentationFormComponent } from './documentation-form.component';
import { DocumentationFormService } from '../services/documentation-form.service';
import { CatalogueService } from '../services/catalogue.service';
import { AutocompleteService } from '../../../core/services/autocomplete.service';
import { AuthService } from '../../../core/services/auth.service';
import { DocumentationFormResponse } from '../models/documentation-form.model';

/**
 * استمارة التوثيق save parity with Form6.frm Command1_Click (:2799-2845) / Command16_Click / Command3_Click:
 * الرقم can never be typed, تسجيل without a record shows the legacy message and sends nothing, a locked
 * record is refused, an unlocked record with empty fields is still saved.
 */
describe('DocumentationFormComponent — تسجيل legacy parity', () => {
  const LEGACY_NO_RECORD = 'رقم الاستمارة فارغ يجب ان تضغط على سجل جديد';
  const LEGACY_LOCKED = 'لاتستطيع التعدل او الالغاء ....لان الوثيقة مقفلة.';   // is_trans MsgBox, verbatim

  let fixture: ComponentFixture<DocumentationFormComponent>;
  let component: DocumentationFormComponent;
  let snack: { open: ReturnType<typeof vi.fn> };
  let svc: Record<string, ReturnType<typeof vi.fn>>;

  const ok = <T>(data: T) => of({ success: true, data, timestamp: '' });

  function record(appNo: string, locked: boolean): DocumentationFormResponse {
    return {
      appNo, catalogueTitle: null, additionalTitle: null, dataEntry: null, appDoc: null,
      entryDate: '2026-10-12T15:47:33', result: null, documentNature: null, date: null,
      periodicalNo: null, periodicalName: null, subjectType: null, pageNo: null, articleNo: null,
      lang: null, lang1: null, date1: null, periodical1: null, periodical1Name: null, locked
    };
  }

  async function settle(): Promise<void> {
    for (let i = 0; i < 3; i++) {
      fixture.detectChanges();
      await fixture.whenStable();
      await new Promise(r => setTimeout(r));
    }
    fixture.detectChanges();
  }

  function toolbarButton(label: string): HTMLButtonElement {
    // Toolbar buttons hold a <mat-icon> ligature ("save", "note_add"…) before the translated label.
    const btn = Array.from(fixture.nativeElement.querySelectorAll('.doc-toolbar button') as NodeListOf<HTMLButtonElement>)
      .find(b => {
        const clone = b.cloneNode(true) as HTMLElement;
        clone.querySelectorAll('mat-icon').forEach(i => i.remove());
        return clone.textContent?.trim() === label;
      });
    if (!btn) throw new Error(`button "${label}" not found`);
    return btn;
  }

  function appNoInput(): HTMLInputElement {
    return fixture.nativeElement.querySelector('input[formcontrolname="appNo"]') as HTMLInputElement;
  }

  function lastSnack(): string | undefined {
    return snack.open.mock.calls.at(-1)?.[0];
  }

  beforeEach(async () => {
    snack = { open: vi.fn() };
    svc = {
      getById: vi.fn((no: string) => ok(record(no, false))),
      create: vi.fn(),
      createNext: vi.fn(() => ok(record('ق000001', false))),
      update: vi.fn((no: string) => ok(record(no, false))),
      delete: vi.fn(),
      findAppNosSorted: vi.fn(),
      searchByTitle: vi.fn()
    };
    await TestBed.configureTestingModule({
      imports: [CatalogueModule],
      providers: [
        provideRouter([]),
        provideNoopAnimations(),
        provideHttpClient(),
        provideHttpClientTesting(),
        importProvidersFrom(TranslateModule.forRoot()),
        { provide: MatSnackBar, useValue: snack },
        { provide: DocumentationFormService, useValue: svc },
        { provide: CatalogueService, useValue: { getLinkedAuthors: () => ok([]), getText1: () => ok([]), unlock: vi.fn() } },
        {
          provide: AutocompleteService, useValue: {
            getCodingByCodePrefix: () => ok([]), getAllPeriodicals: () => ok([]),
            searchPeriodicals: () => ok([]), searchAuthors: () => ok([]), searchForms: () => ok({ content: [] })
          }
        },
        { provide: AuthService, useValue: { getCurrentUser: () => ({ user_doc: '01', user_ent: '02' }) } }
      ]
    }).compileComponents();

    const translate = TestBed.inject(TranslateService);
    translate.setTranslation('ar', ar as Record<string, unknown>);
    translate.use('ar');

    fixture = TestBed.createComponent(DocumentationFormComponent);
    component = fixture.componentInstance;
    await settle();
  });

  it('uses the legacy Arabic texts for the two refusals', () => {
    expect(TestBed.inject(TranslateService).instant('DOC_FORM.NO_RECORD_LOADED')).toBe(LEGACY_NO_RECORD);
    expect(TestBed.inject(TranslateService).instant('DOC_FORM.CANCEL_BLOCKED_LOCKED')).toBe(LEGACY_LOCKED);
  });

  it('keeps الرقم disabled: on open, after سجل جديد and after a record is loaded', async () => {
    expect(appNoInput().disabled).toBe(true);

    toolbarButton('سجل جديد').click();
    await settle();
    expect(component.savedAppNo()).toBe('ق000001');
    expect(appNoInput().disabled).toBe(true);

    component.loadRecord('ق000009');
    await settle();
    expect(appNoInput().disabled).toBe(true);
  });

  it('تسجيل with no record loaded shows the legacy message and sends no request', async () => {
    toolbarButton('تسجيل').click();
    await settle();

    expect(lastSnack()).toBe(LEGACY_NO_RECORD);
    expect(svc['update']).not.toHaveBeenCalled();
    expect(svc['create']).not.toHaveBeenCalled();
  });

  it('التحليل with no record loaded shows the same message before any prompt', async () => {
    toolbarButton('التحليل').click();
    await settle();

    expect(lastSnack()).toBe(LEGACY_NO_RECORD);
    expect(document.querySelector('app-page2-prompt-dialog')).toBeNull();
  });

  it('تسجيل on a locked record shows the lock message and sends no request', async () => {
    svc['getById'].mockImplementation((no: string) => ok(record(no, true)));
    component.loadRecord('ق000004');
    await settle();

    toolbarButton('تسجيل').click();
    await settle();

    expect(lastSnack()).toBe(LEGACY_LOCKED);
    expect(svc['update']).not.toHaveBeenCalled();
    expect(svc['create']).not.toHaveBeenCalled();
  });

  it('shows the server refusal message (backend lock check / 409) instead of a generic error', async () => {
    component.loadRecord('ق000005');
    await settle();
    svc['update'].mockReturnValue(throwError(() => new HttpErrorResponse({ status: 409, error: { message: LEGACY_LOCKED } })));

    toolbarButton('تسجيل').click();
    await settle();

    expect(lastSnack()).toBe(LEGACY_LOCKED);
  });

  it('an unlocked record with every field empty is still saved (update, never create)', async () => {
    component.loadRecord('ق000006');
    await settle();

    toolbarButton('تسجيل').click();
    await settle();

    expect(svc['update']).toHaveBeenCalledTimes(1);
    expect(svc['update'].mock.calls[0][0]).toBe('ق000006');
    expect(svc['create']).not.toHaveBeenCalled();
    expect(lastSnack()).toBe(ar.APP.SUCCESS);
  });

  it('تاريخ الادخال is a date only: shown as yyyy-mm-dd and sent as midnight', async () => {
    component.loadRecord('ق000007');
    await settle();
    expect(component.form.get('entryDate')?.value).toBe('2026-10-12');
    expect(fixture.nativeElement.querySelector('input[formcontrolname="entryDate"]').type).toBe('date');

    toolbarButton('تسجيل').click();
    await settle();

    expect(svc['update'].mock.calls[0][1].entryDate).toBe('2026-10-12T00:00:00');
  });
});
