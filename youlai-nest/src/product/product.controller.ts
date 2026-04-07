import { Controller, Get, Post, Body, Put, Param, Delete, Query } from "@nestjs/common";
import { ProductService } from "./product.service";
import { CreateProductDto } from "./dto/create-product.dto";
import { UpdateProductDto } from "./dto/update-product.dto";
import { CreateProductCategoryDto } from "./dto/create-product-category.dto";
import { UpdateProductCategoryDto } from "./dto/update-product-category.dto";
import { ApiOperation, ApiTags } from "@nestjs/swagger";
import { Permissions, Public } from "../common/decorators/public.decorator";

@ApiTags("产品管理")
@Controller("products")
export class ProductController {
  constructor(private readonly productService: ProductService) {}

  // ==================== 产品分类接口 ====================

  @ApiOperation({ summary: "获取产品分类树形列表" })
  @Public()
  @Get("categories")
  async getCategories(@Query("keywords") keywords?: string, @Query("status") status?: number) {
    return await this.productService.findCategoryTree(keywords, status);
  }

  @ApiOperation({ summary: "获取产品分类下拉选项" })
  @Public()
  @Get("categories/options")
  async getCategoryOptions() {
    return await this.productService.findCategoryOptions();
  }

  @ApiOperation({ summary: "获取产品分类表单数据" })
  @Get("categories/:id/form")
  async getCategoryForm(@Param("id") id: string) {
    return await this.productService.getCategoryForm(parseInt(id));
  }

  @ApiOperation({ summary: "创建产品分类" })
  @Post("categories")
  // @Permissions("product:category:create")
  async createCategory(@Body() createCategoryDto: CreateProductCategoryDto) {
    console.log('[产品分类Controller] 接收到的请求体:', JSON.stringify(createCategoryDto, null, 2));
    return await this.productService.createCategory(createCategoryDto);
  }

  @ApiOperation({ summary: "更新产品分类" })
  @Put("categories/:id")
  // @Permissions("product:category:update")
  async updateCategory(
    @Param("id") id: string,
    @Body() updateCategoryDto: UpdateProductCategoryDto
  ) {
    return await this.productService.updateCategory(parseInt(id), updateCategoryDto);
  }

  @ApiOperation({ summary: "删除产品分类" })
  @Delete("categories/:ids")
  // @Permissions("product:category:delete")
  async deleteCategories(@Param("ids") ids: string) {
    console.log('[产品分类Controller] 接收到的ids字符串:', ids);
    const idArray = ids
      .split(",")
      .map((id) => parseInt(id.trim()))
      .filter(Boolean);
    console.log('[产品分类Controller] 解析后的id数组:', idArray);
    return await this.productService.deleteCategory(idArray);
  }

  // ==================== 产品接口 ====================

  @ApiOperation({ summary: "获取产品列表（分页）" })
  @Public()
  @Get()
  async getProducts(
    @Query("page") page: number = 1,
    @Query("limit") limit: number = 10,
    @Query("cateId") cateId?: number,
    @Query("keywords") keywords?: string,
    @Query("status") status?: number
  ) {
    return await this.productService.findProducts(page, limit, cateId, keywords, status);
  }

  @ApiOperation({ summary: "获取产品表单数据" })
  @Get(":id/form")
  async getProductForm(@Param("id") id: string) {
    return await this.productService.getProductForm(parseInt(id));
  }

  @ApiOperation({ summary: "创建产品" })
  @Post()
  // @Permissions("product:create")
  async createProduct(@Body() createProductDto: CreateProductDto) {
    return await this.productService.createProduct(createProductDto);
  }

  @ApiOperation({ summary: "更新产品" })
  @Put(":id")
  // @Permissions("product:update")
  async updateProduct(@Param("id") id: string, @Body() updateProductDto: UpdateProductDto) {
    return await this.productService.updateProduct(parseInt(id), updateProductDto);
  }

  @ApiOperation({ summary: "删除产品" })
  @Delete(":ids")
  // @Permissions("product:delete")
  async deleteProducts(@Param("ids") ids: string) {
    const idArray = ids
      .split(",")
      .map((id) => parseInt(id.trim()))
      .filter(Boolean);
    return await this.productService.deleteProduct(idArray);
  }
}
