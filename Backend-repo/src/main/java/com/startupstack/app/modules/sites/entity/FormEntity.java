package com.startupstack.app.modules.sites.entity;

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
@Table(name = "form")
public class FormEntity {

    @Id
    @Column(name = "SUB_NO")
    private String formNo;

    @Column(name = "SUB_TYP")
    private String formType;

    @Column(name = "SUB_NAME")
    private String name;

    @Column(name = "SUB_DTE")
    private LocalDateTime date;

    @Column(name = "SUB_USER", columnDefinition = "char(3)")
    private String user;

    @Column(name = "SUB_SEC")
    private Integer section;

    @Column(name = "SUB_NOJIHAD")
    private Integer jihadNo;

    @Column(name = "SUB_NAME_PRINT", columnDefinition = "char(100)")
    private String printName;
}
