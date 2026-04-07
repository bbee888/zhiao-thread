import request from "@/utils/request";

export interface ProductLangData {
  title: string;
  content?: string;
  color?: string;
  length?: string;
  tenacity?: string;
  keywords?: string;
  description?: string;
}

export interface ProductItem {
  id?: number;
  cateId?: number;
  cover?: string;
  price?: number;
  model?: string;
  color?: string;
  length?: string;
  tenacity?: string;
  sort?: number;
  status?: number;
  langData?: Record<string, ProductLangData>;
}

export interface ProductForm {
  id?: number;
  cateId: number;
  cover?: string;
  price?: number;
  model?: string;
  color?: string;
  length?: string;
  tenacity?: string;
  sort?: number;
  status?: number;
  langData?: Record<string, ProductLangData>;
}

export interface ProductListResponse {
  items: ProductItem[];
  total: number;
}

const PRODUCT_BASE_URL = "/api/v1/products";

const ProductAPI = {
  getList(params?: { page?: number; limit?: number; cateId?: number; keywords?: string; status?: number }) {
    return request<any, ProductListResponse>({
      url: PRODUCT_BASE_URL,
      method: "get",
      params,
    });
  },

  getFormData(id: number) {
    return request<any, ProductForm>({
      url: `${PRODUCT_BASE_URL}/${id}/form`,
      method: "get",
    });
  },

  create(data: ProductForm) {
    return request({
      url: PRODUCT_BASE_URL,
      method: "post",
      data,
    });
  },

  update(id: number, data: ProductForm) {
    return request({
      url: `${PRODUCT_BASE_URL}/${id}`,
      method: "put",
      data,
    });
  },

  deleteByIds(ids: string) {
    return request({
      url: `${PRODUCT_BASE_URL}/${ids}`,
      method: "delete",
    });
  },
};

export default ProductAPI;
