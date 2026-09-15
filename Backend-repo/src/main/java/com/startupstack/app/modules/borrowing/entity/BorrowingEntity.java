package com.startupstack.app.modules.borrowing.entity;

import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.persons.entity.PersonEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "ISTARA")
@IdClass(BorrowingId.class)
public class BorrowingEntity {

    @Id
    @Column(name = "IAR_NO")
    private String iarNo;

    @Id
    @Column(name = "iar_serial")
    private Double serial;

    @Id
    @Column(name = "iar_ist_typ")
    private Double borrowingType;

    @Column(name = "IAR_DTE")
    private LocalDateTime borrowDate;

    @Column(name = "IAR_PRS", insertable = false, updatable = false)
    private String personNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "IAR_PRS", referencedColumnName = "PRS_NO")
    private PersonEntity person;

    @Column(name = "IAR_TYP")
    private Double type;

    @Column(name = "IAR_CAUSE")
    private String cause;

    @Column(name = "IAR_PERIOD")
    private Double period;

    @Column(name = "IAR_DTE1")
    private LocalDateTime dueDate;

    @Column(name = "IAR_DTE2")
    private LocalDateTime returnDate;

    @Column(name = "IAR_RMK")
    private String remark;

    @Column(name = "IAR_TYP1")
    private Double type1;

    @Column(name = "iar_book", insertable = false, updatable = false)
    private String bookNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "iar_book", referencedColumnName = "MN_APP_NO")
    private CatalogueEntity catalogue;

    @Column(name = "iar_ent")
    private String entity;

    @Column(name = "iar_reg_no")
    private Double regNo;

    @Column(name = "iar_tamin")
    private Double deposit;
}
