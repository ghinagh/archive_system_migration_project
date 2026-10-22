import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter } from '@angular/router';
import { provideNoopAnimations } from '@angular/platform-browser/animations';
import { importProvidersFrom } from '@angular/core';
import { TranslateModule } from '@ngx-translate/core';
import { of } from 'rxjs';
import { vi } from 'vitest';
import { FormThesaurusModule } from '../form-thesaurus.module';
import { FormThesaurusComponent } from './form-thesaurus.component';
import { FormThesaurusService } from '../services/form-thesaurus.service';
import { FormThesaurusAccessService } from '../../../core/services/form-thesaurus-access.service';
import { CodingRow, FormRow } from '../models/form-thesaurus.model';

/**
 * Regression: after a double-click on an المستوى الاول (DBList1) parent, a click on another parent
 * did nothing until the page was reloaded. coding.frm disables DBList1 on the drill
 * (DBList1_DblClick :2658) and re-enables it only on Esc in DBList2 (DBList2_KeyPress :2702-2705);
 * the screen copied that, so the mouse was swallowed by the disabled list. A click on a parent now
 * performs that same Esc transition first, so users can pick parents repeatedly.
 */
describe('FormThesaurusComponent — choosing another المستوى الاول parent', () => {
  const level1: CodingRow[] = [
    { level: '1', code: '1000', description: 'المجموعة 10' },
    { level: '1', code: '2000', description: 'المجموعة 20' },
    { level: '1', code: '3000', description: 'المجموعة 30' }
  ];
  const children: Record<string, CodingRow[]> = {
    '10': [{ level: '1', code: '1000', description: 'المجموعة 10' }, { level: '2', code: '1001', description: 'شخص' }],
    '20': [{ level: '1', code: '2000', description: 'المجموعة 20' }, { level: '2', code: '2001', description: 'قيمة 20' }],
    '30': [{ level: '1', code: '3000', description: 'المجموعة 30' }, { level: '2', code: '3001', description: 'قيمة 30' }]
  };
  const countries: FormRow[] = [{ type: '04', number: '00100000', name: 'بلد', code: '0400100000' }];

  let fixture: ComponentFixture<FormThesaurusComponent>;
  let component: FormThesaurusComponent;
  let api: {
    context: ReturnType<typeof vi.fn>;
    codingLevelOne: ReturnType<typeof vi.fn>;
    codingChildren: ReturnType<typeof vi.fn>;
    forms: ReturnType<typeof vi.fn>;
  };

  const ok = <T>(data: T) => of({ success: true, data, timestamp: '' });

  async function settle(): Promise<void> {
    for (let i = 0; i < 4; i++) {
      fixture.detectChanges();
      await fixture.whenStable();
      await new Promise(r => setTimeout(r));
    }
    fixture.detectChanges();
  }

  function row(list: string, index: number): HTMLElement {
    const el = fixture.nativeElement.querySelector(`#ft-${list}-row-${index}`) as HTMLElement | null;
    if (!el) throw new Error(`row ${list}#${index} not rendered`);
    return el;
  }

  async function click(list: string, index: number): Promise<void> {
    const el = row(list, index);
    el.dispatchEvent(new MouseEvent('mousedown', { bubbles: true, cancelable: true }));
    el.dispatchEvent(new MouseEvent('click', { bubbles: true }));
    await settle();
  }

  /** A real double-click: two clicks, then dblclick. */
  async function dblClick(list: string, index: number): Promise<void> {
    await click(list, index);
    await click(list, index);
    row(list, index).dispatchEvent(new MouseEvent('dblclick', { bubbles: true }));
    await settle();
  }

  beforeEach(async () => {
    // jsdom has no Element.scrollTo; the CDK virtual-scroll viewport calls it when a row is selected.
    if (!(Element.prototype as { scrollTo?: unknown }).scrollTo) {
      (Element.prototype as { scrollTo: () => void }).scrollTo = () => {};
    }
    api = {
      context: vi.fn(() => ok({ boxCompany: null })),
      codingLevelOne: vi.fn(() => ok(level1)),
      codingChildren: vi.fn((prefix: string) => ok(children[prefix] ?? [])),
      forms: vi.fn(() => ok(countries))
    };
    await TestBed.configureTestingModule({
      imports: [FormThesaurusModule],
      providers: [
        provideRouter([]),
        provideNoopAnimations(),
        importProvidersFrom(TranslateModule.forRoot()),
        { provide: FormThesaurusService, useValue: api },
        { provide: FormThesaurusAccessService, useValue: { release: vi.fn(), headers: vi.fn(), hasAccess: () => true } }
      ]
    }).compileComponents();

    fixture = TestBed.createComponent(FormThesaurusComponent);
    component = fixture.componentInstance;
    await settle();
  });

  it('keeps المستوى الاول clickable after drilling into a parent', async () => {
    await dblClick('l1', 0);
    expect(api.codingChildren).toHaveBeenLastCalledWith('10');
    expect(component.l2().rows.map(r => r.code)).toEqual(['1000', '1001']);
    expect(component.l1().enabled).toBe(false); // legacy DBList1.Enabled = False after the drill

    await click('l1', 1);

    expect(component.l1().selected).toBe(1);
    expect(component.text1()).toBe('2000');
    expect(component.l1().enabled).toBe(true);   // same state as legacy Esc in DBList2
    expect(component.l2().enabled).toBe(false);
  });

  it('loads the children of each parent chosen in turn, without a reload', async () => {
    await dblClick('l1', 0);
    await dblClick('l1', 1);
    expect(api.codingChildren).toHaveBeenLastCalledWith('20');
    expect(component.l2().rows.map(r => r.code)).toEqual(['2000', '2001']);

    await dblClick('l1', 2);
    expect(api.codingChildren).toHaveBeenLastCalledWith('30');
    expect(component.l2().rows.map(r => r.code)).toEqual(['3000', '3001']);
    expect(component.l2().enabled).toBe(true);
    expect(component.l1().enabled).toBe(false);
    expect(api.codingLevelOne).toHaveBeenCalledTimes(1); // no page reload involved
  });

  it('returns from the countries list to another parent (Esc chain countries → l2 → l1)', async () => {
    await dblClick('l1', 0);
    await dblClick('l2', 1);                       // "1001" → codes 10xx open الدول
    expect(component.countries().visible).toBe(true);

    await dblClick('l1', 2);

    expect(component.countries().visible).toBe(false);
    expect(api.codingChildren).toHaveBeenLastCalledWith('30');
    expect(component.l2().enabled).toBe(true);
    expect(component.l1().enabled).toBe(false);
  });
});
