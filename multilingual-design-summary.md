# 多语言设计模式总结

## 核心设计原则

所有模块都遵循相同的一对多关系设计：
**主表 (1) ───────► 语言表 (N)**

---

## 模块对比表

### 1. 文章模块 (Article)

#### 主表：`article`
| 字段 | 类型 | 说明 |
|------|------|------|
| id | bigint | 主键 |
| cate_id | int | 分类ID |
| cover | varchar | 封面图 |
| sort | int | 排序 |
| status | tinyint | 状态 (1=发布 0=隐藏) |
| create_by | bigint | 创建人 |
| create_time | datetime | 创建时间 |
| update_by | bigint | 修改人 |
| update_time | datetime | 修改时间 |
| is_deleted | tinyint | 逻辑删除 |

#### 语言表：`article_lang`
| 字段 | 类型 | 说明 |
|------|------|------|
| id | bigint | 主键 |
| article_id | int | 外键，关联 article.id |
| lang | varchar(10) | 语言代码 (zh/en/ar/th/ms/id/vi/fr/it/km) |
| title | varchar(255) | 文章标题 |
| content | longtext | 内容 |
| seo_title | varchar(255) | SEO标题 |
| seo_keywords | varchar(255) | SEO关键词 |
| seo_description | varchar(500) | SEO描述 |
| create_by | bigint | 创建人 |
| create_time | datetime | 创建时间 |
| update_by | bigint | 修改人 |
| update_time | datetime | 修改时间 |
| is_deleted | tinyint | 逻辑删除 |

**联合唯一索引**：`(article_id, lang)`

---

### 2. 文章分类模块 (Article Category)

#### 主表：`article_category`
| 字段 | 类型 | 说明 |
|------|------|------|
| id | bigint | 主键 |
| sort | int | 排序 |
| status | tinyint | 状态 (1=启用 0=禁用) |
| create_by | bigint | 创建人 |
| create_time | datetime | 创建时间 |
| update_by | bigint | 修改人 |
| update_time | datetime | 修改时间 |
| is_deleted | tinyint | 逻辑删除 |

#### 语言表：`article_category_lang`
| 字段 | 类型 | 说明 |
|------|------|------|
| id | bigint | 主键 |
| cate_id | int | 外键，关联 article_category.id |
| lang | varchar(10) | 语言代码 |
| name | varchar(100) | 分类名称 |
| create_by | bigint | 创建人 |
| create_time | datetime | 创建时间 |
| update_by | bigint | 修改人 |
| update_time | datetime | 修改时间 |
| is_deleted | tinyint | 逻辑删除 |

**联合唯一索引**：`(cate_id, lang)`

---

### 3. 产品模块 (Product)

#### 主表：`product`
| 字段 | 类型 | 说明 |
|------|------|------|
| id | bigint | 主键 |
| cate_id | int | 分类ID |
| cover | varchar(255) | 主图 |
| price | decimal(10,2) | 价格 |
| model | varchar(100) | 型号 |
| sort | int | 排序 |
| status | tinyint | 状态 (1=上架 0=下架) |
| create_by | bigint | 创建人 |
| create_time | datetime | 创建时间 |
| update_by | bigint | 修改人 |
| update_time | datetime | 修改时间 |
| is_deleted | tinyint | 逻辑删除 |

#### 语言表：`product_lang`
| 字段 | 类型 | 说明 |
|------|------|------|
| id | bigint | 主键 |
| product_id | int | 外键，关联 product.id |
| lang | varchar(10) | 语言代码 |
| title | varchar(255) | 产品标题 |
| content | longtext | 详情内容 |
| seo_title | varchar(255) | SEO标题 |
| seo_keywords | varchar(255) | SEO关键词 |
| seo_description | varchar(500) | SEO描述 |
| create_by | bigint | 创建人 |
| create_time | datetime | 创建时间 |
| update_by | bigint | 修改人 |
| update_time | datetime | 修改时间 |
| is_deleted | tinyint | 逻辑删除 |

**联合唯一索引**：`(product_id, lang)`

---

### 4. 产品分类模块 (Product Category)

#### 主表：`product_category`
| 字段 | 类型 | 说明 |
|------|------|------|
| id | bigint | 主键 |
| parent_id | int | 父分类ID |
| sort | int | 排序 |
| status | tinyint | 状态 (1=启用 0=禁用) |
| create_by | bigint | 创建人 |
| create_time | datetime | 创建时间 |
| update_by | bigint | 修改人 |
| update_time | datetime | 修改时间 |
| is_deleted | tinyint | 逻辑删除 |

#### 语言表：`product_category_lang`
| 字段 | 类型 | 说明 |
|------|------|------|
| id | bigint | 主键 |
| cate_id | int | 外键，关联 product_category.id |
| lang | varchar(10) | 语言代码 |
| name | varchar(100) | 分类名称 |
| create_by | bigint | 创建人 |
| create_time | datetime | 创建时间 |
| update_by | bigint | 修改人 |
| update_time | datetime | 修改时间 |
| is_deleted | tinyint | 逻辑删除 |

**联合唯一索引**：`(cate_id, lang)`

---

## 统一设计模式

### 1. 实体类结构（TypeORM）

所有语言表实体都遵循相同模式：

```typescript
@Entity("table_name_lang")
@Unique(["foreign_key_id", "lang"])  // 联合唯一索引
export class TableNameLang extends BaseEntity {
  @Column({ name: "foreign_key_id", type: "int", comment: "外键ID" })
  foreignKeyId: number;

  @Column({ type: "varchar", length: 10, comment: "语言代码" })
  lang: string;

  // 语言相关字段
  @Column({ name: "title/name", type: "varchar", length: 255, comment: "标题/名称" })
  title/name: string;

  // 其他SEO字段（可选）
  @Column({ name: "seo_title", type: "varchar", length: 255, default: "", comment: "SEO标题" })
  seoTitle: string;

  // ...其他SEO字段

  @ManyToOne(() => MainTable)
  @JoinColumn({ name: "foreign_key_id" })
  mainTable: MainTable;
}
```

### 2. DTO结构

所有创建DTO都遵循相同模式：

```typescript
export class CreateDto {
  // 公共字段（不依赖语言）
  sort?: number = 100;
  status?: number = 1;
  // ...其他公共字段

  // 多语言数据
  langData?: Record<string, LangData>;
}

export class LangData {
  title: string;  // 或 name: string
  content?: string;
  seoTitle?: string;
  seoKeywords?: string;
  seoDescription?: string;
}
```

### 3. Service层逻辑

所有Service都遵循相同的保存逻辑：

```typescript
async create(dto: CreateDto) {
  // 1. 保存主表
  const mainEntity = this.mainRepository.create({
    sort: dto.sort,
    status: dto.status,
    // ...其他公共字段
  });
  const saved = await this.mainRepository.save(mainEntity);

  // 2. 保存多语言数据
  if (dto.langData) {
    await this.saveLangData(saved.id, dto.langData);
  }

  return saved;
}

private async saveLangData(id: number, langData: Record<string, any>) {
  // 1. 删除旧数据
  await this.langRepository.delete({ foreignKeyId: id });

  // 2. 插入新数据
  const entities = Object.entries(langData).map(([lang, data]) =>
    this.langRepository.create({
      foreignKeyId: id,
      lang,
      ...data,
    })
  );

  await this.langRepository.save(entities);
}
```

### 4. 查询逻辑

所有查询都遵循相同模式：

```typescript
async findAll() {
  // 1. 查询主表
  const mainList = await this.mainRepository.find({ ... });

  // 2. 获取所有ID
  const ids = mainList.map(item => item.id);

  // 3. 批量查询语言数据
  const langData = await this.langRepository.find({
    where: { foreignKeyId: In(ids) }
  });

  // 4. 合并数据
  return mainList.map(item => ({
    ...item,
    langData: langData
      .filter(lang => lang.foreignKeyId === item.id)
      .reduce((acc, lang) => {
        acc[lang.lang] = {
          title: lang.title,
          // ...其他字段
        };
        return acc;
      }, {})
  }));
}
```

---

## 当前实现状态

### ✅ 已正确实现的模块
1. **article** ↔ **article_lang** ✓
2. **article_category** ↔ **article_category_lang** ✓
3. **product_category** ↔ **product_category_lang** ✓
4. **product** ↔ **product_lang** ✓

### ✅ 已实现的功能
- 实体类定义（带联合唯一索引）
- DTO定义
- Service层CRUD操作
- 批量保存多语言数据
- 查询时合并多语言数据
- 更新时删除旧数据并插入新数据
- 详细的日志记录
- 空值过滤

### 📋 待测试的功能
- [ ] 文章分类多语言保存
- [ ] 文章多语言保存
- [ ] 产品分类多语言保存
- [ ] 产品多语言保存

---

## 数据库验证

运行以下脚本验证数据库结构：

```bash
/Users/shangxb/fastapi-vue3/nextjs+vue3/verify-multilingual.sh
```

预期输出：
```
✓ article_lang 联合唯一索引存在 (article_id, lang)
✓ article_category_lang 联合唯一索引存在 (cate_id, lang)
✓ product_lang 联合唯一索引存在 (product_id, lang)
✓ product_category_lang 联合唯一索引存在 (cate_id, lang)
```

---

## 测试步骤

### 1. 重启后端服务
```bash
cd /Users/shangxb/fastapi-vue3/nextjs+vue3/youlai-nest
npm run start:dev
```

### 2. 测试文章分类
访问：http://localhost:3000/article/category

### 3. 查看日志
观察控制台输出，确认完整的日志流程。

### 4. 验证数据库
```bash
mysql -u root -p123456 -D youlai_admin -e "
SELECT * FROM article_category_lang 
WHERE cate_id = [你的分类ID] 
ORDER BY lang;
"
```

---

## 总结

所有4个模块（文章、文章分类、产品、产品分类）都遵循**完全相同**的设计模式：

1. **主表**存储公共字段（排序、状态、创建人等）
2. **语言表**存储语言相关字段（标题、内容、SEO等）
3. **一对多关系**：1条主表记录对应N条语言记录
4. **联合唯一索引**：确保每种语言只有一条记录
5. **批量操作**：保存时先删旧数据，再插入新数据
6. **审计字段**：所有表都继承 BaseEntity，自动填充创建人、创建时间等

这个设计具有**高度一致性**、**可扩展性**和**可维护性**！
