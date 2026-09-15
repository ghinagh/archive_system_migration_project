package com.startupstack.app.modules.lookups.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "ARRAYS")
@IdClass(ArraysEntityId.class)
public class ArraysEntity {

    @Id
    @Column(name = "AR_TYP", columnDefinition = "char(2)")
    private String arTyp;

    @Id
    @Column(name = "AR_CODE")
    private Double arCode;

    @Column(name = "AR_DESC")
    private String arDesc;

    @Column(name = "AR_LEVEL")
    private String arLevel;
}
