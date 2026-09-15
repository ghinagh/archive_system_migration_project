package com.startupstack.app.modules.catalogue.entity;

import com.startupstack.app.modules.users.entity.UserEntity;
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
@Table(name = "tmp_fileadd")
@IdClass(TmpFileAddId.class)
public class TmpFileAddEntity {

    @Id
    @Column(name = "tmp_fad_no", length = 7)
    private String tmpFadNo;

    @Id
    @Column(name = "tmp_ser")
    private Double tmpSer;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tmp_fad_no", referencedColumnName = "MN_APP_NO",
            insertable = false, updatable = false)
    private CatalogueEntity catalogue;

    @Column(name = "tmp_file_name", length = 50)
    private String tmpFileName;

    @Column(name = "tmp_rmrk", length = 50)
    private String tmpRmrk;

    @Column(name = "tmp_mk", length = 30)
    private String tmpMk;

    @Column(name = "tmp_date")
    private LocalDateTime tmpDate;

    @Column(name = "tmp_user_no", columnDefinition = "char(3)")
    private String tmpUserNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tmp_user_no", referencedColumnName = "user_no",
            insertable = false, updatable = false)
    private UserEntity user;

    @Column(name = "tmp_final")
    private Integer tmpFinal;
}
