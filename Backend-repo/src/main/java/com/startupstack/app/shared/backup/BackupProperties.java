package com.startupstack.app.shared.backup;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

@Data
@ConfigurationProperties(prefix = "app.backup")
public class BackupProperties {

    private String directory = "./backups";
    private String pgDumpPath = "pg_dump";
}
