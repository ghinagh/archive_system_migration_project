package com.startupstack.app.modules.digitization.entity;

import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * A beneficiary usage-request log entry — migrated equivalent of the legacy "result" table
 * that backs both "شاشة البحث" (user_interface.frm, the only screen that creates rows here,
 * via its F3 export-and-register panel) and "شاشة الطلبات" (f_result.frm, "أرشيف طلبات
 * الاستفادة", which lists/edits/cancels these same rows). Unrelated to the demand table
 * (video-orders queue) despite both loosely translating to "request" in English.
 */
@Getter
@Setter
@Entity
@Table(name = "result")
public class ResultEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "auto")
    private Integer id;

    @Column(name = "res_no", columnDefinition = "char(7)", nullable = false)
    private String resultNo;

    @Column(name = "res_ser", nullable = false)
    private Integer serial;

    @Column(name = "res_dig_no", columnDefinition = "char(6)")
    private String digitNo;

    @Column(name = "res_typ", columnDefinition = "char(3)")
    private String type;

    @Column(name = "res_typ1", columnDefinition = "char(2)")
    private String type1;

    @Column(name = "res_dte")
    private LocalDateTime date;

    @Column(name = "res_user_no", columnDefinition = "char(3)")
    private String userNo;

    @Column(name = "res_no_ist", columnDefinition = "char(7)")
    private String catalogueAppNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "res_no_ist", referencedColumnName = "MN_APP_NO", insertable = false, updatable = false)
    private CatalogueEntity catalogue;

    @Column(name = "res_prs", columnDefinition = "char(50)")
    private String person;

    @Column(name = "res_cote", columnDefinition = "char(3)")
    private String cote;

    @Column(name = "res_permit", columnDefinition = "char(2)")
    private String permit;

    @Column(name = "res_subject", columnDefinition = "char(50)")
    private String subject;
}
