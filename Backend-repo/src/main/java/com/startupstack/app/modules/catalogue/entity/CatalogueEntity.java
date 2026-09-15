package com.startupstack.app.modules.catalogue.entity;

import com.startupstack.app.modules.sites.entity.SiteEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "main")
public class CatalogueEntity {

    @Id
    @Column(name = "MN_APP_NO", columnDefinition = "char(7)")
    private String appNo;

    @Column(name = "MN_ACT_TTL")
    private String activeTitleAr;

    @Column(name = "MN_ADD_TTL")
    private String additionalTitle;

    @Column(name = "MN_DATA_EN")
    private String dataEntry;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MN_DATA_EN", referencedColumnName = "sit_no", insertable = false, updatable = false)
    private SiteEntity site;

    @Column(name = "MN_APP_DOC")
    private String appDoc;

    @Column(name = "MN_ENT_DTE")
    private LocalDateTime entryDate;

    @Column(name = "MN_WRT_DTE")
    private LocalDateTime writeDate;

    @Column(name = "MN_APP_REV")
    private String appRevision;

    @Column(name = "MN_TYP", columnDefinition = "char(1)")
    private String type;

    @Column(name = "MN_RESULT", columnDefinition = "char(1000)")
    private String result;

    @Column(name = "mn_trans")
    private Integer trans;

    @Column(name = "mn_doc_nature", columnDefinition = "char(1)")
    private String documentNature;
}
