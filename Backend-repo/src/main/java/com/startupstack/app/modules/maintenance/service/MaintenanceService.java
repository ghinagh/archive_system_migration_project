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
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Admin-only data-maintenance utilities migrated from the legacy VB6
 * {@code correct.frm} / {@code corect1.frm} screens (never wired to a menu
 * in the legacy app, but requested by the client as a proper admin utility).
 */
@Service
public class MaintenanceService {

    private final CatalogueRepository catalogueRepository;
    private final BookRepository bookRepository;
    private final ArticleRepository articleRepository;
    private final NewsRepository newsRepository;
    private final CorrectionLogRepository correctionLogRepository;
    private final FileLinkRepository fileLinkRepository;
    private final MediaService mediaService;

    public MaintenanceService(CatalogueRepository catalogueRepository,
                               BookRepository bookRepository,
                               ArticleRepository articleRepository,
                               NewsRepository newsRepository,
                               CorrectionLogRepository correctionLogRepository,
                               FileLinkRepository fileLinkRepository,
                               MediaService mediaService) {
        this.catalogueRepository = catalogueRepository;
        this.bookRepository = bookRepository;
        this.articleRepository = articleRepository;
        this.newsRepository = newsRepository;
        this.correctionLogRepository = correctionLogRepository;
        this.fileLinkRepository = fileLinkRepository;
        this.mediaService = mediaService;
    }

    // --- 1. Renumber a catalogue record's app number ---

    /**
     * Renumbers {@code oldAppNo} to {@code newAppNo} across {@code main} and whichever
     * of BOOK / ARTICLE / NEWS holds a matching detail row, plus historical
     * {@code correction_log} entries, all inside a single transaction.
     *
     * <p>Each repository's {@code renumberAppNo} is a bulk JPQL {@code UPDATE}
     * (see {@link CatalogueRepository#renumberAppNo}), which is what makes this safe:
     * a bulk update never loads the row into the persistence context, so there is no
     * managed entity whose {@code @Id} could be mutated and re-inserted as a duplicate.
     */
    @Transactional
    public void renumberAppNo(RenumberRequest request) {
        String oldAppNo = request.oldAppNo();
        String newAppNo = request.newAppNo();

        if (!catalogueRepository.existsById(oldAppNo)) {
            throw new ResourceNotFoundException("Catalogue record not found: " + oldAppNo);
        }
        if (catalogueRepository.existsById(newAppNo)) {
            throw new BusinessException("A catalogue record already exists with app number: " + newAppNo);
        }

        catalogueRepository.renumberAppNo(oldAppNo, newAppNo);

        if (bookRepository.existsById(oldAppNo)) {
            bookRepository.renumberAppNo(oldAppNo, newAppNo);
        }
        if (articleRepository.existsById(oldAppNo)) {
            articleRepository.renumberAppNo(oldAppNo, newAppNo);
        }
        if (newsRepository.existsById(oldAppNo)) {
            newsRepository.renumberAppNo(oldAppNo, newAppNo);
        }

        correctionLogRepository.renumberAppNo(oldAppNo, newAppNo);
    }

    // --- 2. Copy a media file into the archive ---

    @Transactional(readOnly = true)
    public CopyToArchiveResponse copyToArchive(CopyToArchiveRequest request) {
        String destination = mediaService.copyToArchive(request.stockNo());
        String source = mediaService.resolveStockPath(request.stockNo());
        return new CopyToArchiveResponse(source, destination);
    }

    // --- 3. Link a file to a catalogue record ---

    @Transactional
    public FileLinkResponse linkFile(FileLinkRequest request) {
        if (!catalogueRepository.existsById(request.appNo())) {
            throw new ResourceNotFoundException("Catalogue record not found: " + request.appNo());
        }

        FileLinkEntity entity = new FileLinkEntity();
        entity.setAppNo(request.appNo());
        entity.setFilePath(request.filePath());
        entity.setLinkedByUser(Optional.ofNullable(SecurityUtils.getCurrentUsername()).orElse("system"));
        entity.setLinkedAt(LocalDateTime.now());

        return toResponse(fileLinkRepository.save(entity));
    }

    @Transactional(readOnly = true)
    public List<FileLinkResponse> getLinksForAppNo(String appNo) {
        return fileLinkRepository.findByAppNo(appNo).stream()
                .map(this::toResponse)
                .toList();
    }

    @Transactional
    public void deleteLink(UUID id) {
        if (!fileLinkRepository.existsById(id)) {
            throw new ResourceNotFoundException("File link not found: " + id);
        }
        fileLinkRepository.deleteById(id);
    }

    private FileLinkResponse toResponse(FileLinkEntity entity) {
        FileLinkResponse r = new FileLinkResponse();
        r.setId(entity.getId());
        r.setAppNo(entity.getAppNo());
        r.setFilePath(entity.getFilePath());
        r.setLinkedByUser(entity.getLinkedByUser());
        r.setLinkedAt(entity.getLinkedAt());
        return r;
    }
}
