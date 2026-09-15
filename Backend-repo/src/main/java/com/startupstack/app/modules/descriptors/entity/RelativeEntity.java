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
@Table(name = "RELATIVE")
public class RelativeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AUTO")
    private Integer id;

    @Column(name = "REL_APP_NO")
    private String appNo;

    @Column(name = "REL_DESC_N")
    private String descriptorNo;

    @Column(name = "REL_SER_NO")
    private String serialNo;

    @Column(name = "REL_RLTV_N")
    private String relativeNo;

    @Column(name = "REL_RLTV_T")
    private String relativeType;

    @Column(name = "REL_REL_NO")
    private String relationNo;
}
