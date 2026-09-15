import { Directive, Input, OnInit, TemplateRef, ViewContainerRef, inject } from '@angular/core';
import { AuthService } from '../../../core/services/auth.service';
import { TokenService } from '../../../core/services/token.service';

const LEVEL_HIERARCHY: Record<string, number> = { 'A': 3, 'U': 2, 'G': 1 };

@Directive({ standalone: false, selector: '[appRequiresLevel],[appRequiresPermission]' })
export class RequiresLevelDirective implements OnInit {

  @Input('appRequiresLevel') requiredLevel = 'G';
  @Input('appRequiresPermission') requiredPermission?: number;

  private templateRef = inject(TemplateRef<unknown>);
  private viewContainer = inject(ViewContainerRef);
  private tokenService = inject(TokenService);
  private authService = inject(AuthService);

  ngOnInit(): void {
    const user = this.tokenService.getUser();
    const level = user?.level?.trim() || 'G';

    // Admins bypass all permission checks
    if (level === 'A') {
      this.viewContainer.createEmbeddedView(this.templateRef);
      return;
    }

    let allowed: boolean;

    if (this.requiredPermission != null) {
      // Bitmask check: read perm claim directly from the JWT payload
      const perm = this.authService.getCurrentUser()?.perm ?? 0;
      allowed = (perm & this.requiredPermission) !== 0;
    } else {
      // Level hierarchy check (original behaviour)
      const userRank = LEVEL_HIERARCHY[level] || 0;
      const requiredRank = LEVEL_HIERARCHY[this.requiredLevel] || 0;
      allowed = userRank >= requiredRank;
    }

    if (allowed) {
      this.viewContainer.createEmbeddedView(this.templateRef);
    } else {
      this.viewContainer.clear();
    }
  }
}
