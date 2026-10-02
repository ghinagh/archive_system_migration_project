package com.startupstack.app.modules.retrieval.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

/**
 * Per-user "حقول العرض في الجدول" marks — migrated equivalent of legacy's
 * view_user_bnkout/user_bnkout rows (user_no, user_out_choice, user_out_choi1), scoped to our
 * app's authenticated username in place of legacy's user_no. See V29 migration for the exact
 * legacy evidence.
 */
@Getter
@Setter
@Entity
@Table(name = "retrieval_user_field")
public class RetrievalUserFieldEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private UUID id;

    @Column(name = "user_no", nullable = false, length = 100)
    private String userNo;

    @Column(name = "field_key", nullable = false, length = 50)
    private String fieldKey;

    /** Legacy user_out_choice — dblclick output-column toggle. */
    @Column(name = "display", nullable = false)
    private boolean display = false;

    /** Legacy user_out_choi1 — F10 order/sort-field toggle. */
    @Column(name = "order_mark", nullable = false)
    private boolean orderMark = false;
}
