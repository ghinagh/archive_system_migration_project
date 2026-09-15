import { Component, inject, signal } from '@angular/core';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { ReportsService } from '../services/reports.service';

interface ReportOption {
  labelKey: string;
  value: string;
}

@Component({
  standalone: false,
  selector: 'app-report-viewer',
  templateUrl: './report-viewer.component.html',
  styleUrls: ['./report-viewer.component.scss']
})
export class ReportViewerComponent {
  private svc = inject(ReportsService);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  readonly reportOptions: ReportOption[] = [
    { labelKey: 'REPORTS.VIEWER.BOOK_CATALOGUE',   value: 'book-catalogue'  },
    { labelKey: 'REPORTS.VIEWER.RESOURCE_RESULT',  value: 'resource-result' },
    { labelKey: 'REPORTS.VIEWER.GENERAL_1',        value: 'general-1'       },
    { labelKey: 'REPORTS.VIEWER.GENERAL_2',        value: 'general-2'       },
    { labelKey: 'REPORTS.VIEWER.GENERAL_4',        value: 'general-4'       },
    { labelKey: 'REPORTS.VIEWER.GENERAL_5',        value: 'general-5'       },
    { labelKey: 'REPORTS.VIEWER.GENERAL_7',        value: 'general-7'       },
    { labelKey: 'REPORTS.VIEWER.GENERAL_13',       value: 'general-13'      },
    { labelKey: 'REPORTS.VIEWER.ADDENDUM',         value: 'rpt-add'         },
    { labelKey: 'REPORTS.VIEWER.ADDENDUM_VARIANT', value: 'rpt-add1'        },
    { labelKey: 'REPORTS.VIEWER.TEMP_RESULT',      value: 'tmp-result'      },
  ];

  selectedType = signal<string>('book-catalogue');
  isGenerating = signal(false);

  download(): void {
    const type = this.selectedType();
    this.isGenerating.set(true);
    this.svc.generateReport(type, {}).subscribe({
      next: (blob) => {
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `${type}.pdf`;
        a.click();
        URL.revokeObjectURL(url);
        this.isGenerating.set(false);
      },
      error: () => {
        this.snack.open(this.t.instant('APP.ERROR'), '', { duration: 3000 });
        this.isGenerating.set(false);
      }
    });
  }

  preview(): void {
    const type = this.selectedType();
    this.isGenerating.set(true);
    this.svc.generateReport(type, {}).subscribe({
      next: (blob) => {
        const url = URL.createObjectURL(blob);
        window.open(url, '_blank');
        setTimeout(() => URL.revokeObjectURL(url), 60000);
        this.isGenerating.set(false);
      },
      error: () => {
        this.snack.open(this.t.instant('APP.ERROR'), '', { duration: 3000 });
        this.isGenerating.set(false);
      }
    });
  }
}
