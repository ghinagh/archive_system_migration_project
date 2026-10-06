package com.startupstack.app.modules.subjectthesaurus.service;

import com.startupstack.app.modules.subjectthesaurus.config.SubjectThesaurusProperties;
import com.startupstack.app.modules.subjectthesaurus.dto.Level3CodeResponse;
import com.startupstack.app.modules.subjectthesaurus.dto.SubjectThesaurusContext;
import com.startupstack.app.modules.subjectthesaurus.dto.ThesaurusTermInsertRequest;
import com.startupstack.app.modules.subjectthesaurus.dto.ThesaurusTermQuery;
import com.startupstack.app.modules.subjectthesaurus.dto.ThesaurusTermRow;
import com.startupstack.app.modules.subjectthesaurus.dto.ThesaurusTermUpdateRequest;
import com.startupstack.app.modules.subjectthesaurus.repository.SubjectThesaurusRepository;
import com.startupstack.app.modules.subjectthesaurus.repository.ThesaurusTermView;
import com.startupstack.app.modules.users.entity.UserEntity;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.PermissionDeniedException;
import com.startupstack.app.shared.util.SecurityUtils;
import jakarta.persistence.EntityManager;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * "المكنز الموضوعي" — legacy Form5.frm (ARCHIVE.frm menu التــرميــز → m6, Ctrl+A, key-protected).
 *
 * <p>Each method is one statement Form5 sends: the RecordSources of macnz1/2/3 (proc_macnz1,
 * proc_macnz, serh_macnz, serh_wrdmacnz), insr_macnz + div_word/insr_word, upd_macnz, del_macnz,
 * and the op_macnz + max_macnz pair behind a level-three add. Parameter shaping (VB Trim/Mid, the
 * nvarchar truncations of the procedure parameters) follows the legacy call sites.
 *
 * <p>Writes evict the "lookups-subjects" cache that /api/lookups/subjects would use if caching
 * were enabled, so other screens keep reading MACNZ live as legacy screens did.
 */
@Service
public class SubjectThesaurusService {

    /** insr_macnz / upd_macnz / serh_macnz @desc nvarchar(40). */
    static final int DESC_PARAM_LENGTH = 40;
    /** insr_macnz / upd_macnz / del_macnz @m_code nvarchar(9). */
    static final int CODE_PARAM_LENGTH = 9;
    /** proc_macnz @v_cod, op_macnz / max_macnz @m_sub nvarchar(6). */
    static final int PREFIX_PARAM_LENGTH = 6;
    /** serh_wrdmacnz @desc nvarchar(50) and its local @m_word nvarchar(20). */
    static final int WORD_SEARCH_PARAM_LENGTH = 50;
    static final int WORD_PATTERN_LENGTH = 20;
    /** insr_word @desc nvarchar(12), @m_no nvarchar(10). */
    static final int WORD_LENGTH = 12;
    static final int WORD_CODE_LENGTH = 10;

    private final SubjectThesaurusRepository repository;
    private final UserRepository userRepository;
    private final SubjectThesaurusProperties properties;
    private final EntityManager entityManager;

    public SubjectThesaurusService(SubjectThesaurusRepository repository, UserRepository userRepository,
                                   SubjectThesaurusProperties properties, EntityManager entityManager) {
        this.repository = repository;
        this.userRepository = userRepository;
        this.properties = properties;
        this.entityManager = entityManager;
    }

    public SubjectThesaurusContext context() {
        String userNo = currentUserNo();
        return new SubjectThesaurusContext(userNo, isWriter(userNo));
    }

    /**
     * The RecordSources of macnz1/2/3, evaluated with the legacy collation: proc_macnz1 and
     * proc_macnz order by sub_code, serh_macnz orders by sub_desc, serh_wrdmacnz has no ORDER BY
     * (table order).
     */
    @Transactional(readOnly = true)
    public List<ThesaurusTermRow> list(ThesaurusTermQuery query, String level, String parentCode, String text) {
        List<ThesaurusTermView> all = repository.findAllRows();
        List<ThesaurusTermView> rows = switch (query) {
            // proc_macnz1: where sub_level = '1' order by sub_code
            case LEVEL1 -> LegacyCollation.sortBy(
                    all.stream().filter(r -> LegacyCollation.equal(r.getLevel(), "1")).toList(), ThesaurusTermView::getCode);
            case CHILDREN -> {
                // datalist1 DblClick/Enter: proc_macnz 1, 2, '2', Mid(code, 1, 2)
                // datalist2 DblClick/Enter: proc_macnz 1, 6, '3', Mid(code, 1, 6)
                // where SUBSTRING(sub_code, @lent1, @lent2) = @v_cod and sub_level = @m_leve order by sub_code
                int length = switch (level == null ? "" : level) {
                    case "2" -> 2;
                    case "3" -> 6;
                    default -> throw new BusinessException("مستوى غير صالح: " + level);
                };
                String prefix = truncate(mid(parentCode, length), PREFIX_PARAM_LENGTH);
                yield LegacyCollation.sortBy(all.stream()
                                .filter(r -> r.getCode() != null
                                        && LegacyCollation.equal(LegacyCollation.left(r.getCode(), length), prefix)
                                        && LegacyCollation.equal(r.getLevel(), level))
                                .toList(),
                        ThesaurusTermView::getCode);
            }
            case PREFIX -> {
                // serh_macnz m_desc, Len(Trim(m_desc)):
                // where substring(sub_desc, 1, @lent) = ltrim(@desc) order by sub_desc
                String desc = truncate(nullToEmpty(text), DESC_PARAM_LENGTH);
                String right = ltrim(desc);
                int lent = vbTrim(nullToEmpty(text)).length();
                yield LegacyCollation.sortBy(all.stream()
                                .filter(r -> r.getDescription() != null
                                        && LegacyCollation.equal(LegacyCollation.left(r.getDescription(), lent), right))
                                .toList(),
                        ThesaurusTermView::getDescription);
            }
            // serh_wrdmacnz: where sub_desc like @m_word — no ORDER BY
            case WORD -> {
                String pattern = wordPattern(text);
                yield all.stream().filter(r -> LegacyCollation.like(r.getDescription(), pattern)).toList();
            }
        };
        return rows.stream().map(r -> new ThesaurusTermRow(r.getCode(), r.getLevel(), r.getDescription())).toList();
    }

    /** Command3, mod_typ = "1": insr_macnz then div_word(m_code, desc.Text, "1"). */
    @CacheEvict(value = "lookups-subjects", allEntries = true)
    @Transactional
    public void insert(ThesaurusTermInsertRequest request) {
        requireWriter();
        String code = truncate(nullToEmpty(request.code()), CODE_PARAM_LENGTH);
        try {
            repository.insert(truncate(nullToEmpty(request.description()), DESC_PARAM_LENGTH), code,
                    truncate(nullToEmpty(request.level()), 1));
            entityManager.flush();
        } catch (DataIntegrityViolationException e) {
            throw new BusinessException("لا يمكن التسجيل: الرمز " + code + " مستخدم سابقا في المكنز");
        }
        String wordCode = truncate(nullToEmpty(request.wordCode()), WORD_CODE_LENGTH);
        for (String word : divWord(request.description())) {
            repository.insertWord(truncate(word, WORD_LENGTH), wordCode, "1");
        }
    }

    /** Command3, mod_typ = "2": upd_macnz desc.Text, code.Text (an edit, or the end of a level-three add). */
    @CacheEvict(value = "lookups-subjects", allEntries = true)
    @Transactional
    public void update(ThesaurusTermUpdateRequest request) {
        requireWriter();
        List<String> codes = codesEqualTo(truncate(nullToEmpty(request.code()), CODE_PARAM_LENGTH));
        if (!codes.isEmpty()) {
            repository.updateDescription(truncate(nullToEmpty(request.description()), DESC_PARAM_LENGTH), codes);
        }
    }

    /** Command4 after "ن"/"y": del_macnz m_code. */
    @CacheEvict(value = "lookups-subjects", allEntries = true)
    @Transactional
    public void delete(String code) {
        requireWriter();
        String param = truncate(nullToEmpty(code), CODE_PARAM_LENGTH);
        try {
            List<String> codes = codesEqualTo(param);
            if (!codes.isEmpty()) {
                repository.deleteByCodes(codes);
                entityManager.flush();
            }
        } catch (DataIntegrityViolationException e) {
            throw new BusinessException("لا يمكن الالغاء: الواصفة " + param
                    + " مستخدمة في تحليل وثائق او مواضيع مرتبطة");
        }
    }

    /**
     * Command1 on the third level: {@code EXECUTE OP_macnz m_sub} (inserts the next code with
     * level '3', logic 0 and a 40-blank description), then {@code max_macnz m_sub} and
     * {@code code.Text = m_sub + max1}. The row exists from here on; تسجيل only renames it.
     */
    @CacheEvict(value = "lookups-subjects", allEntries = true)
    @Transactional
    public Level3CodeResponse openLevelThree(String parentCode) {
        requireWriter();
        String vbSub = mid(parentCode, PREFIX_PARAM_LENGTH);
        String sub = truncate(vbSub, PREFIX_PARAM_LENGTH);

        String max = maxLevelThreeSuffix(sub);
        if (max == null) {
            // op_macnz would insert a NULL code and VB would stop on "Invalid use of Null".
            throw new BusinessException("تعذر توليد رمز المستوى الثالث تحت الرمز " + sub);
        }
        String newCode = truncate(sub + nextSuffix(max), CODE_PARAM_LENGTH);
        try {
            repository.insertLevelThreePlaceholder(newCode);
            entityManager.flush();
        } catch (DataIntegrityViolationException e) {
            throw new BusinessException("لا يمكن الاضافة: الرمز " + newCode + " مستخدم سابقا في المكنز");
        }
        String max1 = maxLevelThreeSuffix(sub);
        return new Level3CodeResponse(vbSub + nullToEmpty(max1));
    }

    // ─── Legacy algorithms ───────────────────────────────────────────────

    /** op_macnz / max_macnz: max(substring(sub_code, 7, 3)) where substring(sub_code, 1, 6) = @m_sub. */
    private String maxLevelThreeSuffix(String sub) {
        return repository.findAllRows().stream()
                .map(ThesaurusTermView::getCode)
                .filter(code -> code != null && LegacyCollation.equal(LegacyCollation.left(code, 6), sub))
                .map(code -> code.length() <= 6 ? "" : code.substring(6, Math.min(code.length(), 9)))
                .max(LegacyCollation::compare)
                .orElse(null);
    }

    /** The stored codes that "sub_code = @m_code" selects under the legacy collation. */
    private List<String> codesEqualTo(String code) {
        return repository.findAllRows().stream()
                .map(ThesaurusTermView::getCode)
                .filter(c -> LegacyCollation.equal(c, code))
                .toList();
    }

    /** T-SQL LTRIM: leading blanks only. */
    static String ltrim(String s) {
        int start = 0;
        while (start < s.length() && s.charAt(start) == ' ') {
            start++;
        }
        return s.substring(start);
    }

    /**
     * op_macnz: {@code @m_max = cast(max(...) as int) + 1};
     * {@code @m_no = substring('000', 1, 3 - len(ltrim(cast(@m_max as nvarchar)))) + ltrim(cast(@m_max as nvarchar))}.
     */
    static String nextSuffix(String max) {
        int value = sqlServerIntCast(max) + 1;
        String digits = String.valueOf(value);
        int pad = 3 - digits.length();
        if (pad < 0) {
            // SUBSTRING with a negative length: "Invalid length parameter passed to the substring function".
            throw new BusinessException("لا يمكن الاضافة: تجاوز عدد الواصفات في المستوى الثالث 999");
        }
        return "000".substring(0, pad) + digits;
    }

    /** T-SQL CAST(nvarchar AS int): blanks around the digits are ignored and '' is 0. */
    static int sqlServerIntCast(String s) {
        String t = vbTrim(s);
        if (t.isEmpty()) {
            return 0;
        }
        try {
            return Integer.parseInt(t.startsWith("+") ? t.substring(1) : t);
        } catch (NumberFormatException e) {
            throw new BusinessException("لا يمكن الاضافة: رموز المستوى الثالث تحت هذا الرمز ليست رقمية (" + t + ")");
        }
    }

    /**
     * Form5.div_word: splits the description on blanks and returns the words insr_word receives —
     * leading "ال" / "لل" stripped repeatedly, a leading "أ" turned into "ا", kept when longer than
     * two characters and not starting with a digit. Ported literally, including the outer
     * {@code While i < L} that skips a one-character last word and the "وال" test that can never
     * match (it compares a two-character Mid).
     */
    static List<String> divWord(String description) {
        List<String> words = new ArrayList<>();
        String swDesc = vbTrim(description);
        int len = swDesc.length();
        int i = 1;
        while (i < len) {
            StringBuilder word = new StringBuilder();
            while (!vbMid(swDesc, i, 1).equals(" ") && i < len + 1) {
                word.append(vbMid(swDesc, i, 1));
                i++;
            }
            String swDes = word.toString();
            int l1 = swDes.length();
            while (vbMid(swDesc, i, 1).equals(" ") && i < len + 1) {
                i++;
            }
            if (l1 > 1) {
                boolean again = true;
                while (again) {
                    String two = vbMid(swDes, 1, 2);
                    if (two.equals("ال") || two.equals("لل")) {
                        swDes = vbMid(swDes, 3, swDes.length() - 2);
                    } else if (two.equals("وال")) {
                        swDes = vbMid(swDes, 4, swDes.length() - 3);
                    } else if (vbMid(swDes, 1, 1).equals("أ")) {
                        swDes = "ا" + vbMid(swDes, 2, swDes.length() - 1);
                    } else {
                        again = false;
                    }
                }
            }
            // nb = InStr(1, "0123456789", Mid(sw_des, 1, 1)) — InStr of "" returns 1.
            String first = vbMid(swDes, 1, 1);
            boolean digitOrEmpty = first.isEmpty() || "0123456789".contains(first);
            if (swDes.length() > 2 && !digitOrEmpty) {
                words.add(swDes);
            }
        }
        return words;
    }

    /** serh_wrdmacnz: @desc nvarchar(50); @m_word nvarchar(20) = '%' + ltrim(@desc) + '%'. */
    static String wordPattern(String raw) {
        String desc = truncate(nullToEmpty(raw), WORD_SEARCH_PARAM_LENGTH);
        int start = 0;
        while (start < desc.length() && desc.charAt(start) == ' ') {
            start++;
        }
        return truncate("%" + desc.substring(start) + "%", WORD_PATTERN_LENGTH);
    }

    /** VB Mid(s, start, length) with a 1-based start; "" past the end. */
    static String vbMid(String s, int start, int length) {
        if (s == null || start > s.length() || length <= 0) {
            return "";
        }
        int from = start - 1;
        return s.substring(from, Math.min(s.length(), from + length));
    }

    /** VB Mid(code, 1, n) — a NULL sub_code concatenates as "". */
    private static String mid(String s, int length) {
        return vbMid(nullToEmpty(s), 1, length);
    }

    /** VB Trim / T-SQL LTRIM+RTRIM: blanks only. */
    static String vbTrim(String s) {
        if (s == null) {
            return "";
        }
        int start = 0;
        int end = s.length();
        while (start < end && s.charAt(start) == ' ') {
            start++;
        }
        while (end > start && s.charAt(end - 1) == ' ') {
            end--;
        }
        return s.substring(start, end);
    }

    private void requireWriter() {
        if (!isWriter(currentUserNo())) {
            throw new PermissionDeniedException("هذه العملية متاحة للمستخدم " + properties.getWriterUserNo() + " فقط");
        }
    }

    private boolean isWriter(String userNo) {
        return userNo != null && userNo.equals(properties.getWriterUserNo());
    }

    private String currentUserNo() {
        String username = SecurityUtils.getCurrentUsername();
        if (username == null) {
            return null;
        }
        return userRepository.findByUserName(username)
                .map(UserEntity::getUserNo)
                .map(String::trim)
                .orElse(null);
    }

    private static String nullToEmpty(String s) {
        return s == null ? "" : s;
    }

    private static String truncate(String s, int max) {
        return s.length() > max ? s.substring(0, max) : s;
    }
}
