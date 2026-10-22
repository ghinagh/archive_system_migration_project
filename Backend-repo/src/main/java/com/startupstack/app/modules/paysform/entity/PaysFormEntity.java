package com.startupstack.app.modules.paysform.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Immutable;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Immutable   // legacy view: form rows with SUB_TYP '04' and SUB_NO ending '00000' (V36)
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
