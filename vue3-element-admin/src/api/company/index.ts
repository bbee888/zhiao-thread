import request from "@/utils/request";

export interface CompanyLangData {
  title?: string;
  content?: string;
  seoTitle?: string;
  seoKeywords?: string;
  seoDescription?: string;
}

export interface CompanyItem {
  id?: number;
  logo?: string;
  cover?: string;
  sort?: number;
  status?: number;
  title?: string;
  langData?: Record<string, CompanyLangData>;
}

export interface CompanyForm {
  id?: number;
  logo?: string;
  cover?: string;
  sort?: number;
  status?: number;
  langData?: Record<string, CompanyLangData>;
}

export interface CompanyListResponse {
  items: CompanyItem[];
  total: number;
}

const COMPANY_BASE_URL = "/api/v1/company";

const CompanyAPI = {
  getPage(params?: { pageNum?: number; pageSize?: number; keyword?: string; status?: number }) {
    return request<any, CompanyListResponse>({
      url: `${COMPANY_BASE_URL}/page`,
      method: "get",
      params,
    });
  },

  getFormData(id: number) {
    return request<any, CompanyForm>({
      url: `${COMPANY_BASE_URL}/${id}`,
      method: "get",
    });
  },

  create(data: CompanyForm) {
    return request({
      url: COMPANY_BASE_URL,
      method: "post",
      data,
    });
  },

  update(id: number, data: CompanyForm) {
    return request({
      url: `${COMPANY_BASE_URL}/${id}`,
      method: "put",
      data,
    });
  },

  deleteByIds(ids: string) {
    return request({
      url: `${COMPANY_BASE_URL}/${ids}`,
      method: "delete",
    });
  },
};

export default CompanyAPI;
