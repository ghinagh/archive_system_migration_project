package com.startupstack.app.modules.retrievalfields.entity;

import com.startupstack.app.shared.auditing.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

/**
 * An admin-defined field that becomes searchable via a domain's advanced-search
 * builder (the {@code POST /api/{module}/search} endpoints backed by
 * {@link com.startupstack.app.shared.specification.GenericSpecificationBuilder}).
 * Migrated equivalent of the legacy "retrieval field builder / management" menu
 * items (ملف بناء الاسترجاعات / معالجة حقول الاسترجاع) — those let an operator
 * define which fields end users could filter on in the retrieval screens.
 *
 * Entries here are merged additively with each domain service's hardcoded
 * baseline field map (see {@code CatalogueService.ADVANCED_SEARCH_FIELDS}) —
 * they extend what's searchable, they never remove a built-in field.
 */
@Getter
@Setter
@Entity
@Table(name = "retrieval_field")
public class RetrievalFieldEntity extends BaseEntity {

    /** Which domain's advanced-search this field applies to, e.g. "CATALOGUE", "NEWS". */
    @Column(name = "module", nullable = false, length = 30)
    private String module;

    /** The key clients send in a {@code SearchCondition.field}. */
    @Column(name = "field_key", nullable = false, length = 50)
    private String fieldKey;

    /** The JPA entity attribute path this key maps to. */
    @Column(name = "entity_path", nullable = false, length = 100)
    private String entityPath;

    /** One of {@code SearchField.FieldType}: STRING, NUMBER, or DATE. */
    @Column(name = "field_type", nullable = false, length = 10)
    private String fieldType;

    @Column(name = "label", nullable = false, length = 100)
    private String label;

    @Column(name = "enabled", nullable = false)
    private boolean enabled = true;

    /**
     * The fixed JPQL join alias (see RetrievalService's join skeleton: c=catalogue,
     * a=article, p=periodical, au=author, sub=subject/thesaurus) that {@link #entityPath}
     * is read from. Null/blank means the catalogue root ("c"). Only consumed by the
     * cross-domain graphical retrieval engine (module = "GRAPHICAL_RETRIEVAL") — the
     * per-module single-entity advanced-search endpoints ignore it.
     */
    @Column(name = "join_path", length = 150)
    private String joinPath;

    /** Groups fields in the graphical retrieval field picker and drives the "mark whole category" bulk action. */
    @Column(name = "category", length = 60)
    private String category;

    /** Whether the graphical retrieval builder offers a bound value-picker list for this field instead of free text. */
    @Column(name = "lookup_enabled", nullable = false)
    private boolean lookupEnabled = false;

    @Column(name = "display_order", nullable = false)
    private int displayOrder = 0;
}
