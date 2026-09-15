package com.startupstack.app.modules.books.service;

import com.startupstack.app.modules.books.dto.BookRequest;
import com.startupstack.app.modules.books.dto.BookResponse;
import com.startupstack.app.modules.books.dto.SeriesRequest;
import com.startupstack.app.modules.books.dto.SeriesResponse;
import com.startupstack.app.modules.books.entity.BookEntity;
import com.startupstack.app.modules.books.entity.SeriesEntity;
import com.startupstack.app.modules.books.mapper.BookMapper;
import com.startupstack.app.modules.books.repository.BookRepository;
import com.startupstack.app.modules.books.repository.SeriesRepository;
import com.startupstack.app.modules.books.specification.BookSpecification;
import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.catalogue.service.CatalogueService;
import com.startupstack.app.modules.descriptors.dto.ResRequest;
import com.startupstack.app.modules.descriptors.dto.SubjectAnalysisRequest;
import com.startupstack.app.modules.descriptors.entity.ResEntity;
import com.startupstack.app.modules.descriptors.entity.SubjectAnalysisEntity;
import com.startupstack.app.modules.descriptors.mapper.DescriptorMapper;
import com.startupstack.app.modules.descriptors.repository.ResRepository;
import com.startupstack.app.modules.descriptors.repository.SubjectAnalysisRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.util.SecurityUtils;
import com.startupstack.app.shared.wordindex.WordIndexService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class BookService {

    private final BookRepository bookRepository;
    private final CatalogueRepository catalogueRepository;
    private final CatalogueService catalogueService;
    private final SeriesRepository seriesRepository;
    private final BookMapper bookMapper;
    private final WordIndexService wordIndexService;
    private final ResRepository resRepository;
    private final SubjectAnalysisRepository subjectAnalysisRepository;
    private final DescriptorMapper descriptorMapper;

    public BookService(BookRepository bookRepository,
                       CatalogueRepository catalogueRepository,
                       CatalogueService catalogueService,
                       SeriesRepository seriesRepository,
                       BookMapper bookMapper,
                       WordIndexService wordIndexService,
                       ResRepository resRepository,
                       SubjectAnalysisRepository subjectAnalysisRepository,
                       DescriptorMapper descriptorMapper) {
        this.bookRepository = bookRepository;
        this.catalogueRepository = catalogueRepository;
        this.catalogueService = catalogueService;
        this.seriesRepository = seriesRepository;
        this.bookMapper = bookMapper;
        this.wordIndexService = wordIndexService;
        this.resRepository = resRepository;
        this.subjectAnalysisRepository = subjectAnalysisRepository;
        this.descriptorMapper = descriptorMapper;
    }

    @Transactional(readOnly = true)
    public Page<BookResponse> findAll(String title, String lang, String status, Pageable pageable) {
        boolean isAdmin = SecurityUtils.isAdmin();
        String userEnt = isAdmin ? null : SecurityUtils.getCurrentUserEnt();
        String userDoc = isAdmin ? null : SecurityUtils.getCurrentUserDoc();
        Specification<BookEntity> spec =
                BookSpecification.hasDocumentType(userDoc)
                        .and(BookSpecification.belongsToUserEntity(userEnt))
                        .and(BookSpecification.titleContains(title))
                        .and(BookSpecification.hasLang(lang))
                        .and(BookSpecification.hasStatus(status));
        return bookRepository.findAll(spec, pageable).map(bookMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public BookResponse findById(String appNo) {
        BookEntity book = bookRepository.findById(appNo)
                .orElseThrow(() -> new ResourceNotFoundException("Book not found: " + appNo));
        return bookMapper.toResponse(book);
    }

    @Transactional
    public BookResponse create(BookRequest request) {
        request.getMainData().setType("B");
        String appNo = request.getMainData().getAppNo();

        // "main" carries a FK to BOOK (MN_APP_NO -> BK_APP_NO), so the BOOK row must be inserted
        // first or the subsequent insert into "main" trips the FK constraint.
        BookEntity book = bookMapper.toEntity(request);
        book.setAppNo(appNo);
        BookEntity savedBook = bookRepository.save(book);

        CatalogueEntity catalogue = catalogueService.createMainRecord(request.getMainData());
        book.setCatalogue(catalogue);

        List<ResEntity> savedAuthors = new ArrayList<>();
        if (request.getAuthors() != null) {
            for (ResRequest authorReq : request.getAuthors()) {
                ResEntity res = descriptorMapper.toResEntity(authorReq);
                res.setAppNo(appNo);
                savedAuthors.add(resRepository.save(res));
            }
        }

        List<SubjectAnalysisEntity> savedSubjects = new ArrayList<>();
        if (request.getSubjects() != null) {
            for (SubjectAnalysisRequest subjectReq : request.getSubjects()) {
                SubjectAnalysisEntity analysis = descriptorMapper.toSubjectEntity(subjectReq);
                analysis.setAppNo(appNo);
                savedSubjects.add(subjectAnalysisRepository.save(analysis));
            }
        }

        SeriesEntity savedSeries = null;
        if (request.getSeries() != null) {
            SeriesEntity series = bookMapper.toSeriesEntity(request.getSeries());
            series.setAppNo(appNo);
            savedSeries = seriesRepository.save(series);
        }

        wordIndexService.indexText(appNo, catalogue.getActiveTitleAr(), "B");

        BookResponse response = bookMapper.toResponse(savedBook);
        response.setAuthors(descriptorMapper.toResResponseList(savedAuthors));
        response.setSubjects(descriptorMapper.toSubjectResponseList(savedSubjects));
        if (savedSeries != null) {
            response.setSeries(bookMapper.toSeriesResponse(savedSeries));
        }
        return response;
    }

    @Transactional
    public BookResponse update(String appNo, BookRequest request) {
        BookEntity book = bookRepository.findById(appNo)
                .orElseThrow(() -> new ResourceNotFoundException("Book not found: " + appNo));

        CatalogueEntity catalogue = catalogueRepository.findById(appNo)
                .orElseThrow(() -> new ResourceNotFoundException("Catalogue record not found: " + appNo));
        catalogue.setActiveTitleAr(request.getActiveTitleAr());
        catalogue.setAdditionalTitle(request.getAdditionalCatalogueTitle());
        catalogueRepository.save(catalogue);

        bookMapper.updateEntity(request, book);
        bookRepository.save(book);

        book.setCatalogue(catalogue);
        return bookMapper.toResponse(book);
    }

    @Transactional
    public void delete(String appNo) {
        if (!bookRepository.existsById(appNo)) {
            throw new ResourceNotFoundException("Book not found: " + appNo);
        }
        bookRepository.deleteById(appNo);
        catalogueRepository.deleteById(appNo);
    }

    @Transactional(readOnly = true)
    public SeriesResponse getSeries(String appNo) {
        validateBook(appNo);
        SeriesEntity series = seriesRepository.findById(appNo)
                .orElseThrow(() -> new ResourceNotFoundException("Series not found for book: " + appNo));
        return bookMapper.toSeriesResponse(series);
    }

    @Transactional
    public SeriesResponse createSeries(String appNo, SeriesRequest request) {
        validateBook(appNo);
        if (seriesRepository.existsById(appNo)) {
            throw new IllegalStateException("Series already exists for book: " + appNo + ". Use PUT to update.");
        }
        SeriesEntity entity = bookMapper.toSeriesEntity(request);
        entity.setAppNo(appNo);
        return bookMapper.toSeriesResponse(seriesRepository.save(entity));
    }

    @Transactional
    public SeriesResponse updateSeries(String appNo, SeriesRequest request) {
        validateBook(appNo);
        SeriesEntity entity = seriesRepository.findById(appNo)
                .orElseThrow(() -> new ResourceNotFoundException("Series not found for book: " + appNo));
        bookMapper.updateSeriesEntity(request, entity);
        return bookMapper.toSeriesResponse(seriesRepository.save(entity));
    }

    @Transactional
    public void deleteSeries(String appNo) {
        validateBook(appNo);
        if (!seriesRepository.existsById(appNo)) {
            throw new ResourceNotFoundException("Series not found for book: " + appNo);
        }
        seriesRepository.deleteById(appNo);
    }

    private void validateBook(String appNo) {
        if (!bookRepository.existsById(appNo)) {
            throw new ResourceNotFoundException("Book not found: " + appNo);
        }
    }
}
