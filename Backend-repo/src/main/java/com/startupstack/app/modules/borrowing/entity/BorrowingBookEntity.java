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
@Table(name = "IST_BK")
public class BorrowingBookEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ctid", insertable = false, updatable = false)
    private String rowId;

    @Column(name = "IAB_NO")
    private String borrowingNo;

    @Column(name = "IAB_SER")
    private Double serial;

    @Column(name = "IAB_BOOK")
    private String bookNo;
}
