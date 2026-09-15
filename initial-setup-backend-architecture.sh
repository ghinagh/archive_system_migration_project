#!/bin/bash

APP_NAME=backend-repo

mkdir -p $APP_NAME
cd $APP_NAME

BASE_PKG=src/main/java/com/startupstack/app

# ----------------------------
# MAIN SOURCE CODE STRUCTURE
# ----------------------------
mkdir -p $BASE_PKG

mkdir -p $BASE_PKG/config/{security,swagger,cache,async,database}

mkdir -p $BASE_PKG/shared/{exception,constants,enums,mapper,util,validation,response,auditing}

mkdir -p $BASE_PKG/modules/users/{controller,service,repository,entity,dto,mapper,specification}
mkdir -p $BASE_PKG/modules/products/{controller,service,repository,entity,dto,mapper,specification}
mkdir -p $BASE_PKG/modules/orders/{controller,service,repository,entity,dto,mapper,specification}
mkdir -p $BASE_PKG/modules/notifications/{controller,service,repository,entity,dto,mapper,specification}

mkdir -p src/main/resources/db/migration

# ----------------------------
# MAIN APPLICATION CONFIGS
# ----------------------------
touch src/main/resources/application.yml
touch src/main/resources/application-dev.yml
touch src/main/resources/application-prod.yml
touch src/main/resources/application-qa.yml

# ----------------------------
# TEST STRUCTURE
# ----------------------------
mkdir -p src/test/unit/modules/{users,products,orders,notifications}
mkdir -p src/test/unit/shared
mkdir -p src/test/unit/config

mkdir -p src/test/integration/modules
mkdir -p src/test/integration/infrastructure

mkdir -p src/test/{fixtures,builder,mocks,stubs,helpers}

mkdir -p src/test/resources/{sql,json,test-data}

# ----------------------------
# TEST CONFIGS
# ----------------------------
touch src/test/resources/application-test.yml

# ----------------------------
# POSTMAN COLLECTIONS (NEW)
# ----------------------------
mkdir -p src/test/postman

touch src/test/postman/startupstack-api.postman_collection.json
touch src/test/postman/startupstack-dev.postman_environment.json
touch src/test/postman/startupstack-qa.postman_environment.json

echo "Backend modular monolith (startupstack) created successfully with Postman collections"