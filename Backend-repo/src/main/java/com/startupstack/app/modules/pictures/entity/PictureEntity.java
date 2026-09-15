package com.startupstack.app.modules.pictures.entity;

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
@Table(name = "PICTURE")
public class PictureEntity {

    @Id
    @Column(name = "pic_no", columnDefinition = "varchar(7)")
    private String picNo;

    @Column(name = "pic_ng_no", columnDefinition = "varchar(6)")
    private String picNgNo;

    @Column(name = "pic_pos_no", columnDefinition = "varchar(6)")
    private String picPosNo;

    @Column(name = "pic_doc", columnDefinition = "varchar(3)")
    private String picDoc;

    @Column(name = "pic_doc_dte")
    private LocalDateTime picDocDte;

    @Column(name = "pic_ent", columnDefinition = "varchar(3)")
    private String picEnt;

    @Column(name = "pic_ent_dte")
    private LocalDateTime picEntDte;

    @Column(name = "pic_prs", columnDefinition = "varchar(3)")
    private String picPrs;

    @Column(name = "pic_dte")
    private LocalDateTime picDte;

    @Column(name = "pic_tit", columnDefinition = "varchar(100)")
    private String picTit;

    @Column(name = "pic_cot", columnDefinition = "varchar(10)")
    private String picCot;

    @Column(name = "pic_geo", columnDefinition = "varchar(10)")
    private String picGeo;

    @Column(name = "pic_typ")
    private Double picTyp;

    @Column(name = "pic_form")
    private Double picForm;

    @Column(name = "pic_len")
    private Double picLen;

    @Column(name = "pic_large")
    private Double picLarge;

    @Column(name = "pic_qualty")
    private Double picQualty;

    @Column(name = "pic_sub")
    private Double picSub;

    @Column(name = "pic_rmrk", columnDefinition = "varchar(70)")
    private String picRmrk;

    @Column(name = "pic_copy")
    private Double picCopy;

    @Column(name = "pic_lbn", columnDefinition = "varchar(5)")
    private String picLbn;

    @Column(name = "pic_page", columnDefinition = "varchar(5)")
    private String picPage;

    @Column(name = "pic_line", columnDefinition = "varchar(5)")
    private String picLine;

    @Column(name = "pic_typ1")
    private Double picTyp1;

    @Column(name = "pic_brind")
    private Double picBrind;

    @Column(name = "pic_choice")
    private Double picChoice;
}
