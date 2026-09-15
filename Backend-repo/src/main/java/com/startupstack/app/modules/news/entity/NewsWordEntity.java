package com.startupstack.app.modules.news.entity;

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
@Table(name = "NEWS_WRD")
@IdClass(NewsWordEntityId.class)
public class NewsWordEntity {

    @Id
    @Column(name = "WRD_APP_NO", columnDefinition = "varchar(7)")
    private String wrdAppNo;

    @Id
    @Column(name = "WRD_WORD", columnDefinition = "varchar(12)")
    private String wrdWord;
}
