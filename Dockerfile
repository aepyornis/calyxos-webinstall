FROM docker.io/library/node:24-alpine AS build
RUN npm install -g pnpm
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm run build

FROM docker.io/library/caddy:2-alpine
COPY --from=build /app/dist /site
COPY Caddyfile /etc/caddy/Caddyfile
