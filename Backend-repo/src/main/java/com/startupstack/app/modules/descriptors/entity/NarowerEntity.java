package com.startupstack.app.modules.descriptors.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "NAROWER")
public class NarowerEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AUTO")
    private Integer id;

    @Column(name = "NAR_APP_NO")
    private String appNo;

    @Column(name = "NAR_DESC_N")
    private String descriptorNo;

    @Column(name = "NAR_SER_NO")
    private String serialNo;

    @Column(name = "NAR_RLTV_N")
    private String relativeNo;

    @Column(name = "NAR_NAR_TY")
    private String narrowerType;

    @Column(name = "NAR_NAR_NO")
    private String narrowerNo;
}
