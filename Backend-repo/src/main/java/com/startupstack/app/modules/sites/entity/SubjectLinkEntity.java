package com.startupstack.app.modules.sites.entity;

import com.startupstack.app.modules.lookups.entity.MacnzEntity;
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
@Table(name = "SUBJECT")
@IdClass(SubjectLinkId.class)
public class SubjectLinkEntity {

    @Id
    @Column(name = "SUB_FORM", length = 10)
    private String subForm;

    @Id
    @Column(name = "SUB_MCNZ", length = 9)
    private String subMcnz;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SUB_FORM", referencedColumnName = "SUB_NO", insertable = false, updatable = false)
    private FormEntity form;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SUB_MCNZ", referencedColumnName = "SUB_CODE", insertable = false, updatable = false)
    private MacnzEntity macnz;

    @Column(name = "SUB_DTE")
    private LocalDateTime subDte;

    @Column(name = "SUB_DTE1")
    private LocalDateTime subDte1;

    @Column(name = "SUB_REL", length = 2)
    private String subRel;
}
