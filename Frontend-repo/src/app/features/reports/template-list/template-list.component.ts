import { Component, OnInit, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { ReportsService } from '../services/reports.service';
import { OutputTemplate } from '../models/reports.model';
import { PERM_CREATE, PERM_UPDATE, PERM_DELETE } from '../../../shared/models/permission-constants';

@Component({ standalone: false, selector: 'app-template-list', templateUrl: './template-list.component.html', styleUrls: ['./template-list.component.scss'] })
export class TemplateListComponent implements OnInit {
  protected readonly PERM_CREATE = PERM_CREATE;
  protected readonly PERM_UPDATE = PERM_UPDATE;
  protected readonly PERM_DELETE = PERM_DELETE;

  private svc = inject(ReportsService);
  private router = inject(Router);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);

  cols = ['outputNum', 'description', 'name', 'field', 'type', 'nature', 'category', 'actions'];
  items = signal<OutputTemplate[]>([]);
  total = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);
  filterType = signal('');
  filterCategory = signal('');

  ngOnInit(): void { this.load(); }

  load(): void {
    this.isLoading.set(true);
    this.svc.getTemplates(this.pageIndex(), this.pageSize(), undefined, this.filterType() || undefined, this.filterCategory() || undefined).subscribe({
      next: r => { this.items.set(r.data.content); this.total.set(r.data.totalElements); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }

  onPage(e: PageEvent): void { this.pageIndex.set(e.pageIndex); this.pageSize.set(e.pageSize); this.load(); }
  applyFilter(): void { this.pageIndex.set(0); this.load(); }
  clearFilter(): void { this.filterType.set(''); this.filterCategory.set(''); this.pageIndex.set(0); this.load(); }
  addNew(): void { this.router.navigate(['/reports', 'templates', 'new']); }
  onEdit(id: number): void { this.router.navigate(['/reports', 'templates', id, 'edit']); }

  onDelete(id: number): void {
    if (!confirm(this.t.instant('APP.CONFIRM_DELETE'))) return;
    this.svc.deleteTemplate(id).subscribe({ next: () => { this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 }); this.load(); } });
  }
}
