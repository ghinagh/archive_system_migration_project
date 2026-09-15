package com.startupstack.app.modules.corrections.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "correction_log")
public class CorrectionLogEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "app_no", nullable = false, length = 7)
    private String appNo;

    @Column(name = "corrected_at", nullable = false)
    private LocalDateTime correctedAt;

    @Column(name = "corrected_by_user", nullable = false, length = 30)
    private String correctedByUser;

    @Column(name = "field_name", nullable = false, length = 50)
    private String fieldName;

    @Column(name = "old_value", columnDefinition = "TEXT")
    private String oldValue;

    @Column(name = "new_value", columnDefinition = "TEXT")
    private String newValue;

    @Column(name = "correction_reason", columnDefinition = "TEXT")
    private String correctionReason;
}
