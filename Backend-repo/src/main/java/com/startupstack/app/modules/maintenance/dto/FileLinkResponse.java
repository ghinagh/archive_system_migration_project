package com.startupstack.app.modules.maintenance.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
public class FileLinkResponse {

    private UUID id;
    private String appNo;
    private String filePath;
    private String linkedByUser;
    private LocalDateTime linkedAt;
}
