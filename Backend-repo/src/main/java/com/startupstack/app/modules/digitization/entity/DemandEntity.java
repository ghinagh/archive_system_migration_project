package com.startupstack.app.modules.digitization.entity;

import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.users.entity.UserEntity;
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

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "demand")
public class DemandEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "auto")
    private Integer id;

    @Column(name = "dmd_no", columnDefinition = "char(7)", nullable = false)
    private String demandNo;

    @Column(name = "dmd_ser", nullable = false)
    private Integer serial;

    @Column(name = "dmd_user", insertable = false, updatable = false, columnDefinition = "char(3)")
    private String userNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dmd_user", referencedColumnName = "user_no")
    private UserEntity user;

    @Column(name = "dmd_dte")
    private LocalDateTime date;

    @Column(name = "dmd_in")
    private BigDecimal inputSize;

    @Column(name = "dmd_out")
    private BigDecimal outputSize;

    @Column(name = "dmd_path", columnDefinition = "char(100)")
    private String path;

    @Column(name = "dmd_time")
    private BigDecimal time;

    @Column(name = "dmd_mch_no", insertable = false, updatable = false, columnDefinition = "char(7)")
    private String machineNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dmd_mch_no", referencedColumnName = "MN_APP_NO")
    private CatalogueEntity catalogue;

    @Column(name = "dmd_desc", columnDefinition = "char(100)")
    private String description;

    @Column(name = "dmd_chek")
    private Integer checked;

    @Column(name = "dmd_mch_stock", columnDefinition = "char(6)")
    private String machineStock;

    @Column(name = "dmd_s")
    private Integer seconds;

    @Column(name = "dmd_m")
    private Integer minutes;

    @Column(name = "dmd_o")
    private Integer hours;

    @Column(name = "dmd_f")
    private Integer frames;

    @Column(name = "dmd_cote", columnDefinition = "char(50)")
    private String cote;

    @Column(name = "dmd_time1", columnDefinition = "char(12)")
    private String time1;

    @Column(name = "dmd_chek1")
    private Boolean checked1;

    /**
     * Who executed the delivery — legacy {@code upd_dmd_user_do}, written by Command5
     * alongside {@code dmd_chek = 2}. Distinct from {@link #userNo}, who requested the scene.
     */
    @Column(name = "dmd_user_do", columnDefinition = "char(3)")
    private String executedByUserNo;
}
