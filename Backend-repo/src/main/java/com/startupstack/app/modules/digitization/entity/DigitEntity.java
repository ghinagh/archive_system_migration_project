package com.startupstack.app.modules.digitization.entity;

import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
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

import java.math.BigDecimal;

@Getter
@Setter
@Entity
@Table(name = "DIGIT")
@IdClass(DigitId.class)
public class DigitEntity {

    @Id
    @Column(name = "DIG_NO", columnDefinition = "char(7)")
    private String docNo;

    @Id
    @Column(name = "DIG_SER")
    private Integer serial;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "DIG_NO", referencedColumnName = "MN_APP_NO", insertable = false, updatable = false)
    private CatalogueEntity catalogue;

    @Column(name = "DIG_DIG_NO", columnDefinition = "char(6)")
    private String digitNo;

    @Column(name = "DIG_TYP", columnDefinition = "char(4)")
    private String type;

    @Column(name = "DIG_TYP1", columnDefinition = "char(2)")
    private String type1;

    @Column(name = "DIG_O")
    private Integer durationHours;

    @Column(name = "DIG_M")
    private Integer durationMinutes;

    @Column(name = "DIG_S")
    private Integer durationSeconds;

    @Column(name = "DIG_O1")
    private Integer durationHours1;

    @Column(name = "DIG_M1")
    private Integer durationMinutes1;

    @Column(name = "DIG_S1")
    private Integer durationSeconds1;

    @Column(name = "DIG_SIZE")
    private BigDecimal size;

    @Column(name = "DIG_NOCHRT", columnDefinition = "char(6)")
    private String chartNo;

    @Column(name = "dig_newnochrt", columnDefinition = "char(6)")
    private String newChartNo;

    @Column(name = "dig_typchrt", columnDefinition = "char(2)")
    private String chartType;

    @Column(name = "dig_geochrt", columnDefinition = "char(10)")
    private String chartGeo;

    @Column(name = "dig_choice")
    private Integer choice;

    @Column(name = "dig_nochrt1", columnDefinition = "char(8)")
    private String chartNo1;

    @Column(name = "dig_typmat", columnDefinition = "char(2)")
    private String materialType;

    @Column(name = "dig_typ_high", columnDefinition = "char(3)")
    private String highType;
}
