package com.startupstack.app.modules.borrowing.entity;

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
@Table(name = "IST_OTH")
public class BorrowingOtherEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ctid", insertable = false, updatable = false)
    private String rowId;

    @Column(name = "IAO_NO")
    private String borrowingNo;

    @Column(name = "IAO_SER")
    private Double serial;

    @Column(name = "IAO_TIT")
    private String title;

    @Column(name = "IAO_TYP")
    private Double type;

    @Column(name = "IAO_NB")
    private Double count;
}
