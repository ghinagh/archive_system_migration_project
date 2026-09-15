package com.startupstack.app.modules.users.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "config")
public class UserEntity {

    @Id
    @Column(name = "user_no", columnDefinition = "char(3)")
    private String userNo;

    @Column(name = "user_name", columnDefinition = "char(50)")
    private String userName;

    @Column(name = "user_password", columnDefinition = "varchar(72)")
    private String userPassword;

    @Column(name = "user_cnf_path", columnDefinition = "char(100)")
    private String userCnfPath;

    @Column(name = "user_start")
    private Integer userStart;

    @Column(name = "USER_PWD")
    private Integer userPwd;

    @Column(name = "user_cmpvd", columnDefinition = "char(100)")
    private String userCmpvd;

    @Column(name = "user_video_path", columnDefinition = "char(100)")
    private String userVideoPath;

    @Column(name = "user_company")
    private Integer userCompany;

    @Column(name = "user_video_path1", columnDefinition = "char(100)")
    private String userVideoPath1;

    @Column(name = "SITE_WLY")
    private Integer siteWly;

    @Column(name = "user_level", columnDefinition = "char(1)")
    private String userLevel;

    @Column(name = "user_permition")
    private Integer userPermission;

    @Column(name = "user_ent", columnDefinition = "char(2)")
    private String userEnt;

    @Column(name = "user_doc", columnDefinition = "char(2)")
    private String userDoc;
}
