export interface VideoOrder {
  id: string;
  orderNo: string;
  stockNo: string;
  chartId: number | null;
  description: string | null;
  requestedBy: string;
  requestDate: string;
  status: string;
  mediaAvailable: boolean;
  createdAt: string;
  updatedAt: string;
}

export interface VideoOrderRequest {
  orderNo: string;
  stockNo: string;
  chartId?: number | null;
  description?: string;
  requestedBy: string;
  requestDate: string;
  status?: string;
}
