# Youlai Admin 系统接口文档

> 版本：v1.0  
> 最后更新：2026年4月2日  
> Swagger地址：http://localhost:8000/api-docs  
> 基础URL：http://localhost:8000/api/v1

## 📋 目录

1. [认证中心](#1-认证中心)
2. [用户接口](#2-用户接口)
3. [系统管理](#3-系统管理)
4. [文章管理](#4-文章管理)
5. [产品管理](#5-产品管理)
6. [文件接口](#6-文件接口)
7. [其他接口](#7-其他接口)

---

## 1. 认证中心

### 1.1 登录接口

**接口地址**：`POST /api/v1/auth/login`

**功能说明**：用户登录认证，需要图形验证码

**请求参数**：
```json
{
  "username": "admin",      // 用户名
  "password": "123456",     // 密码
  "captchaCode": "ABCD",    // 验证码
  "captchaId": "uuid-xxx"   // 验证码ID
}
```

**返回示例**：
```json
{
  "code": "A00000",
  "msg": "操作成功",
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "tokenType": "Bearer",
    "expires": 7200
  }
}
```

**错误码**：
- `B0001` - 系统执行出错
- `A00002` - 用户验证码已过期
- `A00003` - 用户验证码错误

---

### 1.2 短信验证码登录

**接口地址**：`POST /api/v1/auth/login/sms`

**功能说明**：使用短信验证码登录

**请求参数**：
- `mobile` (query): 手机号码
- `code` (query): 短信验证码

**返回示例**：同登录接口

---

### 1.3 发送短信验证码

**接口地址**：`POST /api/v1/auth/sms/code`

**功能说明**：发送登录短信验证码

**请求参数**：
- `mobile` (query): 手机号码

**返回示例**：
```json
{
  "code": "A00000",
  "msg": "操作成功",
  "data": null
}
```

---

### 1.4 注销登录

**接口地址**：`DELETE /api/v1/auth/logout`

**功能说明**：用户注销，将token加入黑名单

**请求头**：
```
Authorization: Bearer {accessToken}
```

**返回示例**：
```json
{
  "code": "A00000",
  "msg": "操作成功",
  "data": null
}
```

---

### 1.5 获取图形验证码

**接口地址**：`GET /api/v1/auth/captcha`

**功能说明**：获取图形验证码（Base64格式）

**返回示例**：
```json
{
  "code": "A00000",
  "msg": "操作成功",
  "data": {
    "captchaBase64": "data:image/svg+xml;base64,PHN2Z...",
    "captchaId": "uuid-xxxx-xxxx"
  }
}
```

**说明**：验证码有效期120秒，需要在登录时提交 captchaCode 和 captchaId

---

### 1.6 刷新令牌

**接口地址**：`POST /api/v1/auth/refresh-token`

**功能说明**：使用 refreshToken 获取新的 accessToken

**请求参数**：
- `refreshToken` (query): 刷新令牌

**返回示例**：同登录接口

---

## 2. 用户接口

### 2.1 获取当前登录用户信息

**接口地址**：`GET /api/v1/users/me`

**功能说明**：获取当前登录用户的详细信息

**请求头**：需要认证

**返回示例**：
```json
{
  "code": "A00000",
  "msg": "操作成功",
  "data": {
    "id": 1,
    "username": "admin",
    "nickname": "管理员",
    "gender": 1,
    "mobile": "13800138000",
    "email": "admin@youlai.tech",
    "avatar": "/20250401/xxx.jpg",
    "deptId": 1,
    "roleIds": [1],
    "status": 1
  }
}
```

---

### 2.2 用户管理（CRUD）

**接口地址**：
- `GET /api/v1/users` - 获取用户列表（分页）
- `POST /api/v1/users` - 创建用户
- `PUT /api/v1/users/:id` - 更新用户
- `DELETE /api/v1/users/:ids` - 删除用户（批量）
- `GET /api/v1/users/:id` - 获取用户详情

**功能说明**：用户管理接口，支持分页、查询、创建、更新、删除

**查询参数**：
- `page`: 页码，默认1
- `limit`: 每页数量，默认10
- `username`: 用户名（模糊查询）
- `mobile`: 手机号（模糊查询）
- `deptId`: 部门ID
- `status`: 状态（0-禁用，1-启用）

**返回示例**：
```json
{
  "code": "A00000",
  "msg": "操作成功",
  "data": {
    "items": [...],
    "total": 100,
    "page": 1,
    "limit": 10
  }
}
```

---

### 2.3 修改密码

**接口地址**：`PUT /api/v1/users/password`

**功能说明**：修改当前用户密码

**请求参数**：
```json
{
  "oldPassword": "123456",
  "newPassword": "654321",
  "confirmPassword": "654321"
}
```

**返回示例**：
```json
{
  "code": "A00000",
  "msg": "操作成功",
  "data": null
}
```

---

### 2.4 用户导入导出

**接口地址**：
- `GET /api/v1/users/template` - 下载用户导入模板（Excel）
- `POST /api/v1/users/import` - 导入用户（Excel）
- `POST /api/v1/users/export` - 导出用户（Excel）

**功能说明**：用户数据的批量导入导出功能

---

## 3. 系统管理

### 3.1 角色管理

**接口地址**：
- `GET /api/v1/roles` - 获取角色列表
- `POST /api/v1/roles` - 创建角色
- `PUT /api/v1/roles/:id` - 更新角色
- `DELETE /api/v1/roles/:ids` - 删除角色
- `GET /api/v1/roles/:id` - 获取角色详情
- `GET /api/v1/roles/options` - 获取角色下拉选项

**功能说明**：角色权限管理，支持菜单权限、数据权限配置

---

### 3.2 菜单管理

**接口地址**：
- `GET /api/v1/menus` - 获取菜单列表（树形结构）
- `POST /api/v1/menus` - 创建菜单
- `PUT /api/v1/menus/:id` - 更新菜单
- `DELETE /api/v1/menus/:ids` - 删除菜单
- `GET /api/v1/menus/user` - 获取当前用户菜单（路由）

**功能说明**：系统菜单管理，支持多级菜单、按钮权限

---

### 3.3 部门管理

**接口地址**：
- `GET /api/v1/depts` - 获取部门列表（树形结构）
- `POST /api/v1/depts` - 创建部门
- `PUT /api/v1/depts/:id` - 更新部门
- `DELETE /api/v1/depts/:ids` - 删除部门
- `GET /api/v1/depts/options` - 获取部门下拉选项

**功能说明**：组织架构管理，支持多级部门

---

### 3.4 字典管理

**接口地址**：
- `GET /api/v1/dicts/types` - 获取字典类型列表
- `POST /api/v1/dicts/types` - 创建字典类型
- `PUT /api/v1/dicts/types/:id` - 更新字典类型
- `DELETE /api/v1/dicts/types/:ids` - 删除字典类型
- `GET /api/v1/dicts/data` - 获取字典数据列表
- `POST /api/v1/dicts/data` - 创建字典数据
- `PUT /api/v1/dicts/data/:id` - 更新字典数据
- `DELETE /api/v1/dicts/data/:ids` - 删除字典数据
- `GET /api/v1/dicts/:type` - 根据类型获取字典数据

**功能说明**：系统字典管理，用于配置各类下拉选项

---

### 3.5 系统配置

**接口地址**：
- `GET /api/v1/configs` - 获取配置列表
- `POST /api/v1/configs` - 创建配置
- `PUT /api/v1/configs/:id` - 更新配置
- `DELETE /api/v1/configs/:ids` - 删除配置
- `GET /api/v1/configs/key/:key` - 根据key获取配置

**功能说明**：系统参数配置管理

---

### 3.6 系统日志

**接口地址**：
- `GET /api/v1/logs/login` - 获取登录日志（分页）
- `GET /api/v1/logs/operation` - 获取操作日志（分页）
- `DELETE /api/v1/logs/login/:ids` - 删除登录日志
- `DELETE /api/v1/logs/operation/:ids` - 删除操作日志

**功能说明**：系统日志管理，包括登录日志和操作日志

---

### 3.7 系统通知

**接口地址**：
- `GET /api/v1/notices` - 获取通知列表
- `POST /api/v1/notices` - 创建通知
- `PUT /api/v1/notices/:id` - 更新通知
- `DELETE /api/v1/notices/:ids` - 删除通知
- `GET /api/v1/notices/user` - 获取当前用户通知（分页）
- `PUT /api/v1/notices/:id/read` - 标记通知已读
- `PUT /api/v1/notices/read/all` - 标记所有通知已读

**功能说明**：系统通知公告管理

---

## 4. 文章管理

### 4.1 文章分类接口

**接口地址**：
- `GET /api/v1/articles/categories` - 获取文章分类列表（树形）
- `GET /api/v1/articles/categories/options` - 获取文章分类下拉选项
- `GET /api/v1/articles/categories/:id/form` - 获取文章分类表单数据
- `POST /api/v1/articles/categories` - 创建文章分类
- `PUT /api/v1/articles/categories/:id` - 更新文章分类
- `DELETE /api/v1/articles/categories/:ids` - 删除文章分类

**功能说明**：文章分类管理，支持多语言

**多语言说明**：
- `langData` 字段格式：`{ "zh": "分类名称", "en": "Category Name", "ar": "اسم التصنيف" }`
- 支持语言：zh(中文), en(英文), ar(阿拉伯语), vi(越南语), id(印尼语), th(泰语), km(柬埔寨语), fr(法语), it(意大利语)

---

### 4.2 文章接口

**接口地址**：
- `GET /api/v1/articles` - 获取文章列表（分页）
- `GET /api/v1/articles/:id/form` - 获取文章表单数据
- `POST /api/v1/articles` - 创建文章
- `PUT /api/v1/articles/:id` - 更新文章
- `DELETE /api/v1/articles/:ids` - 删除文章

**功能说明**：文章内容管理，支持多语言、封面图

**查询参数**：
- `page`: 页码
- `limit`: 每页数量
- `cateId`: 分类ID
- `keywords`: 关键词（搜索标题）
- `status`: 状态（0-隐藏，1-发布）

**请求示例**：
```json
{
  "cateId": 10,
  "cover": "/20250402/xxx.jpg",
  "sort": 100,
  "status": 1,
  "langData": {
    "zh": {
      "title": "文章标题",
      "content": "文章内容",
      "seoTitle": "SEO标题",
      "seoKeywords": "关键词1,关键词2",
      "seoDescription": "SEO描述"
    },
    "en": {
      "title": "Article Title",
      "content": "Article Content",
      "seoTitle": "SEO Title",
      "seoKeywords": "keyword1,keyword2",
      "seoDescription": "SEO Description"
    }
  }
}
```

---

## 5. 产品管理

### 5.1 产品分类接口

**接口地址**：
- `GET /api/v1/products/categories` - 获取产品分类列表（树形）
- `GET /api/v1/products/categories/options` - 获取产品分类下拉选项
- `GET /api/v1/products/categories/:id/form` - 获取产品分类表单数据
- `POST /api/v1/products/categories` - 创建产品分类
- `PUT /api/v1/products/categories/:id` - 更新产品分类
- `DELETE /api/v1/products/categories/:ids` - 删除产品分类

**功能说明**：产品分类管理，支持多语言

---

### 5.2 产品接口

**接口地址**：
- `GET /api/v1/products` - 获取产品列表（分页）
- `GET /api/v1/products/:id/form` - 获取产品表单数据
- `POST /api/v1/products` - 创建产品
- `PUT /api/v1/products/:id` - 更新产品
- `DELETE /api/v1/products/:ids` - 删除产品

**功能说明**：产品管理，支持多语言、封面图、多图

---

## 6. 文件接口

### 6.1 上传文件

**接口地址**：`POST /api/v1/files`

**功能说明**：上传文件到OSS/本地存储

**请求方式**：multipart/form-data

**请求参数**：
- `file` (formData): 文件数据

**返回示例**：
```json
{
  "code": "A00000",
  "msg": "操作成功",
  "data": {
    "name": "test.jpg",
    "url": "/20250402/c7fce521-7b11-44db-a220-e788a8680837.jpg"
  }
}
```

**存储配置说明**：
- 支持三种存储方式：aliyun(阿里云OSS)、minio(MinIO)、local(本地存储)
- 本地存储路径：`youlai-nest/data/oss/`
- 访问URL：`http://localhost:8000/20250402/xxx.jpg`

---

### 6.2 删除文件

**接口地址**：`DELETE /api/v1/files`

**功能说明**：删除已上传的文件

**请求参数**：
- `filePath` (query): 文件路径（如：/20250402/xxx.jpg）

**返回示例**：
```json
{
  "code": "A00000",
  "msg": "操作成功",
  "data": true
}
```

---

## 7. 其他接口

### 7.1 Server-Sent Events (SSE)

**接口地址**：`GET /api/v1/sse/subscribe`

**功能说明**：SSE长连接，用于实时推送消息

**请求头**：需要认证

**返回**：text/event-stream 格式

---

### 7.2 代码生成

**接口地址**：
- `GET /api/v1/codegen/tables` - 获取数据库表列表
- `GET /api/v1/codegen/config/:tableName` - 获取代码生成配置
- `PUT /api/v1/codegen/config/:tableName` - 更新代码生成配置
- `POST /api/v1/codegen/generate/:tableName` - 生成代码

**功能说明**：根据数据库表自动生成前后端代码

---

## 🔐 认证说明

### 请求头格式

所有需要认证的接口（除登录、验证码等开放接口外），都需要在请求头中添加：

```
Authorization: Bearer {accessToken}
```

### Token有效期

- **accessToken**: 默认2小时（7200秒）
- **refreshToken**: 用于刷新accessToken，有效期更长

### 开放接口（无需认证）

- `POST /api/v1/auth/login` - 登录
- `POST /api/v1/auth/login/sms` - 短信登录
- `POST /api/v1/auth/sms/code` - 发送短信验证码
- `GET /api/v1/auth/captcha` - 获取验证码
- `POST /api/v1/auth/refresh-token` - 刷新令牌

---

## 📊 统一响应格式

### 成功响应

```json
{
  "code": "A00000",      // 成功码
  "msg": "操作成功",      // 消息
  "data": {}             // 数据
}
```

### 错误响应

```json
{
  "code": "B0001",       // 错误码
  "msg": "系统执行出错",  // 错误消息
  "data": null
}
```

### 常见错误码

| 错误码 | 说明 |
|--------|------|
| A00000 | 操作成功 |
| B0001 | 系统执行出错 |
| A00001 | 用户请求参数错误 |
| A00002 | 用户验证码已过期 |
| A00003 | 用户验证码错误 |
| A00004 | 用户账户已被禁用 |
| A00005 | 用户凭证已过期 |
| A00006 | 用户凭证无效 |
| A00007 | 用户没有权限访问该资源 |
| A00008 | 用户登录已过期 |
| A00009 | 请求过于频繁，请稍后再试 |
| A00010 | 该操作需要安全验证 |
| A00011 | 用户账号或密码错误 |
| A00012 | 用户手机号已存在 |
| A00013 | 用户邮箱已存在 |
| A00014 | 原密码错误 |
| A00015 | 用户不存在 |
| A00016 | 数据不存在 |
| A00017 | 数据已存在 |
| A00018 | 数据被引用，无法删除 |
| A00019 | 文件上传失败 |
| A00020 | 文件类型不支持 |
| A00021 | 文件大小超过限制 |

---

## 🌍 多语言支持

### 支持的语言

| 语言代码 | 语言名称 | 国家/地区 |
|----------|----------|-----------|
| zh | 中文 | 中国 |
| en | English | 欧美 |
| ar | العربية | 中东阿拉伯 |
| vi | Tiếng Việt | 越南 |
| id | Bahasa Indonesia | 印尼 |
| th | ไทย | 泰国 |
| km | ខ្មែរ | 柬埔寨 |
| fr | Français | 法国 |
| it | Italiano | 意大利 |

### 多语言字段格式

```typescript
// 分类名称多语言
langData: {
  "zh": "分类名称",
  "en": "Category Name",
  "ar": "اسم التصنيف"
}

// 文章内容多语言
langData: {
  "zh": {
    "title": "文章标题",
    "content": "文章内容",
    "seoTitle": "SEO标题",
    "seoKeywords": "关键词",
    "seoDescription": "SEO描述"
  },
  "en": {
    "title": "Article Title",
    "content": "Article Content",
    "seoTitle": "SEO Title",
    "seoKeywords": "Keywords",
    "seoDescription": "SEO Description"
  }
}
```

---

## 🚀 快速开始

### 1. 获取验证码

```bash
curl http://localhost:8000/api/v1/auth/captcha
```

### 2. 登录

```bash
curl -X POST http://localhost:8000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin",
    "password": "123456",
    "captchaCode": "ABCD",
    "captchaId": "uuid-xxxx"
  }'
```

### 3. 访问需要认证的接口

```bash
curl http://localhost:8000/api/v1/users/me \
  -H "Authorization: Bearer {accessToken}"
```

---

## 📚 数据库说明

### 主要表结构

- **用户表**：sys_user
- **角色表**：sys_role
- **菜单表**：sys_menu
- **部门表**：sys_dept
- **字典表**：sys_dict_type, sys_dict_data
- **配置表**：sys_config
- **日志表**：sys_log_login, sys_log_operation
- **通知表**：sys_notice, sys_notice_user
- **文章表**：article, article_category, article_lang, article_category_lang
- **产品表**：product, product_category, product_lang, product_category_lang
- **文件表**：sys_file（记录文件信息）

### 多语言表设计

**主表**：存储通用字段
```sql
CREATE TABLE article_category (
  id INT PRIMARY KEY,
  parent_id INT,
  icon VARCHAR(100),
  sort INT,
  status TINYINT,
  -- 其他通用字段
  INDEX idx_parent_id (parent_id)
);
```

**语言表**：存储多语言字段
```sql
CREATE TABLE article_category_lang (
  id INT,
  lang VARCHAR(10),  -- 语言代码：zh, en, ar, vi, id, th, km, fr, it
  name VARCHAR(100),  -- 分类名称
  description TEXT,   -- 分类描述
  PRIMARY KEY (id, lang)
);
```

---

## 📝 开发注意事项

### 1. 权限注解

使用 `@Permissions()` 注解控制接口访问权限：

```typescript
@Permissions("user:create")  // 用户创建权限
@Permissions("user:update")  // 用户修改权限
@Permissions("user:delete")  // 用户删除权限
@Permissions("user:query")   // 用户查询权限
```

### 2. 日志记录

使用 `@Log()` 注解记录操作日志：

```typescript
@Log(LogModuleValue.USER, ActionTypeValue.CREATE)  // 记录用户创建操作
@Log(LogModuleValue.USER, ActionTypeValue.UPDATE)  // 记录用户更新操作
```

### 3. DTO验证

所有接口参数都需要通过 DTO 验证：

```typescript
export class CreateUserDto {
  @IsNotEmpty({ message: "用户名不能为空" })
  @IsString()
  username: string;

  @IsOptional()
  @IsObject()
  langData?: Record<string, string>;
}
```

### 4. 文件上传

文件上传返回的URL格式：
- 本地存储：`/{日期}/{uuid}.扩展名`
- 阿里云OSS：`https://{bucket}.{endpoint}/{日期}/{uuid}.扩展名`
- MinIO：`{customDomain}/{bucket}/{日期}/{uuid}.扩展名`

### 5. 错误处理

统一使用 BusinessException 抛出自定义错误：

```typescript
throw new BusinessException({
  code: ErrorCode.USER_NOT_EXIST,
  msg: "用户不存在"
});
```

---

## 📞 技术支持

如有问题，请查看：
- Swagger文档：http://localhost:8000/api-docs
- 接口测试：可使用 Postman 或 Swagger UI 进行测试
- 日志文件：`youlai-nest/logs/`

---

## 🔄 更新日志

### 2026-04-02
- 新增多语言支持（9种语言）
- 优化文件上传功能（支持本地/阿里云OSS/MinIO）
- 完善接口文档

### 2026-04-01
- 修复文章和产品分类批量删除问题
- 优化分类列表显示（多语言名称）
- 新增本地存储模式（相对路径）

---

**文档结束**
