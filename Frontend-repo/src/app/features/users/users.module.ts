import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MatExpansionModule } from '@angular/material/expansion';
import { SharedModule } from '../../shared/shared.module';
import { adminGuard } from '../../core/guards/admin.guard';
import { UserListComponent } from './user-list/user-list.component';
import { UserFormComponent } from './user-form/user-form.component';
import { ChangePasswordDialogComponent } from './change-password-dialog/change-password-dialog.component';
import { MigratePasswordsDialogComponent } from './migrate-passwords-dialog/migrate-passwords-dialog.component';

const routes: Routes = [
  { path: '', component: UserListComponent, canActivate: [adminGuard] },
  { path: 'new', component: UserFormComponent, canActivate: [adminGuard] },
  { path: ':id/edit', component: UserFormComponent, canActivate: [adminGuard] }
];

@NgModule({
  declarations: [
    UserListComponent,
    UserFormComponent,
    ChangePasswordDialogComponent,
    MigratePasswordsDialogComponent
  ],
  imports: [SharedModule, MatExpansionModule, RouterModule.forChild(routes)],
  exports: []
})
export class UsersModule { }
