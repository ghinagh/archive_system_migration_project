package com.startupstack.app.modules.books.service;

import com.startupstack.app.modules.books.dto.BookRequest;
import com.startupstack.app.modules.books.dto.BookResponse;
import com.startupstack.app.modules.books.entity.BookEntity;
import com.startupstack.app.modules.books.mapper.BookMapper;
import com.startupstack.app.modules.books.repository.BookRepository;
import com.startupstack.app.modules.books.repository.SeriesRepository;
import com.startupstack.app.modules.catalogue.dto.CatalogueRequest;
import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.catalogue.service.CatalogueService;
import com.startupstack.app.modules.descriptors.mapper.DescriptorMapper;
import com.startupstack.app.modules.descriptors.repository.ResRepository;
import com.startupstack.app.modules.descriptors.repository.SubjectAnalysisRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.wordindex.WordIndexService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class BookServiceTest {

    @Mock private BookRepository bookRepository;
    @Mock private CatalogueRepository catalogueRepository;
    @Mock private CatalogueService catalogueService;
    @Mock private SeriesRepository seriesRepository;
    @Mock private BookMapper bookMapper;
    @Mock private WordIndexService wordIndexService;
    @Mock private ResRepository resRepository;
    @Mock private SubjectAnalysisRepository subjectAnalysisRepository;
    @Mock private DescriptorMapper descriptorMapper;
    @InjectMocks private BookService bookService;

    @Test
    void create_savesParentCatalogueWithTypeB_thenSavesBook() {
        CatalogueRequest catalogueRequest = new CatalogueRequest();
        catalogueRequest.setAppNo("BK00001");
        catalogueRequest.setActiveTitleAr("كتاب اختبار");

        BookRequest request = new BookRequest();
        request.setMainData(catalogueRequest);
        request.setIsSeries(false);

        CatalogueEntity catalogueEntity = new CatalogueEntity();
        catalogueEntity.setAppNo("BK00001");
        catalogueEntity.setActiveTitleAr("كتاب اختبار");

        BookEntity bookEntity = new BookEntity();
        bookEntity.setAppNo("BK00001");

        BookResponse response = new BookResponse();
        response.setAppNo("BK00001");

        when(catalogueService.createMainRecord(any())).thenReturn(catalogueEntity);
        when(bookMapper.toEntity(request)).thenReturn(bookEntity);
        when(bookRepository.save(bookEntity)).thenReturn(bookEntity);
        when(bookMapper.toResponse(bookEntity)).thenReturn(response);
        when(descriptorMapper.toResResponseList(any())).thenReturn(List.of());
        when(descriptorMapper.toSubjectResponseList(any())).thenReturn(List.of());

        bookService.create(request);

        ArgumentCaptor<CatalogueRequest> captor = ArgumentCaptor.forClass(CatalogueRequest.class);
        verify(catalogueService).createMainRecord(captor.capture());
        assertEquals("B", captor.getValue().getType());
        assertEquals("BK00001", captor.getValue().getAppNo());
        assertEquals("كتاب اختبار", captor.getValue().getActiveTitleAr());
        verify(bookRepository).save(bookEntity);
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        when(bookRepository.findById("NONE")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> bookService.findById("NONE"));
    }

    @Test
    void delete_removesBookThenCatalogue() {
        when(bookRepository.existsById("BK00001")).thenReturn(true);

        bookService.delete("BK00001");

        verify(bookRepository).deleteById("BK00001");
        verify(catalogueRepository).deleteById("BK00001");
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(bookRepository.existsById("NONE")).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> bookService.delete("NONE"));
    }
}
