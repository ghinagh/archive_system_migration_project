package com.startupstack.app.modules.formthesaurus.service;

import com.startupstack.app.modules.formthesaurus.dto.CodingRow;
import com.startupstack.app.modules.formthesaurus.dto.FormQuery;
import com.startupstack.app.modules.formthesaurus.dto.FormRow;
import com.startupstack.app.modules.formthesaurus.dto.MacnzQuery;
import com.startupstack.app.modules.formthesaurus.dto.MacnzRow;
import com.startupstack.app.modules.formthesaurus.dto.PositionRow;
import com.startupstack.app.modules.formthesaurus.repository.FormThesaurusRepository;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.exception.BusinessException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.Clock;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneOffset;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class FormThesaurusServiceTest {

    @Mock
    private FormThesaurusRepository repository;
    @Mock
    private UserRepository userRepository;

    private FormThesaurusService service;
    private static final LocalDate TODAY = LocalDate.of(2026, 10, 6);

    @BeforeEach
    void setUp() {
        service = new FormThesaurusService(repository, userRepository,
                Clock.fixed(Instant.parse("2026-10-06T09:00:00Z"), ZoneOffset.UTC));
    }

    private static FormRow form(String typ, String no, String name) {
        return new FormRow(typ, no, name, typ + no);
    }

    private static List<String> names(List<FormRow> rows) {
        return rows.stream().map(FormRow::name).toList();
    }

    // ─── CODING ───

    @Test
    void codingChildren_truncatesPrefixAndOrdersByCode() {
        when(repository.codingChildren("10")).thenReturn(List.of(
                new CodingRow("2", "1004", "د"), new CodingRow("2", "1001", "ا"), new CodingRow("1", "10", "ج")));
        assertEquals(List.of("10", "1001", "1004"),
                service.codingChildren("10xx").stream().map(CodingRow::code).toList());
    }

    @Test
    void insertCoding_columnOverflowIsSilentlyNotSaved_likeOnErrorResumeNext() {
        assertFalse(service.insertCoding("12345", "x", "1").saved());
        assertFalse(service.insertCoding("12", "x".repeat(101), "1").saved());
        verify(repository, never()).insertCoding(anyString(), anyString(), anyString());
        assertTrue(service.insertCoding("1201", "شهري", "2").saved());
        verify(repository).insertCoding("1201", "شهري", "2");
    }

    @Test
    void updateCoding_truncatesProcParameters() {
        service.updateCoding("123456", "x".repeat(120));
        verify(repository).updateCoding("x".repeat(100), "1234");
    }

    // ─── form searches ───

    @Test
    void names_isNamFormOrderedByTypePlusNumber() {
        when(repository.formsOf("01", "001")).thenReturn(List.of(
                form("01", "00100003", "ج"), form("01", "00100001", "ا"), form("01", "00100002", "ب")));
        assertEquals(List.of("ا", "ب", "ج"),
                names(service.forms(FormQuery.NAMES, "01", "001", null, null, null)));
    }

    @Test
    void nameSearch_isSerh1FormPrefixUnderLegacyCollationOrderedByName() {
        when(repository.formsOf("01", "001")).thenReturn(List.of(
                form("01", "00100001", "مدرسة الشؤون"), form("01", "00100002", "مدرست"),
                form("01", "00100003", "مكتبة"), form("01", "00100004", null)));
        // ة = ت under SQL_Latin1_General_CP1256_CI_AS, so "مدرست" is a prefix of "مدرسة الشؤون" and sorts first
        assertEquals(List.of("مدرست", "مدرسة الشؤون"),
                names(service.forms(FormQuery.NAME_SEARCH, "01", "001", "مدرسة", 5, null)));
    }

    @Test
    void duplicateNameCheck_paddedSixtyCharsIsAnExactNameMatch() {
        when(repository.formsOf("01", "001")).thenReturn(List.of(form("01", "00100001", "احمد"), form("01", "00100002", "احمد علي")));
        String padded = "احمد" + " ".repeat(56);
        assertEquals(List.of("احمد"), names(service.forms(FormQuery.NAME_SEARCH, "01", "001", padded, 60, null)));
    }

    @Test
    void likeSearch_isSerhWrdFormWithTwentyCharPattern() {
        when(repository.allForms()).thenReturn(List.of(form("01", "1", "وزارة الخارجية"), form("03", "2", "وزارة الداخلية"),
                form("01", "3", "مجلس")));
        assertEquals(List.of("وزارة الخارجية"), names(service.forms(FormQuery.LIKE_SEARCH, null, null, "خارج", 5, null)));
    }

    @Test
    void wordSearch_isSerhWrdForm1PrefixOnWordJoin() {
        when(repository.wordJoinedForms("01001")).thenReturn(List.of(
                new Object[]{form("01", "00100001", "وزارة الخارجية"), "خارجية"},
                new Object[]{form("01", "00100002", "وزارة الداخلية"), "داخلية"}));
        assertEquals(List.of("وزارة الخارجية"), names(service.forms(FormQuery.WORD_SEARCH, null, null, "خار", 3, "01001")));
    }

    // ─── op_form / max_form ───

    @Test
    void nextNumber_insertsPlaceholderAndReturnsTypePlusMaxNumber() {
        when(repository.formsWithPrefix("01001")).thenReturn(
                List.of(form("01", "00100000", "بلد"), form("01", "00100007", "س")),
                List.of(form("01", "00100000", "بلد"), form("01", "00100007", "س"), form("01", "00100008", null)));
        assertEquals("0100100008", service.nextNumber("01001").code());
        verify(repository).insertForm("01", "00100008", null, TODAY);
    }

    @Test
    void nextNumber_noRowsOrOverflowIsAMessageAndWritesNothing() {
        when(repository.formsWithPrefix("01009")).thenReturn(List.of());
        assertThrows(BusinessException.class, () -> service.nextNumber("01009"));
        when(repository.formsWithPrefix("01001")).thenReturn(List.of(form("01", "00199999", "x")));
        assertThrows(BusinessException.class, () -> service.nextNumber("01001"));
        verify(repository, never()).insertForm(any(), any(), any(), any());
    }

    @Test
    void insertForm_nameWiderThanColumnIsSilentlyNotSaved() {
        assertFalse(service.insertForm("x".repeat(61), "00100001", "01").saved());
        verify(repository, never()).insertForm(any(), any(), any(), any());
        assertTrue(service.insertForm("x".repeat(60), "001000019", "011").saved());
        verify(repository).insertForm("01", "00100001", "x".repeat(60), TODAY);
    }

    // ─── words ───

    @Test
    void replaceWords_deletesThenDivWordsWithTypeTwo() {
        service.replaceWords("0100100001", "وزارة الخارجية");
        verify(repository).deleteWords("0100100001", "2");
        verify(repository).insertWord("وزارة", "0100100001", "2");
        verify(repository).insertWord("خارجية", "0100100001", "2");
    }

    // ─── positions ───

    @Test
    void updatePosition_matchesOldNameUnderLegacyCollation() {
        when(repository.positions("0100100001")).thenReturn(List.of(
                new PositionRow("0100100001", "مدير عام", null), new PositionRow("0100100001", "وزير", null)));
        service.updatePosition("مدير", "0100100001", "مدير عام ");
        verify(repository).updatePositions("مدير", "0100100001", List.of("مدير عام"));
        service.deletePosition("0100100001", "غير موجود");
        verify(repository, never()).deletePositions(any(), any());
    }

    // ─── MACNZ picker ───

    @Test
    void macnzPrefix_isSerhMacnzOrderedByDescription() {
        when(repository.allMacnz()).thenReturn(List.of(new MacnzRow("2", "1", "الشئون"), new MacnzRow("1", "1", "الشؤون"),
                new MacnzRow("3", "1", "التعليم")));
        assertEquals(List.of("الشؤون", "الشئون"),
                service.macnz(MacnzQuery.PREFIX, "الش", 3).stream().map(MacnzRow::description).toList());
    }
}
