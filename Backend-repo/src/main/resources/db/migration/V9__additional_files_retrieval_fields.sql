-- Adds the FILE_ADD cross-reference domain (legacy "استرجاع الملفات الاضافية" menu item,
-- which reused the same sort_form shell scoped to the POUT metadata partition out_ist='02')
-- as one more field category inside the existing graphical retrieval screen, rather than
-- standing up a second identical query-builder screen.
INSERT INTO retrieval_field (id, module, field_key, entity_path, field_type, label, enabled, join_path, category, lookup_enabled, display_order) VALUES
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'file_relation_type1', 'fileType1',     'STRING', 'رمز نوع العلاقة 1',        TRUE, 'fa', 'الملفات الاضافية', TRUE,  0),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'file_relation_type2', 'fileType2',     'STRING', 'رمز نوع العلاقة 2',        TRUE, 'fa', 'الملفات الاضافية', TRUE,  1),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'file_relative_no',    'relativeNo',    'STRING', 'الرقم النسبي',              TRUE, 'fa', 'الملفات الاضافية', FALSE, 2),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'file_related_app_no', 'fileNo',        'STRING', 'رقم الوثيقة المرتبطة',      TRUE, 'fa', 'الملفات الاضافية', FALSE, 3),
    (gen_random_uuid(), 'GRAPHICAL_RETRIEVAL', 'file_related_title',  'activeTitleAr', 'STRING', 'عنوان الوثيقة المرتبطة',    TRUE, 'rd', 'الملفات الاضافية', TRUE,  4);
