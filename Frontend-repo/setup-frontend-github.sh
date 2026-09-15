#!/bin/bash

git init

git checkout -b main
git checkout -b dev
git checkout -b qa
git checkout -b staging
git checkout -b prod

mkdir -p docker
mkdir -p src/environments
mkdir -p .github/workflows

touch docker/Dockerfile
touch docker/nginx.conf
touch docker/docker-compose.dev.yml

touch src/environments/environment.ts
touch src/environments/environment.dev.ts
touch src/environments/environment.qa.ts
touch src/environments/environment.staging.ts
touch src/environments/environment.prod.ts

touch .github/workflows/frontend-dev.yml
touch .github/workflows/frontend-cicd.yml

git add .
git commit -m "Initial frontend structure"

git remote add origin https://github.com/Hassanghrayeb/startupstack-frontend-repo.git

git push -u origin main
git push -u origin dev
git push -u origin qa
git push -u origin staging
git push -u origin prod


read -p "Press Enter to exit..."