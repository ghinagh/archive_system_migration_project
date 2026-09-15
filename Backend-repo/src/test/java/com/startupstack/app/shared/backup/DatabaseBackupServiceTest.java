package com.startupstack.app.shared.backup;

import com.startupstack.app.shared.exception.BusinessException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class DatabaseBackupServiceTest {

    @TempDir
    Path tempDir;

    private BackupProperties properties;
    private DatabaseBackupService service;

    @BeforeEach
    void setUp() {
        properties = new BackupProperties();
        properties.setDirectory(tempDir.toString());
        service = new DatabaseBackupService(properties,
                "jdbc:postgresql://localhost:5432/macnz_manar", "postgres", "postgres");
    }

    @Test
    void parseJdbcUrl_extractsHostPortAndDatabase() {
        String[] parts = DatabaseBackupService.parseJdbcUrl("jdbc:postgresql://db-host:5433/macnz_manar");

        assertArrayEquals(new String[] { "db-host", "5433", "macnz_manar" }, parts);
    }

    @Test
    void parseJdbcUrl_withQueryParams_stripsThem() {
        String[] parts = DatabaseBackupService.parseJdbcUrl("jdbc:postgresql://localhost:5432/macnz_manar?sslmode=require");

        assertEquals("macnz_manar", parts[2]);
    }

    @Test
    void parseJdbcUrl_withUnsupportedUrl_throwsBusinessException() {
        assertThrows(BusinessException.class, () -> DatabaseBackupService.parseJdbcUrl("jdbc:mysql://localhost:3306/x"));
    }

    @Test
    void listBackups_withEmptyDirectory_returnsEmptyList() {
        List<BackupFile> backups = service.listBackups();

        assertTrue(backups.isEmpty());
    }

    @Test
    void listBackups_returnsExistingFilesNewestFirst() throws IOException, InterruptedException {
        Path older = tempDir.resolve("macnz_manar_20260101_000000.sql");
        Files.writeString(older, "-- older dump");
        Thread.sleep(10);
        Path newer = tempDir.resolve("macnz_manar_20260102_000000.sql");
        Files.writeString(newer, "-- newer dump");

        List<BackupFile> backups = service.listBackups();

        assertEquals(2, backups.size());
        assertEquals("macnz_manar_20260102_000000.sql", backups.get(0).fileName());
        assertEquals("macnz_manar_20260101_000000.sql", backups.get(1).fileName());
    }

    @Test
    void listBackups_whenDirectoryMissing_returnsEmptyList() {
        properties.setDirectory(tempDir.resolve("does-not-exist").toString());

        assertTrue(service.listBackups().isEmpty());
    }
}
