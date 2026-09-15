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
@Table(name = "ANALIS")
public class SubjectAnalysisEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AUTO")
    private Integer id;

    @Column(name = "AN_APP_NO")
    private String appNo;

    @Column(name = "AN_DESC_NO")
    private String descriptorNo;

    @Column(name = "AN_SER_NO")
    private String serialNo;
}
