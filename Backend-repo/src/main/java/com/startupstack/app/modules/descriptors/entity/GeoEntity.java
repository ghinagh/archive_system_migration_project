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
@Table(name = "GEO")
public class GeoEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "auto")
    private Integer id;

    @Column(name = "GEO_APP_NO")
    private String appNo;

    @Column(name = "GEO_DESC_N")
    private String descriptorNo;

    @Column(name = "GEO_SER_NO")
    private String serialNo;

    @Column(name = "GEO_GEO_NO")
    private String geoNo;
}
