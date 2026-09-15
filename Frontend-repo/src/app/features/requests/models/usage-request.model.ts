export interface UsageRequest {
  id: string;
  requestNo: string;
  digitizationType: string | null;
  digitizationNo: string | null;
  permitNo: string | null;
  requester: string;
  cote: string | null;
  requestDate: string;
  status: string;
  createdAt: string;
  updatedAt: string;
}

export interface UsageRequestRequest {
  requestNo: string;
  digitizationType?: string;
  digitizationNo?: string;
  permitNo?: string;
  requester: string;
  cote?: string;
  requestDate: string;
  status?: string;
}
