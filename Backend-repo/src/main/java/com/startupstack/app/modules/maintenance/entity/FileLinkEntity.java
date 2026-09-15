package com.startupstack.app.modules.maintenance.entity;

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

/**
 * Links an arbitrary file path to a catalogue record ({@code main.MN_APP_NO}).
 * Table created by {@code V4__video_orders_usage_requests_file_links.sql}.
 *
 * Not extended from {@link com.startupstack.app.shared.auditing.BaseEntity} because this
 * table has its own explicit {@code linked_at} column rather than {@code created_at}/{@code updated_at}.
 */
@Getter
@Setter
@Entity
@Table(name = "file_link")
public class FileLinkEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "app_no", nullable = false, length = 7)
    private String appNo;

    @Column(name = "file_path", nullable = false, length = 255)
    private String filePath;

    @Column(name = "linked_by_user", nullable = false, length = 30)
    private String linkedByUser;

    @Column(name = "linked_at", nullable = false)
    private LocalDateTime linkedAt;
}
