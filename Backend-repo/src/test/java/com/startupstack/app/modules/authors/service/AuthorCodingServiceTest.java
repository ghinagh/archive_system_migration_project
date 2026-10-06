package com.startupstack.app.modules.authors.service;

import com.startupstack.app.modules.authors.dto.AuthorCodingInsertRequest;
import com.startupstack.app.modules.authors.dto.AuthorCodingQuery;
import com.startupstack.app.modules.authors.dto.AuthorCodingRow;
import com.startupstack.app.modules.authors.dto.AuthorCodingUpdateRequest;
import com.startupstack.app.modules.authors.entity.AuthorEntity;
import com.startupstack.app.modules.authors.repository.AuthorCodingRepository;
import com.startupstack.app.shared.exception.BusinessException;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.dao.DataIntegrityViolationException;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyDouble;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AuthorCodingServiceTest {

    @Mock
    private AuthorCodingRepository repository;
    @InjectMocks
    private AuthorCodingService service;

    private static AuthorEntity entity(double no, String name) {
        AuthorEntity e = new AuthorEntity();
        e.setAutNo(no);
        e.setAutName(name);
        return e;
    }

    @Test
    void list_byNumber_usesRecordSourceQuery() {
        when(repository.findAllOrderByNumber()).thenReturn(List.of(entity(1, "a"), entity(2, "b")));

        List<AuthorCodingRow> rows = service.list(AuthorCodingQuery.BY_NUMBER, null);

        assertEquals(List.of(new AuthorCodingRow(1d, "a"), new AuthorCodingRow(2d, "b")), rows);
    }

    @Test
    void list_prefix_passesTrimmedTextAndItsLength() {
        when(repository.findByNamePrefix("دار", 3)).thenReturn(List.of());

        service.list(AuthorCodingQuery.PREFIX, "  دار  ");

        verify(repository).findByNamePrefix("دار", 3);
    }

    @Test
    void list_prefix_emptyTextMatchesEverything() {
        when(repository.findByNamePrefix("", 0)).thenReturn(List.of());

        service.list(AuthorCodingQuery.PREFIX, null);

        verify(repository).findByNamePrefix("", 0);
    }

    @Test
    void wordPattern_wrapsLeftTrimmedTextInPercents() {
        assertEquals("%الفكر %", AuthorCodingService.wordPattern("  الفكر "));
        assertEquals("%%", AuthorCodingService.wordPattern(""));
    }

    @Test
    void wordPattern_truncatesLikeTheNvarchar15Parameters() {
        // @desc keeps 15 chars, then '%' + 15 + '%' is cut back to 15 — the closing % is lost.
        assertEquals("%abcdefghijklmn", AuthorCodingService.wordPattern("abcdefghijklmnopqrst"));
        assertEquals("%abcdefghijklm%", AuthorCodingService.wordPattern("abcdefghijklm"));
    }

    @Test
    void insert_emptyNumberBecomesZeroLikeSqlServerFloatConversion() {
        AuthorCodingRow row = service.insert(new AuthorCodingInsertRequest("", "x"));

        verify(repository).insert("x", 0d);
        assertEquals(0d, row.number());
    }

    @Test
    void insert_truncatesNameToTheNvarchar100Parameter() {
        String longName = "a".repeat(120);

        service.insert(new AuthorCodingInsertRequest("5", longName));

        verify(repository).insert("a".repeat(100), 5d);
    }

    @Test
    void insert_nonNumericNumberIsRejected() {
        assertThrows(BusinessException.class, () -> service.insert(new AuthorCodingInsertRequest("12x", "x")));
        verify(repository, never()).insert(any(), anyDouble());
    }

    @Test
    void insert_duplicateNumberReportsBusinessError() {
        when(repository.insert("x", 7d)).thenThrow(new DataIntegrityViolationException("uq_auther_no"));

        BusinessException ex = assertThrows(BusinessException.class,
                () -> service.insert(new AuthorCodingInsertRequest("7", "x")));
        assertTrue(ex.getMessage().contains("7"));
    }

    @Test
    void update_changesOnlyTheName() {
        service.updateName(9d, new AuthorCodingUpdateRequest("جديد"));

        verify(repository).updateName("جديد", 9d);
    }

    @Test
    void delete_referencedRowReportsBusinessError() {
        when(repository.deleteByNumber(3d)).thenThrow(new DataIntegrityViolationException("fk"));

        assertThrows(BusinessException.class, () -> service.delete(3d));
    }
}
