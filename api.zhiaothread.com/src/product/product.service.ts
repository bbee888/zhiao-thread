import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository, In } from "typeorm";
import { Product } from "./entities/product.entity";
import { ProductLang } from "./entities/product-lang.entity";
import { ProductCategory } from "./entities/product-category.entity";
import { ProductCategoryLang } from "./entities/product-category-lang.entity";
import { CreateProductDto, ProductLangData } from "./dto/create-product.dto";
import { UpdateProductDto } from "./dto/update-product.dto";
import { CreateProductCategoryDto } from "./dto/create-product-category.dto";
import { UpdateProductCategoryDto } from "./dto/update-product-category.dto";

@Injectable()
export class ProductService {
  constructor(
    @InjectRepository(Product)
    private readonly productRepository: Repository<Product>,
    @InjectRepository(ProductLang)
    private readonly productLangRepository: Repository<ProductLang>,
    @InjectRepository(ProductCategory)
    private readonly productCategoryRepository: Repository<ProductCategory>,
    @InjectRepository(ProductCategoryLang)
    private readonly productCategoryLangRepository: Repository<ProductCategoryLang>
  ) {}

  // ==================== 产品分类相关方法 ====================

  /**
   * 获取产品分类树形列表
   */
  async findCategoryTree(keyword?: string, status?: number) {
    const queryBuilder = this.productCategoryRepository.createQueryBuilder("category");
    queryBuilder.where("category.isDeleted = :isDeleted", { isDeleted: 0 });

    if (keyword) {
      // 通过多语言表搜索名称
      const langIds = await this.productCategoryLangRepository
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
      const allLangs = await this.productCategoryLangRepository.find({
        where: { cateId: In(cateIds) },
      });
      allLangs.forEach((lang) => {
        if (!langDataMap.has(lang.cateId)) {
          langDataMap.set(lang.cateId, {});
        }
        langDataMap.get(lang.cateId)[lang.lang] = lang.name;
      });
    }

    const treeData = categoryList.map((c) => ({
      ...c,
      langData: langDataMap.get(c.id) || {},
    }));

    return this.buildCategoryTree(treeData);
  }

  /**
   * 获取产品分类下拉选项
   */
  async findCategoryOptions() {
    const categories = await this.productCategoryRepository.find({
      where: { isDeleted: 0 },
      order: { sort: "ASC" },
    });

    const cateIds = categories.map((c) => c.id);
    const langDataMap = new Map<number, string>();
    if (cateIds.length > 0) {
      const zhLangs = await this.productCategoryLangRepository.find({
        where: { cateId: In(cateIds), lang: "zh" },
      });
      zhLangs.forEach((l) => langDataMap.set(l.cateId, l.name));
    }

    return categories.map((c) => ({
      value: c.id,
      label: langDataMap.get(c.id) || `分类 ${c.id}`,
    }));
  }

  private buildOptionsTree(items: any[]): any[] {
    const map = new Map();
    const roots = [];

    items.forEach((item) => {
      map.set(item.value, { ...item, children: [] });
    });

    items.forEach((item) => {
      const node = map.get(item.value);
      if (!item.parentId || item.parentId === 0) {
        roots.push(node);
      } else {
        const parent = map.get(item.parentId);
        if (parent) {
          parent.children.push(node);
        } else {
          roots.push(node);
        }
      }
    });

    return roots;
  }

  /**
   * 创建产品分类
   */
  async createCategory(createCategoryDto: CreateProductCategoryDto) {
    console.log('[产品分类] 接收到的DTO:', JSON.stringify(createCategoryDto, null, 2));
    
    const category = this.productCategoryRepository.create({
      parentId: createCategoryDto.parentId || 0,
      sort: createCategoryDto.sort || 100,
      status: createCategoryDto.status || 1,
    });

    const savedCategory = await this.productCategoryRepository.save(category);
    console.log('[产品分类] 主表保存成功, ID:', savedCategory.id);

    // 保存多语言数据
    if (createCategoryDto.langData && Object.keys(createCategoryDto.langData).length > 0) {
      console.log('[产品分类] 开始保存多语言数据:', createCategoryDto.langData);
      await this.saveCategoryLangData(savedCategory.id, createCategoryDto.langData);
      console.log('[产品分类] 多语言数据保存成功');
    } else {
      console.log('[产品分类] 没有多语言数据需要保存');
    }

    return savedCategory;
  }

  /**
   * 更新产品分类
   */
  async updateCategory(id: number, updateCategoryDto: UpdateProductCategoryDto) {
    const category = await this.productCategoryRepository.findOne({
      where: { id, isDeleted: 0 },
    });

    if (!category) {
      throw new NotFoundException("分类不存在");
    }

    // 更新分类基本信息
    await this.productCategoryRepository.update(id, {
      parentId: updateCategoryDto.parentId,
      sort: updateCategoryDto.sort,
      status: updateCategoryDto.status,
    });

    // 更新多语言数据
    if (updateCategoryDto.langData) {
      console.log('[产品分类更新] 开始保存多语言数据:', updateCategoryDto.langData);
      await this.saveCategoryLangData(id, updateCategoryDto.langData);
      console.log('[产品分类更新] 多语言数据保存成功');
    }

    return await this.productCategoryRepository.findOne({ where: { id } });
  }

  /**
   * 获取产品分类表单数据（包含多语言）
   */
  async getCategoryForm(id: number) {
    const category = await this.productCategoryRepository.findOne({
      where: { id, isDeleted: 0 },
    });

    if (!category) {
      throw new NotFoundException("分类不存在");
    }

    // 获取多语言数据
    const langData = await this.productCategoryLangRepository.find({
      where: { cateId: id },
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
   * 删除产品分类
   */
  async deleteCategory(ids: number[]) {
    console.log('[产品分类删除] 接收到的ids:', ids);
    
    if (!ids || ids.length === 0) {
      throw new Error('删除的ID列表不能为空');
    }

    // 检查是否有子分类
    for (const id of ids) {
      console.log(`[产品分类删除] 检查分类 ${id} 是否有子分类`);
      const hasChildren = await this.productCategoryRepository.findOne({
        where: { parentId: id, isDeleted: 0 },
      });
      if (hasChildren) {
        throw new Error(`分类 ID ${id} 下有子分类，无法删除`);
      }

      // 检查是否有产品关联（排除已删除的产品）
      console.log(`[产品分类删除] 检查分类 ${id} 是否有产品关联`);
      const hasProducts = await this.productRepository.findOne({
        where: { cateId: id, isDeleted: 0 },
      });
      if (hasProducts) {
        throw new Error(`分类 ID ${id} 下有产品关联，无法删除`);
      }
    }

    // 逻辑删除分类
    console.log('[产品分类删除] 开始逻辑删除分类，ids:', ids);
    await this.productCategoryRepository.update(ids, { isDeleted: 1 } as Partial<ProductCategory>);
    console.log('[产品分类删除] 分类逻辑删除成功');

    // 删除多语言数据 - 使用 createQueryBuilder 支持批量删除
    console.log('[产品分类删除] 开始删除多语言数据，ids:', ids);
    await this.productCategoryLangRepository
      .createQueryBuilder()
      .delete()
      .where("cate_id IN (:...ids)", { ids })
      .execute();
    console.log('[产品分类删除] 多语言数据删除成功');
  }

  /**
   * 保存分类多语言数据
   */
  private async saveCategoryLangData(
    cateId: number,
    langData: Record<string, string>
  ): Promise<void> {
    try {
      console.log('[产品分类] saveCategoryLangData 参数 - cateId:', cateId, 'langData:', JSON.stringify(langData));
      
      // 过滤掉空值
      const filteredLangData = Object.entries(langData).filter(([_, name]) => name && name.trim() !== '');
      console.log('[产品分类] 过滤后的多语言数据:', JSON.stringify(Object.fromEntries(filteredLangData)));
      
      if (filteredLangData.length === 0) {
        console.log('[产品分类] 没有有效的多语言数据需要保存');
        return;
      }

      // 删除旧的多语言数据
      console.log('[产品分类] 删除旧的多语言数据，cateId:', cateId);
      await this.productCategoryLangRepository.delete({ cateId });
      console.log('[产品分类] 旧数据删除成功');

      // 插入新的多语言数据
      const langEntities = filteredLangData.map(([lang, name]) =>
        this.productCategoryLangRepository.create({
          cateId,
          lang,
          name,
        })
      );
      console.log('[产品分类] 准备保存的多语言实体:', JSON.stringify(langEntities));

      const result = await this.productCategoryLangRepository.save(langEntities);
      console.log('[产品分类] 多语言数据保存成功，结果:', JSON.stringify(result));
    } catch (error) {
      console.error('[产品分类] 保存多语言数据失败:', error);
      throw error;
    }
  }

  // ==================== 产品相关方法 ====================

  /**
   * 查询产品列表（分页）
   */
  async findProducts(
    page: number = 1,
    limit: number = 10,
    cateId?: number,
    keyword?: string,
    status?: number
  ) {
    const queryBuilder = this.productRepository.createQueryBuilder("product");
    queryBuilder.where("product.isDeleted = :isDeleted", { isDeleted: 0 });

    if (cateId) {
      queryBuilder.andWhere("product.cate_id = :cateId", { cateId });
    }

    if (keyword) {
      // 通过多语言表搜索标题
      const langIds = await this.productLangRepository
        .createQueryBuilder("lang")
        .select("lang.productId")
        .where("lang.title LIKE :keyword", { keyword: `%${keyword}%` })
        .getRawMany();

      if (langIds.length > 0) {
        const productIds = langIds.map((item) => item.productId);
        queryBuilder.andWhere("product.id IN (:...productIds)", { productIds });
      } else {
        queryBuilder.andWhere("1=0"); // 无匹配结果
      }
    }

    if (status !== undefined && status !== null) {
      queryBuilder.andWhere("product.status = :status", { status });
    }

    queryBuilder.orderBy("product.sort", "ASC").addOrderBy("product.createTime", "DESC");

    const [items, total] = await queryBuilder
      .skip((page - 1) * limit)
      .take(limit)
      .getManyAndCount();

    // 获取每个产品的多语言数据和分类信息
    const itemsWithLang = await Promise.all(
      items.map(async (item) => {
        const [langData, categoryLang] = await Promise.all([
          this.productLangRepository.find({
            where: { productId: item.id },
          }),
          item.cateId
            ? this.productCategoryLangRepository.findOne({
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

    return {
      items: itemsWithLang,
      total,
    };
  }

  /**
   * 获取前台产品详情（包含多语言与分类多语言）
   */
  async getProductDetail(id: number) {
    const product = await this.productRepository.findOne({
      where: { id, isDeleted: 0, status: 1 },
    });

    if (!product) {
      throw new NotFoundException("产品不存在");
    }

    const [langData, categoryLangData] = await Promise.all([
      this.productLangRepository.find({ where: { productId: product.id } }),
      product.cateId
        ? this.productCategoryLangRepository.find({ where: { cateId: product.cateId } })
        : Promise.resolve([]),
    ]);

    const categoryLangMap = (categoryLangData || []).reduce((acc, item) => {
      acc[item.lang] = { name: item.name, description: item.description };
      return acc;
    }, {} as Record<string, any>);

    const productLangMap = (langData || []).reduce((acc, lang) => {
      acc[lang.lang] = {
        title: lang.title,
        content: lang.content,
        keywords: lang.keywords,
        description: lang.description,
      };
      return acc;
    }, {} as Record<string, any>);

    const zhCategory = product.cateId
      ? await this.productCategoryLangRepository.findOne({ where: { cateId: product.cateId, lang: "zh" } })
      : null;

    return {
      ...product,
      categoryName: zhCategory ? zhCategory.name : "",
      categoryLangData: categoryLangMap,
      langData: productLangMap,
    };
  }

  /**
   * 获取产品表单数据（包含多语言）
   */
  async getProductForm(id: number) {
    const product = await this.productRepository.findOne({
      where: { id, isDeleted: 0 },
    });

    if (!product) {
      throw new NotFoundException("产品不存在");
    }

    const langData = await this.productLangRepository.find({
      where: { productId: id },
    });

    return {
      ...product,
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
   * 创建产品
   */
  async createProduct(createProductDto: CreateProductDto) {
    console.log('[产品] 接收到的DTO:', JSON.stringify(createProductDto, null, 2));
    
    const product = this.productRepository.create({
      cateId: createProductDto.cateId,
      cover: createProductDto.cover || "",
      price: createProductDto.price || 0,
      model: createProductDto.model || "",
      color: createProductDto.color || "",
      length: createProductDto.length || "",
      tenacity: createProductDto.tenacity || "",
      sort: createProductDto.sort || 100,
      status: createProductDto.status || 1,
    });

    const savedProduct = await this.productRepository.save(product);
    console.log('[产品] 主表保存成功, ID:', savedProduct.id);

    // 保存多语言数据
    if (createProductDto.langData && Object.keys(createProductDto.langData).length > 0) {
      console.log('[产品] 开始保存多语言数据:', createProductDto.langData);
      await this.saveProductLangData(savedProduct.id, createProductDto.langData);
      console.log('[产品] 多语言数据保存成功');
    } else {
      console.log('[产品] 没有多语言数据需要保存');
    }

    return savedProduct;
  }

  /**
   * 更新产品
   */
  async updateProduct(id: number, updateProductDto: UpdateProductDto) {
    const product = await this.productRepository.findOne({
      where: { id, isDeleted: 0 },
    });

    if (!product) {
      throw new NotFoundException("产品不存在");
    }

    // 更新产品基本信息
    await this.productRepository.update(id, {
      cateId: updateProductDto.cateId,
      cover: updateProductDto.cover,
      price: updateProductDto.price,
      model: updateProductDto.model,
      color: updateProductDto.color,
      length: updateProductDto.length,
      tenacity: updateProductDto.tenacity,
      sort: updateProductDto.sort,
      status: updateProductDto.status,
    });

    // 更新多语言数据
    if (updateProductDto.langData) {
      console.log('[产品更新] 开始保存多语言数据:', updateProductDto.langData);
      await this.saveProductLangData(id, updateProductDto.langData);
      console.log('[产品更新] 多语言数据保存成功');
    }

    return await this.productRepository.findOne({ where: { id } });
  }

  /**
   * 删除产品
   */
  async deleteProduct(ids: number[]) {
    // 逻辑删除产品
    await this.productRepository.update(ids, { isDeleted: 1 } as Partial<Product>);

    // 删除多语言数据 - 使用 createQueryBuilder 支持批量删除
    await this.productLangRepository
      .createQueryBuilder()
      .delete()
      .where("product_id IN (:...ids)", { ids })
      .execute();
  }

  /**
   * 保存产品多语言数据
   */
  private async saveProductLangData(
    productId: number,
    langData: Record<string, ProductLangData>
  ): Promise<void> {
    try {
      console.log('[产品] saveProductLangData 参数 - productId:', productId, 'langData:', JSON.stringify(langData));
      
      // 过滤掉空值
      const filteredLangData = Object.entries(langData).filter(([_, data]) => data && data.title && data.title.trim() !== '');
      console.log('[产品] 过滤后的多语言数据:', JSON.stringify(Object.fromEntries(filteredLangData)));
      
      if (filteredLangData.length === 0) {
        console.log('[产品] 没有有效的多语言数据需要保存');
        return;
      }

      // 删除旧的多语言数据
      console.log('[产品] 删除旧的多语言数据，productId:', productId);
      await this.productLangRepository.delete({ productId });
      console.log('[产品] 旧数据删除成功');

      // 插入新的多语言数据
      const langEntities = filteredLangData.map(([lang, data]) =>
        this.productLangRepository.create({
          productId,
          lang,
          title: data.title,
          content: data.content || "",
          keywords: data.keywords || "",
          description: data.description || "",
        })
      );
      console.log('[产品] 准备保存的多语言实体:', JSON.stringify(langEntities));

      const result = await this.productLangRepository.save(langEntities);
      console.log('[产品] 多语言数据保存成功，结果:', JSON.stringify(result));
    } catch (error) {
      console.error('[产品] 保存多语言数据失败:', error);
      throw error;
    }
  }

  /**
   * 构建分类树结构
   */
  private buildCategoryTree(categoryList: ProductCategory[]): any[] {
    const map: { [key: number]: any } = {};
    const roots: any[] = [];

    categoryList.forEach((category) => {
      map[category.id] = {
        ...category,
        children: [],
      };
    });

    categoryList.forEach((category) => {
      if (category.parentId === 0 || category.parentId === null) {
        roots.push(map[category.id]);
      } else {
        if (map[category.parentId]) {
          map[category.parentId].children.push(map[category.id]);
        }
      }
    });

    return roots;
  }

  /**
   * 构建分类选项树
   */
  private buildCategoryOptionsTree(categories: ProductCategory[]): any[] {
    const map: { [key: number]: any } = {};
    const roots: any[] = [];

    categories.forEach((category) => {
      map[category.id] = {
        label: `分类 ID: ${category.id}`, // 默认标签，实际使用时会从多语言表获取
        value: category.id,
        children: [],
      };
    });

    categories.forEach((category) => {
      if (category.parentId === 0 || category.parentId === null) {
        roots.push(map[category.id]);
      } else {
        if (map[category.parentId]) {
          map[category.parentId].children.push(map[category.id]);
        }
      }
    });

    return roots;
  }
}
