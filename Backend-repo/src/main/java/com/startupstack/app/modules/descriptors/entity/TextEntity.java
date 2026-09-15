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
@Table(name = "TEXT")
public class TextEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ctid", insertable = false, updatable = false)
    private String rowId;

    @Column(name = "TXT_APP_NO")
    private String appNo;

    @Column(name = "TXT_MEM")
    private String memo;

    @Column(name = "txt_ser")
    private Double serial;

    @Column(name = "txt_page")
    private Double page;
}
