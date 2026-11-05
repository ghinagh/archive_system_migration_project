import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { TokenService } from '../services/token.service';

export const adminGuard: CanActivateFn = () => {
  const tokenService = inject(TokenService);
  const router = inject(Router);
  const snackBar = inject(MatSnackBar);
  const translate = inject(TranslateService);

  const user = tokenService.getUser();
  if (user && user.level?.trim() === 'A') {
    return true;
  }

  // get() waits for the translation file, so a page opened by its URL shows Arabic, not the key
  translate.get(['USERS.ADMIN_ONLY', 'APP.CANCEL']).subscribe(t =>
    snackBar.open(t['USERS.ADMIN_ONLY'], t['APP.CANCEL'],
      { duration: 4000, horizontalPosition: 'center', verticalPosition: 'top' }));
  router.navigate(['/catalogue']);
  return false;
};
