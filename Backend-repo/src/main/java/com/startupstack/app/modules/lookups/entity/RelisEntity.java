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
@Table(name = "RELIS")
@IdClass(RelisEntityId.class)
public class RelisEntity {

    @Id
    @Column(name = "SUB_CODE1", length = 9)
    private String subCode1;

    @Id
    @Column(name = "SUB_CODE2", length = 9)
    private String subCode2;

    @Column(name = "RELITION")
    private Double relition;
}
