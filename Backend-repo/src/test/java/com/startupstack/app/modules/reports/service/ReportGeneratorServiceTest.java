package com.startupstack.app.modules.reports.service;

import com.startupstack.app.modules.authors.entity.AuthorEntity;
import com.startupstack.app.modules.authors.repository.AuthorRepository;
import com.startupstack.app.modules.books.repository.BookRepository;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.descriptors.entity.ResEntity;
import com.startupstack.app.modules.descriptors.repository.ResRepository;
import com.startupstack.app.modules.reports.repository.ReportTemplateRepository;
import com.startupstack.app.shared.exception.ReportGenerationException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anySet;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ReportGeneratorServiceTest {

    @Mock
    private BookRepository bookRepository;
    @Mock
    private CatalogueRepository catalogueRepository;
    @Mock
    private AuthorRepository authorRepository;
    @Mock
    private ResRepository resRepository;
    @Mock
    private ReportTemplateRepository reportTemplateRepository;
    @Mock
    private TemplateExecutionService templateExecutionService;
    @InjectMocks
    private ReportGeneratorService reportGeneratorService;

    @Test
    void generateReport_unknownType_throwsResourceNotFound() {
        assertThrows(ResourceNotFoundException.class,
                () -> reportGeneratorService.generateReport("no-such-report", Map.of()));
    }

    @Test
    void generateReport_generalNumberOutOfRange_throwsResourceNotFound() {
        assertThrows(ResourceNotFoundException.class,
                () -> reportGeneratorService.generateReport("general-14", Map.of()));
        verifyNoInteractions(reportTemplateRepository);
    }

    @Test
    void generateReport_generalNoTemplatesFound_throwsResourceNotFound() {
        when(reportTemplateRepository.findByOutputNumOrderByIdAsc(1.0)).thenReturn(List.of());

        assertThrows(ResourceNotFoundException.class,
                () -> reportGeneratorService.generateReport("general-1", Map.of()));
    }

    @Test
    void generateReport_dynamicWithoutTemplateNum_throwsResourceNotFound() {
        assertThrows(ResourceNotFoundException.class,
                () -> reportGeneratorService.generateReport("dynamic", Map.of()));
        verifyNoInteractions(templateExecutionService);
    }

    @Test
    void generateReport_resourceResult_producesPdfBytes() {
        ResEntity res = new ResEntity();
        res.setAppNo("MN000001");
        res.setResourceType("01");
        AuthorEntity author = new AuthorEntity();
        author.setAutNo(1.0);
        author.setAutName("ابن خلدون");
        res.setAuthor(author);
        when(resRepository.findAllWithAuthor()).thenReturn(List.of(res));
        when(catalogueRepository.findAllById(anySet())).thenReturn(List.of());

        byte[] pdf = reportGeneratorService.generateReport("resource-result", Map.of());

        assertNotNull(pdf);
        assertTrue(pdf.length > 0);
        assertEquals("%PDF", new String(pdf, 0, 4));
    }

    @Test
    void generateReport_bookCatalogue_producesPdfBytes() {
        when(bookRepository.findAllWithCatalogue()).thenReturn(List.of());

        byte[] pdf = reportGeneratorService.generateReport("book-catalogue", Map.of());

        assertNotNull(pdf);
        assertEquals("%PDF", new String(pdf, 0, 4));
    }

    @Test
    void generateReport_repositoryFailure_wrapsInReportGenerationException() {
        when(resRepository.findAllWithAuthor()).thenThrow(new RuntimeException("db unreachable"));

        assertThrows(ReportGenerationException.class,
                () -> reportGeneratorService.generateReport("resource-result", Map.of()));
    }
}
