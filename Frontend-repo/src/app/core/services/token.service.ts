import { Injectable } from '@angular/core';

const ACCESS_TOKEN_KEY = 'access_token';
const USER_KEY = 'current_user';

@Injectable({ providedIn: 'root' })
export class TokenService {

  getToken(): string | null {
    return localStorage.getItem(ACCESS_TOKEN_KEY);
  }

  setToken(token: string): void {
    localStorage.setItem(ACCESS_TOKEN_KEY, token);
  }

  removeToken(): void {
    localStorage.removeItem(ACCESS_TOKEN_KEY);
  }

  setUser(username: string, level: string, permission: number): void {
    localStorage.setItem(USER_KEY, JSON.stringify({ username, level, permission }));
  }

  getUser(): { username: string; level: string; permission: number } | null {
    const raw = localStorage.getItem(USER_KEY);
    if (!raw) return null;
    return JSON.parse(raw);
  }

  removeUser(): void {
    localStorage.removeItem(USER_KEY);
  }

  clear(): void {
    this.removeToken();
    this.removeUser();
  }
}
