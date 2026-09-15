package com.startupstack.app.modules.videoorders.entity;

import com.startupstack.app.modules.archive.entity.ChartEntity;
import com.startupstack.app.shared.auditing.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "video_order")
public class VideoOrderEntity extends BaseEntity {

    @Column(name = "order_no", nullable = false, length = 20)
    private String orderNo;

    @Column(name = "stock_no", nullable = false, length = 6)
    private String stockNo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "chart_id")
    private ChartEntity chart;

    @Column(name = "description", length = 200)
    private String description;

    @Column(name = "requested_by", nullable = false, length = 30)
    private String requestedBy;

    @Column(name = "request_date", nullable = false)
    private LocalDateTime requestDate;

    @Column(name = "status", nullable = false, length = 20)
    private String status;
}
