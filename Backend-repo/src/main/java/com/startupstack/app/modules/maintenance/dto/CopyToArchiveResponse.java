package com.startupstack.app.modules.maintenance.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CopyToArchiveResponse {

    private String sourcePath;
    private String destinationPath;

    public CopyToArchiveResponse() {
    }

    public CopyToArchiveResponse(String sourcePath, String destinationPath) {
        this.sourcePath = sourcePath;
        this.destinationPath = destinationPath;
    }
}
