package com.startupstack.app.modules.sites.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * Maps to the legacy "form1" table. This is a secondary form-definition index
 * that shares the same SUB_TYP/SUB_NO key space as the primary "form" table but
 * omits the security-oriented columns (SUB_USER, SUB_SEC, SUB_NOJIHAD, SUB_NAME_PRINT).
 * In VB6 the two tables were queried interchangeably in different screens:
 *   - "form"  = full definition used in site-configuration and permission screens
 *   - "form1" = lightweight copy used for dropdown selection and print labelling
 * They share the same business key, so records with the same SUB_TYP+SUB_NO in
 * both tables describe the same form. A future cleanup pass could consolidate them.
 */
@Getter
@Setter
@Entity
@Table(name = "form1")
@IdClass(Form1Id.class)
public class Form1Entity {

    @Id
    @Column(name = "SUB_TYP", length = 2)
    private String formType;

    @Id
    @Column(name = "SUB_NO", length = 8)
    private String formNo;

    @Column(name = "SUB_NAME", length = 80)
    private String name;

    @Column(name = "sub_dte")
    private LocalDateTime date;
}
