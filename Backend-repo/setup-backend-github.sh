#!/bin/bash

git init

git checkout -b main
git checkout -b dev
git checkout -b qa
git checkout -b staging
git checkout -b prod

mkdir -p docker
mkdir -p src/main/resources
mkdir -p .github/workflows

touch docker/Dockerfile
touch docker/docker-compose.dev.yml

touch src/main/resources/application.yml
touch src/main/resources/application-dev.yml
touch src/main/resources/application-qa.yml
touch src/main/resources/application-staging.yml
touch src/main/resources/application-prod.yml
touch src/main/resources/logback-spring.xml

touch .github/workflows/backend-dev.yml
touch .github/workflows/backend-cicd.yml

git add .
git commit -m "Initial backend structure"

git remote remove origin
git remote add origin https://github.com/Hassanghrayeb/startupstack-backend-repo.git

git push -u origin main
git push -u origin dev
git push -u origin qa
git push -u origin staging
git push -u origin prod


read -p "Press Enter to exit..."