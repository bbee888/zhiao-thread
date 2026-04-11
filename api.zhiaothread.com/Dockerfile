FROM node:20-bookworm-slim AS build
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN corepack enable
RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm build

FROM node:20-bookworm-slim AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY package.json pnpm-lock.yaml ./
RUN corepack enable
RUN pnpm install --prod --frozen-lockfile
COPY --from=build /app/dist ./dist
EXPOSE 8000
CMD ["node", "dist/main.js"]
