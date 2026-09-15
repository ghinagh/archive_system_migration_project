package com.startupstack.app.modules.books.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "SERIES")
public class SeriesEntity {

    @Id
    @Column(name = "SER_APP_NO", length = 7)
    private String appNo;

    @Column(name = "SER_AC_TTL", length = 40)
    private String arabicSeriesTitle;

    @Column(name = "SER_AD_TTL", length = 40)
    private String additionalTitle;

    @Column(name = "SER_ACT_NO")
    private Double activeNo;

    @Column(name = "SER_ADD_NO")
    private Double additionalNo;
}
