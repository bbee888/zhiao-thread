FROM node:20-alpine AS builder
WORKDIR /app

# 安装 pnpm
RUN npm install -g pnpm

# 只复制 package.json，不复制旧的 pnpm-lock.yaml
COPY package.json ./

# 强制修复两个失效的包（关键）
RUN pnpm pkg set axios=latest
RUN pnpm pkg set plain-crypto-js=latest

# 全新安装，不使用旧锁文件
RUN pnpm install

COPY . .
RUN pnpm run build

# 生产环境
FROM node:20-alpine
WORKDIR /app

RUN npm install -g pnpm

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json ./

# 重新安装生产依赖
RUN pnpm pkg set axios=latest
RUN pnpm pkg set plain-crypto-js=latest
RUN pnpm install --prod



EXPOSE 8000
CMD ["node", "dist/main.js"]
