package com.startupstack.app.modules.reports.entity;

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
@Table(name = "catogorie")
public class CategoryEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "auto")
    private Integer id;

    @Column(name = "cat_no", columnDefinition = "char(2)")
    private String categoryNo;

    @Column(name = "cat_num")
    private Integer outputNum;
}
