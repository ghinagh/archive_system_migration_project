import { Injectable, Injector, inject } from '@angular/core';
import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent, HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';

@Injectable()
export class ErrorInterceptor implements HttpInterceptor {

  private router = inject(Router);
  private snackBar = inject(MatSnackBar);
  // Resolved lazily (not injected directly) to avoid a circular dependency:
  // TranslateService's HTTP loader needs HttpClient, which builds the
  // interceptor chain — including this interceptor — before it can be used.
  private injector = inject(Injector);

  private get translate(): TranslateService {
    return this.injector.get(TranslateService);
  }

  intercept(req: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {
    return next.handle(req).pipe(
      catchError((error: HttpErrorResponse) => {
        switch (error.status) {
          case 401:
            localStorage.removeItem('access_token');
            localStorage.removeItem('current_user');
            this.router.navigate(['/auth/login']);
            break;
          case 403:
            this.showError(this.translate.instant('AUTH.FORBIDDEN') || 'Permission denied');
            break;
          case 500:
            this.showError(this.translate.instant('APP.ERROR') || 'An error occurred');
            break;
        }
        return throwError(() => error);
      })
    );
  }

  private showError(message: string): void {
    this.snackBar.open(message, this.translate.instant('APP.CANCEL') || 'Close', {
      duration: 5000,
      horizontalPosition: 'center',
      verticalPosition: 'top'
    });
  }
}
