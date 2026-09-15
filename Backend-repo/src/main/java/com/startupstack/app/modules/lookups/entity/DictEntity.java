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
@Table(name = "DICT")
@IdClass(DictEntityId.class)
public class DictEntity {

    @Id
    @Column(name = "SUB_CODE3", length = 9)
    private String subCode3;

    @Id
    @Column(name = "NUM")
    private Double num;

    @Column(name = "SUB_DESC3", length = 30)
    private String subDesc3;
}
