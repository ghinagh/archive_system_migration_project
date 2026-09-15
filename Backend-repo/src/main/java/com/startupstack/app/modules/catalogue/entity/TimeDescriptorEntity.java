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
@Table(name = "TIME")
@IdClass(TimeDescriptorId.class)
public class TimeDescriptorEntity {

    @Id
    @Column(name = "TM_APP_NO", length = 7)
    private String tmAppNo;

    @Id
    @Column(name = "TM_SER_NO", length = 2)
    private String tmSerNo;

    @Id
    @Column(name = "TM_RLTV_NO", length = 2)
    private String tmRltvNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TM_APP_NO", referencedColumnName = "MN_APP_NO", insertable = false, updatable = false)
    private CatalogueEntity catalogue;

    @Column(name = "TM_DESC_NO", length = 9)
    private String tmDescNo;

    @Column(name = "TM_O")
    private Double tmO;

    @Column(name = "TM_M")
    private Double tmM;

    @Column(name = "TM_S")
    private Double tmS;

    @Column(name = "TM_O1")
    private Double tmO1;

    @Column(name = "TM_M1")
    private Double tmM1;

    @Column(name = "TM_S1")
    private Double tmS1;
}
