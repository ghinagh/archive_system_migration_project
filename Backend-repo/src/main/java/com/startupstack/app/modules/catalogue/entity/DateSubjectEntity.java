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

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "date_subject")
@IdClass(DateSubjectId.class)
public class DateSubjectEntity {

    @Id
    @Column(name = "DTE_APP_NO", columnDefinition = "char(7)")
    private String dteAppNo;

    @Id
    @Column(name = "DTE_SER_NO", columnDefinition = "char(2)")
    private String dteSerNo;

    @Id
    @Column(name = "DTE_REL_NO", columnDefinition = "char(2)")
    private String dteRelNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "DTE_APP_NO", referencedColumnName = "MN_APP_NO", insertable = false, updatable = false)
    private CatalogueEntity catalogue;

    @Column(name = "DTE_DESC_NO", columnDefinition = "char(9)")
    private String dteDescNo;

    @Column(name = "DTE_DTE_DEB")
    private LocalDateTime dteDteDeb;

    @Column(name = "DTE_DTE_FIN")
    private LocalDateTime dteDteFin;
}
