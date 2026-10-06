package com.startupstack.app.modules.formthesaurus.service;

import com.startupstack.app.modules.formthesaurus.dto.AdditionalFileCriterion;
import com.startupstack.app.modules.formthesaurus.dto.AdditionalFileCriterion.Kind;
import com.startupstack.app.modules.formthesaurus.dto.AdditionalFileRow;
import com.startupstack.app.modules.formthesaurus.repository.AdditionalFilesRepository;
import com.startupstack.app.modules.users.entity.UserEntity;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.exception.BusinessException;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;

import java.sql.Timestamp;
import java.time.Clock;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AdditionalFilesServiceTest {

    @Mock
    private AdditionalFilesRepository repository;
    @Mock
    private UserRepository userRepository;
    private AdditionalFilesService service;

    @BeforeEach
    void setUp() {
        service = new AdditionalFilesService(repository, userRepository, Clock.fixed(Instant.parse("2026-10-06T09:00:00Z"), ZoneOffset.UTC));
    }

    @AfterEach
    void clear() {
        SecurityContextHolder.clearContext();
    }

    private static AdditionalFileRow row(String no, Integer fin, String name, String rmrk, LocalDate d, String user, Double ser) {
        return new AdditionalFileRow(no, fin, name, rmrk, "مكان", d == null ? null : d.atStartOfDay(), user, ser);
    }

    private static AdditionalFileCriterion c(Kind k, LocalDate d, String t) {
        return new AdditionalFileCriterion(k, d, t);
    }

    private List<Double> serials(List<AdditionalFileRow> rows) {
        return rows.stream().map(AdditionalFileRow::serial).toList();
    }

    @Test
    void search_appliesTmpResultCriteria_andOrdersBySerialDescNullsLast() {
        when(repository.all()).thenReturn(List.of(
                row("0000001", 0, "ملف", "اول", LocalDate.of(2026, 1, 10), "ADM", 1.0),
                row("0000002", 1, "ملف", "ثاني", LocalDate.of(2026, 5, 1), "ADM", 2.0),
                row("0000003", null, "تقرير", "سنوي", null, "U01", 3.0),
                row("0000004", 0, null, "بدون اسم", LocalDate.of(2078, 1, 1), "ADM", null)));
        // Form_Load: (tmp_date <= today or tmp_date is null)
        assertEquals(List.of(3.0, 2.0, 1.0), serials(service.search(List.of(c(Kind.TO, LocalDate.of(2026, 10, 6), null)))));
        assertEquals(List.of(3.0, 2.0), serials(service.search(List.of(c(Kind.FROM, LocalDate.of(2026, 2, 1), null),
                c(Kind.TO, LocalDate.of(2026, 10, 6), null)))));
        assertEquals(List.of(2.0, 1.0), serials(service.search(List.of(c(Kind.USER, null, "adm "), c(Kind.TO, LocalDate.of(2026, 10, 6), null)))));
        // tmp_file_name + tmp_rmrk like '%…%' — NULL name never matches
        assertEquals(List.of(2.0), serials(service.search(List.of(c(Kind.WORD, null, "ملفثا")))));
        assertEquals(List.of(), serials(service.search(List.of(c(Kind.WORD, null, "بدون")))));
        assertEquals(List.of(2.0), serials(service.search(List.of(c(Kind.FINAL, null, null)))));
        assertEquals(List.of(3.0, 1.0), serials(service.search(List.of(c(Kind.NOT_FINAL, null, null), c(Kind.TO, LocalDate.of(2026, 10, 6), null)))));
        assertEquals(List.of(), serials(service.search(List.of(c(Kind.FINAL, null, null), c(Kind.NOT_FINAL, null, null)))));
    }

    @Test
    void search_isDistinctUnderTheColumnCollation() {
        when(repository.all()).thenReturn(List.of(
                row("0000001", 0, "ملف", "x", null, "ADM", 5.0),
                row("0000001", 0, "ملف ", "X", null, "adm", 5.0)));
        assertEquals(1, service.search(List.of()).size());
    }

    @Test
    void insertOp_nextSerialPerUser_paddedCharParams() {
        SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken("admin", null, List.of()));
        UserEntity u = new UserEntity();
        u.setUserNo("AD");
        when(userRepository.findByUserName("admin")).thenReturn(Optional.of(u));
        when(repository.maxSerial("AD")).thenReturn(7.6);
        service.insertOp("");
        verify(repository).insertOp(eq(8.0), eq("AD "), eq("       "), eq(Timestamp.valueOf(LocalDateTime.of(2026, 10, 6, 0, 0))));
        when(repository.maxSerial("AD")).thenReturn(null);
        service.insertOp("1234567");
        verify(repository).insertOp(eq(1.0), eq("AD "), eq("1234567"), any());
    }

    @Test
    void cellConversions_followTheColumnTypes() {
        assertEquals(Timestamp.valueOf(LocalDateTime.of(2020, 7, 17, 0, 0)), AdditionalFilesService.convert("tmp_date", "17/07/2020"));
        assertEquals(LocalDate.of(2026, 5, 13), AdditionalFilesService.vbDate("05/13/2026"));   // CDate falls back to mm/dd
        assertNull(AdditionalFilesService.convert("tmp_date", ""));
        assertThrows(BusinessException.class, () -> AdditionalFilesService.convert("tmp_date", "31/31/2026"));
        assertThrows(BusinessException.class, () -> AdditionalFilesService.convert("tmp_date", "01/01/2099"));   // beyond smalldatetime
        assertEquals(1, AdditionalFilesService.convert("tmp_final", "1"));
        assertThrows(BusinessException.class, () -> AdditionalFilesService.convert("tmp_final", "x"));
        assertThrows(BusinessException.class, () -> AdditionalFilesService.convert("tmp_fad_no", "12345678"));
        assertEquals("AB ", AdditionalFilesService.convert("tmp_user_no", "AB"));
        // رقم الموثق: any char(3) value — a user number that does not exist, blank, exactly 3 characters
        assertEquals("ZZZ", AdditionalFilesService.convert("tmp_user_no", "ZZZ"));
        assertEquals("   ", AdditionalFilesService.convert("tmp_user_no", ""));
        assertThrows(BusinessException.class, () -> AdditionalFilesService.convert("tmp_user_no", "ABCD"));
    }

    @Test
    void insertRow_requiresTheNotNullFileNumber() {
        assertThrows(BusinessException.class, () -> service.insertRow(Map.of("fileName", "x")));
        service.insertRow(Map.of("fileNo", "0000009", "fileName", "x"));
        verify(repository).insert(any());
    }
}
