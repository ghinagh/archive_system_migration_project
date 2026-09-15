package com.startupstack.app.modules.admin.service;

import com.startupstack.app.modules.admin.dto.BackupResponse;
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
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AdminService {

    private final TempSchemaRepository tempSchemaRepository;
    private final RanjpathRepository ranjpathRepository;
    private final DatabaseBackupService databaseBackupService;

    public AdminService(TempSchemaRepository tempSchemaRepository,
                        RanjpathRepository ranjpathRepository,
                        DatabaseBackupService databaseBackupService) {
        this.tempSchemaRepository = tempSchemaRepository;
        this.ranjpathRepository = ranjpathRepository;
        this.databaseBackupService = databaseBackupService;
    }

    // --- Database backup ---

    public BackupResponse createBackup() {
        return toBackupResponse(databaseBackupService.createBackup());
    }

    public List<BackupResponse> listBackups() {
        return databaseBackupService.listBackups().stream()
                .map(this::toBackupResponse)
                .toList();
    }

    // --- Temp schema ---

    @Transactional(readOnly = true)
    public List<TempSchemaResponse> getAllTempSchema() {
        return tempSchemaRepository.findAll().stream()
                .map(this::toTempResponse)
                .toList();
    }

    @Transactional
    public TempSchemaResponse createTempSchema(TempSchemaRequest request) {
        TempSchemaEntity entity = new TempSchemaEntity();
        entity.setFieldName(request.fieldName());
        entity.setFieldType(request.fieldType());
        entity.setFieldLen(request.fieldLen());
        entity.setFieldDec(request.fieldDec());
        return toTempResponse(tempSchemaRepository.save(entity));
    }

    @Transactional
    public void deleteTempSchema(String fieldName) {
        if (!tempSchemaRepository.existsById(fieldName)) {
            throw new ResourceNotFoundException("Temp schema field not found: " + fieldName);
        }
        tempSchemaRepository.deleteById(fieldName);
    }

    // --- Media ranges (ranjpath) ---

    @Transactional(readOnly = true)
    public List<MediaRangeResponse> getAllMediaRanges() {
        return ranjpathRepository.findAll().stream()
                .map(this::toRangeResponse)
                .toList();
    }

    @Transactional
    public MediaRangeResponse createMediaRange(MediaRangeRequest request) {
        RanjpathEntity entity = new RanjpathEntity();
        entity.setRjpNoFrom(request.noFrom());
        entity.setRjpNoTo(request.noTo());
        entity.setRjpPath(request.path());
        entity.setRjpTyp(request.typ());
        return toRangeResponse(ranjpathRepository.save(entity));
    }

    @Transactional
    public MediaRangeResponse updateMediaRange(Integer id, MediaRangeRequest request) {
        RanjpathEntity entity = ranjpathRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Media range not found: " + id));
        entity.setRjpNoFrom(request.noFrom());
        entity.setRjpNoTo(request.noTo());
        entity.setRjpPath(request.path());
        entity.setRjpTyp(request.typ());
        return toRangeResponse(ranjpathRepository.save(entity));
    }

    @Transactional
    public void deleteMediaRange(Integer id) {
        if (!ranjpathRepository.existsById(id)) {
            throw new ResourceNotFoundException("Media range not found: " + id);
        }
        ranjpathRepository.deleteById(id);
    }

    private TempSchemaResponse toTempResponse(TempSchemaEntity entity) {
        TempSchemaResponse r = new TempSchemaResponse();
        r.setFieldName(entity.getFieldName());
        r.setFieldType(entity.getFieldType());
        r.setFieldLen(entity.getFieldLen());
        r.setFieldDec(entity.getFieldDec());
        return r;
    }

    private BackupResponse toBackupResponse(BackupFile file) {
        BackupResponse r = new BackupResponse();
        r.setFileName(file.fileName());
        r.setSizeBytes(file.sizeBytes());
        r.setCreatedAt(file.createdAt());
        return r;
    }

    private MediaRangeResponse toRangeResponse(RanjpathEntity entity) {
        MediaRangeResponse r = new MediaRangeResponse();
        r.setId(entity.getRjpNo());
        r.setNoFrom(entity.getRjpNoFrom());
        r.setNoTo(entity.getRjpNoTo());
        r.setPath(entity.getRjpPath());
        r.setTyp(entity.getRjpTyp());
        return r;
    }
}
