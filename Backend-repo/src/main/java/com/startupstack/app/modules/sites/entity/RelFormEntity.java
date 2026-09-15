package com.startupstack.app.modules.sites.entity;

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
@Table(name = "REL_FORM")
@IdClass(RelFormId.class)
public class RelFormEntity {

    @Id
    @Column(name = "RLF_FORM1", length = 10)
    private String rlfForm1;

    @Id
    @Column(name = "RLF_FORM2", length = 10)
    private String rlfForm2;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "RLF_FORM1", referencedColumnName = "SUB_NO", insertable = false, updatable = false)
    private FormEntity form1;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "RLF_FORM2", referencedColumnName = "SUB_NO", insertable = false, updatable = false)
    private FormEntity form2;

    @Column(name = "RLF_DTE")
    private LocalDateTime rlfDte;

    @Column(name = "RLF_DTE1")
    private LocalDateTime rlfDte1;

    @Column(name = "RLF_REL", length = 2)
    private String rlfRel;
}
