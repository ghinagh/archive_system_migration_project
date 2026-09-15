package com.startupstack.app.modules.descriptors.entity;

import com.startupstack.app.modules.authors.entity.AuthorEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "RES")
public class ResEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AUTO")
    private Integer id;

    @Column(name = "RES_APP_NO", length = 7)
    private String appNo;

    @Column(name = "RES_APP_TY", length = 2)
    private String resourceType;

    @Column(name = "RES_RES_NO")
    private Double authorNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "RES_RES_NO", referencedColumnName = "AUT_NO", insertable = false, updatable = false)
    private AuthorEntity author;
}
