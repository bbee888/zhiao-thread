import {
  Controller,
  Get,
  Post,
  Body,
  Put,
  Param,
  Delete,
  Query,
} from "@nestjs/common";
import { ArticleService } from "./article.service";
import { CreateArticleDto } from "./dto/create-article.dto";
import { UpdateArticleDto } from "./dto/update-article.dto";
import { CreateArticleCategoryDto } from "./dto/create-article-category.dto";
import { UpdateArticleCategoryDto } from "./dto/update-article-category.dto";
import { ApiOperation, ApiTags } from "@nestjs/swagger";
import { Permissions, Public } from "../common/decorators/public.decorator";

@ApiTags("文章管理")
@Controller("articles")
export class ArticleController {
  constructor(private readonly articleService: ArticleService) {}

  // ==================== 文章分类接口 ====================

  @ApiOperation({ summary: "获取文章分类列表" })
  @Public()
  @Get("categories")
  async getCategories(
    @Query("keywords") keywords?: string,
    @Query("status") status?: number
  ) {
    return await this.articleService.findCategoryTree(keywords, status);
  }

  @ApiOperation({ summary: "获取文章分类下拉选项" })
  @Public()
  @Get("categories/options")
  async getCategoryOptions() {
    return await this.articleService.findCategoryOptions();
  }

  @ApiOperation({ summary: "获取文章分类表单数据" })
  @Get("categories/:id/form")
  async getCategoryForm(@Param("id") id: string) {
    return await this.articleService.getCategoryForm(parseInt(id));
  }

  @ApiOperation({ summary: "创建文章分类" })
  @Post("categories")
  // @Permissions("article:category:create")  // 暂时注释权限验证
  async createCategory(@Body() createCategoryDto: CreateArticleCategoryDto) {
    console.log('[文章分类Controller] 接收到的原始DTO:', JSON.stringify(createCategoryDto, null, 2));
    return await this.articleService.createCategory(createCategoryDto);
  }

  @ApiOperation({ summary: "更新文章分类" })
  @Put("categories/:id")
  // @Permissions("article:category:update")
  async updateCategory(
    @Param("id") id: string,
    @Body() updateCategoryDto: UpdateArticleCategoryDto
  ) {
    return await this.articleService.updateCategory(parseInt(id), updateCategoryDto);
  }

  @ApiOperation({ summary: "删除文章分类" })
  @Delete("categories/:ids")
  // @Permissions("article:category:delete")
  async deleteCategories(@Param("ids") ids: string) {
    console.log('[文章分类Controller] 接收到的ids字符串:', ids);
    const idArray = ids
      .split(",")
      .map((id) => parseInt(id.trim()))
      .filter(Boolean);
    console.log('[文章分类Controller] 解析后的id数组:', idArray);
    return await this.articleService.deleteCategory(idArray);
  }

  // ==================== 文章接口 ====================

  @ApiOperation({ summary: "获取文章列表（分页）" })
  @Public()
  @Get()
  async getArticles(
    @Query("page") page: number = 1,
    @Query("limit") limit: number = 10,
    @Query("cateId") cateId?: number,
    @Query("keywords") keywords?: string,
    @Query("status") status?: number
  ) {
    return await this.articleService.findArticles(page, limit, cateId, keywords, status);
  }

  @ApiOperation({ summary: "获取文章表单数据" })
  @Get(":id/form")
  async getArticleForm(@Param("id") id: string) {
    return await this.articleService.getArticleForm(parseInt(id));
  }

  @ApiOperation({ summary: "创建文章" })
  @Post()
  // @Permissions("article:create")
  async createArticle(@Body() createArticleDto: CreateArticleDto) {
    return await this.articleService.createArticle(createArticleDto);
  }

  @ApiOperation({ summary: "更新文章" })
  @Put(":id")
  // @Permissions("article:update")
  async updateArticle(@Param("id") id: string, @Body() updateArticleDto: UpdateArticleDto) {
    return await this.articleService.updateArticle(parseInt(id), updateArticleDto);
  }

  @ApiOperation({ summary: "删除文章" })
  @Delete(":ids")
  // @Permissions("article:delete")
  async deleteArticles(@Param("ids") ids: string) {
    const idArray = ids
      .split(",")
      .map((id) => parseInt(id.trim()))
      .filter(Boolean);
    return await this.articleService.deleteArticle(idArray);
  }
}
