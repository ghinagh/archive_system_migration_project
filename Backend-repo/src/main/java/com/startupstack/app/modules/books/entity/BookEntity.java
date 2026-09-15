package com.startupstack.app.modules.books.entity;

import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "BOOK")
public class BookEntity {

    @Id
    @Column(name = "BK_APP_NO")
    private String appNo;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "BK_APP_NO", referencedColumnName = "MN_APP_NO", insertable = false, updatable = false)
    private CatalogueEntity catalogue;

    @Column(name = "BK_PUB_LOC")
    private String publishLocation;

    @Column(name = "BK_PBLSHR")
    private Double publisher;

    @Column(name = "BK_PUB_TYP")
    private String publishType;

    @Column(name = "BK_SLCT_NO")
    private String selectNo;

    @Column(name = "BK_PUB_DTE")
    private LocalDateTime publishDate;

    @Column(name = "BK_MAT_CNT")
    private String materialCount;

    @Column(name = "BK_LANG3")
    private String lang3;

    @Column(name = "BK_EDTN")
    private Double edition;

    @Column(name = "BK_RDMK")
    private String rdmk;

    @Column(name = "BK_CVR")
    private String cover;

    @Column(name = "BK_PG_NO")
    private Double pageCount;

    @Column(name = "BK_PRT_NO")
    private Double partNo;

    @Column(name = "BK_IS_SER", nullable = false)
    private Boolean isSeries;

    @Column(name = "BK_NO_CP")
    private Double copyCount;

    @Column(name = "BK_REG_NO")
    private Double regNo;

    @Column(name = "BK_ADT_TTL")
    private String additionalTitle;

    @Column(name = "BK_KHALIF")
    private String khalif;

    @Column(name = "BK_VOL")
    private Double volume;

    @Column(name = "BK_WATH_TY")
    private String documentType;

    @Column(name = "BK_QUATER")
    private String quarter;

    @Column(name = "BK_SAVE")
    private Double save;

    @Column(name = "BK_PRIX")
    private Double price;

    @Column(name = "BK_IKTDTE")
    private LocalDateTime acquisitionDate;

    @Column(name = "BK_MTRJM")
    private Double translator;

    @Column(name = "BK_SER_TTL")
    private String seriesTitle;

    @Column(name = "BK_SER_NO")
    private Double seriesNo;

    @Column(name = "BK_LANG1")
    private String lang1;

    @Column(name = "bk_vol1")
    private Double volume1;

    @Column(name = "bk_mjld")
    private Double bindingFrom;

    @Column(name = "bk_mjld1")
    private Double bindingTo;

    @Column(name = "bk_jz")
    private Double partFrom;

    @Column(name = "bk_jz1")
    private Double partTo;

    @Column(name = "bk_content")
    private String content;

    @Column(name = "bk_memo")
    private String memo;

    @Column(name = "bk_year_pub")
    private Double yearPublished;

    @Column(name = "bk_typ_year")
    private Double yearType;

    @Column(name = "bk_result")
    private String result;

    @Column(name = "bk_free")
    private Double free;

    @Column(name = "bk_lang")
    private String lang;

    @Column(name = "bk_iar_no")
    private String borrowingNo;

    @Column(name = "bk_stat", columnDefinition = "char(2)")
    private String status;
}
