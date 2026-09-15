package com.startupstack.app.modules.articles.entity;

import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.periodicals.entity.PeriodicalEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "ARTICLE")
public class ArticleEntity {

    @Id
    @Column(name = "ART_APP_NO")
    private String appNo;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ART_APP_NO", referencedColumnName = "MN_APP_NO", insertable = false, updatable = false)
    private CatalogueEntity catalogue;

    @Column(name = "ART_YEAR")
    private Double year;

    @Column(name = "ART_VOL")
    private Double volume;

    @Column(name = "ART_NO")
    private Integer articleNo;

    @Column(name = "ART_DTE")
    private LocalDateTime date;

    @Column(name = "ART_PER_NO", insertable = false, updatable = false)
    private Double periodicalNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ART_PER_NO", referencedColumnName = "PER_PER_NO")
    private PeriodicalEntity periodical;

    @Column(name = "ART_SUB_TY")
    private String subjectType;

    @Column(name = "ART_PG_NO")
    private String pageNo;

    @Column(name = "ART_CO_NO")
    private String countryNo;

    @Column(name = "ART_SER_NO")
    private Double serialNo;

    @Column(name = "ART_FLM_NO")
    private Double filmNo;

    @Column(name = "ART_TYP")
    private Double type;

    @Column(name = "ART_LANG")
    private String lang;

    @Column(name = "ART_DTE1")
    private LocalDateTime date1;

    @Column(name = "ART_PER1")
    private Double periodical1;

    @Column(name = "ART_CHOICE")
    private Double choice;

    @Column(name = "art_upd")
    private Double updated;

    @Column(name = "ART_PIC", columnDefinition = "char(6)")
    private String picture;

    @Column(name = "ART_LANG1", columnDefinition = "char(2)")
    private String lang1;
}
