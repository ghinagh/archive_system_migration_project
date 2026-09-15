package com.startupstack.app.modules.authors.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "AUTHER")
public class AuthorEntity {

    @Id
    @Column(name = "AUT_NO")
    private Double autNo;

    @Column(name = "AUT_TYP")
    private String autType;

    @Column(name = "AUT_NAM")
    private String autName;

    @Column(name = "aut_sub_no", columnDefinition = "char(10)")
    private String subjectNo;
}
