#!/bin/bash

APP_NAME=frontend-repo

echo "🚀 Creating Angular project: $APP_NAME"

npm install -g @angular/cli@21.2.12

ng new $APP_NAME \
  --routing \
  --style=scss \
  --ssr=false \
  --skip-git

cd $APP_NAME

echo "📁 Creating Modular Monolith structure..."

# ----------------------------
# CORE (Application level services)
# ----------------------------
mkdir -p src/app/core/{guards,interceptors,services,models,constants,config}

# ----------------------------
# SHARED (Reusable UI + utilities)
# ----------------------------
mkdir -p src/app/shared/{components,directives,pipes,validators,interfaces,enums}

# ----------------------------
# LAYOUT (Shell structure)
# ----------------------------
mkdir -p src/app/layout/{header,footer,sidebar}

# ----------------------------
# FEATURE MODULES (Business domains)
# ----------------------------
mkdir -p src/app/modules/{users,products,orders,notifications}

# Each module internal structure
for module in users products orders notifications
do
  mkdir -p src/app/modules/$module/{pages,components,services,models,routes}
done

# ----------------------------
# STATE MANAGEMENT
# ----------------------------
mkdir -p src/app/state/{actions,reducers,effects,selectors,store}

# ----------------------------
# TESTING FOUNDATION
# ----------------------------
mkdir -p src/app/testing/{mocks,fixtures,builder,stubs,spies,helpers,test-data}

# ----------------------------
# ASSETS
# ----------------------------
mkdir -p src/assets/{icons,images,styles,translations}

# ----------------------------
# ENVIRONMENTS
# ----------------------------
mkdir -p src/environments

# ----------------------------
# CREATE BASE FILES (optional but recommended)
# ----------------------------
touch src/app/core/core.module.ts
touch src/app/shared/shared.module.ts

touch src/app/app.routes.ts
touch src/app/app.config.ts

touch src/styles.scss

echo "✅ Frontend Modular Monolith (Angular 21.2.12) created successfully!"