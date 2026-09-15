package com.startupstack.app.modules.lookups.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "COTE_PUB")
public class CotePubEntity {

    @Id
    @Column(name = "CTP_NO")
    private Double ctpNo;

    @Column(name = "CTP_NAM", length = 40)
    private String ctpNam;
}
