import { Component, OnDestroy, OnInit, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { firstValueFrom } from 'rxjs';
import { LegacyGridColumn, LegacyGridWriter } from '../../users/legacy-grid/legacy-grid.component';
import { Row, RetrievalBuildService } from '../retrieval-build.service';

type Table = 'pout' | 'bnkout';

/**
 * Form4 — "ملف بناء الاسترجاعات" (ARCHIVE.frm m9, key a5g5 / ش5ل5). Two MSDBGrid grids bound
 * straight to the retrieval-field tables: DBGrid1 ← pout ("select * from pout order by out_ist")
 * and DBGrid2 ← bnkout ("select * from bnkout order by out_num"). MSDBGrid defaults: every column
 * shown with its field name as caption, cells editable, no add-new line and no delete.
 */
@Component({
  standalone: false,
  selector: 'app-form4',
  template: `
  <div class="f4" dir="ltr">
    <div class="f4-bar"><span class="f4-title">Form4</span><button type="button" class="f4-close" (click)="close()">×</button></div>
    <label class="f4-label">pout</label>
    <app-legacy-grid gridId="f4-pout" [columns]="cols().pout" [rows]="rows().pout" [writer]="writers.pout"
                     [allowAddNew]="false" [allowDelete]="false" [loading]="loading()"></app-legacy-grid>
    <label class="f4-label">bnkout</label>
    <app-legacy-grid gridId="f4-bnkout" [columns]="cols().bnkout" [rows]="rows().bnkout" [writer]="writers.bnkout"
                     [allowAddNew]="false" [allowDelete]="false" [loading]="loading()"></app-legacy-grid>
  </div>`,
  styles: [`
    .f4 { padding: 8px; background: #d4d0c8; min-height: calc(100vh - 120px); display: flex; flex-direction: column; gap: 4px; }
    .f4-bar { display: flex; justify-content: space-between; align-items: center; background: #0a246a; color: #fff; padding: 2px 6px; }
    .f4-title { font-weight: 600; }
    .f4-close { background: #d4d0c8; border: 1px outset #fff; cursor: pointer; width: 22px; }
    .f4-label { font-weight: 600; }
    app-legacy-grid { display: block; max-height: 40vh; overflow: auto; }
  `]
})
export class Form4Component implements OnInit, OnDestroy {

  private api = inject(RetrievalBuildService);
  private router = inject(Router);
  private snack = inject(MatSnackBar);

  cols = signal<Record<Table, LegacyGridColumn[]>>({ pout: [], bnkout: [] });
  rows = signal<Record<Table, Row[]>>({ pout: [], bnkout: [] });
  loading = signal(false);

  readonly writers: Record<Table, LegacyGridWriter> = {
    pout: { update: (r, c, t) => this.write('pout', r, c, t) },
    bnkout: { update: (r, c, t) => this.write('bnkout', r, c, t) }
  };

  ngOnInit(): void {
    this.load('pout');
    this.load('bnkout');
  }

  ngOnDestroy(): void {
    this.api.release('FORM4');
  }

  close(): void {
    this.router.navigate(['/']);
  }

  private load(table: Table): void {
    this.loading.set(true);
    this.api.form4(table).subscribe({
      next: r => {
        // "auto" is the IDENTITY column — shown, but not editable.
        const columns = (r.data?.columns ?? []).map(c => ({ key: c, label: c, locked: c.toLowerCase() === 'auto', width: 110 }));
        this.cols.update(v => ({ ...v, [table]: columns }));
        this.rows.update(v => ({ ...v, [table]: r.data?.rows ?? [] }));
        this.loading.set(false);
      },
      error: () => this.loading.set(false)
    });
  }

  private async write(table: Table, row: number, column: string, text: string): Promise<boolean> {
    const auto = Number(this.rows()[table][row]?.['auto']);
    try {
      await firstValueFrom(this.api.form4Cell(table, auto, column, text));
      this.load(table);
      return true;
    } catch (e: any) {
      this.snack.open(e?.error?.message || 'تعذر حفظ القيمة', '', { duration: 4000 });
      return false;
    }
  }
}
