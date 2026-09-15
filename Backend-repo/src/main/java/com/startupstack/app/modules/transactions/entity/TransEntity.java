package com.startupstack.app.modules.transactions.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "TRANS")
@IdClass(TransEntityId.class)
public class TransEntity {

    @Id
    @Column(name = "TRS_OPNO")
    private Double trsOpno;

    @Id
    @Column(name = "TRS_NO")
    private Double trsNo;

    @Column(name = "TRS_DTE")
    private LocalDateTime trsDte;

    @Column(name = "TRS_NUM", columnDefinition = "varchar(5)")
    private String trsNum;

    @Column(name = "TRS_NB")
    private Double trsNb;

    @Column(name = "TRS_YEAR")
    private Double trsYear;

    @Column(name = "TRS_TYP")
    private Double trsTyp;

    @Column(name = "TRS_DTE1")
    private LocalDateTime trsDte1;
}
