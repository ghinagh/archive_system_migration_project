package com.startupstack.app.modules.lookups.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "MACNZ")
public class MacnzEntity {

    @Id
    @Column(name = "SUB_CODE")
    private String subCode;

    @Column(name = "SUB_LEVEL")
    private String subLevel;

    @Column(name = "SUB_DESC")
    private String subDesc;

    @Column(name = "SUB_LOGIC")
    private Double subLogic;
}
