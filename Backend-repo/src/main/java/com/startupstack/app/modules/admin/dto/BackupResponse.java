package com.startupstack.app.modules.admin.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class BackupResponse {

    private String fileName;
    private long sizeBytes;
    private LocalDateTime createdAt;
}
