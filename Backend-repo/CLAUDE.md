# Backend Context — Spring Boot (Backend-repo)

## Framework & Versions
| Component | Version |
|-----------|---------|
| Spring Boot | 3.2 |
| Java | 25 |
| Build Tool | Maven (`pom.xml`) |
| Database | PostgreSQL 16 (docker dev), PostgreSQL 18 (prod target) |
| Cache | Redis 7 |
| DB Migrations | Flyway |
| Mapper | MapStruct |

## Running the App Locally
```bash
# Start dependencies (postgres + redis)
cd docker
docker compose -f docker-compose.dev.yml up -d db redis

# Run the app with dev profile
mvn spring-boot:run -Dspring-boot.run.profiles=dev
# → http://localhost:8080
```

## Project Package Structure
```
com.startupstack.app
├── config/
│   ├── async/         ← Async executor config (@EnableAsync)
│   ├── cache/         ← Redis cache config (@EnableCaching, CacheManager)
│   ├── database/      ← DataSource / JPA config
│   ├── security/      ← Spring Security + JWT filter chain
│   └── swagger/       ← OpenAPI / Springdoc config
├── modules/           ← ONE sub-package per domain feature
│   ├── notifications/
│   │   ├── controller/    ← @RestController, @RequestMapping
│   │   ├── dto/           ← Request + Response DTOs (records or classes)
│   │   ├── entity/        ← @Entity classes
│   │   ├── mapper/        ← MapStruct @Mapper interfaces
│   │   ├── repository/    ← JpaRepository + JpaSpecificationExecutor
│   │   ├── service/       ← @Service, business logic
│   │   └── specification/ ← JPA Specifications for dynamic filtering
│   ├── orders/            ← same structure
│   ├── products/          ← same structure
│   └── users/             ← same structure
│   └── <new-module>/      ← follow the same 7-layer structure
└── shared/
    ├── auditing/      ← @CreatedDate, @LastModifiedDate base entity
    ├── constants/     ← app-wide constants
    ├── enums/         ← shared enums
    ├── exception/     ← custom exceptions + @ControllerAdvice global handler
    ├── mapper/        ← base mapper utilities
    ├── response/      ← ApiResponse<T> wrapper
    └── util/          ← utility classes
```

## Required Maven Dependencies (pom.xml)
Always ensure these are present when working on any feature:
```xml
<!-- Core -->
<dependency>spring-boot-starter-web</dependency>
<dependency>spring-boot-starter-data-jpa</dependency>
<dependency>spring-boot-starter-security</dependency>
<dependency>spring-boot-starter-validation</dependency>
<dependency>spring-boot-starter-data-redis</dependency>

<!-- Database -->
<dependency>postgresql</dependency>
<dependency>flyway-core</dependency>
<dependency>flyway-database-postgresql</dependency>

<!-- Code generation -->
<dependency>lombok</dependency>
<dependency>mapstruct</dependency>
<dependency>mapstruct-processor</dependency>

<!-- JWT -->
<dependency>jjwt-api</dependency>
<dependency>jjwt-impl</dependency>
<dependency>jjwt-jackson</dependency>

<!-- API Docs -->
<dependency>springdoc-openapi-starter-webmvc-ui</dependency>

<!-- Testing -->
<dependency>spring-boot-starter-test</dependency>
<dependency>spring-security-test</dependency>
```

## Layered Architecture Rules (strict)
```
Controller → Service → Repository → Entity
```
- **Controller**: HTTP concerns only — validate input, call service, return `ResponseEntity<>`
- **Service**: Business logic, transactions (`@Transactional`), call repositories
- **Repository**: `JpaRepository<Entity, UUID>` + `JpaSpecificationExecutor<Entity>` for filtering
- **Entity**: JPA mapping only — no business logic, no JSON annotations
- **DTO**: Request/Response classes — annotate with `@Valid` constraints on request DTOs
- **Mapper**: MapStruct `@Mapper(componentModel = "spring")` — entity ↔ DTO conversion only
- **Specification**: `Specification<Entity>` implementations for dynamic query filtering

## Coding Rules

### Injection
```java
// ✅ CORRECT — constructor injection
@Service
public class UserService {
    private final UserRepository userRepository;
    private final UserMapper userMapper;

    public UserService(UserRepository userRepository, UserMapper userMapper) {
        this.userRepository = userRepository;
        this.userMapper = userMapper;
    }
}

// ❌ WRONG — field injection
@Autowired
private UserRepository userRepository;
```

### Response Wrapping
Always wrap responses in `ResponseEntity<>` using the shared `ApiResponse<T>` wrapper:
```java
// ✅ CORRECT
@GetMapping("/{id}")
public ResponseEntity<ApiResponse<UserResponse>> getUser(@PathVariable UUID id) {
    return ResponseEntity.ok(ApiResponse.success(userService.findById(id)));
}

// ❌ WRONG — returning entity or plain object
@GetMapping("/{id}")
public User getUser(@PathVariable UUID id) { ... }
```

### Exception Handling
- Define custom exceptions in `shared/exception/` (e.g. `ResourceNotFoundException`, `BusinessException`)
- Handle ALL exceptions in a single `@ControllerAdvice` class in `shared/exception/`
- Never catch-and-swallow exceptions; always propagate to the global handler

### Entity Design (new tables)
```java
// All new entities must extend BaseEntity from shared/auditing/
@Entity
@Table(name = "users")
public class UserEntity extends BaseEntity {
    // BaseEntity provides: id (UUID), created_at, updated_at
}
```
Legacy tables from `macnz_manar` keep original column names via `@Column(name = "...")`:
```java
@Entity
@Table(name = "main")
public class MainCatalogueEntity {
    @Id
    @Column(name = "MN_APP_NO")
    private String appNo;

    @Column(name = "MN_ACT_TTL")
    private String activeTitleAr;
    // ... use clean Java field names, map to legacy column names
}
```

### Flyway Migrations
- Place migration files in `src/main/resources/db/migration/`
- Naming convention: `V<version>__<description>.sql`
  - `V1__baseline_macnz_manar.sql` — import `macnz_manar_postgres.sql` as baseline
  - `V2__add_uuid_to_users.sql` — any subsequent migrations
- Never modify an already-applied migration file

### Caching with Redis
Use `@Cacheable`, `@CacheEvict`, `@CachePut` for:
- Lookup/reference tables read-only at runtime: `ARRAYS`, `MACNZ` (subject taxonomy), `CODING`
- Application-level variables / configuration
- Session-sensitive data that changes infrequently

```java
@Cacheable(value = "macnz-subjects", key = "#subCode")
public MacnzSubjectDto getSubject(String subCode) { ... }
```

### Security
- JWT authentication — filter chain in `config/security/`
- Include `Authorization: Bearer <token>` header on all protected endpoints
- Public endpoints (login, register) must be explicitly whitelisted in the security config

### Specifications (Dynamic Filtering)
Use `JpaSpecificationExecutor` for all list/search endpoints:
```java
public interface UserRepository extends JpaRepository<UserEntity, UUID>,
                                        JpaSpecificationExecutor<UserEntity> {}

// In the specification class:
public static Specification<UserEntity> hasName(String name) {
    return (root, query, cb) -> name == null ? null : cb.like(root.get("name"), "%" + name + "%");
}
```

## Spring Profiles & Environment Files
| Profile | File | Used when |
|---------|------|-----------|
| `dev` | `application-dev.yml` | Local development (docker compose) |
| `qa` | `application-qa.yml` | QA server (CI triggered on `qa` branch) |
| `staging` | `application-staging.yml` | Staging server |
| `prod` | `application-prod.yml` | Production server |

Environment-specific values (DB URL, Redis URL, JWT secret) must go in the profile-specific files —
never hardcode them in `application.yml`.

## CI/CD (DO NOT MODIFY WORKFLOW FILES)
| Workflow | Trigger | Action |
|----------|---------|--------|
| `backend-dev.yml` | push to `dev` | `mvn clean test` + `mvn package` + docker build |
| `backend-cicd.yml` | push to `qa`/`staging`/`prod` | build + docker push + SSH deploy |

Required GitHub Secrets: `DOCKER_USERNAME`, `DOCKER_PASSWORD`, `HOST`, `USER`, `SSH_KEY`

## Docker
- Dev compose file: `docker/docker-compose.dev.yml`
- Backend image built from: `docker/Dockerfile`
- Services: `backend` (`:8080`), `db` (postgres:16), `redis` (redis:7)
- App auto-selects `SPRING_PROFILES_ACTIVE=dev` in docker compose

## What NOT To Do
- Never use `@Autowired` field injection
- Never expose `@Entity` classes in controller responses
- Never write raw SQL scripts — use Flyway migrations
- Never create stored procedures
- Never use SQL Server syntax
- Never modify `.github/workflows/` files
- Never put secrets or credentials in `application.yml` (use profile-specific files or env vars)
- Never skip DTOs — even for simple CRUD, always have Request/Response DTOs