package com.startupstack.app.modules.articles.service;

import com.startupstack.app.modules.articles.dto.ArticleRequest;
import com.startupstack.app.modules.articles.dto.ArticleResponse;
import com.startupstack.app.modules.articles.entity.ArticleEntity;
import com.startupstack.app.modules.articles.mapper.ArticleMapper;
import com.startupstack.app.modules.articles.repository.ArticleRepository;
import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.periodicals.repository.PeriodicalRepository;
import com.startupstack.app.shared.exception.BusinessException;
import jakarta.persistence.EntityManager;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * استمارة التوثيق save parity with Form6.frm Command1_Click (:2799-2845): only a loaded, unlocked
 * record can be saved; every field may be empty; a number that already exists can never be
 * overwritten through POST /api/articles. Rejections must happen before anything is written.
 */
@ExtendWith(MockitoExtension.class)
class ArticleServiceDocumentationParityTest {

    @Mock private ArticleRepository articleRepository;
    @Mock private CatalogueRepository catalogueRepository;
    @Mock private PeriodicalRepository periodicalRepository;
    @Mock private ArticleMapper articleMapper;
    @Mock private EntityManager entityManager;
    @InjectMocks private ArticleService articleService;

    private static ArticleRequest request(String appNo) {
        ArticleRequest r = new ArticleRequest();
        r.setAppNo(appNo);
        return r;
    }

    private static CatalogueEntity catalogue(String appNo, Integer trans) {
        CatalogueEntity c = new CatalogueEntity();
        c.setAppNo(appNo);
        c.setTrans(trans);
        c.setActiveTitleAr("عنوان قديم");
        return c;
    }

    // ── POST /api/articles: duplicate number ──

    @Test
    void create_numberAlreadyInArticle_isRejectedWithLegacyMessage_andWritesNothing() {
        when(articleRepository.existsById("ق000001")).thenReturn(true);

        BusinessException ex = assertThrows(BusinessException.class, () -> articleService.create(request("ق000001")));

        assertEquals("هذا الرقم تابع لاستمارة اخرى!!!!!", ex.getMessage());
        verify(articleRepository, never()).save(any());
        verify(catalogueRepository, never()).save(any());
        verifyNoInteractions(articleMapper, periodicalRepository, entityManager);
    }

    @Test
    void create_numberOnlyInMain_isRejected_andWritesNothing() {
        when(articleRepository.existsById("ق000002")).thenReturn(false);
        when(catalogueRepository.existsById("ق000002")).thenReturn(true);

        assertThrows(BusinessException.class, () -> articleService.create(request("ق000002")));

        verify(articleRepository, never()).save(any());
        verify(catalogueRepository, never()).save(any());
    }

    @Test
    void create_newNumber_isStillInserted() {
        ArticleEntity article = new ArticleEntity();
        when(articleMapper.toEntity(any())).thenReturn(article);
        when(articleMapper.toResponse(article)).thenReturn(new ArticleResponse());
        when(catalogueRepository.save(any(CatalogueEntity.class))).thenAnswer(i -> i.getArgument(0));

        articleService.create(request("ق000003"));

        verify(articleRepository).save(article);
        verify(catalogueRepository).save(any(CatalogueEntity.class));
    }

    // ── PUT /api/articles/{no}/documentation: locked record ──

    @Test
    void updateDocumentationForm_lockedRecord_isRejectedWithLegacyMessage_andWritesNothing() {
        when(articleRepository.findById("ق000004")).thenReturn(Optional.of(new ArticleEntity()));
        when(catalogueRepository.findById("ق000004")).thenReturn(Optional.of(catalogue("ق000004", 1)));
        ArticleRequest r = request("ق000004");
        r.setActiveTitleAr("عنوان جديد");

        BusinessException ex = assertThrows(BusinessException.class,
                () -> articleService.updateDocumentationForm("ق000004", r));

        assertEquals("لا تستطيع التعديل او الالغاء ....لان الوثيقة مقفلة.", ex.getMessage());
        verify(articleRepository, never()).save(any());
        verify(catalogueRepository, never()).save(any());
    }

    @Test
    void updateDocumentationForm_unlockedRecordWithEveryFieldEmpty_isSaved() {
        ArticleEntity article = new ArticleEntity();
        CatalogueEntity main = catalogue("ق000005", 0);
        when(articleRepository.findById("ق000005")).thenReturn(Optional.of(article));
        when(catalogueRepository.findById("ق000005")).thenReturn(Optional.of(main));
        when(articleMapper.toResponse(article)).thenReturn(new ArticleResponse());

        articleService.updateDocumentationForm("ق000005", request("ق000005"));

        verify(catalogueRepository).save(main);
        verify(articleRepository).save(article);
        assertNull(main.getActiveTitleAr());
        assertNull(main.getEntryDate());
    }

    @Test
    void updateDocumentationForm_nullLockFlag_isTreatedAsOpen_andKeepsDataEntryAndStoresDateOnly() {
        ArticleEntity article = new ArticleEntity();
        CatalogueEntity main = catalogue("ق000006", null);
        when(articleRepository.findById("ق000006")).thenReturn(Optional.of(article));
        when(catalogueRepository.findById("ق000006")).thenReturn(Optional.of(main));
        when(articleMapper.toResponse(article)).thenReturn(new ArticleResponse());
        ArticleRequest r = request("ق000006");
        r.setActiveTitleAr("عنوان جزئي");
        r.setDataEntry("01");
        r.setEntryDate(LocalDateTime.of(2026, 10, 12, 15, 47, 33));

        articleService.updateDocumentationForm("ق000006", r);

        assertEquals("عنوان جزئي", main.getActiveTitleAr());
        assertEquals("01", main.getDataEntry());
        assertEquals(LocalDateTime.of(2026, 10, 12, 0, 0), main.getEntryDate());
        verify(catalogueRepository).save(main);
    }
}
