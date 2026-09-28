package com.startupstack.app.modules.paysform.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "pays_form")
public class PaysFormEntity {

    @Id
    @Column(name = "SUB_NO")
    private String formNo;

    @Column(name = "SUB_TYP")
    private String formType;

    @Column(name = "SUB_NAME")
    private String name;

    @Column(name = "SUB_DTE")
    private LocalDateTime date;
}
