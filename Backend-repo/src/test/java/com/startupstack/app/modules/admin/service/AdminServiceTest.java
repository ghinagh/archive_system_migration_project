package com.startupstack.app.modules.admin.service;

import com.startupstack.app.modules.admin.dto.MediaRangeRequest;
import com.startupstack.app.modules.admin.dto.MediaRangeResponse;
import com.startupstack.app.modules.admin.dto.TempSchemaRequest;
import com.startupstack.app.modules.admin.dto.TempSchemaResponse;
import com.startupstack.app.modules.admin.entity.RanjpathEntity;
import com.startupstack.app.modules.admin.entity.TempSchemaEntity;
import com.startupstack.app.modules.admin.repository.RanjpathRepository;
import com.startupstack.app.modules.admin.repository.TempSchemaRepository;
import com.startupstack.app.shared.backup.BackupFile;
import com.startupstack.app.shared.backup.DatabaseBackupService;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AdminServiceTest {

    @Mock
    private TempSchemaRepository tempSchemaRepository;
    @Mock
    private RanjpathRepository ranjpathRepository;
    @Mock
    private DatabaseBackupService databaseBackupService;
    @InjectMocks
    private AdminService adminService;

    private RanjpathEntity rangeEntity;
    private TempSchemaEntity tempEntity;

    @BeforeEach
    void setUp() {
        rangeEntity = new RanjpathEntity();
        rangeEntity.setRjpNo(1);
        rangeEntity.setRjpNoFrom("0000000001");
        rangeEntity.setRjpNoTo("0000000100");
        rangeEntity.setRjpPath("/media/1-100");
        rangeEntity.setRjpTyp(1);

        tempEntity = new TempSchemaEntity();
        tempEntity.setFieldName("F_TITLE");
        tempEntity.setFieldType("C");
        tempEntity.setFieldLen(50.0);
        tempEntity.setFieldDec(0.0);
    }

    @Test
    void createBackup_delegatesToBackupServiceAndMapsResponse() {
        BackupFile file = new BackupFile("macnz_manar_20260101_000000.sql", 1024L, LocalDateTime.now());
        when(databaseBackupService.createBackup()).thenReturn(file);

        var result = adminService.createBackup();

        assertEquals("macnz_manar_20260101_000000.sql", result.getFileName());
        assertEquals(1024L, result.getSizeBytes());
    }

    @Test
    void listBackups_mapsAllFiles() {
        BackupFile file = new BackupFile("dump.sql", 512L, LocalDateTime.now());
        when(databaseBackupService.listBackups()).thenReturn(List.of(file));

        List<?> result = adminService.listBackups();

        assertEquals(1, result.size());
    }

    @Test
    void getAllTempSchema_mapsAllEntities() {
        when(tempSchemaRepository.findAll()).thenReturn(List.of(tempEntity));

        List<TempSchemaResponse> result = adminService.getAllTempSchema();

        assertEquals(1, result.size());
        assertEquals("F_TITLE", result.get(0).getFieldName());
    }

    @Test
    void createTempSchema_savesAndReturnsResponse() {
        TempSchemaRequest request = new TempSchemaRequest("F_TITLE", "C", 50.0, 0.0);
        when(tempSchemaRepository.save(any(TempSchemaEntity.class))).thenReturn(tempEntity);

        TempSchemaResponse result = adminService.createTempSchema(request);

        assertEquals("F_TITLE", result.getFieldName());
        verify(tempSchemaRepository).save(any(TempSchemaEntity.class));
    }

    @Test
    void deleteTempSchema_existing_deletes() {
        when(tempSchemaRepository.existsById("F_TITLE")).thenReturn(true);

        adminService.deleteTempSchema("F_TITLE");

        verify(tempSchemaRepository).deleteById("F_TITLE");
    }

    @Test
    void deleteTempSchema_nonExistent_throwsResourceNotFound() {
        when(tempSchemaRepository.existsById("MISSING")).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> adminService.deleteTempSchema("MISSING"));
        verify(tempSchemaRepository, never()).deleteById(any());
    }

    @Test
    void getAllMediaRanges_mapsAllEntities() {
        when(ranjpathRepository.findAll()).thenReturn(List.of(rangeEntity));

        List<MediaRangeResponse> result = adminService.getAllMediaRanges();

        assertEquals(1, result.size());
        assertEquals("/media/1-100", result.get(0).getPath());
    }

    @Test
    void createMediaRange_savesAndReturnsResponse() {
        MediaRangeRequest request = new MediaRangeRequest("0000000001", "0000000100", "/media/1-100", 1);
        when(ranjpathRepository.save(any(RanjpathEntity.class))).thenReturn(rangeEntity);

        MediaRangeResponse result = adminService.createMediaRange(request);

        assertEquals("/media/1-100", result.getPath());
        verify(ranjpathRepository).save(any(RanjpathEntity.class));
    }

    @Test
    void updateMediaRange_existing_updatesAndReturnsResponse() {
        MediaRangeRequest request = new MediaRangeRequest("0000000001", "0000000200", "/media/1-200", 2);
        when(ranjpathRepository.findById(1)).thenReturn(Optional.of(rangeEntity));
        when(ranjpathRepository.save(any(RanjpathEntity.class))).thenReturn(rangeEntity);

        MediaRangeResponse result = adminService.updateMediaRange(1, request);

        assertNotNull(result);
        verify(ranjpathRepository).save(rangeEntity);
    }

    @Test
    void updateMediaRange_nonExistent_throwsResourceNotFound() {
        MediaRangeRequest request = new MediaRangeRequest("0000000001", "0000000200", "/media/1-200", 2);
        when(ranjpathRepository.findById(999)).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> adminService.updateMediaRange(999, request));
    }

    @Test
    void deleteMediaRange_existing_deletes() {
        when(ranjpathRepository.existsById(1)).thenReturn(true);

        adminService.deleteMediaRange(1);

        verify(ranjpathRepository).deleteById(1);
    }

    @Test
    void deleteMediaRange_nonExistent_throwsResourceNotFound() {
        when(ranjpathRepository.existsById(999)).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> adminService.deleteMediaRange(999));
        verify(ranjpathRepository, never()).deleteById(any());
    }
}
