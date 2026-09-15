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
@Table(name = "posts")
public class PostEntity {

    @Id
    @Column(name = "post_serial", columnDefinition = "char(6)")
    private String serial;

    @Column(name = "post_no", columnDefinition = "char(10)", insertable = false, updatable = false)
    private String formNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "post_no", referencedColumnName = "SUB_NO")
    private FormEntity form;

    @Column(name = "post_sit_no", columnDefinition = "char(13)")
    private String siteNo;

    @Column(name = "post_doc_no", columnDefinition = "char(7)")
    private String docNo;

    @Column(name = "post_deb_dte")
    private LocalDateTime startDate;

    @Column(name = "post_fin_dte")
    private LocalDateTime endDate;

    @Column(name = "post_wly_no")
    private Integer wilyaNo;

    @Column(name = "post_stat")
    private Integer status;

    @Column(name = "post_level_no", columnDefinition = "char(2)")
    private String levelNo;

    @Column(name = "post_typ")
    private Integer type;

    @Column(name = "post_user", columnDefinition = "char(3)")
    private String user;

    @Column(name = "post_permition")
    private Integer permission;

    @Column(name = "post_level", columnDefinition = "char(1)")
    private String level;
}
