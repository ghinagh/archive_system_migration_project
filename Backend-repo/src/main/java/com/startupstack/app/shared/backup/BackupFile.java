package com.startupstack.app.shared.backup;

import java.time.LocalDateTime;

public record BackupFile(String fileName, long sizeBytes, LocalDateTime createdAt) {
}
