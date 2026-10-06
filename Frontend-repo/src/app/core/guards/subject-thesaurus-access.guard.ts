import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { HttpErrorResponse } from '@angular/common/http';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { firstValueFrom } from 'rxjs';
import { AccessKeyDialogComponent } from '../../shared/components/access-key-dialog/access-key-dialog.component';
import { SubjectThesaurusAccessService } from '../services/subject-thesaurus-access.service';

/**
 * ARCHIVE.frm M6_Click: "المكنز الموضوعي" never opens directly — Frame3 asks for the key first
 * (password1 = "891045", checked server-side here). Runs on every activation of the route, so the
 * menu item, Ctrl+A and a typed URL all go through the same prompt. Cancel / Esc / a wrong key
 * leave the user where they were (or on the home screen when the URL was opened directly).
 */
export const subjectThesaurusAccessGuard: CanActivateFn = async () => {
  const dialog = inject(MatDialog);
  const access = inject(SubjectThesaurusAccessService);
  const router = inject(Router);
  const snack = inject(MatSnackBar);
  const translate = inject(TranslateService);

  const stay = () => router.navigated ? false : router.parseUrl('/');

  const key = await firstValueFrom(
    dialog.open<AccessKeyDialogComponent, void, string | undefined>(AccessKeyDialogComponent, {
      width: '340px',
      autoFocus: 'first-tabbable',
      restoreFocus: true
    }).afterClosed()
  );
  if (key === undefined) {
    return stay();
  }
  try {
    await firstValueFrom(access.requestAccess(key));
    return true;
  } catch (e) {
    const message = e instanceof HttpErrorResponse ? e.error?.message : null;
    snack.open(message || translate.instant('ACCESS_KEY.WRONG'), translate.instant('APP.CANCEL'), {
      duration: 4000, horizontalPosition: 'center', verticalPosition: 'top'
    });
    return stay();
  }
};
