import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { ReportsService } from '../services/reports.service';
import { OutputTemplate, ReportExecutionResult } from '../models/reports.model';

@Component({
  standalone: false,
  selector: 'app-report-execution',
  templateUrl: './report-execution.component.html',
  styleUrls: ['./report-execution.component.scss']
})
export class ReportExecutionComponent implements OnInit {
  private svc   = inject(ReportsService);
  private snack = inject(MatSnackBar);
  private t     = inject(TranslateService);

  templates       = signal<OutputTemplate[]>([]);
  selectedTemplate = signal<OutputTemplate | null>(null);
  isExecuting     = signal(false);
  isExporting     = signal(false);
  result          = signal<ReportExecutionResult | null>(null);

  // Plain object for two-way ngModel bindings — reset on template change
  paramValues: Record<string, string> = {};

  // Comma-separated codeName split into individual filter-column keys
  paramKeys = computed(() => {
    const tpl = this.selectedTemplate();
    if (!tpl?.codeName) return [];
    return tpl.codeName.split(',').map(s => s.trim()).filter(Boolean);
  });

  displayedColumns = computed(() => {
    const r = this.result();
    return r ? r.columns.map(c => c.fieldName) : [];
  });

  ngOnInit(): void {
    this.svc.getTemplates(0, 500).subscribe({
      next: r => this.templates.set(r.data.content)
    });
  }

  onTemplateChange(tpl: OutputTemplate): void {
    this.selectedTemplate.set(tpl);
    this.result.set(null);
    const fresh: Record<string, string> = {};
    tpl.codeName?.split(',').map(s => s.trim()).filter(Boolean)
        .forEach(k => fresh[k] = '');
    this.paramValues = fresh;
  }

  execute(): void {
    const tpl = this.selectedTemplate();
    if (!tpl) return;
    this.isExecuting.set(true);

    const params: Record<string, string> = {};
    Object.entries(this.paramValues).forEach(([k, v]) => { if (v?.trim()) params[k] = v.trim(); });

    this.svc.executeTemplate(tpl.outputNum, params).subscribe({
      next: r => { this.result.set(r.data); this.isExecuting.set(false); },
      error: () => {
        this.snack.open(this.t.instant('APP.ERROR'), '', { duration: 3000 });
        this.isExecuting.set(false);
      }
    });
  }

  exportCsv(): void {
    const r   = this.result();
    const tpl = this.selectedTemplate();
    if (!r || !tpl) return;

    const header = r.columns.map(c => `"${c.label.replace(/"/g, '""')}"`).join(',');
    const dataRows = r.rows.map(row =>
      r.columns.map(c => {
        const val = String(row[c.fieldName] ?? '').replace(/"/g, '""');
        return `"${val}"`;
      }).join(',')
    );
    const csv  = [header, ...dataRows].join('\n');
    const blob = new Blob(['﻿' + csv], { type: 'text/csv;charset=utf-8;' });
    const url  = URL.createObjectURL(blob);
    const a    = document.createElement('a');
    a.href     = url;
    a.download = `report-${Math.round(tpl.outputNum)}.csv`;
    a.click();
    URL.revokeObjectURL(url);
  }

  exportPdf(): void {
    const tpl = this.selectedTemplate();
    if (!tpl) return;
    this.isExporting.set(true);
    this.svc.generateReport('dynamic', { templateNum: String(Math.round(tpl.outputNum)) }).subscribe({
      next: blob => {
        const url  = URL.createObjectURL(blob);
        const a    = document.createElement('a');
        a.href     = url;
        a.download = `report-${Math.round(tpl.outputNum)}.pdf`;
        a.click();
        URL.revokeObjectURL(url);
        this.isExporting.set(false);
      },
      error: () => {
        this.snack.open(this.t.instant('APP.ERROR'), '', { duration: 3000 });
        this.isExporting.set(false);
      }
    });
  }
}
