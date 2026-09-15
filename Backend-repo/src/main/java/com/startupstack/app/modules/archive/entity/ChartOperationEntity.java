package com.startupstack.app.modules.archive.entity;

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

@Getter
@Setter
@Entity
@Table(name = "OPR_CHRT")
public class ChartOperationEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "auto")
    private Integer id;

    @Column(name = "OPR_NO")
    private String oprNo;

    @Column(name = "OPR_SER")
    private Double serial;

    @Column(name = "OPR_NO1", insertable = false, updatable = false)
    private String chartNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "OPR_NO1", referencedColumnName = "CHA_NO")
    private ChartEntity chart;

    @Column(name = "OPR_SUB")
    private String subject;

    @Column(name = "OPR_DTE")
    private LocalDateTime date;

    @Column(name = "OPR_TIME")
    private String time;

    @Column(name = "OPR_COTFRM")
    private String fromSite;

    @Column(name = "OPR_PRSFRM")
    private String fromPerson;

    @Column(name = "OPR_COTTO")
    private String toSite;

    @Column(name = "OPR_PRSTO")
    private String toPerson;

    @Column(name = "OPR_DTE1")
    private LocalDateTime returnDate;

    @Column(name = "OPR_RMK")
    private String remark;

    @Column(name = "OPR_TITLE")
    private String title;

    @Column(name = "OPR_TRANS", nullable = false)
    private Boolean transferred;

    @Column(name = "opr_choice", columnDefinition = "char(20)")
    private String choice;

    @Column(name = "opr_extcote", columnDefinition = "char(10)")
    private String externalCode;
}
