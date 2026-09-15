package com.startupstack.app.modules.sites.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "POSITION")
public class PositionEntity {

    @Id
    @Column(name = "POS_NO")
    private String posNo;

    @Column(name = "POS_NAM")
    private String name;

    @Column(name = "DAT_REC")
    private LocalDateTime recordDate;
}
