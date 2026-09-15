import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { Observable, tap } from 'rxjs';
import { environment } from '../../../environments/environment';
import { TokenService } from './token.service';
import { ApiResponse, LoginRequest, LoginResponse, JwtPayload } from '../models/api-response.model';

@Injectable({ providedIn: 'root' })
export class AuthService {

  private http = inject(HttpClient);
  private router = inject(Router);
  private tokenService = inject(TokenService);

  login(credentials: LoginRequest): Observable<ApiResponse<LoginResponse>> {
    return this.http.post<ApiResponse<LoginResponse>>(
      `${environment.apiUrl}/api/auth/login`,
      credentials
    ).pipe(
      tap(response => {
        if (response.success && response.data) {
          if (response.data.requiresPasswordChange) {
            sessionStorage.setItem('otp_token', response.data.token);
          } else {
            this.tokenService.setToken(response.data.token);
            this.tokenService.setUser(response.data.username, response.data.level, response.data.permission ?? 0);
          }
        }
      })
    );
  }

  changePassword(newPassword: string, confirmPassword: string): Observable<ApiResponse<LoginResponse>> {
    const otpToken = sessionStorage.getItem('otp_token') ?? '';
    return this.http.post<ApiResponse<LoginResponse>>(
      `${environment.apiUrl}/api/auth/change-password`,
      { newPassword, confirmPassword },
      { headers: { 'X-OTP-Token': otpToken } }
    ).pipe(
      tap(response => {
        if (response.success && response.data) {
          sessionStorage.removeItem('otp_token');
          this.tokenService.setToken(response.data.token);
          this.tokenService.setUser(response.data.username, response.data.level, response.data.permission ?? 0);
        }
      })
    );
  }

  logout(): void {
    this.tokenService.clear();
    this.router.navigate(['/auth/login']);
  }

  getToken(): string | null {
    return this.tokenService.getToken();
  }

  isLoggedIn(): boolean {
    const token = this.tokenService.getToken();
    if (!token) return false;

    const payload = this.parseJwt(token);
    if (!payload) return false;

    return payload.exp * 1000 > Date.now();
  }

  getCurrentUser(): JwtPayload | null {
    const token = this.tokenService.getToken();
    if (!token) return null;
    return this.parseJwt(token);
  }

  private parseJwt(token: string): JwtPayload | null {
    try {
      const parts = token.split('.');
      if (parts.length !== 3) return null;
      const payload = atob(parts[1]);
      return JSON.parse(payload);
    } catch {
      return null;
    }
  }
}
