-- Extends retrieval_field with the metadata the cross-domain "graphical retrieval"
-- query builder needs (migrated equivalent of legacy sort_from.frm / bnkout table):
-- which fixed JPQL join alias the field lives behind (see RetrievalService's join
-- skeleton: c=catalogue, a=article, p=periodical, au=author, sub=subject/thesaurus),
-- a grouping category for the field picker + "mark whole category" bulk action,
-- whether it offers a bound value-picker list, and a display order.
ALTER TABLE retrieval_field ADD COLUMN join_path VARCHAR(150);
ALTER TABLE retrieval_field ADD COLUMN category VARCHAR(60);
ALTER TABLE retrieval_field ADD COLUMN lookup_enabled BOOLEAN NOT NULL DEFAULT FALSE;
ALTER TABLE retrieval_field ADD COLUMN display_order INT NOT NULL DEFAULT 0;

-- Seed the field catalogue for module = 'GRAPHICAL_RETRIEVAL', spanning the
-- catalogue (main) root plus its article / periodical / author / subject joins —
-- the same cross-table coverage the legacy bnkout metadata gave sort_form.
INSERT INTO retrieval_field (id, module, field_key, entity_path, field_type, label, enabled, join_path, category, lookup_enabled, display_order) VALUES
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'doc_app_no',        'appNo',           'STRING', 'رقم الوارد',           TRUE, NULL,                     'الوثيقة',    FALSE, 0),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'doc_title',         'activeTitleAr',   'STRING', 'العنوان الرئيسي',      TRUE, NULL,                     'الوثيقة',    FALSE, 1),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'doc_subtitle',      'additionalTitle', 'STRING', 'العنوان الثانوي',      TRUE, NULL,                     'الوثيقة',    FALSE, 2),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'doc_entry_date',    'entryDate',       'DATE',   'تاريخ الإدخال',        TRUE, NULL,                     'الوثيقة',    FALSE, 3),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'doc_type',          'type',            'STRING', 'نوع الوثيقة',          TRUE, NULL,                     'الوثيقة',    TRUE,  4),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'doc_nature',        'documentNature',  'STRING', 'طبيعة الوثيقة',        TRUE, NULL,                     'الوثيقة',    TRUE,  5),

    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'article_date',        'date',        'DATE',   'تاريخ المقال',     TRUE, 'a',   'المقال',     FALSE, 0),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'article_page_no',     'pageNo',      'STRING', 'رقم الصفحة',       TRUE, 'a',   'المقال',     FALSE, 1),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'article_subject_type','subjectType', 'STRING', 'نوع الموضوع',      TRUE, 'a',   'المقال',     TRUE,  2),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'article_lang',        'lang',        'STRING', 'لغة المقال',       TRUE, 'a',   'المقال',     TRUE,  3),

    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'periodical_name',       'name',      'STRING', 'اسم الدورية',        TRUE, 'p',  'الدورية',    TRUE,  0),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'periodical_frequency',  'frequency', 'STRING', 'دورية الصدور',       TRUE, 'p',  'الدورية',    TRUE,  1),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'periodical_start_date', 'startDate', 'DATE',   'تاريخ بدء الإصدار',   TRUE, 'p',  'الدورية',    FALSE, 2),

    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'author_name', 'autName', 'STRING', 'اسم المؤلف',  TRUE, 'au', 'المؤلفون', TRUE, 0),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'author_type', 'autType', 'STRING', 'نوع المؤلف',  TRUE, 'au', 'المؤلفون', TRUE, 1),

    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'subject_term',  'subDesc',  'STRING', 'الموضوع (ماكنز)', TRUE, 'sub', 'الموضوع', TRUE, 0),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'subject_level', 'subLevel', 'STRING', 'مستوى التصنيف',   TRUE, 'sub', 'الموضوع', TRUE, 1);
