package com.startupstack.app.modules.sites.service;

import com.startupstack.app.modules.sites.dto.SiteResponse;
import com.startupstack.app.modules.sites.entity.SiteEntity;
import com.startupstack.app.modules.sites.mapper.SiteMapper;
import com.startupstack.app.modules.sites.repository.SiteRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
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
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class SiteServiceTest {

    @Mock
    private SiteRepository siteRepository;
    @Mock
    private SiteMapper siteMapper;
    @InjectMocks
    private SiteService siteService;

    private SiteEntity testSite;
    private SiteResponse testSiteResponse;

    @BeforeEach
    void setUp() {
        testSite = new SiteEntity();
        testSite.setSiteNo("SITE000001");
        testSite.setDescription("موقع تجريبي");
        testSite.setWilyaNo(5);

        testSiteResponse = new SiteResponse();
        testSiteResponse.setSiteNo("SITE000001");
        testSiteResponse.setDescription("موقع تجريبي");
        testSiteResponse.setWilyaNo(5);
    }

    @AfterEach
    void tearDown() {
        RequestContextHolder.resetRequestAttributes();
    }

    @Test
    void findById_existingSite_returnsResponse() {
        when(siteRepository.findById("SITE000001")).thenReturn(Optional.of(testSite));
        when(siteMapper.toResponse(testSite)).thenReturn(testSiteResponse);

        SiteResponse result = siteService.findById("SITE000001");

        assertEquals("SITE000001", result.getSiteNo());
        assertEquals("موقع تجريبي", result.getDescription());
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        when(siteRepository.findById("NONE")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> siteService.findById("NONE"));
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(siteRepository.existsById("NONE")).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> siteService.delete("NONE"));
    }

    /**
     * Given a non-admin user with {@code siteWly = 5} in their JWT,
     * {@code SiteService.findAll()} must build a Specification that includes
     * a predicate filtering {@code sit_wly_no = 5} so that only sites in
     * wilaya 5 are returned.
     */
    @Test
    @SuppressWarnings("unchecked")
    void findAll_withWilayaClaim_restrictsToUserWilaya() {
        MockHttpServletRequest httpRequest = new MockHttpServletRequest();
        httpRequest.setAttribute("siteWly",   5);
        httpRequest.setAttribute("userLevel", "G"); // non-admin
        RequestContextHolder.setRequestAttributes(new ServletRequestAttributes(httpRequest));

        ArgumentCaptor<Specification<SiteEntity>> specCaptor =
                ArgumentCaptor.forClass(Specification.class);
        Page<SiteEntity> page = new PageImpl<>(List.of(testSite));
        when(siteRepository.findAll(specCaptor.capture(), any(Pageable.class))).thenReturn(page);
        when(siteMapper.toResponse(testSite)).thenReturn(testSiteResponse);

        // Call without includeNames/includeFormInfo so the Specification path is taken
        siteService.findAll(null, null, null, false, false, PageRequest.of(0, 10));

        // Replay the captured Specification against mock JPA criteria objects
        CriteriaBuilder       cb   = mock(CriteriaBuilder.class);
        CriteriaQuery<?>      q    = mock(CriteriaQuery.class);
        Root<SiteEntity>      root = mock(Root.class);
        Path<Object>          path = mock(Path.class);
        Predicate             stub = mock(Predicate.class);

        when(root.<Object>get(anyString())).thenReturn(path);
        when(cb.equal(any(), any(Object.class))).thenReturn(stub);
        when(cb.conjunction()).thenReturn(stub);
        when(cb.and(any(Predicate.class), any(Predicate.class))).thenReturn(stub);

        specCaptor.getValue().toPredicate(root, q, cb);

        // SitesSpecification.siteHasWilya(5) must have called cb.equal(<path>, 5)
        verify(cb).equal(any(Path.class), eq(5));
    }

    /**
     * Admin users bypass the wilaya restriction: even if their JWT carries
     * {@code siteWly = 5}, {@code SecurityUtils.getCurrentUserWilaya()} returns
     * {@code null} for admins and no wilaya predicate should be added.
     */
    @Test
    @SuppressWarnings("unchecked")
    void findAll_adminUser_noWilayaPredicateAdded() {
        MockHttpServletRequest httpRequest = new MockHttpServletRequest();
        httpRequest.setAttribute("siteWly",   5);
        httpRequest.setAttribute("userLevel", "A"); // admin
        RequestContextHolder.setRequestAttributes(new ServletRequestAttributes(httpRequest));

        ArgumentCaptor<Specification<SiteEntity>> specCaptor =
                ArgumentCaptor.forClass(Specification.class);
        Page<SiteEntity> page = new PageImpl<>(List.of(testSite));
        when(siteRepository.findAll(specCaptor.capture(), any(Pageable.class))).thenReturn(page);
        when(siteMapper.toResponse(testSite)).thenReturn(testSiteResponse);

        siteService.findAll(null, null, null, false, false, PageRequest.of(0, 10));

        CriteriaBuilder       cb   = mock(CriteriaBuilder.class);
        CriteriaQuery<?>      q    = mock(CriteriaQuery.class);
        Root<SiteEntity>      root = mock(Root.class);
        Path<Object>          path = mock(Path.class);
        Predicate             stub = mock(Predicate.class);

        lenient().when(root.<Object>get(anyString())).thenReturn(path);
        lenient().when(cb.equal(any(), any(Object.class))).thenReturn(stub);
        lenient().when(cb.conjunction()).thenReturn(stub);
        lenient().when(cb.and(any(Predicate.class), any(Predicate.class))).thenReturn(stub);

        specCaptor.getValue().toPredicate(root, q, cb);

        // Admin: getCurrentUserWilaya() returns null → siteHasWilya(null) returns null
        // (no predicate) → cb.equal should never be called with the integer 5
        verify(cb, never()).equal(any(Path.class), eq(5));
    }
}
