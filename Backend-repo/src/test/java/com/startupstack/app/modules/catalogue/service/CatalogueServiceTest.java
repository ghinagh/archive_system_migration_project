package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.CatalogueRequest;
import com.startupstack.app.modules.catalogue.dto.CatalogueResponse;
import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.catalogue.mapper.CatalogueMapper;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.corrections.service.CorrectionLogService;
import com.startupstack.app.modules.retrievalfields.service.RetrievalFieldService;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.wordindex.WordIndexService;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Path;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.Root;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class CatalogueServiceTest {

    @Mock
    private CatalogueRepository catalogueRepository;
    @Mock
    private CatalogueMapper catalogueMapper;
    @Mock
    private UserRepository userRepository;
    @Mock
    private WordIndexService wordIndexService;
    @Mock
    private CorrectionLogService correctionLogService;
    @Mock
    private RetrievalFieldService retrievalFieldService;
    @InjectMocks
    private CatalogueService catalogueService;

    private CatalogueEntity testEntity;
    private CatalogueResponse testResponse;

    @AfterEach
    void tearDown() {
        RequestContextHolder.resetRequestAttributes();
    }

    @BeforeEach
    void setUp() {
        testEntity = new CatalogueEntity();
        testEntity.setAppNo("0000001");
        testEntity.setActiveTitleAr("عنوان الكتاب");
        testEntity.setType("B");
        testEntity.setEntryDate(LocalDateTime.now());

        testResponse = new CatalogueResponse();
        testResponse.setAppNo("0000001");
        testResponse.setActiveTitleAr("عنوان الكتاب");
        testResponse.setType("B");
    }

    @Test
    void findById_existingRecord_returnsResponse() {
        when(catalogueRepository.findById("0000001")).thenReturn(Optional.of(testEntity));
        when(catalogueMapper.toResponse(testEntity)).thenReturn(testResponse);

        CatalogueResponse result = catalogueService.findById("0000001");

        assertEquals("0000001", result.getAppNo());
        assertEquals("عنوان الكتاب", result.getActiveTitleAr());
    }

    @Test
    void findById_nonExistentRecord_throwsResourceNotFound() {
        when(catalogueRepository.findById("9999999")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> catalogueService.findById("9999999"));
    }

    @Test
    void create_validRequest_savesAndReturns() {
        CatalogueRequest request = new CatalogueRequest();
        request.setAppNo("0000002");
        request.setActiveTitleAr("عنوان جديد");
        request.setType("A");

        when(catalogueMapper.toEntity(request)).thenReturn(testEntity);
        when(catalogueRepository.save(testEntity)).thenReturn(testEntity);
        when(catalogueMapper.toResponse(testEntity)).thenReturn(testResponse);

        CatalogueResponse result = catalogueService.create(request);

        assertNotNull(result);
        verify(catalogueRepository).save(testEntity);
    }

    @Test
    void update_nonExistentRecord_throwsResourceNotFound() {
        CatalogueRequest request = new CatalogueRequest();
        when(catalogueRepository.findById("9999999")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class,
                () -> catalogueService.update("9999999", request, null));
    }

    @Test
    void delete_nonExistentRecord_throwsResourceNotFound() {
        when(catalogueRepository.findById("9999999")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class,
                () -> catalogueService.delete("9999999"));
    }

    @Test
    @SuppressWarnings("unchecked")
    void findAll_withFilters_returnsPaginatedResults() {
        Page<CatalogueEntity> page = new PageImpl<>(List.of(testEntity));
        when(catalogueRepository.findAll(any(Specification.class), any(PageRequest.class))).thenReturn(page);
        when(catalogueMapper.toResponse(testEntity)).thenReturn(testResponse);

        Page<CatalogueResponse> result = catalogueService.findAll("B", null, null, PageRequest.of(0, 10));

        assertEquals(1, result.getTotalElements());
        assertEquals("B", result.getContent().get(0).getType());
    }

    @Test
    @SuppressWarnings("unchecked")
    void findAll_withUserDocClaim_restrictsByDocumentType() {
        // Simulate a request context where the JWT carries user_doc = "BK", non-admin level
        MockHttpServletRequest httpRequest = new MockHttpServletRequest();
        httpRequest.setAttribute("userDoc",   "BK");
        httpRequest.setAttribute("userLevel", "G");
        RequestContextHolder.setRequestAttributes(new ServletRequestAttributes(httpRequest));

        ArgumentCaptor<Specification<CatalogueEntity>> specCaptor =
                ArgumentCaptor.forClass(Specification.class);
        Page<CatalogueEntity> page = new PageImpl<>(List.of(testEntity));
        when(catalogueRepository.findAll(specCaptor.capture(), any(PageRequest.class))).thenReturn(page);
        when(catalogueMapper.toResponse(testEntity)).thenReturn(testResponse);

        catalogueService.findAll(null, null, null, PageRequest.of(0, 10));

        // Evaluate the captured compound spec against mock JPA criteria objects
        // to verify that a predicate for appDoc = "BK" was generated
        CriteriaBuilder       cb   = mock(CriteriaBuilder.class);
        CriteriaQuery<?>      q    = mock(CriteriaQuery.class);
        Root<CatalogueEntity> root = mock(Root.class);
        Path<Object>          path = mock(Path.class);
        Predicate             stub = mock(Predicate.class);

        when(root.<Object>get(anyString())).thenReturn(path);
        when(cb.equal(any(), any(Object.class))).thenReturn(stub);
        when(cb.conjunction()).thenReturn(stub);
        when(cb.and(any(Predicate.class), any(Predicate.class))).thenReturn(stub);

        specCaptor.getValue().toPredicate(root, q, cb);

        // Must use all matchers — mixing real objects with matchers throws InvalidUseOfMatchersException
        verify(cb).equal(any(Path.class), eq("BK"));
    }
}
