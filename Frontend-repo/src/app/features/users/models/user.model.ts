export interface SystemUser {
  userNo: string;
  userName: string;
  userLevel: string;
  userPermission: number;
  userEnt: string;
  userDoc: string;
  configPath: string;
  startPage: number | null;
  passwordChangeFlag: number | null;
  compressedVideoPath: string;
  videoPath: string;
  company: number | null;
  secondaryVideoPath: string;
  wilayaScope: number | null;
}

export interface UserRequest {
  userNo: string;
  userName?: string;
  userPassword?: string;
  userLevel?: string;
  userPermission?: number;
  userEnt?: string;
  userDoc?: string;
  configPath?: string;
  startPage?: number | null;
  passwordChangeFlag?: number | null;
  compressedVideoPath?: string;
  videoPath?: string;
  company?: number | null;
  secondaryVideoPath?: string;
  wilayaScope?: number | null;
}

export interface ChangePasswordRequest {
  newPassword: string;
}
