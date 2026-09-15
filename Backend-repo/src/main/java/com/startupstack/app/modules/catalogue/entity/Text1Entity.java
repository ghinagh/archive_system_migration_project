package com.startupstack.app.modules.catalogue.entity;

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

@Getter
@Setter
@Entity
@Table(name = "text1")
@IdClass(Text1Id.class)
public class Text1Entity {

    @Id
    @Column(name = "txt_no", length = 7)
    private String txtNo;

    @Id
    @Column(name = "txt_ser_no", length = 2)
    private String txtSerNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "txt_no", referencedColumnName = "MN_APP_NO", insertable = false, updatable = false)
    private CatalogueEntity catalogue;

    @Column(name = "txt_desc_n", length = 9)
    private String txtDescN;

    @Column(name = "txt_rltv_n", length = 2)
    private String txtRltvN;

    @Column(name = "txt_rltv_typ", length = 1)
    private String txtRltvTyp;

    @Column(name = "txt_text", length = 4000)
    private String txtText;

    @Column(name = "txt_nbpage")
    private Integer txtNbpage;
}
