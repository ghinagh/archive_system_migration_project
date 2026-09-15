package com.startupstack.app.modules.catalogue.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "abb")
@IdClass(AbbreviationId.class)
public class AbbreviationEntity {

    @Id
    @Column(name = "REL_APP_NO", length = 7)
    private String relAppNo;

    @Id
    @Column(name = "REL_SER_NO", length = 2)
    private String relSerNo;

    @Id
    @Column(name = "REL_RLTV_N", length = 2)
    private String relRltvN;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "REL_APP_NO", referencedColumnName = "MN_APP_NO", insertable = false, updatable = false)
    private CatalogueEntity catalogue;

    @Column(name = "REL_DESC_N", length = 9)
    private String relDescN;

    @Column(name = "REL_RLTV_T", length = 1)
    private String relRltvT;

    @Column(name = "REL_REL_NO", length = 9)
    private String relRelNo;
}
