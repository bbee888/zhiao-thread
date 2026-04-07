import request from "@/utils/request";

export interface ArticleLangData {
  title: string;
  content?: string;
  keywords?: string;
  description?: string;
}

export interface ArticleItem {
  id?: number;
  cateId?: number;
  cover?: string;
  sort?: number;
  status?: number;
  langData?: Record<string, ArticleLangData>;
}

export interface ArticleForm {
  id?: number;
  cateId: number;
  cover?: string;
  sort?: number;
  status?: number;
  langData?: Record<string, ArticleLangData>;
}

export interface ArticleListResponse {
  items: ArticleItem[];
  total: number;
}

const ARTICLE_BASE_URL = "/api/v1/articles";

const ArticleAPI = {
  getList(params?: { page?: number; limit?: number; cateId?: number; keywords?: string; status?: number }) {
    return request<any, ArticleListResponse>({
      url: ARTICLE_BASE_URL,
      method: "get",
      params,
    });
  },

  getFormData(id: number) {
    return request<any, ArticleForm>({
      url: `${ARTICLE_BASE_URL}/${id}/form`,
      method: "get",
    });
  },

  create(data: ArticleForm) {
    return request({
      url: ARTICLE_BASE_URL,
      method: "post",
      data,
    });
  },

  update(id: number, data: ArticleForm) {
    return request({
      url: `${ARTICLE_BASE_URL}/${id}`,
      method: "put",
      data,
    });
  },

  deleteByIds(ids: string) {
    return request({
      url: `${ARTICLE_BASE_URL}/${ids}`,
      method: "delete",
    });
  },
};

export default ArticleAPI;
