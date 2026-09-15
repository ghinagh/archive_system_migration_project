package com.startupstack.app.config;

import com.startupstack.app.shared.backup.BackupProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableConfigurationProperties(BackupProperties.class)
public class BackupConfig {}
