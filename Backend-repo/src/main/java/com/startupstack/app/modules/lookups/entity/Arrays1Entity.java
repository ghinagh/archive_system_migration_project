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
@Table(name = "ARRAYS1")
@IdClass(Arrays1EntityId.class)
public class Arrays1Entity {

    @Id
    @Column(name = "ar_typ", length = 2)
    private String arTyp;

    @Id
    @Column(name = "ar_no")
    private Double arNo;

    @Column(name = "ar_desc", length = 30)
    private String arDesc;
}
