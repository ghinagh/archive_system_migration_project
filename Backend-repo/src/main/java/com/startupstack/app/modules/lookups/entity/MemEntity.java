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
@Table(name = "MEM")
@IdClass(MemEntityId.class)
public class MemEntity {

    @Id
    @Column(name = "SUB_CODE4", length = 9)
    private String subCode4;

    @Id
    @Column(name = "NUMBER")
    private Double number;

    @Column(name = "SUB_DESC4", length = 30)
    private String subDesc4;
}
