

## 📁 项目目录

```text
youlai-nest/
├─ src/                      # 核心业务源码
│  ├─ main.ts                # 应用入口
│  ├─ app.module.ts          # 根模块
│  ├─ auth/                  # 认证与鉴权模块
│  ├─ system/                # 系统核心模块（用户/角色/菜单等）
│  ├─ core/                  # 框架核心（守卫/过滤器/拦截器/中间件等）
│  ├─ codegen/               # 代码生成模块
│  ├─ file/                  # 文件管理模块
│  ├─ websocket/             # WebSocket 模块
│  ├─ common/                # 公共能力（常量/枚举/异常/工具类等）
│  ├─ config/                # 配置文件
│  └─ typings/               # 类型定义
├─ sql/                      # 数据库脚本
├─ .env                      # 基础环境配置
├─ .env.dev                  # 开发环境配置
├─ .env.prod                 # 生产环境配置
└─ package.json              # 项目配置与脚本
```

## 🚀 快速启动

### 1. 环境准备

| 要求        | 说明         |
| ----------- | ------------ |
| **Node.js** | 20+ / 24 LTS |
| **pnpm**    | 包管理器     |
| **MySQL**   | 5.7+ 或 8.x  |
| **Redis**   | 7.x 稳定版   |

> ⚠️ **重要提示**：MySQL 与 Redis 为项目启动必需依赖，请确保服务已启动。

### 2. 数据库初始化

推荐使用 **Navicat**、**DBeaver** 或 **MySQL Workbench** 执行 `sql/mysql/youlai_admin.sql` 脚本，完成数据库和基础数据的初始化。

### 3. 修改配置

根据 `.env.example` 创建 `.env.dev` 和 `.env.prod` 文件，并根据实际情况修改 MySQL 和 Redis 的连接信息。

### 4. 启动项目

```bash
# 安装依赖
pnpm install

# 启动开发环境
pnpm run start:dev
```

启动成功后，访问 [http://localhost:8000/api-docs](http://localhost:8000/api-docs) 验证项目是否成功。

## 🐳 项目部署

### 1. 原生部署

```bash
# 构建
pnpm run build

# 启动
pnpm run start:prod
```

### 2. Docker 部署

```bash
# 构建并启动容器
docker compose up -d --build
```
