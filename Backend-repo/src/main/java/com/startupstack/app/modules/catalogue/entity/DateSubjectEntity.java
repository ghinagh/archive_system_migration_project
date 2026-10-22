package com.startupstack.app.modules.catalogue.entity;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
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
    @Column(name = "dte_app_no", columnDefinition = "char(7)")
    private String dteAppNo;

    @Id
    @Column(name = "dte_ser_no", columnDefinition = "char(2)")
    private String dteSerNo;

    @Id
    @Column(name = "dte_rel_no", columnDefinition = "char(2)")
    private String dteRelNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @NotFound(action = NotFoundAction.IGNORE) // legacy has no FK: a deleted target reads as null
    @JoinColumn(name = "dte_app_no", referencedColumnName = "MN_APP_NO", insertable = false, updatable = false)
    private CatalogueEntity catalogue;

    @Column(name = "dte_desc_no", columnDefinition = "char(9)")
    private String dteDescNo;

    @Column(name = "dte_dte_deb")
    private LocalDateTime dteDteDeb;

    @Column(name = "dte_dte_fin")
    private LocalDateTime dteDteFin;
}
