import request from "@/utils/request";

export interface CategoryItem {
  id?: number;
  sort?: number;
  status?: number;
  children?: CategoryItem[];
  langData?: Record<string, string>;
}

export interface CategoryForm {
  id?: number;
  sort?: number;
  status?: number;
  langData?: Record<string, string>;
}

const CATEGORY_BASE_URL = "/api/v1/articles/categories";

const CategoryAPI = {
  getList(queryParams?: { keywords?: string; status?: number }) {
    return request<any, CategoryItem[]>({
      url: CATEGORY_BASE_URL,
      method: "get",
      params: queryParams,
    });
  },

  getOptions() {
    return request<any, any[]>({
      url: `${CATEGORY_BASE_URL}/options`,
      method: "get",
    });
  },

  getFormData(id: number) {
    return request<any, CategoryForm>({
      url: `${CATEGORY_BASE_URL}/${id}/form`,
      method: "get",
    });
  },

  create(data: CategoryForm) {
    return request({
      url: CATEGORY_BASE_URL,
      method: "post",
      data,
    });
  },

  update(id: number, data: CategoryForm) {
    return request({
      url: `${CATEGORY_BASE_URL}/${id}`,
      method: "put",
      data,
    });
  },

  deleteByIds(ids: string) {
    return request({
      url: `${CATEGORY_BASE_URL}/${ids}`,
      method: "delete",
    });
  },
};

export default CategoryAPI;
