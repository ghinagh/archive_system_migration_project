package com.startupstack.app.shared.backup;

import com.startupstack.app.shared.exception.BusinessException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Comparator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
public class DatabaseBackupService {

    private static final Pattern JDBC_URL_PATTERN =
            Pattern.compile("jdbc:postgresql://([^:/]+):(\\d+)/([^?]+)");
    private static final DateTimeFormatter FILE_STAMP = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");

    private final BackupProperties properties;
    private final String datasourceUrl;
    private final String datasourceUsername;
    private final String datasourcePassword;

    public DatabaseBackupService(BackupProperties properties,
                                  @Value("${spring.datasource.url}") String datasourceUrl,
                                  @Value("${spring.datasource.username}") String datasourceUsername,
                                  @Value("${spring.datasource.password}") String datasourcePassword) {
        this.properties = properties;
        this.datasourceUrl = datasourceUrl;
        this.datasourceUsername = datasourceUsername;
        this.datasourcePassword = datasourcePassword;
    }

    /** Extracts host, port, and database name from a {@code jdbc:postgresql://host:port/db} URL. */
    static String[] parseJdbcUrl(String jdbcUrl) {
        Matcher matcher = JDBC_URL_PATTERN.matcher(jdbcUrl == null ? "" : jdbcUrl);
        if (!matcher.find()) {
            throw new BusinessException("Unsupported datasource URL for backup: " + jdbcUrl);
        }
        return new String[] { matcher.group(1), matcher.group(2), matcher.group(3) };
    }

    public BackupFile createBackup() {
        String[] parts = parseJdbcUrl(datasourceUrl);
        String host = parts[0];
        String port = parts[1];
        String dbName = parts[2];

        Path directory = Path.of(properties.getDirectory());
        try {
            Files.createDirectories(directory);
        } catch (IOException e) {
            throw new BusinessException("Could not create backup directory: " + e.getMessage());
        }

        String fileName = "macnz_manar_" + LocalDateTime.now().format(FILE_STAMP) + ".sql";
        Path destination = directory.resolve(fileName);

        ProcessBuilder builder = new ProcessBuilder(
                properties.getPgDumpPath(),
                "-h", host,
                "-p", port,
                "-U", datasourceUsername,
                "-F", "p",
                "-f", destination.toString(),
                dbName);
        builder.environment().put("PGPASSWORD", datasourcePassword);
        builder.redirectErrorStream(true);

        try {
            Process process = builder.start();
            String output = new String(process.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
            int exitCode = process.waitFor();
            if (exitCode != 0) {
                throw new BusinessException("pg_dump failed (exit " + exitCode + "): " + output.trim());
            }
        } catch (IOException e) {
            throw new BusinessException("Could not run pg_dump: " + e.getMessage());
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new BusinessException("Backup was interrupted");
        }

        return toBackupFile(destination);
    }

    public List<BackupFile> listBackups() {
        Path directory = Path.of(properties.getDirectory());
        if (!Files.isDirectory(directory)) {
            return List.of();
        }
        try (var stream = Files.list(directory)) {
            return stream
                    .filter(Files::isRegularFile)
                    .map(this::toBackupFile)
                    .sorted(Comparator.comparing(BackupFile::createdAt).reversed())
                    .collect(Collectors.toList());
        } catch (IOException e) {
            throw new BusinessException("Could not list backups: " + e.getMessage());
        }
    }

    private BackupFile toBackupFile(Path path) {
        try {
            long size = Files.size(path);
            LocalDateTime createdAt = java.time.Instant
                    .ofEpochMilli(Files.getLastModifiedTime(path).toMillis())
                    .atZone(java.time.ZoneId.systemDefault())
                    .toLocalDateTime();
            return new BackupFile(path.getFileName().toString(), size, createdAt);
        } catch (IOException e) {
            throw new BusinessException("Could not read backup file metadata: " + e.getMessage());
        }
    }
}
