package com.startupstack.app.modules.subjectthesaurus.service;

import com.startupstack.app.modules.subjectthesaurus.config.SubjectThesaurusProperties;
import com.startupstack.app.modules.subjectthesaurus.dto.Level3CodeResponse;
import com.startupstack.app.modules.subjectthesaurus.dto.ThesaurusTermInsertRequest;
import com.startupstack.app.modules.subjectthesaurus.dto.ThesaurusTermQuery;
import com.startupstack.app.modules.subjectthesaurus.dto.ThesaurusTermUpdateRequest;
import com.startupstack.app.modules.subjectthesaurus.dto.ThesaurusTermRow;
import com.startupstack.app.modules.subjectthesaurus.repository.SubjectThesaurusRepository;
import com.startupstack.app.modules.subjectthesaurus.repository.ThesaurusTermView;
import com.startupstack.app.modules.users.entity.UserEntity;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.PermissionDeniedException;
import jakarta.persistence.EntityManager;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class SubjectThesaurusServiceTest {

    @Mock
    private SubjectThesaurusRepository repository;
    @Mock
    private UserRepository userRepository;
    @Mock
    private EntityManager entityManager;

    private SubjectThesaurusService service;

    @BeforeEach
    void setUp() {
        service = new SubjectThesaurusService(repository, userRepository, new SubjectThesaurusProperties(), entityManager);
    }

    @AfterEach
    void clearContext() {
        SecurityContextHolder.clearContext();
    }

    private void signInAs(String userNo) {
        SecurityContextHolder.getContext().setAuthentication(
                new UsernamePasswordAuthenticationToken("tester", null, List.of()));
        UserEntity user = new UserEntity();
        user.setUserNo(userNo);
        when(userRepository.findByUserName("tester")).thenReturn(Optional.of(user));
    }

    // ─── div_word ─────────────────────────────────────────────────────

    @Test
    void divWord_stripsArticlesAndShortWords() {
        assertEquals(List.of("علاقات", "اقتصادية", "دولية"), com.startupstack.app.shared.collation.LegacyWords.divWord("العلاقات الاقتصادية الدولية"));
    }

    @Test
    void divWord_lilAndHamzaAndDigits() {
        // "للتنمية" -> "تنمية"; "أمن" -> "امن"; "2020" starts with a digit; "في" is too short.
        assertEquals(List.of("تنمية", "امن"), com.startupstack.app.shared.collation.LegacyWords.divWord("للتنمية في أمن 2020"));
    }

    @Test
    void divWord_waalIsNeverStripped_likeLegacyTwoCharMid() {
        assertEquals(List.of("والتعليم"), com.startupstack.app.shared.collation.LegacyWords.divWord("والتعليم"));
    }

    @Test
    void divWord_outerLoopStopsBeforeOneCharLastWord_andCollapsesBlanks() {
        assertEquals(List.of("زراعة", "صناعة"), com.startupstack.app.shared.collation.LegacyWords.divWord("  الزراعة    الصناعة x"));
    }

    @Test
    void divWord_emptyText() {
        assertTrue(com.startupstack.app.shared.collation.LegacyWords.divWord("   ").isEmpty());
        assertTrue(com.startupstack.app.shared.collation.LegacyWords.divWord(null).isEmpty());
    }

    // ─── op_macnz suffix ──────────────────────────────────────────────

    @Test
    void nextSuffix_padsToThreeDigits() {
        assertEquals("001", SubjectThesaurusService.nextSuffix("000"));
        assertEquals("001", SubjectThesaurusService.nextSuffix(""));   // CAST('' AS int) = 0
        assertEquals("013", SubjectThesaurusService.nextSuffix("012"));
        assertEquals("999", SubjectThesaurusService.nextSuffix("998"));
    }

    @Test
    void nextSuffix_overflowAndNonNumericFail() {
        assertThrows(BusinessException.class, () -> SubjectThesaurusService.nextSuffix("999"));
        assertThrows(BusinessException.class, () -> SubjectThesaurusService.nextSuffix("ab1"));
    }

    @Test
    void wordPattern_ltrimAndTwentyCharLimit() {
        assertEquals("%زراعة%", SubjectThesaurusService.wordPattern("  زراعة"));
        assertEquals("%" + "ابتثجحخدذرزسشصضطظعغ".substring(0, 19), SubjectThesaurusService.wordPattern("ابتثجحخدذرزسشصضطظعغ"));
    }

    // ─── statements ───────────────────────────────────────────────────

    private record Row(String code, String level, String description) implements ThesaurusTermView {
        public String getCode() { return code; }
        public String getLevel() { return level; }
        public String getDescription() { return description; }
    }

    private void table(Row... rows) {
        when(repository.findAllRows()).thenReturn(List.of(rows));
    }

    private static List<String> codes(List<ThesaurusTermRow> rows) {
        return rows.stream().map(ThesaurusTermRow::code).toList();
    }

    @Test
    void list_level1_isProcMacnz1OrderedByCode() {
        table(new Row("960000000", "1", "ب"), new Row("950000000", "1", "ا"), new Row("950100000", "2", "ج"),
                new Row(null, "1", "بلا رمز"));
        assertEquals(java.util.Arrays.asList(null, "950000000", "960000000"),
                codes(service.list(ThesaurusTermQuery.LEVEL1, null, null, null)));
    }

    @Test
    void list_children_usesProcMacnzPrefixLengths() {
        table(new Row("950100000", "2", "a"), new Row("950200000", "2", "b"), new Row("960100000", "2", "c"),
                new Row("950100001", "3", "d"), new Row("950100002", "3", "e"), new Row("950200001", "3", "f"));
        assertEquals(List.of("950100000", "950200000"), codes(service.list(ThesaurusTermQuery.CHILDREN, "2", "950000000", null)));
        assertEquals(List.of("950100001", "950100002"), codes(service.list(ThesaurusTermQuery.CHILDREN, "3", "950100000", null)));
    }

    @Test
    void list_prefix_isSerhMacnzAllLevelsOrderedByLegacyCollation() {
        table(new Row("1", "1", "الشؤون السياسية"), new Row("2", "3", "الشئون"), new Row("3", "2", "الشؤون"),
                new Row("4", "1", "التعليم"), new Row("5", "3", null));
        // SQL Server: الشؤون < الشئون < الشؤون السياسية (hamza forms share one primary)
        assertEquals(List.of("3", "2", "1"), codes(service.list(ThesaurusTermQuery.PREFIX, null, null, "  الش ")));
        assertEquals(List.of("4", "3", "2", "1"), codes(service.list(ThesaurusTermQuery.PREFIX, null, null, "")));
    }

    @Test
    void list_word_isSerhWrdmacnzLikeInTableOrder() {
        table(new Row("1", "3", "التعليم العالي"), new Row("2", "3", "الأمن"), new Row("3", "3", "التـعليم"),
                new Row("4", "3", "أمن الدولة"));
        assertEquals(List.of("1", "3"), codes(service.list(ThesaurusTermQuery.WORD, null, null, "تعليم")));
        assertEquals(List.of("2", "4"), codes(service.list(ThesaurusTermQuery.WORD, null, null, "[اأ]من")));
        assertEquals(List.of(), codes(service.list(ThesaurusTermQuery.WORD, null, null, "[x")));
    }

    @Test
    void insert_writesMacnzThenWords() {
        signInAs("244");
        service.insert(new ThesaurusTermInsertRequest("011234567", "الزراعة الحديثة", "2", "011234567"));
        verify(repository).insert("الزراعة الحديثة", "011234567", "2");
        verify(repository).insertWord("زراعة", "011234567", "1");
        verify(repository).insertWord("حديثة", "011234567", "1");
    }

    @Test
    void insert_duplicateCodeIsAMessage() {
        signInAs("244");
        when(repository.insert(anyString(), anyString(), anyString())).thenThrow(new DataIntegrityViolationException("dup"));
        assertThrows(BusinessException.class,
                () -> service.insert(new ThesaurusTermInsertRequest("01", "x", "1", "")));
        verify(repository, never()).insertWord(anyString(), anyString(), anyString());
    }

    @Test
    void writes_requireUser244() {
        signInAs("ADM");
        assertThrows(PermissionDeniedException.class,
                () -> service.insert(new ThesaurusTermInsertRequest("01", "x", "1", "")));
        assertThrows(PermissionDeniedException.class,
                () -> service.update(new ThesaurusTermUpdateRequest("01", "x")));
        assertThrows(PermissionDeniedException.class, () -> service.delete("01"));
        assertThrows(PermissionDeniedException.class, () -> service.openLevelThree("011234000"));
        verifyNoInteractions(repository);
    }

    @Test
    void update_truncatesLikeProcedureParameters() {
        signInAs("244");
        table(new Row("012345678", "3", "old"), new Row("012345679", "3", "other"));
        service.update(new ThesaurusTermUpdateRequest("0123456789", "x".repeat(45)));
        verify(repository).updateDescription("x".repeat(40), List.of("012345678"));
    }

    @Test
    void openLevelThree_insertsPlaceholderAndReturnsMaxCode() {
        signInAs("244");
        when(repository.findAllRows()).thenReturn(
                List.of(new Row("011234000", "2", "parent")),
                List.of(new Row("011234000", "2", "parent"), new Row("011234001", "3", " ".repeat(40))));
        Level3CodeResponse response = service.openLevelThree("011234000");
        verify(repository).insertLevelThreePlaceholder("011234001");
        assertEquals("011234001", response.code());
    }

    @Test
    void openLevelThree_noMatchingRowsIsAMessage() {
        signInAs("244");
        table(new Row("990000000", "1", "x"));
        assertThrows(BusinessException.class, () -> service.openLevelThree("011234000"));
        verify(repository, never()).insertLevelThreePlaceholder(any());
    }
}
