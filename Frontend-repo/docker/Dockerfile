# Builds the Angular app from source inside the image, instead of trusting a pre-built host
# dist/ to be fresh — a host dist/ that predates the latest source changes was previously
# copied in silently, with no build error, so the running container could serve stale code
# with no signal that anything was wrong.
FROM node:22-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
# Explicit timeout/retries, plus a whole-command retry loop: this environment's path to
# registry.npmjs.org measurably stalls mid-download (observed directly — `npm error code
# EIDLETIMEOUT / Idle timeout reached for host registry.npmjs.org:443` after ~3.8 minutes,
# a transient socket-level failure npm's own fetch-retries config did not cover). Retrying the
# whole install is the pragmatic fix for a flaky registry path, not a workaround for anything
# wrong in this Dockerfile itself.
RUN npm config set fetch-timeout 60000 \
 && npm config set fetch-retries 5 \
 && npm config set fetch-retry-mintimeout 5000 \
 && (npm ci || npm ci || npm ci)
COPY . .
# "development" (not the CLI's default "production") deliberately: environment.dev.ts is the
# only configuration whose apiUrl (http://localhost:8081) matches this docker-compose stack's
# published backend port. environment.prod.ts points at an unrelated placeholder domain
# (https://api.startupstack.com) that would break every API call from inside this stack.
RUN npx ng build --configuration development

FROM nginx:alpine
COPY --from=build /app/dist/frontend-repo/browser/ /usr/share/nginx/html
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]