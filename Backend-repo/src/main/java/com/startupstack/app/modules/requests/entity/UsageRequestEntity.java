package com.startupstack.app.modules.requests.entity;

import com.startupstack.app.shared.auditing.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * Log of material-usage / benefit request tickets — migrated from the legacy
 * VB6 {@code f_result.frm} screen. Tracks who requested access to archive
 * material, under what permit, for which call number (cote).
 */
@Getter
@Setter
@Entity
@Table(name = "usage_request")
public class UsageRequestEntity extends BaseEntity {

    @Column(name = "request_no", nullable = false, length = 20)
    private String requestNo;

    @Column(name = "digitization_type", length = 10)
    private String digitizationType;

    @Column(name = "digitization_no", length = 20)
    private String digitizationNo;

    @Column(name = "permit_no", length = 20)
    private String permitNo;

    @Column(name = "requester", nullable = false, length = 100)
    private String requester;

    @Column(name = "cote", length = 50)
    private String cote;

    @Column(name = "request_date", nullable = false)
    private LocalDateTime requestDate;

    @Column(name = "status", nullable = false, length = 20)
    private String status;
}
