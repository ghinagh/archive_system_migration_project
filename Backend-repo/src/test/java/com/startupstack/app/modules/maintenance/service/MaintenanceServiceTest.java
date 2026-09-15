package com.startupstack.app.modules.maintenance.service;

import com.startupstack.app.modules.articles.repository.ArticleRepository;
import com.startupstack.app.modules.books.repository.BookRepository;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.corrections.repository.CorrectionLogRepository;
import com.startupstack.app.modules.maintenance.dto.CopyToArchiveRequest;
import com.startupstack.app.modules.maintenance.dto.CopyToArchiveResponse;
import com.startupstack.app.modules.maintenance.dto.FileLinkRequest;
import com.startupstack.app.modules.maintenance.dto.FileLinkResponse;
import com.startupstack.app.modules.maintenance.dto.RenumberRequest;
import com.startupstack.app.modules.maintenance.entity.FileLinkEntity;
import com.startupstack.app.modules.maintenance.repository.FileLinkRepository;
import com.startupstack.app.modules.news.repository.NewsRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.media.MediaService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class MaintenanceServiceTest {

    @Mock private CatalogueRepository catalogueRepository;
    @Mock private BookRepository bookRepository;
    @Mock private ArticleRepository articleRepository;
    @Mock private NewsRepository newsRepository;
    @Mock private CorrectionLogRepository correctionLogRepository;
    @Mock private FileLinkRepository fileLinkRepository;
    @Mock private MediaService mediaService;

    @InjectMocks
    private MaintenanceService maintenanceService;

    // --- renumberAppNo ---

    @Test
    void renumberAppNo_success_updatesMainAndDetailTablesAndCorrectionLog() {
        RenumberRequest request = new RenumberRequest("APP0001", "APP0002");

        when(catalogueRepository.existsById("APP0001")).thenReturn(true);
        when(catalogueRepository.existsById("APP0002")).thenReturn(false);
        when(bookRepository.existsById("APP0001")).thenReturn(true);
        when(articleRepository.existsById("APP0001")).thenReturn(false);
        when(newsRepository.existsById("APP0001")).thenReturn(false);

        maintenanceService.renumberAppNo(request);

        verify(catalogueRepository).renumberAppNo("APP0001", "APP0002");
        verify(bookRepository).renumberAppNo("APP0001", "APP0002");
        verify(articleRepository, never()).renumberAppNo(any(), any());
        verify(newsRepository, never()).renumberAppNo(any(), any());
        verify(correctionLogRepository).renumberAppNo("APP0001", "APP0002");
    }

    @Test
    void renumberAppNo_whenNewAppNoAlreadyExists_throwsBusinessException() {
        RenumberRequest request = new RenumberRequest("APP0001", "APP0002");

        when(catalogueRepository.existsById("APP0001")).thenReturn(true);
        when(catalogueRepository.existsById("APP0002")).thenReturn(true);

        assertThrows(BusinessException.class, () -> maintenanceService.renumberAppNo(request));

        verify(catalogueRepository, never()).renumberAppNo(any(), any());
        verify(correctionLogRepository, never()).renumberAppNo(any(), any());
    }

    @Test
    void renumberAppNo_whenOldAppNoMissing_throwsResourceNotFoundException() {
        RenumberRequest request = new RenumberRequest("NOPE", "APP0002");

        when(catalogueRepository.existsById("NOPE")).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> maintenanceService.renumberAppNo(request));

        verify(catalogueRepository, never()).renumberAppNo(any(), any());
    }

    // --- copyToArchive ---

    @Test
    void copyToArchive_success_returnsSourceAndDestinationPaths() {
        CopyToArchiveRequest request = new CopyToArchiveRequest("123456");

        when(mediaService.copyToArchive("123456")).thenReturn("/data/archive/123456");
        when(mediaService.resolveStockPath("123456")).thenReturn("/media/vol1/123456");

        CopyToArchiveResponse response = maintenanceService.copyToArchive(request);

        assertEquals("/media/vol1/123456", response.getSourcePath());
        assertEquals("/data/archive/123456", response.getDestinationPath());
    }

    @Test
    void copyToArchive_whenSourceMissing_throwsBusinessException() {
        CopyToArchiveRequest request = new CopyToArchiveRequest("999999");

        when(mediaService.copyToArchive("999999"))
                .thenThrow(new BusinessException("Source file not found for stock number: 999999"));

        assertThrows(BusinessException.class, () -> maintenanceService.copyToArchive(request));
    }

    // --- linkFile ---

    @Test
    void linkFile_success_savesLinkWithCurrentUserAndTimestamp() {
        FileLinkRequest request = new FileLinkRequest("APP0001", "/scans/doc1.pdf");

        when(catalogueRepository.existsById("APP0001")).thenReturn(true);
        when(fileLinkRepository.save(any(FileLinkEntity.class))).thenAnswer(invocation -> {
            FileLinkEntity entity = invocation.getArgument(0);
            entity.setId(UUID.randomUUID());
            return entity;
        });

        FileLinkResponse response = maintenanceService.linkFile(request);

        assertEquals("APP0001", response.getAppNo());
        assertEquals("/scans/doc1.pdf", response.getFilePath());
        assertNotNull(response.getLinkedByUser());
        assertNotNull(response.getLinkedAt());

        ArgumentCaptor<FileLinkEntity> captor = ArgumentCaptor.forClass(FileLinkEntity.class);
        verify(fileLinkRepository).save(captor.capture());
        assertEquals("APP0001", captor.getValue().getAppNo());
    }

    @Test
    void linkFile_whenAppNoMissing_throwsResourceNotFoundException() {
        FileLinkRequest request = new FileLinkRequest("NOPE", "/scans/doc1.pdf");

        when(catalogueRepository.existsById("NOPE")).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> maintenanceService.linkFile(request));

        verify(fileLinkRepository, never()).save(any());
    }

    // --- getLinksForAppNo ---

    @Test
    void getLinksForAppNo_returnsMappedResponses() {
        FileLinkEntity entity = new FileLinkEntity();
        entity.setId(UUID.randomUUID());
        entity.setAppNo("APP0001");
        entity.setFilePath("/scans/doc1.pdf");
        entity.setLinkedByUser("admin");

        when(fileLinkRepository.findByAppNo("APP0001")).thenReturn(List.of(entity));

        List<FileLinkResponse> responses = maintenanceService.getLinksForAppNo("APP0001");

        assertEquals(1, responses.size());
        assertEquals("APP0001", responses.get(0).getAppNo());
    }

    // --- deleteLink ---

    @Test
    void deleteLink_success_deletesById() {
        UUID id = UUID.randomUUID();
        when(fileLinkRepository.existsById(id)).thenReturn(true);

        maintenanceService.deleteLink(id);

        verify(fileLinkRepository).deleteById(id);
    }

    @Test
    void deleteLink_whenMissing_throwsResourceNotFoundException() {
        UUID id = UUID.randomUUID();
        when(fileLinkRepository.existsById(id)).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> maintenanceService.deleteLink(id));

        verify(fileLinkRepository, never()).deleteById(any(UUID.class));
    }
}
