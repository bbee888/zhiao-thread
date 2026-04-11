import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository, In } from "typeorm";
import { Article } from "./entities/article.entity";
import { ArticleLang } from "./entities/article-lang.entity";
import { ArticleCategory } from "./entities/article-category.entity";
import { ArticleCategoryLang } from "./entities/article-category-lang.entity";
import { CreateArticleDto, ArticleLangData } from "./dto/create-article.dto";
import { UpdateArticleDto } from "./dto/update-article.dto";
import { CreateArticleCategoryDto } from "./dto/create-article-category.dto";
import { UpdateArticleCategoryDto } from "./dto/update-article-category.dto";

@Injectable()
export class ArticleService {
  constructor(
    @InjectRepository(Article)
    private readonly articleRepository: Repository<Article>,
    @InjectRepository(ArticleLang)
    private readonly articleLangRepository: Repository<ArticleLang>,
    @InjectRepository(ArticleCategory)
    private readonly articleCategoryRepository: Repository<ArticleCategory>,
    @InjectRepository(ArticleCategoryLang)
    private readonly articleCategoryLangRepository: Repository<ArticleCategoryLang>
  ) {}

  // ==================== 文章分类相关方法 ====================

  /**
   * 查询文章分类列表
   */
  async findCategoryTree(keyword?: string, status?: number) {
    const queryBuilder = this.articleCategoryRepository.createQueryBuilder("category");
    queryBuilder.where("category.isDeleted = :isDeleted", { isDeleted: 0 });

    if (keyword) {
      // 通过多语言表搜索名称
      const langIds = await this.articleCategoryLangRepository
        .createQueryBuilder("lang")
        .select("lang.cateId")
        .where("lang.name LIKE :keyword", { keyword: `%${keyword}%` })
        .getRawMany();

      if (langIds.length > 0) {
        const cateIds = langIds.map((item) => item.cateId);
        queryBuilder.andWhere("category.id IN (:...cateIds)", { cateIds });
      } else {
        queryBuilder.andWhere("1=0");
      }
    }

    if (status !== undefined && status !== null) {
      queryBuilder.andWhere("category.status = :status", { status });
    }

    queryBuilder.orderBy("category.sort", "ASC");
    const categoryList = await queryBuilder.getMany();

    // 加载多语言数据
    const cateIds = categoryList.map((c) => c.id);
    const langDataMap = new Map<number, Record<string, string>>();
    if (cateIds.length > 0) {
      const allLangs = await this.articleCategoryLangRepository.find({
        where: { cateId: In(cateIds) },
      });
      allLangs.forEach((lang) => {
        if (!langDataMap.has(lang.cateId)) {
          langDataMap.set(lang.cateId, {});
        }
        langDataMap.get(lang.cateId)[lang.lang] = lang.name;
      });
    }

    return categoryList.map((c) => ({
      ...c,
      langData: langDataMap.get(c.id) || {},
    }));
  }

  /**
   * 获取文章分类下拉选项
   */
  async findCategoryOptions() {
    const categories = await this.articleCategoryRepository.find({
      where: { isDeleted: 0 },
      order: { sort: "ASC" },
    });

    const cateIds = categories.map((c) => c.id);
    const langDataMap = new Map<number, string>();
    if (cateIds.length > 0) {
      const zhLangs = await this.articleCategoryLangRepository.find({
        where: { cateId: In(cateIds), lang: "zh" },
      });
      zhLangs.forEach((l) => langDataMap.set(l.cateId, l.name));
    }

    return categories.map((c) => ({
      value: c.id,
      label: langDataMap.get(c.id) || `分类 ${c.id}`,
    }));
  }

  /**
   * 获取分类表单数据（包含多语言）
   */
  async getCategoryForm(id: string | number) {
    const idNum = Number(id);
    const category = await this.articleCategoryRepository.findOne({
      where: { id: idNum, isDeleted: 0 },
    });

    if (!category) {
      throw new NotFoundException("分类不存在");
    }

    // 获取多语言数据
    const langData = await this.articleCategoryLangRepository.find({
      where: { cateId: idNum },
    });

    return {
      ...category,
      langData: langData.reduce((acc, item) => {
        acc[item.lang] = item.name;
        return acc;
      }, {} as Record<string, string>),
    };
  }

  /**
   * 创建文章分类
   */
  async createCategory(createCategoryDto: CreateArticleCategoryDto) {
    console.log('[文章分类] 接收到的DTO:', JSON.stringify(createCategoryDto, null, 2));
    
    const category = this.articleCategoryRepository.create({
      sort: createCategoryDto.sort || 100,
      status: createCategoryDto.status || 1,
    });

    const savedCategory = await this.articleCategoryRepository.save(category);
    console.log('[文章分类] 主表保存成功, ID:', savedCategory.id);

    // 保存多语言数据
    if (createCategoryDto.langData && Object.keys(createCategoryDto.langData).length > 0) {
      console.log('[文章分类] 开始保存多语言数据:', createCategoryDto.langData);
      await this.saveCategoryLangData(savedCategory.id, createCategoryDto.langData);
      console.log('[文章分类] 多语言数据保存成功');
    } else {
      console.log('[文章分类] 没有多语言数据需要保存');
    }

    return savedCategory;
  }

  /**
   * 更新文章分类
   */
  async updateCategory(id: string | number, updateCategoryDto: UpdateArticleCategoryDto) {
    const idNum = Number(id);
    const category = await this.articleCategoryRepository.findOne({
      where: { id: idNum, isDeleted: 0 },
    });

    if (!category) {
      throw new NotFoundException("分类不存在");
    }

    // 更新分类基本信息
    await this.articleCategoryRepository.update(idNum, {
      sort: updateCategoryDto.sort,
      status: updateCategoryDto.status,
    });

    // 更新多语言数据
    if (updateCategoryDto.langData) {
      console.log('[文章分类更新] 开始保存多语言数据:', updateCategoryDto.langData);
      await this.saveCategoryLangData(idNum, updateCategoryDto.langData);
      console.log('[文章分类更新] 多语言数据保存成功');
    }

    return await this.articleCategoryRepository.findOne({ where: { id: idNum } });
  }

  /**
   * 删除文章分类
   */
  async deleteCategory(ids: (string | number)[]) {
    const idNums = ids.map((id) => Number(id));
    // 检查是否有文章关联（排除已删除的文章）
    for (const id of idNums) {
      const hasArticles = await this.articleRepository.findOne({
        where: { cateId: id, isDeleted: 0 },
      });
      if (hasArticles) {
        throw new Error(`分类 ID ${id} 下有文章关联，无法删除`);
      }
    }

    // 逻辑删除分类
    await this.articleCategoryRepository.update(idNums, { isDeleted: 1 });

    // 删除多语言数据 - 使用 createQueryBuilder 支持批量删除
    await this.articleCategoryLangRepository
      .createQueryBuilder()
      .delete()
      .where("cate_id IN (:...ids)", { ids: idNums })
      .execute();
  }

  /**
   * 保存分类多语言数据
   */
  private async saveCategoryLangData(
    cateId: number,
    langData: Record<string, string>
  ): Promise<void> {
    try {
      console.log('[文章分类] saveCategoryLangData 参数 - cateId:', cateId, 'langData:', JSON.stringify(langData));
      
      // 过滤掉空值
      const filteredLangData = Object.entries(langData).filter(([_, name]) => name && name.trim() !== '');
      console.log('[文章分类] 过滤后的多语言数据:', JSON.stringify(Object.fromEntries(filteredLangData)));
      
      if (filteredLangData.length === 0) {
        console.log('[文章分类] 没有有效的多语言数据需要保存');
        return;
      }

      // 删除旧的多语言数据
      console.log('[文章分类] 删除旧的多语言数据，cateId:', cateId);
      await this.articleCategoryLangRepository.delete({ cateId });
      console.log('[文章分类] 旧数据删除成功');

      // 插入新的多语言数据
      const langEntities = filteredLangData.map(([lang, name]) =>
        this.articleCategoryLangRepository.create({
          cateId,
          lang,
          name,
        })
      );
      console.log('[文章分类] 准备保存的多语言实体:', JSON.stringify(langEntities));

      const result = await this.articleCategoryLangRepository.save(langEntities);
      console.log('[文章分类] 多语言数据保存成功，结果:', JSON.stringify(result));
    } catch (error) {
      console.error('[文章分类] 保存多语言数据失败:', error);
      throw error;
    }
  }

  // ==================== 文章相关方法 ====================

  /**
   * 查询文章列表（分页）
   */
  async findArticles(page: number = 1, limit: number = 10, cateId?: number, keyword?: string, status?: number) {
    const queryBuilder = this.articleRepository.createQueryBuilder("article");
    queryBuilder.where("article.isDeleted = :isDeleted", { isDeleted: 0 });

    if (cateId) {
      queryBuilder.andWhere("article.cate_id = :cateId", { cateId });
    }

    if (keyword) {
      // 通过多语言表搜索标题
      const langIds = await this.articleLangRepository
        .createQueryBuilder("lang")
        .select("lang.articleId")
        .where("lang.title LIKE :keyword", { keyword: `%${keyword}%` })
        .getRawMany();

      if (langIds.length > 0) {
        const articleIds = langIds.map((item) => item.articleId);
        queryBuilder.andWhere("article.id IN (:...articleIds)", { articleIds });
      } else {
        queryBuilder.andWhere("1=0"); // 无匹配结果
      }
    }

    if (status !== undefined && status !== null) {
      queryBuilder.andWhere("article.status = :status", { status });
    }

    queryBuilder.orderBy("article.sort", "ASC").addOrderBy("article.createTime", "DESC");

    const [items, total] = await queryBuilder.skip((page - 1) * limit).take(limit).getManyAndCount();

    // 获取每个文章的多语言数据和分类信息
    const itemsWithLang = await Promise.all(
      items.map(async (item) => {
        const [langData, categoryLang] = await Promise.all([
          this.articleLangRepository.find({
            where: { articleId: item.id },
          }),
          item.cateId
            ? this.articleCategoryLangRepository.findOne({
                where: { cateId: item.cateId, lang: "zh" },
              })
            : null,
        ]);

        return {
          ...item,
          categoryName: categoryLang ? categoryLang.name : "",
          langData: langData.reduce((acc, lang) => {
            acc[lang.lang] = {
              title: lang.title,
              content: lang.content,
              keywords: lang.keywords,
              description: lang.description,
            };
            return acc;
          }, {} as Record<string, any>),
        };
      })
    );

    return { items: itemsWithLang, total };
  }

  /**
   * 获取文章表单数据（包含多语言）
   */
  async getArticleForm(id: string | number) {
    const idNum = Number(id);
    const article = await this.articleRepository.findOne({
      where: { id: idNum, isDeleted: 0 },
    });

    if (!article) {
      throw new NotFoundException("文章不存在");
    }

    // 获取多语言数据
    const langData = await this.articleLangRepository.find({
      where: { articleId: idNum },
    });

    return {
      ...article,
      langData: langData.reduce(
        (acc, item) => {
          acc[item.lang] = {
            title: item.title,
            content: item.content,
            keywords: item.keywords,
            description: item.description,
          };
          return acc;
        },
        {} as Record<string, any>
      ),
    };
  }

  /**
   * 创建文章
   */
  async createArticle(createArticleDto: CreateArticleDto) {
    console.log('[文章] 接收到的DTO:', JSON.stringify(createArticleDto, null, 2));
    
    const article = this.articleRepository.create({
      cateId: createArticleDto.cateId ? Number(createArticleDto.cateId) : undefined,
      cover: createArticleDto.cover || "",
      sort: createArticleDto.sort || 100,
      status: createArticleDto.status || 1,
    });

    const savedArticle = await this.articleRepository.save(article);
    console.log('[文章] 主表保存成功, ID:', savedArticle.id);

    // 保存多语言数据
    if (createArticleDto.langData && Object.keys(createArticleDto.langData).length > 0) {
      console.log('[文章] 开始保存多语言数据:', createArticleDto.langData);
      await this.saveArticleLangData(savedArticle.id, createArticleDto.langData);
      console.log('[文章] 多语言数据保存成功');
    } else {
      console.log('[文章] 没有多语言数据需要保存');
    }

    return savedArticle;
  }

  /**
   * 更新文章
   */
  async updateArticle(id: string | number, updateArticleDto: UpdateArticleDto) {
    const idNum = Number(id);
    const article = await this.articleRepository.findOne({
      where: { id: idNum, isDeleted: 0 },
    });

    if (!article) {
      throw new NotFoundException("文章不存在");
    }

    // 更新文章基本信息
    await this.articleRepository.update(idNum, {
      cateId: updateArticleDto.cateId ? Number(updateArticleDto.cateId) : undefined,
      cover: updateArticleDto.cover,
      sort: updateArticleDto.sort,
      status: updateArticleDto.status,
    });

    // 更新多语言数据
    if (updateArticleDto.langData) {
      console.log('[文章更新] 开始保存多语言数据:', updateArticleDto.langData);
      await this.saveArticleLangData(idNum, updateArticleDto.langData);
      console.log('[文章更新] 多语言数据保存成功');
    }

    return await this.articleRepository.findOne({ where: { id: idNum } });
  }

  /**
   * 删除文章
   */
  async deleteArticle(ids: (string | number)[]) {
    const idNums = ids.map((id) => Number(id));
    // 逻辑删除文章
    await this.articleRepository.update(idNums, { isDeleted: 1 });

    // 删除多语言数据 - 使用 createQueryBuilder 支持批量删除
    await this.articleLangRepository
      .createQueryBuilder()
      .delete()
      .where("article_id IN (:...ids)", { ids: idNums })
      .execute();
  }

  /**
   * 保存文章多语言数据
   */
  private async saveArticleLangData(
    articleId: number,
    langData: Record<string, ArticleLangData>
  ): Promise<void> {
    try {
      console.log('[文章] saveArticleLangData 参数 - articleId:', articleId, 'langData:', JSON.stringify(langData));
      
      // 过滤掉空值
      const filteredLangData = Object.entries(langData).filter(([_, data]) => data && data.title && data.title.trim() !== '');
      console.log('[文章] 过滤后的多语言数据:', JSON.stringify(Object.fromEntries(filteredLangData)));
      
      if (filteredLangData.length === 0) {
        console.log('[文章] 没有有效的多语言数据需要保存');
        return;
      }

      // 删除旧的多语言数据
      console.log('[文章] 删除旧的多语言数据，articleId:', articleId);
      await this.articleLangRepository.delete({ articleId });
      console.log('[文章] 旧数据删除成功');

      // 插入新的多语言数据
      const langEntities = filteredLangData.map(([lang, data]) =>
        this.articleLangRepository.create({
          articleId,
          lang,
          title: data.title,
          content: data.content || "",
          keywords: data.keywords || "",
          description: data.description || "",
        })
      );
      console.log('[文章] 准备保存的多语言实体:', JSON.stringify(langEntities));

      const result = await this.articleLangRepository.save(langEntities);
      console.log('[文章] 多语言数据保存成功，结果:', JSON.stringify(result));
    } catch (error) {
      console.error('[文章] 保存多语言数据失败:', error);
      throw error;
    }
  }

  /**
   * 构建分类树结构
   */
  private buildCategoryTree(categoryList: ArticleCategory[]): any[] {
    // 文章分类暂不需要树形结构，直接返回
    return categoryList.map((category) => ({
      ...category,
      children: [],
    }));
  }

  /**
   * 构建分类选项树
   */
  private buildCategoryOptionsTree(categories: ArticleCategory[]): any[] {
    return categories.map((category) => ({
      label: `分类 ID: ${String(category.id)}`, // 默认标签，实际使用时会从多语言表获取
      value: String(category.id),
    }));
  }
}
