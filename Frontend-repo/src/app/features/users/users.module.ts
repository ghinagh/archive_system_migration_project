import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { SharedModule } from '../../shared/shared.module';
import { configUsersAccessGuard } from '../../core/guards/config-users-access.guard';
import { ConfigUsersComponent } from './config-users/config-users.component';

/** " معالجة المستخدمين" — legacy config_users.frm, behind the ARCHIVE.frm Frame3 key 261015. */
const routes: Routes = [
  { path: '', component: ConfigUsersComponent, canActivate: [configUsersAccessGuard] }
];

@NgModule({
  declarations: [ConfigUsersComponent],
  imports: [SharedModule, RouterModule.forChild(routes)]
})
export class UsersModule { }
