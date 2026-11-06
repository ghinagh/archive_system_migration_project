# توثيق الـ API — نظام توثيق الاستمارة (Archive System)

يلخّص هذا الملف ما تفعله الـ endpoints الموجودة في الـ Postman collection، وعلاقة كل واحد منها بشاشات التطبيق.
الوصف الكامل لكل طلب (الغرض، الشاشة، إجراء المستخدم، البيانات المطلوبة، الاستجابة، الكود المرتبط، حالة التحقق) موجود في حقل description للطلب نفسه داخل الـ collection.

## الملفات

| الملف | المحتوى |
|---|---|
| `Archive_System_API.postman_collection.json` | الـ collection: 44 مجلداً (مجلد لكل controller) و391 طلباً |
| `API_DOCUMENTATION.md` | هذا الملف |

## طريقة الاستخدام

1. استورد الـ collection في Postman، واملأ متغيرات الـ collection: `username` و`password`، و`baseUrl` إذا لم يكن الخادم على `http://localhost:8080`.
2. أرسل **POST /api/auth/login** أولاً. يحفظ سكربت الاختبار الـ JWT في متغير الـ collection `{{token}}`، وكل الطلبات الأخرى ترسله كـ Bearer token.
3. المسارات `/api/auth/**` و`/api/public/**` و`/api/lookups/**` ضمن permitAll في `SecurityConfig`، لكن آلية التحقق تختلف من endpoint لآخر:
   - `POST /api/auth/login`: لا يتطلب تسجيل الدخول. التحقق باسم المستخدم وكلمة المرور في الـ body.
   - `POST /api/auth/change-password`: لا يتطلب تسجيل الدخول. يتطلب header `X-OTP-Token`، وهو الرمز المؤقت الذي يرجعه login في الحقل `token` عندما يكون `requiresPasswordChange = true`.
   - `GET /api/public/search` وطلبات GET تحت `/api/lookups/**` (9 طلبات): مفتوحة بالكامل، بلا header ولا `@Permission`.
   - طلبات POST وPUT وDELETE تحت `/api/lookups/**` (9 طلبات): عليها `@Permission`، فـ`PermissionAspect` يرفض غير المسجل بـ 403. تتطلب فعلياً Bearer JWT، وفي الـ collection ترث مصادقة الـ collection (Bearer `{{token}}`) لترسله تلقائياً. باقي الطلبات أعلاه إعدادها noauth.
4. للشاشات المحمية بمفتاح (انظر «بوابات مفاتيح الشاشات» أدناه): أرسل طلب `/access` أولاً، ثم ضع الـ grant token في الـ header الصحيح.

### صيغة اسم الطلب

`METHOD /path  (javaMethod) — [الوحدة] الإجراء` مع لاحقة تبيّن حالة التحقق:

- بدون لاحقة: الاستخدام مؤكد في الواجهة.
- **(API فقط)**: لا توجد Angular service تستدعي هذا الـ endpoint.
- **(غير مؤكد في الواجهة)**: توجد دالة في Angular service، لكن لم يُعثر على شاشة تستدعيها فعلياً.

## ملخص التحقق

| الحالة | العدد |
|---|---|
| مؤكد: الاستدعاء من الـ service إلى الـ component إلى الشاشة متتبَّع في الكود | 305 |
| API فقط: لا توجد Angular service تستدعي الـ endpoint | 62 |
| غير مؤكد: الدالة في الـ service لا يستدعيها أي component | 23 |
| غير مؤكد: يستدعيه component غير مضمَّن في أي شاشة | 1 |
| **المجموع** | **391** |

**طريقة التحقق:**

- استُخرج كل استدعاء `this.http.*` من ملفات `*.service.ts` في Frontend-repo مع الـ URL والـ method.
- طوبق كل استدعاء مع أكثر endpoint تحديداً له نفس الـ method ونفس عدد أجزاء المسار.
- تُتُبّع كل component يحقن الـ service ويستدعي الدالة، ثم route هذا الـ component.
- إذا لم يكن للـ component route، تُتُبّع الشاشة التي تضمّه عبر selector أو تفتحه كـ dialog أو تحميه بـ route guard.
- كل endpoint بدون مطابقة رُوجع ببحث نصي في Frontend-repo/src.
- المطابقات الستة التي تعتمد على جزء متغير (`/api/form-thesaurus/relations/${kind}`) تم التحقق منها يدوياً.
- لم يُرسل أي طلب للخادم، ولم يُعدَّل أي كود في التطبيق.

## الفرق بين 395 و391

أعطى البحث الأولي `grep -o '@(Get|Post|Put|Delete|Patch)Mapping'` العدد 395. الفرق 4 مطابقات تأتي كلها من سطر تعليق Javadoc واحد في `shared/annotation/Permission.java` يذكر أسماء الـ annotations الأربعة. عدد الـ annotations الفعلية في ملفات `*Controller.java` هو **391**، وكلها موجودة في الـ collection. **لا توجد endpoints مفقودة.**

## بوابات مفاتيح الشاشات

بعض الشاشات تطلب في النظام القديم (ARCHIVE.frm Frame3) «كلمة سر» ثابتة قبل أن تُفتح. هذه **ليست بيانات تسجيل دخول**: المستخدم يكون مسجلاً دخوله بـ JWT أصلاً، والمفتاح يفتح شاشة واحدة فقط.

- المفتاح يُقارن على الخادم فقط.
- إذا تطابق، يُصدر الخادم grant token مؤقتاً مرتبطاً بالمستخدم الحالي.
- كل endpoints الشاشة تتطلب هذا الـ token في header خاص، وبدونه ترجع 403.
- في الواجهة: يعرض route guard نافذة المفتاح عند كل فتح للشاشة، ويُلغى الـ token عند مغادرتها.

| الشاشة | طلب المفتاح | Header | مصدر المفتاح على الخادم |
|---|---|---|---|
| معالجة المستخدمين (/users) | POST /api/config-users/access | `X-Config-Users-Access` | `config-users.access-key` (`CONFIG_USERS_ACCESS_KEY`) |
| المكنز الشكلي (/form-thesaurus) | POST /api/form-thesaurus/access | `X-Form-Thesaurus-Access` | `form-thesaurus.access-key` (`FORM_THESAURUS_ACCESS_KEY`) |
| المكنز الموضوعي (/subject-thesaurus) | POST /api/subject-thesaurus/access | `X-Subject-Thesaurus-Access` | `subject-thesaurus.access-key` (`SUBJECT_THESAURUS_ACCESS_KEY`) |
| ملف بناء الاسترجاعات / معالجة حقول الاسترجاع | POST /api/retrieval-build/access (`gate` = FORM4 أو CAT_OUT) | `X-Retrieval-Build-Access` | ثابت في الكود: `RetrievalBuildAccessService.KEYS` (صلاحية الـ token ثماني ساعات) |

**أسماء الـ headers في الـ collection:** طلبات المجلدات ConfigUsers وFormThesaurus وRetrievalBuild وSubjectThesaurus (68 طلباً) تستخدم الآن الأسماء الأربعة أعلاه، وهي نفس الثوابت التي يقرؤها الخادم: `ConfigUsersAccessService.HEADER` و`FormThesaurusAccessService.HEADER` و`RetrievalBuildAccessService.HEADER` و`SubjectThesaurusAccessService.HEADER`. كانت هذه الطلبات ترسل header اسمه `token`، وصُحِّح الاسم فقط.

**قبل تشغيل هذه الطلبات:** قيم هذه الـ headers فارغة في الـ collection، وستفشل في التحقق (403) حتى تُملأ. القيمة المطلوبة ليست مفتاح الشاشة نفسه، بل الـ grant token المؤقت الذي يرجعه طلب `/access` للشاشة. لذلك:

1. يجب أن يكون مفتاح الشاشة الصحيح مُعدّاً على الخادم (الإعدادات المذكورة في الجدول أعلاه)، ومعروفاً لمن يشغّل الطلبات.
2. أرسل طلب `/access` بهذا المفتاح.
3. ضع الـ token الراجع في الـ header.

هذا التوثيق لا يحتوي قيم المفاتيح، ولا يجب حفظها في الـ collection.

قيود إضافية: عمليات الكتابة في «المكنز الموضوعي» (إضافة وتعديل وحذف ورمز المستوى الثالث) يسمح بها الخادم فقط للمستخدم الذي رقمه `subject-thesaurus.writer-user-no` (الافتراضي 244).

## الصلاحيات

- endpoints عليها `@Permission(...)`: يفحص `PermissionAspect` الـ bitmask في `config.user_permition`: VIEW=1، CREATE=2، UPDATE=4، DELETE=8، ADMIN=16، REPORTS=32، EXPORT=64، BORROW=128.
- المستخدم الذي مستواه `A` يتجاوز الفحص.
- إذا لم تتوفر الصلاحية يرجع 403.
- endpoints بدون `@Permission`: يكفي JWT صالح، ما عدا مسارات permitAll.

## ملاحظات وجدها التوثيق (لم يُعدَّل شيء)

1. **قيم headers مفاتيح الشاشات فارغة (68 من 68 طلباً).** أسماء الـ headers صحيحة الآن ومطابقة للخادم (انظر «بوابات مفاتيح الشاشات»)، لكن قيمها فارغة، فسترجع هذه الطلبات 403 حتى تُملأ بـ grant token صالح من طلب `/access` الخاص بكل شاشة.
2. **endpoints ترجع `ApiResponse.error(...)` عند النجاح (52):** الاستجابة HTTP 200 لكن `success = false`. مثال: `DELETE /api/users/{userNo}`، `DELETE /api/admin/temp-schema/{fieldName}`، `DELETE /api/admin/media-ranges/{id}`، `DELETE /api/archive/charts/{id}`، `DELETE /api/archive/charts/{id}/operations/{operationId}`، `DELETE /api/articles/{appNo}`، `DELETE /api/authors/{autNo}`، `DELETE /api/books/{appNo}`، ….
3. **قواعد التحقق:** كل DTO عليه annotations مثل `@NotBlank` و`@Size` يُفحص فعلاً، لأن الـ controller يستخدم `@Valid`. قواعد كل طلب مذكورة في وصفه.
4. **شاشات لا يمكن الوصول إليها إلا بكتابة الرابط:** `/books` و`/articles` و`/news` و`/subjects` و`/video-orders/approvals`. ليست في القائمة الجانبية، ولا يوجد رابط إليها من خارج وحدتها (تم التحقق ببحث نصي في الواجهة). الشاشات الداخلية فيها مرتبطة ببعضها.
5. **components غير مضمَّنة في أي شاشة:** `TempFilesComponent` و`SubjectAssignComponent` يستدعيان endpoints، لكن لا يوجد template يضمّهما، ولا dialog يفتحهما، ولا route لهما.
6. **نسختان من endpoints «ملفات اضافية للادخال»:** الواجهة تستخدم `/api/additional-files/*` غير المحمية بمفتاح. أما النسخة المحمية `/api/form-thesaurus/additional-files/*` فلا تستدعيها أي Angular service.

## الشاشات وعلاقتها بالـ API

كل شاشة في القائمة الجانبية (أو التي تُفتح بالرابط)، مع الـ endpoints التي تستدعيها فعلياً. الـ endpoint المشترك يظهر تحت كل شاشة تستخدمه.

### الترميز

#### المكنز الموضوعي — `/subject-thesaurus`

| Method | Path | الإجراء |
|---|---|---|
| POST | `/api/subject-thesaurus/access` | [المكنز الموضوعي] التحقق من مفتاح فتح الشاشة |
| DELETE | `/api/subject-thesaurus/access` | [المكنز الموضوعي] إلغاء صلاحية فتح الشاشة |
| GET | `/api/subject-thesaurus/context` | [المكنز الموضوعي] بيانات سياق الشاشة |
| GET | `/api/subject-thesaurus/terms` | [المكنز الموضوعي] عرض مصطلحات المكنز |
| POST | `/api/subject-thesaurus/terms` | [المكنز الموضوعي] إضافة مصطلح |
| PUT | `/api/subject-thesaurus/terms` | [المكنز الموضوعي] تعديل مصطلح |
| DELETE | `/api/subject-thesaurus/terms` | [المكنز الموضوعي] حذف مصطلح |
| POST | `/api/subject-thesaurus/terms/level3-code` | [المكنز الموضوعي] رمز المستوى الثالث |

#### المكنز الشكلي — `/form-thesaurus`

| Method | Path | الإجراء |
|---|---|---|
| POST | `/api/additional-files/search` | [ملفات اضافية للادخال] البحث في الملفات الاضافية |
| POST | `/api/additional-files/op-tmp` | [ملفات اضافية للادخال] إضافة الوثيقة الحالية إلى الملفات الاضافية |
| PUT | `/api/additional-files` | [ملفات اضافية للادخال] تعديل خلية في الملفات الاضافية |
| POST | `/api/additional-files` | [ملفات اضافية للادخال] إضافة صف جديد في الملفات الاضافية |
| POST | `/api/additional-files/delete` | [ملفات اضافية للادخال] حذف صف من الملفات الاضافية |
| POST | `/api/form-thesaurus/access` | [المكنز الشكلي] التحقق من مفتاح فتح الشاشة |
| DELETE | `/api/form-thesaurus/access` | [المكنز الشكلي] إلغاء صلاحية فتح الشاشة |
| GET | `/api/form-thesaurus/context` | [المكنز الشكلي] بيانات سياق الشاشة |
| GET | `/api/form-thesaurus/coding` | [المكنز الشكلي] عرض الترميز |
| GET | `/api/form-thesaurus/coding/find` | [المكنز الشكلي] البحث عن رمز |
| POST | `/api/form-thesaurus/coding` | [المكنز الشكلي] إضافة رمز |
| PUT | `/api/form-thesaurus/coding` | [المكنز الشكلي] تعديل رمز |
| DELETE | `/api/form-thesaurus/coding` | [المكنز الشكلي] حذف رمز |
| GET | `/api/form-thesaurus/forms` | [المكنز الشكلي] عرض الاستمارات |
| GET | `/api/form-thesaurus/forms/find` | [المكنز الشكلي] البحث عن استمارة |
| POST | `/api/form-thesaurus/forms` | [المكنز الشكلي] إضافة استمارة |
| PUT | `/api/form-thesaurus/forms` | [المكنز الشكلي] تعديل استمارة |
| DELETE | `/api/form-thesaurus/forms` | [المكنز الشكلي] حذف استمارة |
| POST | `/api/form-thesaurus/forms/next-number` | [المكنز الشكلي] الرقم التالي للاستمارة |
| PUT | `/api/form-thesaurus/words` | [المكنز الشكلي] استبدال الكلمات المفتاحية |
| POST | `/api/form-thesaurus/words` | [المكنز الشكلي] إضافة كلمات مفتاحية |
| GET | `/api/form-thesaurus/positions` | [المكنز الشكلي] عرض المناصب |
| POST | `/api/form-thesaurus/positions` | [المكنز الشكلي] إضافة منصب |
| PUT | `/api/form-thesaurus/positions` | [المكنز الشكلي] تعديل منصب |
| DELETE | `/api/form-thesaurus/positions` | [المكنز الشكلي] حذف منصب |
| GET | `/api/form-thesaurus/relations/forms` | [المكنز الشكلي] عرض علاقات الاستمارات |
| POST | `/api/form-thesaurus/relations/forms` | [المكنز الشكلي] إضافة علاقة استمارة |
| PUT | `/api/form-thesaurus/relations/forms/dates` | [المكنز الشكلي] تعديل تواريخ علاقة استمارة |
| DELETE | `/api/form-thesaurus/relations/forms` | [المكنز الشكلي] حذف علاقة استمارة |
| GET | `/api/form-thesaurus/relations/subjects` | [المكنز الشكلي] عرض علاقات الموضوعات |
| POST | `/api/form-thesaurus/relations/subjects` | [المكنز الشكلي] إضافة علاقة موضوع |
| PUT | `/api/form-thesaurus/relations/subjects/dates` | [المكنز الشكلي] تعديل تواريخ علاقة موضوع |
| DELETE | `/api/form-thesaurus/relations/subjects` | [المكنز الشكلي] حذف علاقة موضوع |
| GET | `/api/form-thesaurus/macnz` | [المكنز الشكلي] قائمة المكنز للاختيار |

#### المؤلفين ودور النشر — `/authors`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/authors/coding` | [المؤلفين ودور النشر] عرض ملف ترميز مسؤولي البيانات |
| POST | `/api/authors/coding` | [المؤلفين ودور النشر] إضافة مسؤول بيانات |
| PUT | `/api/authors/coding/:number` | [المؤلفين ودور النشر] تعديل اسم مسؤول بيانات |
| DELETE | `/api/authors/coding/:number` | [المؤلفين ودور النشر] حذف مسؤول بيانات |

#### ملف بناء الاسترجاعات — `/retrieval-build/form4`

| Method | Path | الإجراء |
|---|---|---|
| POST | `/api/retrieval-build/access` | [ملف بناء الاسترجاعات] التحقق من مفتاح فتح الشاشة |
| DELETE | `/api/retrieval-build/access` | [ملف بناء الاسترجاعات] إلغاء صلاحية فتح الشاشة |
| GET | `/api/retrieval-build/form4/:table` | [ملف بناء الاسترجاعات] عرض جدول Form4 |
| PUT | `/api/retrieval-build/form4/cell` | [ملف بناء الاسترجاعات] تعديل خلية في Form4 |

#### اقفال الوثائق المفتوحة — `/catalogue/lock-all`

| Method | Path | الإجراء |
|---|---|---|
| POST | `/api/catalogue/lock-all` | [اقفال الوثائق المفتوحة] اقفال الوثائق المفتوحة |

#### معالجة المستخدمين — `/users`

| Method | Path | الإجراء |
|---|---|---|
| POST | `/api/config-users/access` | [معالجة المستخدمين] التحقق من مفتاح فتح الشاشة |
| DELETE | `/api/config-users/access` | [معالجة المستخدمين] إلغاء صلاحية فتح الشاشة |
| GET | `/api/config-users/form-types` | [معالجة المستخدمين] قائمة أنواع الاستمارات |
| GET | `/api/config-users/users` | [معالجة المستخدمين] عرض جدول المستخدمين |
| PUT | `/api/config-users/users` | [معالجة المستخدمين] تعديل خلية مستخدم |
| POST | `/api/config-users/users` | [معالجة المستخدمين] إضافة مستخدم |
| POST | `/api/config-users/users/delete` | [معالجة المستخدمين] حذف مستخدم |
| GET | `/api/config-users/fields` | [معالجة المستخدمين] عرض حقول العرض |
| POST | `/api/config-users/fields/create` | [معالجة المستخدمين] إنشاء حقول العرض للمستخدم |
| POST | `/api/config-users/fields/delete` | [معالجة المستخدمين] حذف حقول العرض للمستخدم |
| PUT | `/api/config-users/fields` | [معالجة المستخدمين] تعديل خلية حقل عرض |
| GET | `/api/config-users/ranges` | [معالجة المستخدمين] عرض نطاقات الأرقام |
| PUT | `/api/config-users/ranges` | [معالجة المستخدمين] تعديل خلية نطاق |
| POST | `/api/config-users/ranges` | [معالجة المستخدمين] إضافة نطاق |
| DELETE | `/api/config-users/ranges/:rjpNo` | [معالجة المستخدمين] حذف نطاق |

#### معالجة حقول الاسترجاع — `/retrieval-build/cat-out`

| Method | Path | الإجراء |
|---|---|---|
| POST | `/api/retrieval-build/access` | [ملف بناء الاسترجاعات] التحقق من مفتاح فتح الشاشة |
| DELETE | `/api/retrieval-build/access` | [ملف بناء الاسترجاعات] إلغاء صلاحية فتح الشاشة |
| GET | `/api/retrieval-build/cat-out/fields` | [معالجة حقول الاسترجاع] عرض حقول الاسترجاع |
| PUT | `/api/retrieval-build/cat-out/fields/:outNum` | [معالجة حقول الاسترجاع] تعديل حقل استرجاع |
| POST | `/api/retrieval-build/cat-out/fields` | [معالجة حقول الاسترجاع] إضافة حقل استرجاع |
| DELETE | `/api/retrieval-build/cat-out/fields/:outNum` | [معالجة حقول الاسترجاع] حذف حقل استرجاع |
| PUT | `/api/retrieval-build/cat-out/fields/:outNum/category` | [معالجة حقول الاسترجاع] تعيين فئة الحقل |
| GET | `/api/retrieval-build/cat-out/categories` | [معالجة حقول الاسترجاع] عرض الفئات |
| GET | `/api/retrieval-build/cat-out/categories/:catNo/fields` | [معالجة حقول الاسترجاع] عرض حقول الفئة |
| POST | `/api/retrieval-build/cat-out/categories/:catNo/fields` | [معالجة حقول الاسترجاع] إضافة حقول للفئة |
| POST | `/api/retrieval-build/cat-out/categories/:catNo/rows` | [معالجة حقول الاسترجاع] إضافة صف للفئة |
| PUT | `/api/retrieval-build/cat-out/category-fields/:auto` | [معالجة حقول الاسترجاع] تعديل حقل في الفئة |
| DELETE | `/api/retrieval-build/cat-out/category-fields/:auto` | [معالجة حقول الاسترجاع] حذف حقل من الفئة |

#### نسخ قاعدة البيانات — `/retrieval-build/backup`

| Method | Path | الإجراء |
|---|---|---|
| POST | `/api/retrieval-build/backup` | [نسخ قاعدة البيانات] نسخ قاعدة البيانات |

### المعالجات

#### استمارة التوثيق — `/catalogue/new`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/articles` | [المقالات] عرض قائمة المقالات / البحث بالعنوان |
| GET | `/api/articles/:appNo` | [المقالات] عرض بيانات مقال |
| POST | `/api/articles/next` | [استمارة التوثيق] سجل جديد |
| PUT | `/api/articles/:appNo/documentation` | [استمارة التوثيق] تسجيل بيانات الاستمارة |
| DELETE | `/api/articles/:appNo` | [المقالات] حذف مقال |
| GET | `/api/authors/search` | [المؤلفين ودور النشر] البحث التلقائي عن المؤلفين |
| GET | `/api/catalogue/:appNo/text1` | [التحليل] عرض نص الوثيقة (Text1) |
| GET | `/api/catalogue/:appNo/authors` | [الفهرس] عرض المؤلفين المرتبطين بالوثيقة |
| POST | `/api/catalogue/:appNo/authors` | [استمارة التوثيق] ربط مؤلف بالوثيقة |
| PUT | `/api/catalogue/:appNo/authors/:id` | [استمارة التوثيق] تعديل ربط مؤلف |
| DELETE | `/api/catalogue/:appNo/authors/:id` | [استمارة التوثيق] إلغاء ربط مؤلف |
| GET | `/api/digitization/records` | [الرقمنة] عرض سجلات الملفات الرقمية |
| POST | `/api/digitization/records` | [الرقمنة] إضافة سجل ملف رقمي |
| POST | `/api/digitization/records/upload` | [الرقمنة] رفع ملف رقمي |
| PUT | `/api/digitization/records` | [الرقمنة] تعديل سجل ملف رقمي |
| DELETE | `/api/digitization/records` | [الرقمنة] حذف سجل ملف رقمي |
| PATCH | `/api/catalogue/:appNo/unlock` | [اقفال الوثائق المفتوحة] فتح قفل وثيقة |
| GET | `/api/forms` | [المواقع] البحث في الاستمارات |
| GET | `/api/lookups/coding` | [الجداول المرجعية] عرض جدول الترميز (CODING) |
| GET | `/api/media/file/:stockNo` | [الوسائط] تحميل/تشغيل ملف الفيديو |
| GET | `/api/media/asset/:digitNo` | [الوسائط] عرض ملف غير فيديو |
| GET | `/api/periodicals/all` | [الصحف والمجلات] قائمة كل الدوريات |
| GET | `/api/periodicals/search` | [الصحف والمجلات] البحث في الدوريات |

#### الصحف والمجلات — `/periodicals`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/authors/search` | [المؤلفين ودور النشر] البحث التلقائي عن المؤلفين |
| GET | `/api/authors/:autNo` | [المؤلفين ودور النشر] عرض بيانات مؤلف |
| GET | `/api/forms` | [المواقع] البحث في الاستمارات |
| GET | `/api/forms/by-code/:code` | [المواقع] عرض استمارة حسب الرمز |
| GET | `/api/lookups/coding` | [الجداول المرجعية] عرض جدول الترميز (CODING) |
| GET | `/api/pays-form` | [الجداول المرجعية] البحث في الدول/النماذج |
| GET | `/api/pays-form/:formNo` | [الجداول المرجعية] عرض دولة/نموذج |
| GET | `/api/periodicals/search` | [الصحف والمجلات] البحث في الدوريات |
| GET | `/api/periodicals/next-no` | [الصحف والمجلات] الرقم التالي للدورية |
| GET | `/api/periodicals/:perNo` | [الصحف والمجلات] عرض دورية |
| GET | `/api/periodicals/:perNo/next` | [الصحف والمجلات] الدورية التالية |
| GET | `/api/periodicals/:perNo/previous` | [الصحف والمجلات] الدورية السابقة |
| POST | `/api/periodicals` | [الصحف والمجلات] إضافة دورية |
| PUT | `/api/periodicals/:perNo` | [الصحف والمجلات] تعديل دورية |
| DELETE | `/api/periodicals/:perNo` | [الصحف والمجلات] حذف دورية |

### الاسترجاعات

#### الاسترجاع البياني لبنك المعلومات — `/retrieval`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/catalogue/:appNo/analysis-text` | [التحليل] عرض نص التحليل |
| GET | `/api/catalogue/:appNo/analysis-text/all` | [التحليل] عرض النص الكامل للوثيقة |
| POST | `/api/digitization/results/log-usage` | [شاشة البحث] تسجيل طلب الاستفادة |
| GET | `/api/lookups/coding` | [الجداول المرجعية] عرض جدول الترميز (CODING) |
| GET | `/api/media/file/:stockNo` | [الوسائط] تحميل/تشغيل ملف الفيديو |
| GET | `/api/media/asset/:digitNo` | [الوسائط] عرض ملف غير فيديو |
| GET | `/api/retrieval/fields` | [الاسترجاع البياني لبنك المعلومات] عرض حقول الاسترجاع |
| GET | `/api/retrieval/lookup-values` | [الاسترجاع البياني لبنك المعلومات] قيم البحث للحقل |
| GET | `/api/retrieval/lookup-codes` | [الاسترجاع البياني لبنك المعلومات] رموز الشرط المرمّز |
| POST | `/api/retrieval/search` | [الاسترجاع البياني لبنك المعلومات] تنفيذ الاسترجاع |
| GET | `/api/retrieval/my-field-state` | [الاسترجاع البياني لبنك المعلومات] حالة حقول العرض للمستخدم |
| POST | `/api/retrieval/my-field-state/:fieldKey/toggle-display` | [الاسترجاع البياني لبنك المعلومات] تبديل حقل العرض |
| POST | `/api/retrieval/my-field-state/:fieldKey/toggle-order` | [الاسترجاع البياني لبنك المعلومات] تبديل علامة الترتيب |
| POST | `/api/retrieval/my-field-state/mark-category` | [الاسترجاع البياني لبنك المعلومات] تعليم حقول العرض |
| POST | `/api/retrieval/fields/:fieldKey/toggle-hash-mark` | [الاسترجاع البياني لبنك المعلومات] تبديل علامة # |
| PUT | `/api/search-screen/results/:digitNo/choice` | [شاشة البحث] الاختيار |

#### استرجاع الملفات الاضافية — `/retrieval/additional-files`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/catalogue/:appNo/analysis-text` | [التحليل] عرض نص التحليل |
| GET | `/api/catalogue/:appNo/analysis-text/all` | [التحليل] عرض النص الكامل للوثيقة |
| POST | `/api/digitization/results/log-usage` | [شاشة البحث] تسجيل طلب الاستفادة |
| GET | `/api/lookups/coding` | [الجداول المرجعية] عرض جدول الترميز (CODING) |
| GET | `/api/media/file/:stockNo` | [الوسائط] تحميل/تشغيل ملف الفيديو |
| GET | `/api/media/asset/:digitNo` | [الوسائط] عرض ملف غير فيديو |
| GET | `/api/retrieval/fields` | [الاسترجاع البياني لبنك المعلومات] عرض حقول الاسترجاع |
| GET | `/api/retrieval/lookup-values` | [الاسترجاع البياني لبنك المعلومات] قيم البحث للحقل |
| GET | `/api/retrieval/lookup-codes` | [الاسترجاع البياني لبنك المعلومات] رموز الشرط المرمّز |
| POST | `/api/retrieval/search` | [الاسترجاع البياني لبنك المعلومات] تنفيذ الاسترجاع |
| GET | `/api/retrieval/my-field-state` | [الاسترجاع البياني لبنك المعلومات] حالة حقول العرض للمستخدم |
| POST | `/api/retrieval/my-field-state/:fieldKey/toggle-display` | [الاسترجاع البياني لبنك المعلومات] تبديل حقل العرض |
| POST | `/api/retrieval/my-field-state/:fieldKey/toggle-order` | [الاسترجاع البياني لبنك المعلومات] تبديل علامة الترتيب |
| POST | `/api/retrieval/my-field-state/mark-category` | [الاسترجاع البياني لبنك المعلومات] تعليم حقول العرض |
| POST | `/api/retrieval/fields/:fieldKey/toggle-hash-mark` | [الاسترجاع البياني لبنك المعلومات] تبديل علامة # |
| PUT | `/api/search-screen/results/:digitNo/choice` | [شاشة البحث] الاختيار |

#### طلبات سحب الملفات الاضافية — `/catalogue/files-retrieval`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/temp-files` | [طلبات سحب الملفات الاضافية] عرض طلبات سحب الملفات |
| PATCH | `/api/temp-files/:no/:ser/finalize` | [طلبات سحب الملفات الاضافية] إنهاء طلب سحب |
| DELETE | `/api/temp-files/:no/:ser` | [طلبات سحب الملفات الاضافية] حذف طلب سحب |

#### طلبيات الفيديو — `/video-orders`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/digitization/demand-queue/context` | [طلبيات الفيديو] بيانات سياق قائمة الطلبيات |
| GET | `/api/digitization/demand-queue` | [طلبيات الفيديو] البحث في قائمة الطلبيات |
| GET | `/api/digitization/demand-queue/users` | [طلبيات الفيديو] قائمة المستخدمين |
| GET | `/api/digitization/demand-queue/path-options` | [طلبيات الفيديو] خيارات المسار |
| PATCH | `/api/digitization/demand-queue/checked` | [طلبيات الفيديو] تعليم/إلغاء اختيار طلبية |
| PATCH | `/api/digitization/demand-queue/path` | [طلبيات الفيديو] تعيين المسار |
| POST | `/api/digitization/demand-queue/process` | [طلبيات الفيديو] تنفيذ معالجة الطلبيات |
| DELETE | `/api/digitization/demands/:id` | [الرقمنة] حذف طلب مشهد |
| POST | `/api/digitization/demands/queue-scenes` | [طلبيات الفيديو] إضافة مشهد للطلبيات |
| POST | `/api/digitization/demands/test` | [طلبيات الفيديو] اختبار الطلبيات |
| GET | `/api/digitization/demands/jobs/:jobId` | [الرقمنة] متابعة مهمة التسليم |
| GET | `/api/media/file/:stockNo` | [الوسائط] تحميل/تشغيل ملف الفيديو |

#### استرجاع الصحف والمجلات — `/retrieval/periodicals`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/catalogue/:appNo/analysis-text` | [التحليل] عرض نص التحليل |
| GET | `/api/catalogue/:appNo/analysis-text/all` | [التحليل] عرض النص الكامل للوثيقة |
| POST | `/api/digitization/results/log-usage` | [شاشة البحث] تسجيل طلب الاستفادة |
| GET | `/api/lookups/coding` | [الجداول المرجعية] عرض جدول الترميز (CODING) |
| GET | `/api/media/file/:stockNo` | [الوسائط] تحميل/تشغيل ملف الفيديو |
| GET | `/api/media/asset/:digitNo` | [الوسائط] عرض ملف غير فيديو |
| GET | `/api/retrieval/fields` | [الاسترجاع البياني لبنك المعلومات] عرض حقول الاسترجاع |
| GET | `/api/retrieval/lookup-values` | [الاسترجاع البياني لبنك المعلومات] قيم البحث للحقل |
| GET | `/api/retrieval/lookup-codes` | [الاسترجاع البياني لبنك المعلومات] رموز الشرط المرمّز |
| POST | `/api/retrieval/search` | [الاسترجاع البياني لبنك المعلومات] تنفيذ الاسترجاع |
| GET | `/api/retrieval/my-field-state` | [الاسترجاع البياني لبنك المعلومات] حالة حقول العرض للمستخدم |
| POST | `/api/retrieval/my-field-state/:fieldKey/toggle-display` | [الاسترجاع البياني لبنك المعلومات] تبديل حقل العرض |
| POST | `/api/retrieval/my-field-state/:fieldKey/toggle-order` | [الاسترجاع البياني لبنك المعلومات] تبديل علامة الترتيب |
| POST | `/api/retrieval/my-field-state/mark-category` | [الاسترجاع البياني لبنك المعلومات] تعليم حقول العرض |
| POST | `/api/retrieval/fields/:fieldKey/toggle-hash-mark` | [الاسترجاع البياني لبنك المعلومات] تبديل علامة # |
| PUT | `/api/search-screen/results/:digitNo/choice` | [شاشة البحث] الاختيار |

### عناصر مستقلة في القائمة

#### شاشة البحث — `/catalogue/search`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/authors/search` | [المؤلفين ودور النشر] البحث التلقائي عن المؤلفين |
| POST | `/api/digitization/results/log-usage` | [شاشة البحث] تسجيل طلب الاستفادة |
| GET | `/api/forms` | [المواقع] البحث في الاستمارات |
| GET | `/api/lookups/subjects` | [الجداول المرجعية] عرض موضوعات المكنز |
| GET | `/api/lookups/coding` | [الجداول المرجعية] عرض جدول الترميز (CODING) |
| GET | `/api/media/asset/:digitNo` | [الوسائط] عرض ملف غير فيديو |
| GET | `/api/periodicals/search` | [الصحف والمجلات] البحث في الدوريات |
| POST | `/api/search-screen/search` | [شاشة البحث] تنفيذ البحث |
| PUT | `/api/search-screen/results/:digitNo/choice` | [شاشة البحث] الاختيار |

#### شاشة الطلبات — `/requests`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/digitization/results` | [شاشة الطلبات] عرض طلبات الاستفادة |
| GET | `/api/digitization/results/:id` | [شاشة الطلبات] عرض طلب استفادة |
| PUT | `/api/digitization/results/:id` | [شاشة الطلبات] تعديل طلب استفادة |
| PUT | `/api/digitization/results/by-number/:resultNo` | [شاشة الطلبات] تعديل طلبات معينة |
| DELETE | `/api/digitization/results/by-number/:resultNo` | [شاشة الطلبات] الغاء الطلب |
| GET | `/api/lookups/coding` | [الجداول المرجعية] عرض جدول الترميز (CODING) |

#### شاشة البحث فيديو + صوتي — `/archive-search`

| Method | Path | الإجراء |
|---|---|---|
| POST | `/api/archive-search` | [شاشة البحث فيديو + صوتي] البحث في الأرشيف المرئي والمسموع |
| GET | `/api/archive-search/article-types` | [شاشة البحث فيديو + صوتي] قائمة أنواع المواد للفلترة |
| GET | `/api/archive-search/document-types` | [شاشة البحث فيديو + صوتي] قائمة أنواع الوثائق للفلترة |
| POST | `/api/archive-search/:appNo/remark` | [شاشة البحث فيديو + صوتي] حفظ ملاحظات المستفيد |
| GET | `/api/authors/search` | [المؤلفين ودور النشر] البحث التلقائي عن المؤلفين |
| GET | `/api/digitization/demands` | [الرقمنة] عرض طلبات المشاهد |
| DELETE | `/api/digitization/demands/:id` | [الرقمنة] حذف طلب مشهد |
| POST | `/api/digitization/demands/scenes` | [شاشة البحث فيديو + صوتي] إضافة مشهد للطلب |
| PATCH | `/api/digitization/demands/bulk-status` | [شاشة البحث فيديو + صوتي] تعليم الطلبات كمنفذة/مختارة |
| POST | `/api/digitization/demands/send-to-edlc` | [شاشة البحث فيديو + صوتي] ارسل الى EDLC |
| POST | `/api/digitization/demands/extract-clips` | [شاشة البحث فيديو + صوتي] استخراج المقاطع |
| POST | `/api/digitization/demands/render-dv` | [شاشة البحث فيديو + صوتي] إخراج المشاهد بصيغة DV |
| GET | `/api/digitization/demands/jobs/:jobId` | [الرقمنة] متابعة مهمة التسليم |
| GET | `/api/forms` | [المواقع] البحث في الاستمارات |
| GET | `/api/lookups/subjects` | [الجداول المرجعية] عرض موضوعات المكنز |
| GET | `/api/media/resolve/:stockNo` | [الوسائط] تحديد مكان ملف الوسائط |
| GET | `/api/media/file/:stockNo` | [الوسائط] تحميل/تشغيل ملف الفيديو |
| GET | `/api/media/asset/:digitNo` | [الوسائط] عرض ملف غير فيديو |
| GET | `/api/positions/by-form/:formCode` | [المواقع] المناصب حسب الاستمارة |
| GET | `/api/search/fulltext` | [البحث] البحث في النص الكامل |

### إضافات

#### الصور — `/pictures`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/media/resolve/:stockNo` | [الوسائط] تحديد مكان ملف الوسائط |
| GET | `/api/media/file/:stockNo` | [الوسائط] تحميل/تشغيل ملف الفيديو |
| GET | `/api/pictures` | [الصور] عرض قائمة الصور |
| GET | `/api/pictures/:picNo` | [الصور] عرض صورة |
| POST | `/api/pictures` | [الصور] إضافة صورة |
| PUT | `/api/pictures/:picNo` | [الصور] تعديل صورة |
| DELETE | `/api/pictures/:picNo` | [الصور] حذف صورة |

#### الأشخاص — `/persons`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/persons` | [الأشخاص] عرض قائمة الأشخاص |
| GET | `/api/persons/:prsNo` | [الأشخاص] عرض بيانات شخص |
| POST | `/api/persons` | [الأشخاص] إضافة شخص |
| PUT | `/api/persons/:prsNo` | [الأشخاص] تعديل شخص |
| GET | `/api/persons/:prsNo/assignments` | [الأشخاص] عرض تكليفات الشخص |
| DELETE | `/api/persons/:prsNo` | [الأشخاص] حذف شخص |
| GET | `/api/staff` | [الأشخاص] عرض قائمة الموظفين |
| GET | `/api/staff/:prsNo` | [الأشخاص] عرض بيانات موظف |

#### الإعارة — `/borrowing`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/books` | [الكتب] عرض قائمة الكتب |
| GET | `/api/borrowing` | [الإعارة] عرض قائمة الإعارات |
| GET | `/api/borrowing/lookup` | [الإعارة] عرض بيانات إعارة |
| POST | `/api/borrowing` | [الإعارة] إضافة إعارة |
| PATCH | `/api/borrowing/return` | [الإعارة] إرجاع إعارة |
| GET | `/api/borrowing/:iarNo/books` | [الإعارة] عرض كتب الإعارة |
| POST | `/api/borrowing/:iarNo/books` | [الإعارة] إضافة كتاب للإعارة |
| DELETE | `/api/borrowing/:iarNo/books/:iabSer` | [الإعارة] حذف كتاب من الإعارة |
| GET | `/api/borrowing/:iarNo/others` | [الإعارة] عرض المواد الأخرى للإعارة |
| POST | `/api/borrowing/:iarNo/others` | [الإعارة] إضافة مادة أخرى للإعارة |
| DELETE | `/api/borrowing/:iarNo/others/:iaoSer` | [الإعارة] حذف مادة أخرى من الإعارة |
| GET | `/api/catalogue` | [الفهرس] عرض فهرس الوثائق |
| GET | `/api/persons` | [الأشخاص] عرض قائمة الأشخاص |

#### الأرشيف — `/archive`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/archive/charts` | [الأرشيف] عرض قائمة ملفات الأرشيف |
| GET | `/api/archive/charts/:id` | [الأرشيف] عرض بيانات ملف أرشيف |
| POST | `/api/archive/charts` | [الأرشيف] إضافة ملف أرشيف |
| PUT | `/api/archive/charts/:id` | [الأرشيف] تعديل ملف أرشيف |
| DELETE | `/api/archive/charts/:id` | [الأرشيف] حذف ملف أرشيف |
| GET | `/api/archive/charts/:id/operations` | [الأرشيف] عرض عمليات ملف الأرشيف |
| POST | `/api/archive/charts/:id/operations` | [الأرشيف] إضافة عملية لملف الأرشيف |
| PUT | `/api/archive/charts/:id/operations/:operationId` | [الأرشيف] تعديل عملية لملف الأرشيف |

#### المواقع — `/sites`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/forms/institutions` | [المواقع] عرض المؤسسات |
| GET | `/api/forms` | [المواقع] البحث في الاستمارات |
| POST | `/api/forms` | [المواقع] إضافة استمارة |
| PUT | `/api/forms/:formNo` | [المواقع] تعديل استمارة |
| DELETE | `/api/forms/:formNo` | [المواقع] حذف استمارة |
| GET | `/api/forms/:formNo/subjects` | [المواقع] عرض موضوعات الاستمارة |
| POST | `/api/forms/:formNo/subjects` | [المواقع] إضافة موضوع للاستمارة |
| PUT | `/api/forms/:formNo/subjects/:mcnzCode` | [المواقع] تعديل موضوع الاستمارة |
| DELETE | `/api/forms/:formNo/subjects/:mcnzCode` | [المواقع] حذف موضوع من الاستمارة |
| GET | `/api/forms/:formNo/related-forms` | [المواقع] عرض الاستمارات المرتبطة |
| POST | `/api/forms/:formNo/related-forms` | [المواقع] إضافة استمارة مرتبطة |
| PUT | `/api/forms/:formNo/related-forms/:form2No` | [المواقع] تعديل استمارة مرتبطة |
| DELETE | `/api/forms/:formNo/related-forms/:form2No` | [المواقع] حذف استمارة مرتبطة |
| GET | `/api/positions` | [المواقع] عرض المناصب |
| POST | `/api/positions` | [المواقع] إضافة منصب |
| PUT | `/api/positions/:posNo` | [المواقع] تعديل منصب |
| DELETE | `/api/positions/:posNo` | [المواقع] حذف منصب |
| GET | `/api/posts` | [المواقع] عرض الوظائف |
| GET | `/api/posts/:serial` | [المواقع] عرض وظيفة |
| POST | `/api/posts` | [المواقع] إضافة وظيفة |
| PUT | `/api/posts/:serial` | [المواقع] تعديل وظيفة |
| DELETE | `/api/posts/:serial` | [المواقع] حذف وظيفة |
| GET | `/api/sites` | [المواقع] عرض المواقع |
| GET | `/api/sites/:siteNo` | [المواقع] عرض موقع |
| POST | `/api/sites` | [المواقع] إضافة موقع |
| PUT | `/api/sites/:siteNo` | [المواقع] تعديل موقع |
| DELETE | `/api/sites/:siteNo` | [المواقع] حذف موقع |

#### الرقمنة — `/digitization`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/digitization/records` | [الرقمنة] عرض سجلات الملفات الرقمية |
| POST | `/api/digitization/records` | [الرقمنة] إضافة سجل ملف رقمي |
| DELETE | `/api/digitization/records` | [الرقمنة] حذف سجل ملف رقمي |
| GET | `/api/digitization/demands` | [الرقمنة] عرض طلبات المشاهد |
| POST | `/api/digitization/demands` | [الرقمنة] إضافة طلب |
| DELETE | `/api/digitization/demands/:id` | [الرقمنة] حذف طلب مشهد |
| GET | `/api/digitization/results` | [شاشة الطلبات] عرض طلبات الاستفادة |
| POST | `/api/digitization/results` | [الرقمنة] إضافة نتيجة |
| DELETE | `/api/digitization/results/:id` | [الرقمنة] حذف نتيجة |

#### التقارير — `/reports`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/reports/generate/:reportType` | [التقارير] توليد تقرير |
| GET | `/api/reports/execute/:templateNum` | [التقارير] تنفيذ قالب تقرير |
| GET | `/api/reports/templates` | [التقارير] عرض قوالب التقارير |
| GET | `/api/reports/templates/:id` | [التقارير] عرض قالب تقرير |
| POST | `/api/reports/templates` | [التقارير] إضافة قالب تقرير |
| PUT | `/api/reports/templates/:id` | [التقارير] تعديل قالب تقرير |
| DELETE | `/api/reports/templates/:id` | [التقارير] حذف قالب تقرير |
| GET | `/api/reports/user-outputs` | [التقارير] عرض مخرجات المستخدمين |
| POST | `/api/reports/user-outputs` | [التقارير] تعيين مخرج لمستخدم |
| DELETE | `/api/reports/user-outputs` | [التقارير] حذف مخرج مستخدم |

#### الصيانة — `/maintenance`

| Method | Path | الإجراء |
|---|---|---|
| POST | `/api/admin/backup` | [الصيانة] إنشاء نسخة احتياطية |
| GET | `/api/admin/backup` | [الصيانة] عرض النسخ الاحتياطية |
| GET | `/api/catalogue/locked` | [اقفال الوثائق المفتوحة] عرض الوثائق المقفلة |
| PATCH | `/api/catalogue/:appNo/unlock` | [اقفال الوثائق المفتوحة] فتح قفل وثيقة |
| POST | `/api/maintenance/renumber` | [الصيانة] إعادة الترقيم |
| POST | `/api/maintenance/copy-to-archive` | [الصيانة] نسخ إلى الأرشيف |
| POST | `/api/maintenance/file-links` | [الصيانة] إضافة رابط ملف |
| GET | `/api/maintenance/file-links/:appNo` | [الصيانة] تحميل روابط الملفات |
| DELETE | `/api/maintenance/file-links/:id` | [الصيانة] حذف رابط ملف |
| GET | `/api/retrieval-fields` | [الصيانة] عرض حقول الاسترجاع |
| POST | `/api/retrieval-fields` | [الصيانة] إضافة حقل استرجاع |
| PUT | `/api/retrieval-fields/:id` | [الصيانة] تعديل حقل استرجاع |
| DELETE | `/api/retrieval-fields/:id` | [الصيانة] حذف حقل استرجاع |

### شاشات أخرى

#### فهرس الوثائق (الشاشة الافتراضية بعد الدخول) — `/catalogue`

| Method | Path | الإجراء |
|---|---|---|
| POST | `/api/additional-files/search` | [ملفات اضافية للادخال] البحث في الملفات الاضافية |
| POST | `/api/additional-files/op-tmp` | [ملفات اضافية للادخال] إضافة الوثيقة الحالية إلى الملفات الاضافية |
| PUT | `/api/additional-files` | [ملفات اضافية للادخال] تعديل خلية في الملفات الاضافية |
| POST | `/api/additional-files` | [ملفات اضافية للادخال] إضافة صف جديد في الملفات الاضافية |
| POST | `/api/additional-files/delete` | [ملفات اضافية للادخال] حذف صف من الملفات الاضافية |
| GET | `/api/catalogue/:appNo/analysis-text` | [التحليل] عرض نص التحليل |
| PUT | `/api/catalogue/:appNo/analysis-text` | [التحليل] حفظ نص التحليل |
| PUT | `/api/catalogue/:appNo/abstract` | [التحليل] حفظ الملخص |
| GET | `/api/catalogue` | [الفهرس] عرض فهرس الوثائق |
| GET | `/api/catalogue/:appNo` | [الفهرس] عرض بيانات وثيقة |
| POST | `/api/catalogue/search` | [الفهرس] البحث المتقدم في الفهرس |
| POST | `/api/catalogue` | [الفهرس] إضافة وثيقة للفهرس |
| PUT | `/api/catalogue/:appNo` | [الفهرس] تعديل وثيقة في الفهرس |
| GET | `/api/catalogue/:appNo/corrections` | [الفهرس] سجل التصحيحات |
| DELETE | `/api/catalogue/:appNo` | [الفهرس] حذف وثيقة من الفهرس |
| GET | `/api/catalogue/:appNo/date-subjects` | [التحليل] عرض موضوعات التاريخ |
| POST | `/api/catalogue/:appNo/date-subjects` | [التحليل] إضافة موضوع تاريخ |
| DELETE | `/api/catalogue/:appNo/date-subjects/:serNo/:relNo` | [التحليل] حذف موضوع تاريخ |
| GET | `/api/catalogue/:appNo/time-descriptors` | [التحليل] عرض الواصفات الزمنية |
| POST | `/api/catalogue/:appNo/time-descriptors` | [التحليل] إضافة واصفة زمنية |
| DELETE | `/api/catalogue/:appNo/time-descriptors/:serNo/:rltvNo` | [التحليل] حذف واصفة زمنية |
| GET | `/api/catalogue/:appNo/text1` | [التحليل] عرض نص الوثيقة (Text1) |
| GET | `/api/catalogue/:appNo/subjects` | [التحليل] عرض الواصفات الموضوعية للوثيقة |
| POST | `/api/catalogue/:appNo/subjects` | [التحليل] إضافة واصفة موضوعية |
| PUT | `/api/catalogue/:appNo/subjects/:id` | [التحليل] استبدال الواصفة |
| DELETE | `/api/catalogue/:appNo/subjects/:id` | [التحليل] حذف واصفة موضوعية |
| GET | `/api/catalogue/:appNo/geo` | [التحليل] عرض الواصفات الجغرافية |
| POST | `/api/catalogue/:appNo/geo` | [التحليل] إضافة واصفة جغرافية |
| DELETE | `/api/catalogue/:appNo/geo/:id` | [التحليل] حذف واصفة جغرافية |
| GET | `/api/catalogue/:appNo/files` | [التحليل] عرض الملفات المرتبطة |
| POST | `/api/catalogue/:appNo/files` | [التحليل] ربط ملف بالوثيقة |
| DELETE | `/api/catalogue/:appNo/files/:id` | [التحليل] حذف ملف مرتبط |
| GET | `/api/catalogue/:appNo/narrower` | [التحليل] عرض المصطلحات الأضيق |
| POST | `/api/catalogue/:appNo/narrower` | [التحليل] إضافة مصطلح أضيق |
| DELETE | `/api/catalogue/:appNo/narrower/:id` | [التحليل] حذف مصطلح أضيق |
| GET | `/api/catalogue/:appNo/related` | [التحليل] عرض المصطلحات المرتبطة |
| POST | `/api/catalogue/:appNo/related` | [التحليل] إضافة مصطلح مرتبط |
| DELETE | `/api/catalogue/:appNo/related/:id` | [التحليل] حذف مصطلح مرتبط |
| GET | `/api/catalogue/:appNo/authors` | [الفهرس] عرض المؤلفين المرتبطين بالوثيقة |
| GET | `/api/digitization/records` | [الرقمنة] عرض سجلات الملفات الرقمية |
| GET | `/api/forms` | [المواقع] البحث في الاستمارات |
| GET | `/api/forms/by-code/:code` | [المواقع] عرض استمارة حسب الرمز |
| GET | `/api/forms/:formNo` | [المواقع] عرض بيانات استمارة |
| GET | `/api/lookups/subjects` | [الجداول المرجعية] عرض موضوعات المكنز |
| GET | `/api/catalogue/:appNo/extended` | [الفهرس] عرض المعلومات الاضافية للوثيقة |
| POST | `/api/catalogue/:appNo/extended` | [الفهرس] إضافة معلومات اضافية |
| PUT | `/api/catalogue/:appNo/extended` | [الفهرس] تعديل المعلومات الاضافية |
| GET | `/api/media/file/:stockNo` | [الوسائط] تحميل/تشغيل ملف الفيديو |
| GET | `/api/media/asset/:digitNo` | [الوسائط] عرض ملف غير فيديو |
| GET | `/api/pays-form` | [الجداول المرجعية] البحث في الدول/النماذج |
| GET | `/api/positions/by-form/:formCode` | [المواقع] المناصب حسب الاستمارة |

#### تسجيل الدخول — `/auth/login`

| Method | Path | الإجراء |
|---|---|---|
| POST | `/api/auth/login` | [تسجيل الدخول] تسجيل الدخول |

#### تغيير كلمة المرور — `/auth/change-password`

| Method | Path | الإجراء |
|---|---|---|
| POST | `/api/auth/change-password` | [تسجيل الدخول] تغيير كلمة المرور |

#### البحث دون تسجيل الدخول (رابط من شاشة الدخول) — `/public`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/public/search` | [البحث دون تسجيل الدخول] البحث العام |

#### الشريط العلوي (البحث العام) — `/`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/search/fulltext` | [البحث] البحث في النص الكامل |

#### الكتب — `/books`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/authors/search` | [المؤلفين ودور النشر] البحث التلقائي عن المؤلفين |
| GET | `/api/books` | [الكتب] عرض قائمة الكتب |
| GET | `/api/books/:appNo` | [الكتب] عرض بيانات كتاب |
| PUT | `/api/books/:appNo` | [الكتب] تعديل كتاب |
| DELETE | `/api/books/:appNo` | [الكتب] حذف كتاب |
| GET | `/api/books/:appNo/series` | [الكتب] عرض سلسلة الكتاب |
| GET | `/api/catalogue/:appNo/authors` | [الفهرس] عرض المؤلفين المرتبطين بالوثيقة |

#### المقالات — `/articles`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/articles` | [المقالات] عرض قائمة المقالات / البحث بالعنوان |
| GET | `/api/articles/:appNo` | [المقالات] عرض بيانات مقال |
| PUT | `/api/articles/:appNo` | [المقالات] تعديل مقال |
| DELETE | `/api/articles/:appNo` | [المقالات] حذف مقال |
| GET | `/api/periodicals/search` | [الصحف والمجلات] البحث في الدوريات |

#### الأخبار — `/news`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/news` | [الأخبار] عرض قائمة الأخبار |
| GET | `/api/news/:newsNo` | [الأخبار] عرض خبر |
| POST | `/api/news/search` | [الأخبار] البحث المتقدم في الأخبار |
| POST | `/api/news` | [الأخبار] إضافة خبر |
| PUT | `/api/news/:newsNo` | [الأخبار] تعديل خبر |
| DELETE | `/api/news/:newsNo` | [الأخبار] حذف خبر |
| POST | `/api/news/:newsNo/keywords` | [الأخبار] إضافة كلمة مفتاحية |
| DELETE | `/api/news/:newsNo/keywords/:word` | [الأخبار] حذف كلمة مفتاحية |

#### تصنيف الموضوعات — `/subjects`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/archive/charts` | [الأرشيف] عرض قائمة ملفات الأرشيف |
| GET | `/api/lookups/subjects` | [الجداول المرجعية] عرض موضوعات المكنز |
| POST | `/api/lookups/subjects` | [الجداول المرجعية] إضافة موضوع للمكنز |
| PUT | `/api/lookups/subjects/:code` | [الجداول المرجعية] تعديل موضوع في المكنز |
| DELETE | `/api/lookups/subjects/:code` | [الجداول المرجعية] حذف موضوع من المكنز |
| GET | `/api/lookups/coding` | [الجداول المرجعية] عرض جدول الترميز (CODING) |
| POST | `/api/lookups/coding` | [الجداول المرجعية] إضافة رمز |
| PUT | `/api/lookups/coding/:level/:code` | [الجداول المرجعية] تعديل رمز |
| DELETE | `/api/lookups/coding/:level/:code` | [الجداول المرجعية] حذف رمز |

#### موافقات طلبيات الفيديو — `/video-orders/approvals`

| Method | Path | الإجراء |
|---|---|---|
| GET | `/api/video-orders` | [طلبيات الفيديو] عرض موافقات الطلبيات |
| GET | `/api/video-orders/:id` | [طلبيات الفيديو] عرض طلبية |
| POST | `/api/video-orders` | [طلبيات الفيديو] إضافة طلبية |
| PUT | `/api/video-orders/:id` | [طلبيات الفيديو] تعديل طلبية |
| DELETE | `/api/video-orders/:id` | [طلبيات الفيديو] حذف طلبية |
| PATCH | `/api/video-orders/:id/status` | [طلبيات الفيديو] تغيير حالة طلبية |

## الـ endpoints حسب الـ controller

### User

`Backend-repo/src/main/java/com/startupstack/app/modules/users/controller/UserController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| POST | `/api/auth/login` | [تسجيل الدخول] تسجيل الدخول | مؤكد في الواجهة |
| POST | `/api/auth/change-password` | [تسجيل الدخول] تغيير كلمة المرور | مؤكد في الواجهة |
| POST | `/api/admin/migrate-passwords` | [الصيانة] ترحيل كلمات المرور إلى التشفير | API فقط (لا توجد Angular service) |
| GET | `/api/users` | [إدارة المستخدمين] عرض قائمة المستخدمين | API فقط (لا توجد Angular service) |
| GET | `/api/users/:userNo` | [إدارة المستخدمين] عرض بيانات مستخدم | API فقط (لا توجد Angular service) |
| POST | `/api/users` | [إدارة المستخدمين] إضافة مستخدم | API فقط (لا توجد Angular service) |
| PUT | `/api/users/:userNo` | [إدارة المستخدمين] تعديل مستخدم | API فقط (لا توجد Angular service) |
| DELETE | `/api/users/:userNo` | [إدارة المستخدمين] حذف مستخدم | API فقط (لا توجد Angular service) |

### AdditionalFiles

`Backend-repo/src/main/java/com/startupstack/app/modules/formthesaurus/controller/AdditionalFilesController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| POST | `/api/additional-files/search` | [ملفات اضافية للادخال] البحث في الملفات الاضافية | مؤكد في الواجهة |
| POST | `/api/additional-files/op-tmp` | [ملفات اضافية للادخال] إضافة الوثيقة الحالية إلى الملفات الاضافية | مؤكد في الواجهة |
| PUT | `/api/additional-files` | [ملفات اضافية للادخال] تعديل خلية في الملفات الاضافية | مؤكد في الواجهة |
| POST | `/api/additional-files` | [ملفات اضافية للادخال] إضافة صف جديد في الملفات الاضافية | مؤكد في الواجهة |
| POST | `/api/additional-files/delete` | [ملفات اضافية للادخال] حذف صف من الملفات الاضافية | مؤكد في الواجهة |

### Admin

`Backend-repo/src/main/java/com/startupstack/app/modules/admin/controller/AdminController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/admin/temp-schema` | [الصيانة] عرض حقول الجدول المؤقت | API فقط (لا توجد Angular service) |
| POST | `/api/admin/temp-schema` | [الصيانة] إضافة حقل للجدول المؤقت | API فقط (لا توجد Angular service) |
| DELETE | `/api/admin/temp-schema/:fieldName` | [الصيانة] حذف حقل من الجدول المؤقت | API فقط (لا توجد Angular service) |
| GET | `/api/admin/media-ranges` | [الصيانة] عرض نطاقات الوسائط | API فقط (لا توجد Angular service) |
| POST | `/api/admin/media-ranges` | [الصيانة] إضافة نطاق وسائط | API فقط (لا توجد Angular service) |
| PUT | `/api/admin/media-ranges/:id` | [الصيانة] تعديل نطاق وسائط | API فقط (لا توجد Angular service) |
| DELETE | `/api/admin/media-ranges/:id` | [الصيانة] حذف نطاق وسائط | API فقط (لا توجد Angular service) |
| POST | `/api/admin/backup` | [الصيانة] إنشاء نسخة احتياطية | مؤكد في الواجهة |
| GET | `/api/admin/backup` | [الصيانة] عرض النسخ الاحتياطية | مؤكد في الواجهة |

### AnalysisPage

`Backend-repo/src/main/java/com/startupstack/app/modules/catalogue/controller/AnalysisPageController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/catalogue/:appNo/analysis-text` | [التحليل] عرض نص التحليل | مؤكد في الواجهة |
| GET | `/api/catalogue/:appNo/analysis-text/all` | [التحليل] عرض النص الكامل للوثيقة | مؤكد في الواجهة |
| PUT | `/api/catalogue/:appNo/analysis-text` | [التحليل] حفظ نص التحليل | مؤكد في الواجهة |
| PUT | `/api/catalogue/:appNo/abstract` | [التحليل] حفظ الملخص | مؤكد في الواجهة |

### Archive

`Backend-repo/src/main/java/com/startupstack/app/modules/archive/controller/ArchiveController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/archive/charts` | [الأرشيف] عرض قائمة ملفات الأرشيف | مؤكد في الواجهة |
| GET | `/api/archive/charts/:id` | [الأرشيف] عرض بيانات ملف أرشيف | مؤكد في الواجهة |
| POST | `/api/archive/charts` | [الأرشيف] إضافة ملف أرشيف | مؤكد في الواجهة |
| PUT | `/api/archive/charts/:id` | [الأرشيف] تعديل ملف أرشيف | مؤكد في الواجهة |
| DELETE | `/api/archive/charts/:id` | [الأرشيف] حذف ملف أرشيف | مؤكد في الواجهة |
| POST | `/api/archive/charts/batch` | [الأرشيف] إضافة ملفات أرشيف دفعة واحدة | API فقط (لا توجد Angular service) |
| GET | `/api/archive/charts/:id/operations` | [الأرشيف] عرض عمليات ملف الأرشيف | مؤكد في الواجهة |
| GET | `/api/archive/charts/:id/operations/:operationId` | [الأرشيف] عرض عملية واحدة لملف الأرشيف | API فقط (لا توجد Angular service) |
| POST | `/api/archive/charts/:id/operations` | [الأرشيف] إضافة عملية لملف الأرشيف | مؤكد في الواجهة |
| PUT | `/api/archive/charts/:id/operations/:operationId` | [الأرشيف] تعديل عملية لملف الأرشيف | مؤكد في الواجهة |
| DELETE | `/api/archive/charts/:id/operations/:operationId` | [الأرشيف] حذف عملية من ملف الأرشيف | API فقط (لا توجد Angular service) |

### ArchiveSearch

`Backend-repo/src/main/java/com/startupstack/app/modules/archivesearch/controller/ArchiveSearchController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| POST | `/api/archive-search` | [شاشة البحث فيديو + صوتي] البحث في الأرشيف المرئي والمسموع | مؤكد في الواجهة |
| GET | `/api/archive-search/responsible-persons` | [شاشة البحث فيديو + صوتي] قائمة المسؤولين للفلترة | غير مؤكد: service بدون component |
| GET | `/api/archive-search/article-types` | [شاشة البحث فيديو + صوتي] قائمة أنواع المواد للفلترة | مؤكد في الواجهة |
| GET | `/api/archive-search/document-types` | [شاشة البحث فيديو + صوتي] قائمة أنواع الوثائق للفلترة | مؤكد في الواجهة |
| POST | `/api/archive-search/:appNo/remark` | [شاشة البحث فيديو + صوتي] حفظ ملاحظات المستفيد | مؤكد في الواجهة |

### Article

`Backend-repo/src/main/java/com/startupstack/app/modules/articles/controller/ArticleController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/articles` | [المقالات] عرض قائمة المقالات / البحث بالعنوان | مؤكد في الواجهة |
| GET | `/api/articles/:appNo` | [المقالات] عرض بيانات مقال | مؤكد في الواجهة |
| POST | `/api/articles` | [المقالات] إضافة مقال | غير مؤكد: service بدون component |
| PUT | `/api/articles/:appNo` | [المقالات] تعديل مقال | مؤكد في الواجهة |
| POST | `/api/articles/next` | [استمارة التوثيق] سجل جديد | مؤكد في الواجهة |
| PUT | `/api/articles/:appNo/documentation` | [استمارة التوثيق] تسجيل بيانات الاستمارة | مؤكد في الواجهة |
| DELETE | `/api/articles/:appNo` | [المقالات] حذف مقال | مؤكد في الواجهة |

### Author

`Backend-repo/src/main/java/com/startupstack/app/modules/authors/controller/AuthorController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/authors/search` | [المؤلفين ودور النشر] البحث التلقائي عن المؤلفين | مؤكد في الواجهة |
| GET | `/api/authors` | [المؤلفين ودور النشر] عرض قائمة المؤلفين | API فقط (لا توجد Angular service) |
| GET | `/api/authors/:autNo` | [المؤلفين ودور النشر] عرض بيانات مؤلف | مؤكد في الواجهة |
| POST | `/api/authors` | [المؤلفين ودور النشر] إضافة مؤلف | API فقط (لا توجد Angular service) |
| PUT | `/api/authors/:autNo` | [المؤلفين ودور النشر] تعديل مؤلف | API فقط (لا توجد Angular service) |
| DELETE | `/api/authors/:autNo` | [المؤلفين ودور النشر] حذف مؤلف | API فقط (لا توجد Angular service) |

### AuthorCoding

`Backend-repo/src/main/java/com/startupstack/app/modules/authors/controller/AuthorCodingController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/authors/coding` | [المؤلفين ودور النشر] عرض ملف ترميز مسؤولي البيانات | مؤكد في الواجهة |
| POST | `/api/authors/coding` | [المؤلفين ودور النشر] إضافة مسؤول بيانات | مؤكد في الواجهة |
| PUT | `/api/authors/coding/:number` | [المؤلفين ودور النشر] تعديل اسم مسؤول بيانات | مؤكد في الواجهة |
| DELETE | `/api/authors/coding/:number` | [المؤلفين ودور النشر] حذف مسؤول بيانات | مؤكد في الواجهة |

### Book

`Backend-repo/src/main/java/com/startupstack/app/modules/books/controller/BookController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/books` | [الكتب] عرض قائمة الكتب | مؤكد في الواجهة |
| GET | `/api/books/:appNo` | [الكتب] عرض بيانات كتاب | مؤكد في الواجهة |
| POST | `/api/books` | [الكتب] إضافة كتاب | غير مؤكد: service بدون component |
| PUT | `/api/books/:appNo` | [الكتب] تعديل كتاب | مؤكد في الواجهة |
| DELETE | `/api/books/:appNo` | [الكتب] حذف كتاب | مؤكد في الواجهة |
| GET | `/api/books/:appNo/series` | [الكتب] عرض سلسلة الكتاب | مؤكد في الواجهة |
| POST | `/api/books/:appNo/series` | [الكتب] إضافة سلسلة للكتاب | API فقط (لا توجد Angular service) |
| PUT | `/api/books/:appNo/series` | [الكتب] تعديل سلسلة الكتاب | API فقط (لا توجد Angular service) |
| DELETE | `/api/books/:appNo/series` | [الكتب] حذف سلسلة الكتاب | API فقط (لا توجد Angular service) |

### Borrowing

`Backend-repo/src/main/java/com/startupstack/app/modules/borrowing/controller/BorrowingController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/borrowing` | [الإعارة] عرض قائمة الإعارات | مؤكد في الواجهة |
| GET | `/api/borrowing/lookup` | [الإعارة] عرض بيانات إعارة | مؤكد في الواجهة |
| POST | `/api/borrowing` | [الإعارة] إضافة إعارة | مؤكد في الواجهة |
| PUT | `/api/borrowing` | [الإعارة] تعديل إعارة | API فقط (لا توجد Angular service) |
| PATCH | `/api/borrowing/return` | [الإعارة] إرجاع إعارة | مؤكد في الواجهة |
| DELETE | `/api/borrowing` | [الإعارة] حذف إعارة | API فقط (لا توجد Angular service) |
| GET | `/api/borrowing/:iarNo/books` | [الإعارة] عرض كتب الإعارة | مؤكد في الواجهة |
| POST | `/api/borrowing/:iarNo/books` | [الإعارة] إضافة كتاب للإعارة | مؤكد في الواجهة |
| DELETE | `/api/borrowing/:iarNo/books/:iabSer` | [الإعارة] حذف كتاب من الإعارة | مؤكد في الواجهة |
| GET | `/api/borrowing/:iarNo/others` | [الإعارة] عرض المواد الأخرى للإعارة | مؤكد في الواجهة |
| POST | `/api/borrowing/:iarNo/others` | [الإعارة] إضافة مادة أخرى للإعارة | مؤكد في الواجهة |
| DELETE | `/api/borrowing/:iarNo/others/:iaoSer` | [الإعارة] حذف مادة أخرى من الإعارة | مؤكد في الواجهة |

### Catalogue

`Backend-repo/src/main/java/com/startupstack/app/modules/catalogue/controller/CatalogueController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/catalogue` | [الفهرس] عرض فهرس الوثائق | مؤكد في الواجهة |
| GET | `/api/catalogue/:appNo` | [الفهرس] عرض بيانات وثيقة | مؤكد في الواجهة |
| POST | `/api/catalogue/search` | [الفهرس] البحث المتقدم في الفهرس | مؤكد في الواجهة |
| POST | `/api/catalogue` | [الفهرس] إضافة وثيقة للفهرس | مؤكد في الواجهة |
| PUT | `/api/catalogue/:appNo` | [الفهرس] تعديل وثيقة في الفهرس | مؤكد في الواجهة |
| GET | `/api/catalogue/:appNo/corrections` | [الفهرس] سجل التصحيحات | مؤكد في الواجهة |
| DELETE | `/api/catalogue/:appNo` | [الفهرس] حذف وثيقة من الفهرس | مؤكد في الواجهة |
| GET | `/api/catalogue/locked` | [اقفال الوثائق المفتوحة] عرض الوثائق المقفلة | مؤكد في الواجهة |
| GET | `/api/catalogue/:appNo/date-subjects` | [التحليل] عرض موضوعات التاريخ | مؤكد في الواجهة |
| POST | `/api/catalogue/:appNo/date-subjects` | [التحليل] إضافة موضوع تاريخ | مؤكد في الواجهة |
| DELETE | `/api/catalogue/:appNo/date-subjects/:serNo/:relNo` | [التحليل] حذف موضوع تاريخ | مؤكد في الواجهة |
| GET | `/api/catalogue/:appNo/time-descriptors` | [التحليل] عرض الواصفات الزمنية | مؤكد في الواجهة |
| POST | `/api/catalogue/:appNo/time-descriptors` | [التحليل] إضافة واصفة زمنية | مؤكد في الواجهة |
| DELETE | `/api/catalogue/:appNo/time-descriptors/:serNo/:rltvNo` | [التحليل] حذف واصفة زمنية | مؤكد في الواجهة |
| GET | `/api/catalogue/:appNo/abbreviations` | [التحليل] عرض الاختصارات | API فقط (لا توجد Angular service) |
| POST | `/api/catalogue/:appNo/abbreviations` | [التحليل] إضافة اختصار | API فقط (لا توجد Angular service) |
| DELETE | `/api/catalogue/:appNo/abbreviations/:serNo/:rltvN` | [التحليل] حذف اختصار | API فقط (لا توجد Angular service) |
| GET | `/api/catalogue/:appNo/text1` | [التحليل] عرض نص الوثيقة (Text1) | مؤكد في الواجهة |
| POST | `/api/catalogue/:appNo/text1` | [التحليل] إضافة نص للوثيقة (Text1) | غير مؤكد: service بدون component |
| PUT | `/api/catalogue/:appNo/text1/:serNo` | [التحليل] تعديل نص الوثيقة (Text1) | غير مؤكد: service بدون component |
| DELETE | `/api/catalogue/:appNo/text1/:serNo` | [التحليل] حذف نص من الوثيقة (Text1) | غير مؤكد: service بدون component |

### ConfigUsers

`Backend-repo/src/main/java/com/startupstack/app/modules/configusers/controller/ConfigUsersController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| POST | `/api/config-users/access` | [معالجة المستخدمين] التحقق من مفتاح فتح الشاشة | مؤكد في الواجهة |
| DELETE | `/api/config-users/access` | [معالجة المستخدمين] إلغاء صلاحية فتح الشاشة | مؤكد في الواجهة |
| GET | `/api/config-users/form-types` | [معالجة المستخدمين] قائمة أنواع الاستمارات | مؤكد في الواجهة |
| GET | `/api/config-users/users` | [معالجة المستخدمين] عرض جدول المستخدمين | مؤكد في الواجهة |
| PUT | `/api/config-users/users` | [معالجة المستخدمين] تعديل خلية مستخدم | مؤكد في الواجهة |
| POST | `/api/config-users/users` | [معالجة المستخدمين] إضافة مستخدم | مؤكد في الواجهة |
| POST | `/api/config-users/users/delete` | [معالجة المستخدمين] حذف مستخدم | مؤكد في الواجهة |
| GET | `/api/config-users/fields` | [معالجة المستخدمين] عرض حقول العرض | مؤكد في الواجهة |
| POST | `/api/config-users/fields/create` | [معالجة المستخدمين] إنشاء حقول العرض للمستخدم | مؤكد في الواجهة |
| POST | `/api/config-users/fields/delete` | [معالجة المستخدمين] حذف حقول العرض للمستخدم | مؤكد في الواجهة |
| PUT | `/api/config-users/fields` | [معالجة المستخدمين] تعديل خلية حقل عرض | مؤكد في الواجهة |
| GET | `/api/config-users/ranges` | [معالجة المستخدمين] عرض نطاقات الأرقام | مؤكد في الواجهة |
| PUT | `/api/config-users/ranges` | [معالجة المستخدمين] تعديل خلية نطاق | مؤكد في الواجهة |
| POST | `/api/config-users/ranges` | [معالجة المستخدمين] إضافة نطاق | مؤكد في الواجهة |
| DELETE | `/api/config-users/ranges/:rjpNo` | [معالجة المستخدمين] حذف نطاق | مؤكد في الواجهة |

### DemandQueue

`Backend-repo/src/main/java/com/startupstack/app/modules/digitization/controller/DemandQueueController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/digitization/demand-queue/context` | [طلبيات الفيديو] بيانات سياق قائمة الطلبيات | مؤكد في الواجهة |
| GET | `/api/digitization/demand-queue` | [طلبيات الفيديو] البحث في قائمة الطلبيات | مؤكد في الواجهة |
| GET | `/api/digitization/demand-queue/users` | [طلبيات الفيديو] قائمة المستخدمين | مؤكد في الواجهة |
| GET | `/api/digitization/demand-queue/path-options` | [طلبيات الفيديو] خيارات المسار | مؤكد في الواجهة |
| PATCH | `/api/digitization/demand-queue/checked` | [طلبيات الفيديو] تعليم/إلغاء اختيار طلبية | مؤكد في الواجهة |
| PATCH | `/api/digitization/demand-queue/path` | [طلبيات الفيديو] تعيين المسار | مؤكد في الواجهة |
| POST | `/api/digitization/demand-queue/process` | [طلبيات الفيديو] تنفيذ معالجة الطلبيات | مؤكد في الواجهة |

### Descriptor

`Backend-repo/src/main/java/com/startupstack/app/modules/descriptors/controller/DescriptorController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/catalogue/:appNo/subjects` | [التحليل] عرض الواصفات الموضوعية للوثيقة | مؤكد في الواجهة |
| POST | `/api/catalogue/:appNo/subjects` | [التحليل] إضافة واصفة موضوعية | مؤكد في الواجهة |
| PUT | `/api/catalogue/:appNo/subjects/:id` | [التحليل] استبدال الواصفة | مؤكد في الواجهة |
| DELETE | `/api/catalogue/:appNo/subjects/:id` | [التحليل] حذف واصفة موضوعية | مؤكد في الواجهة |
| GET | `/api/catalogue/:appNo/geo` | [التحليل] عرض الواصفات الجغرافية | مؤكد في الواجهة |
| POST | `/api/catalogue/:appNo/geo` | [التحليل] إضافة واصفة جغرافية | مؤكد في الواجهة |
| DELETE | `/api/catalogue/:appNo/geo/:id` | [التحليل] حذف واصفة جغرافية | مؤكد في الواجهة |
| GET | `/api/catalogue/:appNo/files` | [التحليل] عرض الملفات المرتبطة | مؤكد في الواجهة |
| POST | `/api/catalogue/:appNo/files` | [التحليل] ربط ملف بالوثيقة | مؤكد في الواجهة |
| DELETE | `/api/catalogue/:appNo/files/:id` | [التحليل] حذف ملف مرتبط | مؤكد في الواجهة |
| GET | `/api/catalogue/:appNo/text` | [التحليل] عرض النصوص | API فقط (لا توجد Angular service) |
| POST | `/api/catalogue/:appNo/text` | [التحليل] إضافة نص | API فقط (لا توجد Angular service) |
| GET | `/api/catalogue/:appNo/narrower` | [التحليل] عرض المصطلحات الأضيق | مؤكد في الواجهة |
| POST | `/api/catalogue/:appNo/narrower` | [التحليل] إضافة مصطلح أضيق | مؤكد في الواجهة |
| DELETE | `/api/catalogue/:appNo/narrower/:id` | [التحليل] حذف مصطلح أضيق | مؤكد في الواجهة |
| GET | `/api/catalogue/:appNo/related` | [التحليل] عرض المصطلحات المرتبطة | مؤكد في الواجهة |
| POST | `/api/catalogue/:appNo/related` | [التحليل] إضافة مصطلح مرتبط | مؤكد في الواجهة |
| DELETE | `/api/catalogue/:appNo/related/:id` | [التحليل] حذف مصطلح مرتبط | مؤكد في الواجهة |
| GET | `/api/catalogue/:appNo/authors` | [الفهرس] عرض المؤلفين المرتبطين بالوثيقة | مؤكد في الواجهة |
| POST | `/api/catalogue/:appNo/authors` | [استمارة التوثيق] ربط مؤلف بالوثيقة | مؤكد في الواجهة |
| PUT | `/api/catalogue/:appNo/authors/:id` | [استمارة التوثيق] تعديل ربط مؤلف | مؤكد في الواجهة |
| DELETE | `/api/catalogue/:appNo/authors/:id` | [استمارة التوثيق] إلغاء ربط مؤلف | مؤكد في الواجهة |

### Digitization

`Backend-repo/src/main/java/com/startupstack/app/modules/digitization/controller/DigitizationController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/digitization/records` | [الرقمنة] عرض سجلات الملفات الرقمية | مؤكد في الواجهة |
| GET | `/api/digitization/records/lookup` | [الرقمنة] عرض سجل ملف رقمي | غير مؤكد: service بدون component |
| POST | `/api/digitization/records` | [الرقمنة] إضافة سجل ملف رقمي | مؤكد في الواجهة |
| POST | `/api/digitization/records/upload` | [الرقمنة] رفع ملف رقمي | مؤكد في الواجهة |
| PUT | `/api/digitization/records` | [الرقمنة] تعديل سجل ملف رقمي | مؤكد في الواجهة |
| DELETE | `/api/digitization/records` | [الرقمنة] حذف سجل ملف رقمي | مؤكد في الواجهة |
| GET | `/api/digitization/demands` | [الرقمنة] عرض طلبات المشاهد | مؤكد في الواجهة |
| GET | `/api/digitization/demands/stats` | [الرقمنة] إحصائيات الطلبات | غير مؤكد: service بدون component |
| GET | `/api/digitization/demands/:id` | [الرقمنة] عرض طلب مشهد | غير مؤكد: service بدون component |
| POST | `/api/digitization/demands` | [الرقمنة] إضافة طلب | مؤكد في الواجهة |
| DELETE | `/api/digitization/demands/:id` | [الرقمنة] حذف طلب مشهد | مؤكد في الواجهة |
| POST | `/api/digitization/demands/scenes` | [شاشة البحث فيديو + صوتي] إضافة مشهد للطلب | مؤكد في الواجهة |
| POST | `/api/digitization/demands/queue-scenes` | [طلبيات الفيديو] إضافة مشهد للطلبيات | مؤكد في الواجهة |
| PATCH | `/api/digitization/demands/:id/path` | [الرقمنة] إعادة تعيين مسار طلب | غير مؤكد: service بدون component |
| PATCH | `/api/digitization/demands/bulk-status` | [شاشة البحث فيديو + صوتي] تعليم الطلبات كمنفذة/مختارة | مؤكد في الواجهة |
| POST | `/api/digitization/demands/:id/fulfil` | [الرقمنة] تنفيذ طلب | غير مؤكد: service بدون component |
| POST | `/api/digitization/demands/bulk-fulfil` | [الرقمنة] تنفيذ عدة طلبات | غير مؤكد: service بدون component |
| POST | `/api/digitization/demands/test` | [طلبيات الفيديو] اختبار الطلبيات | مؤكد في الواجهة |
| POST | `/api/digitization/demands/send-to-edlc` | [شاشة البحث فيديو + صوتي] ارسل الى EDLC | مؤكد في الواجهة |
| POST | `/api/digitization/demands/extract-clips` | [شاشة البحث فيديو + صوتي] استخراج المقاطع | مؤكد في الواجهة |
| POST | `/api/digitization/demands/render-dv` | [شاشة البحث فيديو + صوتي] إخراج المشاهد بصيغة DV | مؤكد في الواجهة |
| GET | `/api/digitization/demands/jobs/:jobId` | [الرقمنة] متابعة مهمة التسليم | مؤكد في الواجهة |
| GET | `/api/digitization/results` | [شاشة الطلبات] عرض طلبات الاستفادة | مؤكد في الواجهة |
| GET | `/api/digitization/results/:id` | [شاشة الطلبات] عرض طلب استفادة | مؤكد في الواجهة |
| POST | `/api/digitization/results` | [الرقمنة] إضافة نتيجة | مؤكد في الواجهة |
| PUT | `/api/digitization/results/:id` | [شاشة الطلبات] تعديل طلب استفادة | مؤكد في الواجهة |
| POST | `/api/digitization/results/log-usage` | [شاشة البحث] تسجيل طلب الاستفادة | مؤكد في الواجهة |
| DELETE | `/api/digitization/results/:id` | [الرقمنة] حذف نتيجة | مؤكد في الواجهة |
| PUT | `/api/digitization/results/by-number/:resultNo` | [شاشة الطلبات] تعديل طلبات معينة | مؤكد في الواجهة |
| DELETE | `/api/digitization/results/by-number/:resultNo` | [شاشة الطلبات] الغاء الطلب | مؤكد في الواجهة |

### DocumentLock

`Backend-repo/src/main/java/com/startupstack/app/modules/catalogue/controller/DocumentLockController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| POST | `/api/catalogue/lock-all` | [اقفال الوثائق المفتوحة] اقفال الوثائق المفتوحة | مؤكد في الواجهة |
| PATCH | `/api/catalogue/:appNo/unlock` | [اقفال الوثائق المفتوحة] فتح قفل وثيقة | مؤكد في الواجهة |

### Form

`Backend-repo/src/main/java/com/startupstack/app/modules/sites/controller/FormController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/forms/secondary` | [المواقع] قائمة الاستمارات الثانوية | API فقط (لا توجد Angular service) |
| GET | `/api/forms/institutions` | [المواقع] عرض المؤسسات | مؤكد في الواجهة |
| GET | `/api/forms` | [المواقع] البحث في الاستمارات | مؤكد في الواجهة |
| GET | `/api/forms/by-code/:code` | [المواقع] عرض استمارة حسب الرمز | مؤكد في الواجهة |
| GET | `/api/forms/:formNo` | [المواقع] عرض بيانات استمارة | مؤكد في الواجهة |
| POST | `/api/forms` | [المواقع] إضافة استمارة | مؤكد في الواجهة |
| PUT | `/api/forms/:formNo` | [المواقع] تعديل استمارة | مؤكد في الواجهة |
| DELETE | `/api/forms/:formNo` | [المواقع] حذف استمارة | مؤكد في الواجهة |
| GET | `/api/forms/:formNo/subjects` | [المواقع] عرض موضوعات الاستمارة | مؤكد في الواجهة |
| POST | `/api/forms/:formNo/subjects` | [المواقع] إضافة موضوع للاستمارة | مؤكد في الواجهة |
| PUT | `/api/forms/:formNo/subjects/:mcnzCode` | [المواقع] تعديل موضوع الاستمارة | مؤكد في الواجهة |
| DELETE | `/api/forms/:formNo/subjects/:mcnzCode` | [المواقع] حذف موضوع من الاستمارة | مؤكد في الواجهة |
| GET | `/api/forms/:formNo/related-forms` | [المواقع] عرض الاستمارات المرتبطة | مؤكد في الواجهة |
| POST | `/api/forms/:formNo/related-forms` | [المواقع] إضافة استمارة مرتبطة | مؤكد في الواجهة |
| PUT | `/api/forms/:formNo/related-forms/:form2No` | [المواقع] تعديل استمارة مرتبطة | مؤكد في الواجهة |
| DELETE | `/api/forms/:formNo/related-forms/:form2No` | [المواقع] حذف استمارة مرتبطة | مؤكد في الواجهة |

### FormThesaurus

`Backend-repo/src/main/java/com/startupstack/app/modules/formthesaurus/controller/FormThesaurusController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| POST | `/api/form-thesaurus/access` | [المكنز الشكلي] التحقق من مفتاح فتح الشاشة | مؤكد في الواجهة |
| DELETE | `/api/form-thesaurus/access` | [المكنز الشكلي] إلغاء صلاحية فتح الشاشة | مؤكد في الواجهة |
| GET | `/api/form-thesaurus/context` | [المكنز الشكلي] بيانات سياق الشاشة | مؤكد في الواجهة |
| GET | `/api/form-thesaurus/coding` | [المكنز الشكلي] عرض الترميز | مؤكد في الواجهة |
| GET | `/api/form-thesaurus/coding/find` | [المكنز الشكلي] البحث عن رمز | مؤكد في الواجهة |
| POST | `/api/form-thesaurus/coding` | [المكنز الشكلي] إضافة رمز | مؤكد في الواجهة |
| PUT | `/api/form-thesaurus/coding` | [المكنز الشكلي] تعديل رمز | مؤكد في الواجهة |
| DELETE | `/api/form-thesaurus/coding` | [المكنز الشكلي] حذف رمز | مؤكد في الواجهة |
| GET | `/api/form-thesaurus/forms` | [المكنز الشكلي] عرض الاستمارات | مؤكد في الواجهة |
| GET | `/api/form-thesaurus/forms/find` | [المكنز الشكلي] البحث عن استمارة | مؤكد في الواجهة |
| POST | `/api/form-thesaurus/forms` | [المكنز الشكلي] إضافة استمارة | مؤكد في الواجهة |
| PUT | `/api/form-thesaurus/forms` | [المكنز الشكلي] تعديل استمارة | مؤكد في الواجهة |
| DELETE | `/api/form-thesaurus/forms` | [المكنز الشكلي] حذف استمارة | مؤكد في الواجهة |
| POST | `/api/form-thesaurus/forms/next-number` | [المكنز الشكلي] الرقم التالي للاستمارة | مؤكد في الواجهة |
| PUT | `/api/form-thesaurus/words` | [المكنز الشكلي] استبدال الكلمات المفتاحية | مؤكد في الواجهة |
| POST | `/api/form-thesaurus/words` | [المكنز الشكلي] إضافة كلمات مفتاحية | مؤكد في الواجهة |
| GET | `/api/form-thesaurus/positions` | [المكنز الشكلي] عرض المناصب | مؤكد في الواجهة |
| POST | `/api/form-thesaurus/positions` | [المكنز الشكلي] إضافة منصب | مؤكد في الواجهة |
| PUT | `/api/form-thesaurus/positions` | [المكنز الشكلي] تعديل منصب | مؤكد في الواجهة |
| DELETE | `/api/form-thesaurus/positions` | [المكنز الشكلي] حذف منصب | مؤكد في الواجهة |
| GET | `/api/form-thesaurus/relations/forms` | [المكنز الشكلي] عرض علاقات الاستمارات | مؤكد في الواجهة |
| POST | `/api/form-thesaurus/relations/forms` | [المكنز الشكلي] إضافة علاقة استمارة | مؤكد في الواجهة |
| PUT | `/api/form-thesaurus/relations/forms/dates` | [المكنز الشكلي] تعديل تواريخ علاقة استمارة | مؤكد في الواجهة |
| DELETE | `/api/form-thesaurus/relations/forms` | [المكنز الشكلي] حذف علاقة استمارة | مؤكد في الواجهة |
| GET | `/api/form-thesaurus/relations/subjects` | [المكنز الشكلي] عرض علاقات الموضوعات | مؤكد في الواجهة |
| POST | `/api/form-thesaurus/relations/subjects` | [المكنز الشكلي] إضافة علاقة موضوع | مؤكد في الواجهة |
| PUT | `/api/form-thesaurus/relations/subjects/dates` | [المكنز الشكلي] تعديل تواريخ علاقة موضوع | مؤكد في الواجهة |
| DELETE | `/api/form-thesaurus/relations/subjects` | [المكنز الشكلي] حذف علاقة موضوع | مؤكد في الواجهة |
| GET | `/api/form-thesaurus/macnz` | [المكنز الشكلي] قائمة المكنز للاختيار | مؤكد في الواجهة |
| POST | `/api/form-thesaurus/additional-files/search` | [المكنز الشكلي] البحث في الملفات الاضافية (نسخة محمية) | API فقط (لا توجد Angular service) |
| POST | `/api/form-thesaurus/additional-files/op-tmp` | [المكنز الشكلي] إضافة الوثيقة للملفات الاضافية (نسخة محمية) | API فقط (لا توجد Angular service) |
| PUT | `/api/form-thesaurus/additional-files` | [المكنز الشكلي] تعديل ملف اضافي (نسخة محمية) | API فقط (لا توجد Angular service) |
| POST | `/api/form-thesaurus/additional-files` | [المكنز الشكلي] إضافة ملف اضافي (نسخة محمية) | API فقط (لا توجد Angular service) |
| POST | `/api/form-thesaurus/additional-files/delete` | [المكنز الشكلي] حذف ملف اضافي (نسخة محمية) | API فقط (لا توجد Angular service) |

### Lookups

`Backend-repo/src/main/java/com/startupstack/app/modules/lookups/controller/LookupsController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/lookups/arrays` | [الجداول المرجعية] جدول ARRAYS | API فقط (لا توجد Angular service) |
| GET | `/api/lookups/arrays1` | [الجداول المرجعية] جدول ARRAYS1 | API فقط (لا توجد Angular service) |
| GET | `/api/lookups/relations` | [الجداول المرجعية] جدول العلاقات | API فقط (لا توجد Angular service) |
| GET | `/api/lookups/dict` | [الجداول المرجعية] جدول القاموس (DICT) | API فقط (لا توجد Angular service) |
| GET | `/api/lookups/mem` | [الجداول المرجعية] جدول MEM | API فقط (لا توجد Angular service) |
| GET | `/api/lookups/cote-pub` | [الجداول المرجعية] عرض رموز الناشرين (COTE_PUB) | API فقط (لا توجد Angular service) |
| POST | `/api/lookups/cote-pub` | [الجداول المرجعية] إضافة رمز ناشر | API فقط (لا توجد Angular service) |
| PUT | `/api/lookups/cote-pub/:id` | [الجداول المرجعية] تعديل رمز ناشر | API فقط (لا توجد Angular service) |
| DELETE | `/api/lookups/cote-pub/:id` | [الجداول المرجعية] حذف رمز ناشر | API فقط (لا توجد Angular service) |
| GET | `/api/lookups/operations` | [الجداول المرجعية] جدول العمليات | API فقط (لا توجد Angular service) |
| GET | `/api/lookups/subjects` | [الجداول المرجعية] عرض موضوعات المكنز | مؤكد في الواجهة |
| POST | `/api/lookups/subjects` | [الجداول المرجعية] إضافة موضوع للمكنز | مؤكد في الواجهة |
| PUT | `/api/lookups/subjects/:code` | [الجداول المرجعية] تعديل موضوع في المكنز | مؤكد في الواجهة |
| DELETE | `/api/lookups/subjects/:code` | [الجداول المرجعية] حذف موضوع من المكنز | مؤكد في الواجهة |
| GET | `/api/lookups/coding` | [الجداول المرجعية] عرض جدول الترميز (CODING) | مؤكد في الواجهة |
| POST | `/api/lookups/coding` | [الجداول المرجعية] إضافة رمز | مؤكد في الواجهة |
| PUT | `/api/lookups/coding/:level/:code` | [الجداول المرجعية] تعديل رمز | مؤكد في الواجهة |
| DELETE | `/api/lookups/coding/:level/:code` | [الجداول المرجعية] حذف رمز | مؤكد في الواجهة |

### Main2

`Backend-repo/src/main/java/com/startupstack/app/modules/catalogue/controller/Main2Controller.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/catalogue/extended` | [الفهرس] عرض كل المعلومات الاضافية | API فقط (لا توجد Angular service) |
| GET | `/api/catalogue/:appNo/extended` | [الفهرس] عرض المعلومات الاضافية للوثيقة | مؤكد في الواجهة |
| POST | `/api/catalogue/:appNo/extended` | [الفهرس] إضافة معلومات اضافية | مؤكد في الواجهة |
| PUT | `/api/catalogue/:appNo/extended` | [الفهرس] تعديل المعلومات الاضافية | مؤكد في الواجهة |

### Maintenance

`Backend-repo/src/main/java/com/startupstack/app/modules/maintenance/controller/MaintenanceController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| POST | `/api/maintenance/renumber` | [الصيانة] إعادة الترقيم | مؤكد في الواجهة |
| POST | `/api/maintenance/copy-to-archive` | [الصيانة] نسخ إلى الأرشيف | مؤكد في الواجهة |
| POST | `/api/maintenance/file-links` | [الصيانة] إضافة رابط ملف | مؤكد في الواجهة |
| GET | `/api/maintenance/file-links/:appNo` | [الصيانة] تحميل روابط الملفات | مؤكد في الواجهة |
| DELETE | `/api/maintenance/file-links/:id` | [الصيانة] حذف رابط ملف | مؤكد في الواجهة |

### Media

`Backend-repo/src/main/java/com/startupstack/app/modules/media/controller/MediaController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/media/resolve/:stockNo` | [الوسائط] تحديد مكان ملف الوسائط | مؤكد في الواجهة |
| GET | `/api/media/file/:stockNo` | [الوسائط] تحميل/تشغيل ملف الفيديو | مؤكد في الواجهة |
| GET | `/api/media/asset/:digitNo` | [الوسائط] عرض ملف غير فيديو | مؤكد في الواجهة |

### News

`Backend-repo/src/main/java/com/startupstack/app/modules/news/controller/NewsController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/news` | [الأخبار] عرض قائمة الأخبار | مؤكد في الواجهة |
| GET | `/api/news/:newsNo` | [الأخبار] عرض خبر | مؤكد في الواجهة |
| POST | `/api/news/search` | [الأخبار] البحث المتقدم في الأخبار | مؤكد في الواجهة |
| POST | `/api/news` | [الأخبار] إضافة خبر | مؤكد في الواجهة |
| PUT | `/api/news/:newsNo` | [الأخبار] تعديل خبر | مؤكد في الواجهة |
| DELETE | `/api/news/:newsNo` | [الأخبار] حذف خبر | مؤكد في الواجهة |
| GET | `/api/news/:newsNo/keywords` | [الأخبار] عرض الكلمات المفتاحية للخبر | غير مؤكد: service بدون component |
| POST | `/api/news/:newsNo/keywords` | [الأخبار] إضافة كلمة مفتاحية | مؤكد في الواجهة |
| DELETE | `/api/news/:newsNo/keywords/:word` | [الأخبار] حذف كلمة مفتاحية | مؤكد في الواجهة |

### PaysForm

`Backend-repo/src/main/java/com/startupstack/app/modules/paysform/controller/PaysFormController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/pays-form` | [الجداول المرجعية] البحث في الدول/النماذج | مؤكد في الواجهة |
| GET | `/api/pays-form/:formNo` | [الجداول المرجعية] عرض دولة/نموذج | مؤكد في الواجهة |

### Periodical

`Backend-repo/src/main/java/com/startupstack/app/modules/periodicals/controller/PeriodicalController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/periodicals/all` | [الصحف والمجلات] قائمة كل الدوريات | مؤكد في الواجهة |
| GET | `/api/periodicals/search` | [الصحف والمجلات] البحث في الدوريات | مؤكد في الواجهة |
| GET | `/api/periodicals` | [الصحف والمجلات] عرض قائمة الدوريات | غير مؤكد: service بدون component |
| GET | `/api/periodicals/next-no` | [الصحف والمجلات] الرقم التالي للدورية | مؤكد في الواجهة |
| GET | `/api/periodicals/:perNo` | [الصحف والمجلات] عرض دورية | مؤكد في الواجهة |
| GET | `/api/periodicals/:perNo/next` | [الصحف والمجلات] الدورية التالية | مؤكد في الواجهة |
| GET | `/api/periodicals/:perNo/previous` | [الصحف والمجلات] الدورية السابقة | مؤكد في الواجهة |
| POST | `/api/periodicals` | [الصحف والمجلات] إضافة دورية | مؤكد في الواجهة |
| PUT | `/api/periodicals/:perNo` | [الصحف والمجلات] تعديل دورية | مؤكد في الواجهة |
| DELETE | `/api/periodicals/:perNo` | [الصحف والمجلات] حذف دورية | مؤكد في الواجهة |

### Person

`Backend-repo/src/main/java/com/startupstack/app/modules/persons/controller/PersonController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/persons` | [الأشخاص] عرض قائمة الأشخاص | مؤكد في الواجهة |
| GET | `/api/persons/:prsNo` | [الأشخاص] عرض بيانات شخص | مؤكد في الواجهة |
| POST | `/api/persons` | [الأشخاص] إضافة شخص | مؤكد في الواجهة |
| PUT | `/api/persons/:prsNo` | [الأشخاص] تعديل شخص | مؤكد في الواجهة |
| GET | `/api/persons/:prsNo/assignments` | [الأشخاص] عرض تكليفات الشخص | مؤكد في الواجهة |
| DELETE | `/api/persons/:prsNo` | [الأشخاص] حذف شخص | مؤكد في الواجهة |

### Picture

`Backend-repo/src/main/java/com/startupstack/app/modules/pictures/controller/PictureController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/pictures` | [الصور] عرض قائمة الصور | مؤكد في الواجهة |
| GET | `/api/pictures/:picNo` | [الصور] عرض صورة | مؤكد في الواجهة |
| POST | `/api/pictures` | [الصور] إضافة صورة | مؤكد في الواجهة |
| PUT | `/api/pictures/:picNo` | [الصور] تعديل صورة | مؤكد في الواجهة |
| DELETE | `/api/pictures/:picNo` | [الصور] حذف صورة | مؤكد في الواجهة |

### Position

`Backend-repo/src/main/java/com/startupstack/app/modules/sites/controller/PositionController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/positions` | [المواقع] عرض المناصب | مؤكد في الواجهة |
| GET | `/api/positions/by-form/:formCode` | [المواقع] المناصب حسب الاستمارة | مؤكد في الواجهة |
| GET | `/api/positions/:posNo` | [المواقع] عرض منصب | API فقط (لا توجد Angular service) |
| POST | `/api/positions` | [المواقع] إضافة منصب | مؤكد في الواجهة |
| PUT | `/api/positions/:posNo` | [المواقع] تعديل منصب | مؤكد في الواجهة |
| DELETE | `/api/positions/:posNo` | [المواقع] حذف منصب | مؤكد في الواجهة |

### Post

`Backend-repo/src/main/java/com/startupstack/app/modules/sites/controller/PostController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/posts` | [المواقع] عرض الوظائف | مؤكد في الواجهة |
| GET | `/api/posts/:serial` | [المواقع] عرض وظيفة | مؤكد في الواجهة |
| POST | `/api/posts` | [المواقع] إضافة وظيفة | مؤكد في الواجهة |
| PUT | `/api/posts/:serial` | [المواقع] تعديل وظيفة | مؤكد في الواجهة |
| DELETE | `/api/posts/:serial` | [المواقع] حذف وظيفة | مؤكد في الواجهة |

### PublicSearch

`Backend-repo/src/main/java/com/startupstack/app/modules/search/controller/PublicSearchController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/public/search` | [البحث دون تسجيل الدخول] البحث العام | مؤكد في الواجهة |

### Report

`Backend-repo/src/main/java/com/startupstack/app/modules/reports/controller/ReportController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/reports/generate/:reportType` | [التقارير] توليد تقرير | مؤكد في الواجهة |
| GET | `/api/reports/execute/:templateNum` | [التقارير] تنفيذ قالب تقرير | مؤكد في الواجهة |
| GET | `/api/reports/templates` | [التقارير] عرض قوالب التقارير | مؤكد في الواجهة |
| GET | `/api/reports/templates/:id` | [التقارير] عرض قالب تقرير | مؤكد في الواجهة |
| POST | `/api/reports/templates` | [التقارير] إضافة قالب تقرير | مؤكد في الواجهة |
| PUT | `/api/reports/templates/:id` | [التقارير] تعديل قالب تقرير | مؤكد في الواجهة |
| DELETE | `/api/reports/templates/:id` | [التقارير] حذف قالب تقرير | مؤكد في الواجهة |
| GET | `/api/reports/user-outputs` | [التقارير] عرض مخرجات المستخدمين | مؤكد في الواجهة |
| POST | `/api/reports/user-outputs` | [التقارير] تعيين مخرج لمستخدم | مؤكد في الواجهة |
| DELETE | `/api/reports/user-outputs` | [التقارير] حذف مخرج مستخدم | مؤكد في الواجهة |
| GET | `/api/reports/pout1` | [التقارير] عرض حقول المخرجات (POUT1) | API فقط (لا توجد Angular service) |
| GET | `/api/reports/pout1/:outIst/:outNum` | [التقارير] عرض حقل مخرج (POUT1) | API فقط (لا توجد Angular service) |
| POST | `/api/reports/pout1/:outIst` | [التقارير] إضافة حقل مخرج (POUT1) | API فقط (لا توجد Angular service) |
| PUT | `/api/reports/pout1/:outIst/:outNum` | [التقارير] تعديل حقل مخرج (POUT1) | API فقط (لا توجد Angular service) |
| DELETE | `/api/reports/pout1/:outIst/:outNum` | [التقارير] حذف حقل مخرج (POUT1) | API فقط (لا توجد Angular service) |
| GET | `/api/reports/categories` | [التقارير] عرض فئات التقارير | API فقط (لا توجد Angular service) |
| POST | `/api/reports/categories` | [التقارير] إضافة فئة تقرير | API فقط (لا توجد Angular service) |
| DELETE | `/api/reports/categories/:auto` | [التقارير] حذف فئة تقرير | API فقط (لا توجد Angular service) |

### Retrieval

`Backend-repo/src/main/java/com/startupstack/app/modules/retrieval/controller/RetrievalController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/retrieval/fields` | [الاسترجاع البياني لبنك المعلومات] عرض حقول الاسترجاع | مؤكد في الواجهة |
| GET | `/api/retrieval/lookup-values` | [الاسترجاع البياني لبنك المعلومات] قيم البحث للحقل | مؤكد في الواجهة |
| GET | `/api/retrieval/lookup-codes` | [الاسترجاع البياني لبنك المعلومات] رموز الشرط المرمّز | مؤكد في الواجهة |
| POST | `/api/retrieval/search` | [الاسترجاع البياني لبنك المعلومات] تنفيذ الاسترجاع | مؤكد في الواجهة |
| GET | `/api/retrieval/my-field-state` | [الاسترجاع البياني لبنك المعلومات] حالة حقول العرض للمستخدم | مؤكد في الواجهة |
| POST | `/api/retrieval/my-field-state/:fieldKey/toggle-display` | [الاسترجاع البياني لبنك المعلومات] تبديل حقل العرض | مؤكد في الواجهة |
| POST | `/api/retrieval/my-field-state/:fieldKey/toggle-order` | [الاسترجاع البياني لبنك المعلومات] تبديل علامة الترتيب | مؤكد في الواجهة |
| POST | `/api/retrieval/my-field-state/mark-category` | [الاسترجاع البياني لبنك المعلومات] تعليم حقول العرض | مؤكد في الواجهة |
| POST | `/api/retrieval/fields/:fieldKey/toggle-hash-mark` | [الاسترجاع البياني لبنك المعلومات] تبديل علامة # | مؤكد في الواجهة |

### RetrievalBuild

`Backend-repo/src/main/java/com/startupstack/app/modules/retrievalbuild/controller/RetrievalBuildController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| POST | `/api/retrieval-build/access` | [ملف بناء الاسترجاعات] التحقق من مفتاح فتح الشاشة | مؤكد في الواجهة |
| DELETE | `/api/retrieval-build/access` | [ملف بناء الاسترجاعات] إلغاء صلاحية فتح الشاشة | مؤكد في الواجهة |
| GET | `/api/retrieval-build/form4/:table` | [ملف بناء الاسترجاعات] عرض جدول Form4 | مؤكد في الواجهة |
| PUT | `/api/retrieval-build/form4/cell` | [ملف بناء الاسترجاعات] تعديل خلية في Form4 | مؤكد في الواجهة |
| GET | `/api/retrieval-build/cat-out/fields` | [معالجة حقول الاسترجاع] عرض حقول الاسترجاع | مؤكد في الواجهة |
| PUT | `/api/retrieval-build/cat-out/fields/:outNum` | [معالجة حقول الاسترجاع] تعديل حقل استرجاع | مؤكد في الواجهة |
| POST | `/api/retrieval-build/cat-out/fields` | [معالجة حقول الاسترجاع] إضافة حقل استرجاع | مؤكد في الواجهة |
| DELETE | `/api/retrieval-build/cat-out/fields/:outNum` | [معالجة حقول الاسترجاع] حذف حقل استرجاع | مؤكد في الواجهة |
| PUT | `/api/retrieval-build/cat-out/fields/:outNum/category` | [معالجة حقول الاسترجاع] تعيين فئة الحقل | مؤكد في الواجهة |
| GET | `/api/retrieval-build/cat-out/categories` | [معالجة حقول الاسترجاع] عرض الفئات | مؤكد في الواجهة |
| GET | `/api/retrieval-build/cat-out/categories/:catNo/fields` | [معالجة حقول الاسترجاع] عرض حقول الفئة | مؤكد في الواجهة |
| POST | `/api/retrieval-build/cat-out/categories/:catNo/fields` | [معالجة حقول الاسترجاع] إضافة حقول للفئة | مؤكد في الواجهة |
| POST | `/api/retrieval-build/cat-out/categories/:catNo/rows` | [معالجة حقول الاسترجاع] إضافة صف للفئة | مؤكد في الواجهة |
| PUT | `/api/retrieval-build/cat-out/category-fields/:auto` | [معالجة حقول الاسترجاع] تعديل حقل في الفئة | مؤكد في الواجهة |
| DELETE | `/api/retrieval-build/cat-out/category-fields/:auto` | [معالجة حقول الاسترجاع] حذف حقل من الفئة | مؤكد في الواجهة |
| POST | `/api/retrieval-build/backup` | [نسخ قاعدة البيانات] نسخ قاعدة البيانات | مؤكد في الواجهة |

### RetrievalField

`Backend-repo/src/main/java/com/startupstack/app/modules/retrievalfields/controller/RetrievalFieldController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/retrieval-fields` | [الصيانة] عرض حقول الاسترجاع | مؤكد في الواجهة |
| POST | `/api/retrieval-fields` | [الصيانة] إضافة حقل استرجاع | مؤكد في الواجهة |
| PUT | `/api/retrieval-fields/:id` | [الصيانة] تعديل حقل استرجاع | مؤكد في الواجهة |
| DELETE | `/api/retrieval-fields/:id` | [الصيانة] حذف حقل استرجاع | مؤكد في الواجهة |

### Search

`Backend-repo/src/main/java/com/startupstack/app/modules/search/controller/SearchController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/search/fulltext` | [البحث] البحث في النص الكامل | مؤكد في الواجهة |

### SearchScreen

`Backend-repo/src/main/java/com/startupstack/app/modules/searchscreen/controller/SearchScreenController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| POST | `/api/search-screen/search` | [شاشة البحث] تنفيذ البحث | مؤكد في الواجهة |
| PUT | `/api/search-screen/results/:digitNo/choice` | [شاشة البحث] الاختيار | مؤكد في الواجهة |

### Site

`Backend-repo/src/main/java/com/startupstack/app/modules/sites/controller/SiteController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/sites` | [المواقع] عرض المواقع | مؤكد في الواجهة |
| GET | `/api/sites/:siteNo` | [المواقع] عرض موقع | مؤكد في الواجهة |
| POST | `/api/sites` | [المواقع] إضافة موقع | مؤكد في الواجهة |
| PUT | `/api/sites/:siteNo` | [المواقع] تعديل موقع | مؤكد في الواجهة |
| DELETE | `/api/sites/:siteNo` | [المواقع] حذف موقع | مؤكد في الواجهة |

### Staff

`Backend-repo/src/main/java/com/startupstack/app/modules/staff/controller/StaffController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/staff` | [الأشخاص] عرض قائمة الموظفين | مؤكد في الواجهة |
| GET | `/api/staff/:prsNo` | [الأشخاص] عرض بيانات موظف | مؤكد في الواجهة |
| POST | `/api/staff` | [الأشخاص] إضافة موظف | غير مؤكد: service بدون component |
| PUT | `/api/staff/:prsNo` | [الأشخاص] تعديل موظف | غير مؤكد: service بدون component |
| DELETE | `/api/staff/:prsNo` | [الأشخاص] حذف موظف | غير مؤكد: service بدون component |

### SubjectThesaurus

`Backend-repo/src/main/java/com/startupstack/app/modules/subjectthesaurus/controller/SubjectThesaurusController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| POST | `/api/subject-thesaurus/access` | [المكنز الموضوعي] التحقق من مفتاح فتح الشاشة | مؤكد في الواجهة |
| DELETE | `/api/subject-thesaurus/access` | [المكنز الموضوعي] إلغاء صلاحية فتح الشاشة | مؤكد في الواجهة |
| GET | `/api/subject-thesaurus/context` | [المكنز الموضوعي] بيانات سياق الشاشة | مؤكد في الواجهة |
| GET | `/api/subject-thesaurus/terms` | [المكنز الموضوعي] عرض مصطلحات المكنز | مؤكد في الواجهة |
| POST | `/api/subject-thesaurus/terms` | [المكنز الموضوعي] إضافة مصطلح | مؤكد في الواجهة |
| PUT | `/api/subject-thesaurus/terms` | [المكنز الموضوعي] تعديل مصطلح | مؤكد في الواجهة |
| DELETE | `/api/subject-thesaurus/terms` | [المكنز الموضوعي] حذف مصطلح | مؤكد في الواجهة |
| POST | `/api/subject-thesaurus/terms/level3-code` | [المكنز الموضوعي] رمز المستوى الثالث | مؤكد في الواجهة |

### TmpFileAdd

`Backend-repo/src/main/java/com/startupstack/app/modules/catalogue/controller/TmpFileAddController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/temp-files` | [طلبات سحب الملفات الاضافية] عرض طلبات سحب الملفات | مؤكد في الواجهة |
| POST | `/api/temp-files` | [طلبات سحب الملفات الاضافية] إضافة ملف معلق | غير مؤكد: component غير مضمَّن |
| PATCH | `/api/temp-files/:no/:ser/finalize` | [طلبات سحب الملفات الاضافية] إنهاء طلب سحب | مؤكد في الواجهة |
| DELETE | `/api/temp-files/:no/:ser` | [طلبات سحب الملفات الاضافية] حذف طلب سحب | مؤكد في الواجهة |

### Trans

`Backend-repo/src/main/java/com/startupstack/app/modules/transactions/controller/TransController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/transactions` | [المعاملات] عرض المعاملات | API فقط (لا توجد Angular service) |
| GET | `/api/transactions/:opno/:no` | [المعاملات] عرض معاملة | API فقط (لا توجد Angular service) |
| POST | `/api/transactions` | [المعاملات] إضافة معاملة | API فقط (لا توجد Angular service) |
| PUT | `/api/transactions/:opno/:no` | [المعاملات] تعديل معاملة | API فقط (لا توجد Angular service) |
| DELETE | `/api/transactions/:opno/:no` | [المعاملات] حذف معاملة | API فقط (لا توجد Angular service) |
| GET | `/api/periodicals/:periodicalId/transactions` | [المعاملات] معاملات الدورية | API فقط (لا توجد Angular service) |

### UsageRequest

`Backend-repo/src/main/java/com/startupstack/app/modules/requests/controller/UsageRequestController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/usage-requests` | [شاشة الطلبات] عرض طلبات الاستخدام | غير مؤكد: service بدون component |
| GET | `/api/usage-requests/:id` | [شاشة الطلبات] عرض طلب استخدام | غير مؤكد: service بدون component |
| POST | `/api/usage-requests` | [شاشة الطلبات] إضافة طلب استخدام | غير مؤكد: service بدون component |
| PUT | `/api/usage-requests/:id` | [شاشة الطلبات] تعديل طلب استخدام | غير مؤكد: service بدون component |
| DELETE | `/api/usage-requests/:id` | [شاشة الطلبات] حذف طلب استخدام | غير مؤكد: service بدون component |
| PATCH | `/api/usage-requests/:id/status` | [شاشة الطلبات] تغيير حالة طلب استخدام | غير مؤكد: service بدون component |

### VideoOrder

`Backend-repo/src/main/java/com/startupstack/app/modules/videoorders/controller/VideoOrderController.java`

| Method | Path | الاسم العربي | حالة الواجهة |
|---|---|---|---|
| GET | `/api/video-orders` | [طلبيات الفيديو] عرض موافقات الطلبيات | مؤكد في الواجهة |
| GET | `/api/video-orders/:id` | [طلبيات الفيديو] عرض طلبية | مؤكد في الواجهة |
| POST | `/api/video-orders` | [طلبيات الفيديو] إضافة طلبية | مؤكد في الواجهة |
| PUT | `/api/video-orders/:id` | [طلبيات الفيديو] تعديل طلبية | مؤكد في الواجهة |
| DELETE | `/api/video-orders/:id` | [طلبيات الفيديو] حذف طلبية | مؤكد في الواجهة |
| PATCH | `/api/video-orders/:id/status` | [طلبيات الفيديو] تغيير حالة طلبية | مؤكد في الواجهة |

## الـ endpoints غير المستخدمة أو غير المؤكدة في الواجهة

### API فقط: لا توجد Angular service تستدعيها (62)

- POST `/api/admin/migrate-passwords` — [الصيانة] ترحيل كلمات المرور إلى التشفير
- GET `/api/users` — [إدارة المستخدمين] عرض قائمة المستخدمين
- GET `/api/users/:userNo` — [إدارة المستخدمين] عرض بيانات مستخدم
- POST `/api/users` — [إدارة المستخدمين] إضافة مستخدم
- PUT `/api/users/:userNo` — [إدارة المستخدمين] تعديل مستخدم
- DELETE `/api/users/:userNo` — [إدارة المستخدمين] حذف مستخدم
- GET `/api/admin/temp-schema` — [الصيانة] عرض حقول الجدول المؤقت
- POST `/api/admin/temp-schema` — [الصيانة] إضافة حقل للجدول المؤقت
- DELETE `/api/admin/temp-schema/:fieldName` — [الصيانة] حذف حقل من الجدول المؤقت
- GET `/api/admin/media-ranges` — [الصيانة] عرض نطاقات الوسائط
- POST `/api/admin/media-ranges` — [الصيانة] إضافة نطاق وسائط
- PUT `/api/admin/media-ranges/:id` — [الصيانة] تعديل نطاق وسائط
- DELETE `/api/admin/media-ranges/:id` — [الصيانة] حذف نطاق وسائط
- POST `/api/archive/charts/batch` — [الأرشيف] إضافة ملفات أرشيف دفعة واحدة
- GET `/api/archive/charts/:id/operations/:operationId` — [الأرشيف] عرض عملية واحدة لملف الأرشيف
- DELETE `/api/archive/charts/:id/operations/:operationId` — [الأرشيف] حذف عملية من ملف الأرشيف
- GET `/api/authors` — [المؤلفين ودور النشر] عرض قائمة المؤلفين
- POST `/api/authors` — [المؤلفين ودور النشر] إضافة مؤلف
- PUT `/api/authors/:autNo` — [المؤلفين ودور النشر] تعديل مؤلف
- DELETE `/api/authors/:autNo` — [المؤلفين ودور النشر] حذف مؤلف
- POST `/api/books/:appNo/series` — [الكتب] إضافة سلسلة للكتاب
- PUT `/api/books/:appNo/series` — [الكتب] تعديل سلسلة الكتاب
- DELETE `/api/books/:appNo/series` — [الكتب] حذف سلسلة الكتاب
- PUT `/api/borrowing` — [الإعارة] تعديل إعارة
- DELETE `/api/borrowing` — [الإعارة] حذف إعارة
- GET `/api/catalogue/:appNo/abbreviations` — [التحليل] عرض الاختصارات
- POST `/api/catalogue/:appNo/abbreviations` — [التحليل] إضافة اختصار
- DELETE `/api/catalogue/:appNo/abbreviations/:serNo/:rltvN` — [التحليل] حذف اختصار
- GET `/api/catalogue/:appNo/text` — [التحليل] عرض النصوص
- POST `/api/catalogue/:appNo/text` — [التحليل] إضافة نص
- GET `/api/forms/secondary` — [المواقع] قائمة الاستمارات الثانوية
- POST `/api/form-thesaurus/additional-files/search` — [المكنز الشكلي] البحث في الملفات الاضافية (نسخة محمية)
- POST `/api/form-thesaurus/additional-files/op-tmp` — [المكنز الشكلي] إضافة الوثيقة للملفات الاضافية (نسخة محمية)
- PUT `/api/form-thesaurus/additional-files` — [المكنز الشكلي] تعديل ملف اضافي (نسخة محمية)
- POST `/api/form-thesaurus/additional-files` — [المكنز الشكلي] إضافة ملف اضافي (نسخة محمية)
- POST `/api/form-thesaurus/additional-files/delete` — [المكنز الشكلي] حذف ملف اضافي (نسخة محمية)
- GET `/api/lookups/arrays` — [الجداول المرجعية] جدول ARRAYS
- GET `/api/lookups/arrays1` — [الجداول المرجعية] جدول ARRAYS1
- GET `/api/lookups/relations` — [الجداول المرجعية] جدول العلاقات
- GET `/api/lookups/dict` — [الجداول المرجعية] جدول القاموس (DICT)
- GET `/api/lookups/mem` — [الجداول المرجعية] جدول MEM
- GET `/api/lookups/cote-pub` — [الجداول المرجعية] عرض رموز الناشرين (COTE_PUB)
- POST `/api/lookups/cote-pub` — [الجداول المرجعية] إضافة رمز ناشر
- PUT `/api/lookups/cote-pub/:id` — [الجداول المرجعية] تعديل رمز ناشر
- DELETE `/api/lookups/cote-pub/:id` — [الجداول المرجعية] حذف رمز ناشر
- GET `/api/lookups/operations` — [الجداول المرجعية] جدول العمليات
- GET `/api/catalogue/extended` — [الفهرس] عرض كل المعلومات الاضافية
- GET `/api/positions/:posNo` — [المواقع] عرض منصب
- GET `/api/reports/pout1` — [التقارير] عرض حقول المخرجات (POUT1)
- GET `/api/reports/pout1/:outIst/:outNum` — [التقارير] عرض حقل مخرج (POUT1)
- POST `/api/reports/pout1/:outIst` — [التقارير] إضافة حقل مخرج (POUT1)
- PUT `/api/reports/pout1/:outIst/:outNum` — [التقارير] تعديل حقل مخرج (POUT1)
- DELETE `/api/reports/pout1/:outIst/:outNum` — [التقارير] حذف حقل مخرج (POUT1)
- GET `/api/reports/categories` — [التقارير] عرض فئات التقارير
- POST `/api/reports/categories` — [التقارير] إضافة فئة تقرير
- DELETE `/api/reports/categories/:auto` — [التقارير] حذف فئة تقرير
- GET `/api/transactions` — [المعاملات] عرض المعاملات
- GET `/api/transactions/:opno/:no` — [المعاملات] عرض معاملة
- POST `/api/transactions` — [المعاملات] إضافة معاملة
- PUT `/api/transactions/:opno/:no` — [المعاملات] تعديل معاملة
- DELETE `/api/transactions/:opno/:no` — [المعاملات] حذف معاملة
- GET `/api/periodicals/:periodicalId/transactions` — [المعاملات] معاملات الدورية

### غير مؤكدة: الدالة في الـ service لا يستدعيها أي component (23)

- GET `/api/archive-search/responsible-persons` — [شاشة البحث فيديو + صوتي] قائمة المسؤولين للفلترة — `ArchiveSearchService.getResponsiblePersons`
- POST `/api/articles` — [المقالات] إضافة مقال — `DocumentationFormService.create`
- POST `/api/books` — [الكتب] إضافة كتاب — `BooksService.create`
- POST `/api/catalogue/:appNo/text1` — [التحليل] إضافة نص للوثيقة (Text1) — `CatalogueService.createText1`
- PUT `/api/catalogue/:appNo/text1/:serNo` — [التحليل] تعديل نص الوثيقة (Text1) — `CatalogueService.updateText1`
- DELETE `/api/catalogue/:appNo/text1/:serNo` — [التحليل] حذف نص من الوثيقة (Text1) — `CatalogueService.deleteText1`
- GET `/api/digitization/records/lookup` — [الرقمنة] عرض سجل ملف رقمي — `DigitizationService.getRecordById`
- GET `/api/digitization/demands/stats` — [الرقمنة] إحصائيات الطلبات — `DigitizationService.getDemandStats`
- GET `/api/digitization/demands/:id` — [الرقمنة] عرض طلب مشهد — `DigitizationService.getDemandById`
- PATCH `/api/digitization/demands/:id/path` — [الرقمنة] إعادة تعيين مسار طلب — `DigitizationService.reassignDemandPath`
- POST `/api/digitization/demands/:id/fulfil` — [الرقمنة] تنفيذ طلب — `DigitizationService.fulfilDemand`
- POST `/api/digitization/demands/bulk-fulfil` — [الرقمنة] تنفيذ عدة طلبات — `DigitizationService.bulkFulfilDemands`
- GET `/api/news/:newsNo/keywords` — [الأخبار] عرض الكلمات المفتاحية للخبر — `NewsService.getKeywords`
- GET `/api/periodicals` — [الصحف والمجلات] عرض قائمة الدوريات — `PeriodicalsService.getAll`
- POST `/api/staff` — [الأشخاص] إضافة موظف — `StaffService.create`
- PUT `/api/staff/:prsNo` — [الأشخاص] تعديل موظف — `StaffService.update`
- DELETE `/api/staff/:prsNo` — [الأشخاص] حذف موظف — `StaffService.delete`
- GET `/api/usage-requests` — [شاشة الطلبات] عرض طلبات الاستخدام — `UsageRequestService.getAll`
- GET `/api/usage-requests/:id` — [شاشة الطلبات] عرض طلب استخدام — `UsageRequestService.getById`
- POST `/api/usage-requests` — [شاشة الطلبات] إضافة طلب استخدام — `UsageRequestService.create`
- PUT `/api/usage-requests/:id` — [شاشة الطلبات] تعديل طلب استخدام — `UsageRequestService.update`
- DELETE `/api/usage-requests/:id` — [شاشة الطلبات] حذف طلب استخدام — `UsageRequestService.delete`
- PATCH `/api/usage-requests/:id/status` — [شاشة الطلبات] تغيير حالة طلب استخدام — `UsageRequestService.updateStatus`

### غير مؤكدة: يستدعيها component غير مضمَّن في أي شاشة (1)

- POST `/api/temp-files` — [طلبات سحب الملفات الاضافية] إضافة ملف معلق
