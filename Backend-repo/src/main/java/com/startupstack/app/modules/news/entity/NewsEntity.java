package com.startupstack.app.modules.news.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "NEWS")
public class NewsEntity {

    @Id
    @Column(name = "NEWS_NO", columnDefinition = "varchar(7)")
    private String newsNo;

    @Column(name = "NEWS_DOC", columnDefinition = "varchar(2)")
    private String newsDoc;

    @Column(name = "NEWS_DTE_D")
    private LocalDateTime newsDteD;

    @Column(name = "NEWS_DTE")
    private LocalDateTime newsDte;

    @Column(name = "NEWS_NUM")
    private Double newsNum;

    @Column(name = "NEWS_TIT1", columnDefinition = "varchar(75)")
    private String newsTit1;

    @Column(name = "NEWS_TIT2", columnDefinition = "varchar(75)")
    private String newsTit2;

    @Column(name = "NEWS_DES_T", columnDefinition = "varchar(2)")
    private String newsDesT;

    @Column(name = "NEWS_DES_D")
    private LocalDateTime newsDesD;

    @Column(name = "NEWS_DES_P")
    private Double newsDesP;

    @Column(name = "NEWS_PUB")
    private Double newsPub;

    @Column(name = "NEWS_DES_N", columnDefinition = "varchar(9)")
    private String newsDesN;

    @Column(name = "NEWS_MLH")
    private Double newsMlh;
}
