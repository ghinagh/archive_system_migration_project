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
@Table(name = "CODING")
@IdClass(CodingEntityId.class)
public class CodingEntity {

    @Id
    @Column(name = "SUB_LEVE")
    private String subLeve;

    @Id
    @Column(name = "SUB_CODE")
    private String subCode;

    @Column(name = "SUB_DESC")
    private String subDesc;
}
