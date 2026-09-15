export interface RenumberRequest {
  oldAppNo: string;
  newAppNo: string;
}

export interface CopyToArchiveRequest {
  stockNo: string;
}

export interface CopyToArchiveResult {
  sourcePath: string;
  destinationPath: string;
}

export interface FileLink {
  id: string;
  appNo: string;
  filePath: string;
  linkedByUser: string;
  linkedAt: string;
}

export interface FileLinkRequest {
  appNo: string;
  filePath: string;
}

export interface BackupInfo {
  fileName: string;
  sizeBytes: number;
  createdAt: string;
}

export interface RetrievalField {
  id: string;
  module: string;
  fieldKey: string;
  entityPath: string;
  fieldType: string;
  label: string;
  enabled: boolean;
}

export interface RetrievalFieldRequest {
  module: string;
  fieldKey: string;
  entityPath: string;
  fieldType: string;
  label: string;
  enabled: boolean;
}
