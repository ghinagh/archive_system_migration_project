package com.startupstack.app.modules.books.service;

import com.startupstack.app.modules.books.dto.BookRequest;
import com.startupstack.app.modules.books.repository.BookRepository;
import com.startupstack.app.modules.catalogue.dto.CatalogueRequest;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.descriptors.dto.ResRequest;
import com.startupstack.app.modules.descriptors.dto.SubjectAnalysisRequest;
import com.startupstack.app.modules.descriptors.repository.ResRepository;
import com.startupstack.app.modules.descriptors.repository.SubjectAnalysisRepository;
import com.startupstack.app.shared.wordindex.WordIndexService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.context.ActiveProfiles;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

/**
 * Verifies that BookService.create() rolls back all saves — catalogue, book, and
 * author (RES) rows — when a downstream repository throws inside the same @Transactional
 * boundary.  Requires the "test" profile datasource (macnz_manar_test) to be running.
 */
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.NONE)
@ActiveProfiles("test")
class BookServiceIntegrationTest {

    private static final String TEST_APP_NO = "BK09999";

    @Autowired private BookService bookService;
    @Autowired private BookRepository bookRepository;
    @Autowired private ResRepository resRepository;
    @Autowired private CatalogueRepository catalogueRepository;

    @MockitoBean private SubjectAnalysisRepository subjectAnalysisRepository;
    @MockitoBean private WordIndexService wordIndexService;

    @AfterEach
    void cleanup() {
        resRepository.findByAppNo(TEST_APP_NO).forEach(r -> resRepository.deleteById(r.getId()));
        bookRepository.findById(TEST_APP_NO).ifPresent(bookRepository::delete);
        catalogueRepository.findById(TEST_APP_NO).ifPresent(catalogueRepository::delete);
    }

    @Test
    void create_whenSubjectSaveFails_rollsBackBookAndAuthors() {
        when(subjectAnalysisRepository.save(any())).thenThrow(new RuntimeException("Subject save failure"));

        CatalogueRequest catalogueRequest = new CatalogueRequest();
        catalogueRequest.setAppNo(TEST_APP_NO);
        catalogueRequest.setActiveTitleAr("كتاب اختبار تكاملي");

        ResRequest author1 = new ResRequest();
        ResRequest author2 = new ResRequest();

        SubjectAnalysisRequest subject1 = new SubjectAnalysisRequest();
        subject1.setDescriptorNo("S001");

        BookRequest request = new BookRequest();
        request.setMainData(catalogueRequest);
        request.setAuthors(List.of(author1, author2));
        request.setSubjects(List.of(subject1));
        request.setIsSeries(false);

        assertThrows(RuntimeException.class, () -> bookService.create(request));

        // Transaction rolled back: neither the book nor either author should be persisted
        assertTrue(bookRepository.findById(TEST_APP_NO).isEmpty(),
                "Book must not be persisted after transaction rollback");
        assertTrue(resRepository.findByAppNo(TEST_APP_NO).isEmpty(),
                "Author links (RES) must not be persisted after transaction rollback");
    }
}
