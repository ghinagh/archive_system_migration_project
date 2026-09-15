import { Component, OnInit, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { PageEvent } from '@angular/material/paginator';
import { SitesService } from '../services/sites.service';
import { Post } from '../models/sites.model';
import { PERM_CREATE, PERM_UPDATE, PERM_DELETE } from '../../../shared/models/permission-constants';

@Component({ standalone: false, selector: 'app-post-list', templateUrl: './post-list.component.html', styleUrls: ['./post-list.component.scss'] })
export class PostListComponent implements OnInit {
  protected readonly PERM_CREATE = PERM_CREATE;
  protected readonly PERM_UPDATE = PERM_UPDATE;
  protected readonly PERM_DELETE = PERM_DELETE;

  private sitesService = inject(SitesService);
  private router = inject(Router);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  displayedColumns = ['serial', 'formNo', 'siteNo', 'docNo', 'startDate', 'endDate', 'status', 'level', 'actions'];
  items = signal<Post[]>([]);
  totalElements = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);

  ngOnInit(): void { this.loadData(); }

  loadData(): void {
    this.isLoading.set(true);
    this.sitesService.getPosts(this.pageIndex(), this.pageSize()).subscribe({
      next: r => { this.items.set(r.data.content); this.totalElements.set(r.data.totalElements); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }

  onPageChange(e: PageEvent): void { this.pageIndex.set(e.pageIndex); this.pageSize.set(e.pageSize); this.loadData(); }
  addNew(): void { this.router.navigate(['/sites', 'posts', 'new']); }
  onEdit(serial: string): void { this.router.navigate(['/sites', 'posts', serial, 'edit']); }

  onDelete(serial: string): void {
    if (!confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;
    this.sitesService.deletePost(serial).subscribe({ next: () => { this.snackBar.open(this.translate.instant('APP.SUCCESS'), '', { duration: 3000 }); this.loadData(); } });
  }
}
