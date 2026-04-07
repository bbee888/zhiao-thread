import request from "@/utils/request";

export interface InquiryPageQuery {
  page?: number;
  limit?: number;
  keywords?: string;
  status?: number;
}

export interface InquiryItem {
  id: number;
  name: string;
  email: string;
  company?: string;
  phone?: string;
  country: string;
  interest?: string;
  model?: string;
  quantity?: string;
  color?: string;
  length?: string;
  tenacity?: string;
  productId?: number;
  subject: string;
  message: string;
  attachmentName?: string;
  status: number;
  locale?: string;
  ip?: string;
  userAgent?: string;
  createTime?: string;
}

export interface InquiryPageResult {
  items: InquiryItem[];
  total: number;
}

const INQUIRY_BASE_URL = "/api/v1/inquiries";

export function getInquiryPage(query: InquiryPageQuery) {
  return request<any, InquiryPageResult>({
    url: INQUIRY_BASE_URL,
    method: "get",
    params: query,
  });
}

export function getInquiryDetail(id: number) {
  return request<any, InquiryItem>({
    url: `${INQUIRY_BASE_URL}/${id}`,
    method: "get",
  });
}

export function updateInquiryStatus(id: number, status: number) {
  return request<any, boolean>({
    url: `${INQUIRY_BASE_URL}/${id}/status`,
    method: "patch",
    data: { status },
  });
}

export function deleteInquiry(id: number) {
  return request<any, boolean>({
    url: `${INQUIRY_BASE_URL}/${id}`,
    method: "delete",
  });
}
