package com.startupstack.app.modules.sites.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
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
@Table(name = "sites")
public class SiteEntity {

    @Id
    @Column(name = "sit_no", columnDefinition = "char(10)")
    private String siteNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sit_no", referencedColumnName = "SUB_NO", insertable = false, updatable = false)
    private FormEntity form;

    @Column(name = "sit_nolevel", columnDefinition = "char(13)")
    private String levelNo;

    @Column(name = "sit_level", columnDefinition = "char(2)")
    private String level;

    @Column(name = "sit_proccess", columnDefinition = "char(10)")
    private String process;

    @Column(name = "sit_desc")
    private String description;

    @Column(name = "sit_doc_no", columnDefinition = "char(7)")
    private String docNo;

    @Column(name = "sit_deb_dte")
    private LocalDateTime startDate;

    @Column(name = "sit_fin_dte")
    private LocalDateTime endDate;

    @Column(name = "sit_free")
    private Integer free;

    @Column(name = "sit_typ", columnDefinition = "char(2)")
    private String type;

    @Column(name = "sit_intkb")
    private Integer intkb;

    @Column(name = "sit_morch")
    private Integer morch;

    @Column(name = "sit_wly_no")
    private Integer wilyaNo;

    @Column(name = "sit_stat", columnDefinition = "char(2)")
    private String status;

    @Column(name = "sit_user", columnDefinition = "char(3)")
    private String user;

    @Column(name = "sit_permition")
    private Integer permission;

    @Column(name = "sit_leve", columnDefinition = "char(1)")
    private String accessLevel;

    @Column(name = "sit_kind", columnDefinition = "char(2)")
    private String kind;

    @Column(name = "sit_close_no", columnDefinition = "char(7)")
    private String closeNo;
}
