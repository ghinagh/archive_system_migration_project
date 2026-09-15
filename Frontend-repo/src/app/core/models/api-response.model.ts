export interface ApiResponse<T> {
  success: boolean;
  data: T;
  message?: string;
  timestamp: string;
}

export interface PageResponse<T> {
  content: T[];
  totalElements: number;
  totalPages: number;
  size: number;
  number: number;
}

export interface LoginRequest {
  username: string;
  password: string;
}

export interface LoginResponse {
  token: string;
  username: string;
  level: string;
  permission: number;
  requiresPasswordChange?: boolean;
}

export interface JwtPayload {
  sub: string;
  iat: number;
  exp: number;
  perm: number;
  user_ent: string;
  user_doc: string;
  user_level: string;
}
