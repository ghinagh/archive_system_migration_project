package com.startupstack.app.modules.admin.entity;

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
@Table(name = "ranjpath")
public class RanjpathEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "rjp_no")
    private Integer rjpNo;

    @Column(name = "rjp_nofrom", columnDefinition = "char(10)")
    private String rjpNoFrom;

    @Column(name = "rjp_noto", columnDefinition = "char(10)")
    private String rjpNoTo;

    @Column(name = "rjp_path", columnDefinition = "char(200)")
    private String rjpPath;

    @Column(name = "rjp_typ")
    private Integer rjpTyp;
}
