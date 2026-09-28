export interface DigitRecord {
  docNo: string;
  serial: number;
  catalogueTitle: string;
  digitNo: string;
  type: string;
  type1: string;
  durationHours: number;
  durationMinutes: number;
  durationSeconds: number;
  durationHours1: number;
  durationMinutes1: number;
  durationSeconds1: number;
  size: number;
  chartNo: string;
  newChartNo: string;
  chartType: string;
  chartGeo: string;
  choice: number;
  chartNo1: string;
  materialType: string;
  highType: string;
  /** Resolved CODING domain '24' description for type1 ("شكل الوثيقة") — see DigitizationService.resolveDescriptions. */
  type1Description?: string | null;
  /** Resolved "form" table name for chartGeo ("مكان التصوير/النشر"). */
  chartGeoName?: string | null;
}

export interface DigitRecordRequest {
  docNo: string;
  serial: number;
  digitNo?: string;
  type?: string;
  type1?: string;
  durationHours?: number;
  durationMinutes?: number;
  durationSeconds?: number;
  durationHours1?: number;
  durationMinutes1?: number;
  durationSeconds1?: number;
  size?: number;
  chartNo?: string;
  newChartNo?: string;
  chartType?: string;
  chartGeo?: string;
  choice?: number;
  materialType?: string;
  highType?: string;
}

export interface DigitDemand {
  id: number;
  demandNo: string;
  serial: number;
  userNo: string;
  userName: string;
  date: string | null;
  machineNo: string;
  catalogueTitle: string;
  description: string;
  checked: number;
  machineStock: string;
  path: string | null;
  cote: string;
  time?: number;           // Duration in seconds (legacy dmd_out)
  time1: string;           // Formatted time (HH:MM:SS)
  checked1: boolean;
  inputSize: number | null;
  outputSize: number | null;
}

/**
 * Progress and outcome of a batch delivery (legacy Command5 / Command14).
 *
 * Legacy blocked its window on WaitForSingleObject for the length of the transcode and showed
 * the current item in the m_tit textbox. An HTTP request cannot block that long, so the batch
 * runs server-side as a job and this is polled — currentTitle and processed/total carry what
 * m_tit displayed.
 */
export interface DeliveryJobStatus {
  jobId: string;
  state: 'RUNNING' | 'COMPLETED' | 'FAILED';
  total: number;
  processed: number;
  currentTitle: string | null;
  succeeded: number;
  /** Stock numbers legacy listed in "ارقام الاشرطة التي لم تنفذ". */
  failedStockNumbers: string[];
  errorMessage: string | null;
  /** True when nothing in the selection was queued — legacy "لا يوجد مواد مختارة للتنفيذ". */
  nothingSelected: boolean;
  outputPaths: string[];
  handedOffToEdlc: number;
}

/** Convenience request for the archive-search cockpit's "add scene to request" workflow. */
export interface AddSceneRequest {
  demandNo?: string;
  machineNo: string;
  machineStock?: string;
  description?: string;
  inSeconds: number;
  outSeconds: number;
  path?: string;
  /** DIGIT.DIG_TYP_HIGH — dmd_path must address the broadcast master, not the preview proxy. */
  highExtension?: string;
}

/** START = re-encode (legacy "start"), NEWSTART = ffmpeg stream-copy trim, COPY = plain whole-file copy. */
export type DemandFulfilMechanism = 'START' | 'NEWSTART' | 'COPY';

export interface DemandTestResult {
  id: number;
  demandNo: string | null;
  ok: boolean;
  message: string;
}

export interface DemandStats {
  count: number;
  totalDurationSeconds: number;
}

export interface DigitDemandRequest {
  demandNo: string;
  serial: number;
  userNo?: string;
  date?: string;
  machineNo?: string;
  description?: string;
  cote?: string;
  time1?: string;
}

export interface DigitResult {
  id: number;
  resultNo: string;
  serial: number;
  digitNo: string;
  type: string;
  type1: string;
  date: string | null;
  userNo: string;
  catalogueAppNo: string;
  catalogueTitle: string | null;
  person: string;
  cote: string;
  coteDescription: string | null;
  permit: string;
  permitDescription: string | null;
  subject: string;
  type1Description: string | null;
}

export interface DigitResultRequest {
  resultNo: string;
  serial: number;
  digitNo?: string;
  type?: string;
  type1?: string;
  date?: string;
  userNo?: string;
  catalogueAppNo?: string;
  person?: string;
  cote?: string;
  permit?: string;
  subject?: string;
}

/** One document/digitized-asset being registered under a shared usage-request header. */
export interface LogUsageRequestItem {
  catalogueAppNo: string;
  digitNo?: string;
  type?: string;
  type1?: string;
}

/** "مع تسجيل الطلب" — logs a usage request for one or more documents found on شاشة البحث;
 *  all items share one result header/resultNo (legacy Command9/Command11 batch behavior). */
export interface LogUsageRequestBatch {
  items: LogUsageRequestItem[];
  person: string;
  cote?: string;
  permit?: string;
  subject?: string;
}
