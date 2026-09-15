import { Component, OnInit, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { PageEvent } from '@angular/material/paginator';
import { UsersService } from '../services/users.service';
import { SystemUser } from '../models/user.model';
import { ChangePasswordDialogComponent } from '../change-password-dialog/change-password-dialog.component';
import { MigratePasswordsDialogComponent } from '../migrate-passwords-dialog/migrate-passwords-dialog.component';
import { TokenService } from '../../../core/services/token.service';
import { PERM_ADMIN } from '../../../shared/models/permission-constants';

@Component({ standalone: false, selector: 'app-user-list', templateUrl: './user-list.component.html', styleUrls: ['./user-list.component.scss'] })
export class UserListComponent implements OnInit {
  private svc = inject(UsersService);
  private router = inject(Router);
  private dialog = inject(MatDialog);
  private snack = inject(MatSnackBar);
  private t = inject(TranslateService);
  private tokenService = inject(TokenService);

  cols = ['userNo', 'userName', 'userLevel', 'userEnt', 'userPermission', 'actions'];
  items = signal<SystemUser[]>([]);
  total = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);
  filterLevel = signal('');
  filterEntity = signal('');
  isAdmin = signal(false);
  protected readonly PERM_ADMIN = PERM_ADMIN;

  ngOnInit(): void {
    const user = this.tokenService.getUser();
    this.isAdmin.set(user?.level?.trim() === 'A');
    this.load();
  }

  load(): void {
    this.isLoading.set(true);
    this.svc.getAll(this.pageIndex(), this.pageSize(), this.filterLevel() || undefined, this.filterEntity() || undefined).subscribe({
      next: r => { this.items.set(r.data.content); this.total.set(r.data.totalElements); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }

  onPage(e: PageEvent): void { this.pageIndex.set(e.pageIndex); this.pageSize.set(e.pageSize); this.load(); }
  applyFilter(): void { this.pageIndex.set(0); this.load(); }
  clearFilter(): void { this.filterLevel.set(''); this.filterEntity.set(''); this.pageIndex.set(0); this.load(); }
  addNew(): void { this.router.navigate(['/users', 'new']); }
  onEdit(userNo: string): void { this.router.navigate(['/users', userNo, 'edit']); }

  getLevelClass(level: string): string {
    switch (level?.trim()) {
      case 'A': return 'level-admin';
      case 'U': return 'level-user';
      default: return 'level-guest';
    }
  }

  getLevelLabel(level: string): string {
    switch (level?.trim()) {
      case 'A': return this.t.instant('USERS.LEVEL_ADMIN');
      case 'U': return this.t.instant('USERS.LEVEL_USER');
      default: return this.t.instant('USERS.LEVEL_GUEST');
    }
  }

  onResetPassword(userNo: string): void {
    this.dialog.open(ChangePasswordDialogComponent, {
      width: '400px',
      data: { userNo }
    });
  }

  onMigratePasswords(): void {
    this.dialog.open(MigratePasswordsDialogComponent, {
      width: '480px',
      disableClose: true
    });
  }

  onDelete(userNo: string): void {
    if (!confirm(this.t.instant('APP.CONFIRM_DELETE'))) return;
    this.svc.delete(userNo).subscribe({
      next: () => { this.snack.open(this.t.instant('APP.SUCCESS'), '', { duration: 3000 }); this.load(); }
    });
  }
}
