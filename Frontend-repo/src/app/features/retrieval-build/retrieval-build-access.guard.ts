import { inject } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivateFn, Router } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import { firstValueFrom } from 'rxjs';
import { AccessKeyDialogComponent } from '../../shared/components/access-key-dialog/access-key-dialog.component';
import { RetrievalBuildGate, RetrievalBuildService } from './retrieval-build.service';

/**
 * m9_Click (InputBox, "a5g5" / "ش5ل5" → Form4) and M32_Click (Frame3, "261015" → CAT_OUTFRM):
 * the form opens only with the right key; cancel or a wrong key just leaves the user where they
 * were — the legacy shows no message.
 */
export const retrievalBuildAccessGuard: CanActivateFn = async (route: ActivatedRouteSnapshot) => {
  const dialog = inject(MatDialog);
  const api = inject(RetrievalBuildService);
  const router = inject(Router);
  const gate = route.data['gate'] as RetrievalBuildGate;
  const stay = () => router.navigated ? false : router.parseUrl('/');

  const key = await firstValueFrom(
    dialog.open<AccessKeyDialogComponent, void, string | undefined>(AccessKeyDialogComponent, {
      width: '340px', autoFocus: 'first-tabbable', restoreFocus: true
    }).afterClosed());
  if (key === undefined) return stay();
  try {
    await firstValueFrom(api.requestAccess(gate, key));
    return true;
  } catch {
    return stay();
  }
};
