package com.startupstack.app.modules.catalogue.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "main2")
public class Main2Entity {

    @Id
    @Column(name = "MN_APP_NO")
    private String appNo;

    @Column(name = "MN_ACT_TTL")
    private String activeTitleAr;

    @Column(name = "MN_ACT")
    private String activeCode;

    @Column(name = "MN_ADD_TTL")
    private String additionalTitle;

    @Column(name = "MN_ADD")
    private String additionalCode;

    @Column(name = "MN_DATA_EN")
    private String dataEntry;

    @Column(name = "MN_APP_DOC")
    private String appDoc;

    @Column(name = "MN_ENT_DTE")
    private LocalDateTime entryDate;

    @Column(name = "MN_WRT_DTE")
    private LocalDateTime writeDate;

    @Column(name = "MN_APP_REV")
    private String appRevision;

    @Column(name = "MN_CHRT_NO", columnDefinition = "char(6)")
    private String chartNo;

    @Column(name = "MN_O")
    private Integer startHours;

    @Column(name = "MN_M")
    private Integer startMinutes;

    @Column(name = "MN_S")
    private Integer startSeconds;

    @Column(name = "MN_O1")
    private Integer endHours;

    @Column(name = "MN_M1")
    private Integer endMinutes;

    @Column(name = "MN_S1")
    private Integer endSeconds;

    @Column(name = "MN_SIZE", precision = 5, scale = 2)
    private BigDecimal size;

    @Column(name = "MN_TYP", columnDefinition = "char(1)")
    private String type;

    @Column(name = "MN_PIC", columnDefinition = "char(2)")
    private String pictureCode;

    @Column(name = "MN_VOI", columnDefinition = "char(2)")
    private String voiceCode;

    @Column(name = "MN_RESULT")
    private String result;
}
