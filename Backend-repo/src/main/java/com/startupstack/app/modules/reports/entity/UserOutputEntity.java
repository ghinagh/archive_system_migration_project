package com.startupstack.app.modules.reports.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "user_bnkout")
@IdClass(UserOutputId.class)
public class UserOutputEntity {

    @Id
    @Column(name = "user_ist_no", columnDefinition = "char(2)")
    private String institutionNo;

    @Id
    @Column(name = "user_no", columnDefinition = "char(3)")
    private String userNo;

    @Id
    @Column(name = "user_out_num")
    private Integer outputNum;

    @Column(name = "user_out_choice")
    private Integer outputChoice;

    @Column(name = "user_index", columnDefinition = "char(3)")
    private String userIndex;

    @Column(name = "user_sing", columnDefinition = "char(1)")
    private String sign;

    @Column(name = "user_out_choi1")
    private Integer outputChoice1;

    @Column(name = "user_sing1", columnDefinition = "char(1)")
    private String sign1;
}
