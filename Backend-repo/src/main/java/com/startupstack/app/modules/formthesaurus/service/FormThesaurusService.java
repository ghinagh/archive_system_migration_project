package com.startupstack.app.modules.formthesaurus.service;

import com.startupstack.app.modules.formthesaurus.dto.CodingRow;
import com.startupstack.app.modules.formthesaurus.dto.FormQuery;
import com.startupstack.app.modules.formthesaurus.dto.FormRelationRow;
import com.startupstack.app.modules.formthesaurus.dto.FormRow;
import com.startupstack.app.modules.formthesaurus.dto.FormThesaurusContext;
import com.startupstack.app.modules.formthesaurus.dto.MacnzQuery;
import com.startupstack.app.modules.formthesaurus.dto.MacnzRow;
import com.startupstack.app.modules.formthesaurus.dto.NextNumberResponse;
import com.startupstack.app.modules.formthesaurus.dto.PositionRow;
import com.startupstack.app.modules.formthesaurus.dto.RelationWriteRequest;
import com.startupstack.app.modules.formthesaurus.dto.SaveResult;
import com.startupstack.app.modules.formthesaurus.dto.SubjectRelationRow;
import com.startupstack.app.modules.formthesaurus.repository.FormThesaurusRepository;
import com.startupstack.app.modules.users.entity.UserEntity;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.collation.LegacyCollation;
import com.startupstack.app.shared.collation.LegacyWords;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Clock;
import java.time.LocalDate;
import java.util.List;
import java.util.Objects;

/**
 * "المكنز الشكلي" — legacy coding.frm (ARCHIVE.frm menu التــرميــز → M2, Ctrl+B, key-protected).
 *
 * <p>Each method is one statement coding.frm sends — the RecordSources of cod1/cod2, pays1,
 * name_form1, position, rel_form, subject and frm_mcnz, the coding data-control AddNew/Update, and
 * the insr/upd/del/op/max procedures — with the parameter truncations of the procedure signatures.
 * Writes that legacy ran under "On Error Resume Next" and that fail on the column width report
 * {@code saved = false} instead of raising, as legacy silently continued.
 */
@Service
public class FormThesaurusService {

    /** CODING columns: SUB_CODE nvarchar(4), SUB_DESC nvarchar(100), SUB_LEVE nvarchar(1). */
    static final int CODING_CODE = 4;
    static final int CODING_DESC = 100;
    /** form columns: SUB_NAME nvarchar(60); procedure params @desc nvarchar(80), @m_sub_no nvarchar(8), @m_sub_typ nvarchar(2). */
    static final int FORM_NAME_COLUMN = 60;
    static final int FORM_DESC_PARAM = 80;
    static final int FORM_NO = 8;
    static final int FORM_TYP = 2;
    /** serh_* @desc nvarchar(50), serh_wrdform @m_word nvarchar(20), serh_macnz @desc nvarchar(40). */
    static final int SEARCH_DESC = 50;
    static final int WORD_PATTERN = 20;
    static final int MACNZ_SEARCH_DESC = 40;

    private final FormThesaurusRepository repository;
    private final UserRepository userRepository;
    private final Clock clock;

    @Autowired
    public FormThesaurusService(FormThesaurusRepository repository, UserRepository userRepository) {
        this(repository, userRepository, Clock.systemDefaultZone());
    }

    FormThesaurusService(FormThesaurusRepository repository, UserRepository userRepository, Clock clock) {
        this.repository = repository;
        this.userRepository = userRepository;
        this.clock = clock;
    }

    public FormThesaurusContext context() {
        String username = SecurityUtils.getCurrentUsername();
        Integer company = username == null ? null
                : userRepository.findByUserName(username).map(UserEntity::getUserCompany).orElse(null);
        return new FormThesaurusContext(company);
    }

    // ─── CODING (DBList1 = cod2, DBList2 = cod1) ─────────────────────────

    /** Form_Load: cod2.sql = "execute proc_v_coding1" — no ORDER BY. */
    @Transactional(readOnly = true)
    public List<CodingRow> codingLevelOne() {
        return repository.codingLevelOne();
    }

    /** DBList1 DblClick/Enter: cod1.sql = "execute coding_proc Mid(sub_code, 1, 2)" — order by sub_code. */
    @Transactional(readOnly = true)
    public List<CodingRow> codingChildren(String prefix) {
        return LegacyCollation.sortBy(repository.codingChildren(cut(prefix, 2)), CodingRow::code);
    }

    /** find_coding @m_code nvarchar(4) */
    @Transactional(readOnly = true)
    public List<CodingRow> findCoding(String code) {
        return repository.findCoding(cut(code, CODING_CODE));
    }

    /**
     * Command3 on DBList1/DBList2 with mod_typ = "1": the pending coding.Resultset.AddNew row gets
     * sub_code = code.Text, sub_desc = desc.Text, sub_leve, then Update. A value wider than the
     * column makes Update fail and "On Error Resume Next" skips it.
     */
    @Transactional
    @CacheEvict(value = "lookups-coding", allEntries = true)
    public SaveResult insertCoding(String code, String description, String level) {
        String c = nz(code);
        String d = nz(description);
        String l = nz(level);
        if (c.length() > CODING_CODE || d.length() > CODING_DESC || l.length() > 1) {
            return new SaveResult(false);
        }
        repository.insertCoding(c, d, l);
        return new SaveResult(true);
    }

    /** upd_coding @desc nvarchar(100), @m_code nvarchar(4) */
    @Transactional
    @CacheEvict(value = "lookups-coding", allEntries = true)
    public void updateCoding(String code, String description) {
        repository.updateCoding(cut(description, CODING_DESC), cut(code, CODING_CODE));
    }

    /** del_coding @sa nvarchar(4) */
    @Transactional
    @CacheEvict(value = "lookups-coding", allEntries = true)
    public void deleteCoding(String code) {
        repository.deleteCoding(cut(code, CODING_CODE));
    }

    // ─── form (DataList1 = pays1 countries, DataList2 = name_form1 names, DBList8 picker) ───

    @Transactional(readOnly = true)
    public List<FormRow> forms(FormQuery query, String type, String country, String text, Integer lent, String pays) {
        String desc = cut(text, SEARCH_DESC);
        int len = lent == null ? 0 : Math.max(0, lent);
        return switch (query) {
            // "select * from pay_form" — the view has no ORDER BY
            case COUNTRIES -> repository.countries();
            // serh_form: SUBSTRING(sub_no, 4, 5) = '00000' and substring(sub_name, 1, @lent) = ltrim(@desc)
            case COUNTRY_SEARCH -> repository.countryRows().stream().filter(r -> prefix(r.name(), len, desc)).toList();
            // nam_form: sub_typ = @v_typ AND SUBSTRING(sub_no, 1, 3) = @v_cod order by sub_typ + sub_no
            case NAMES -> LegacyCollation.sortBy(repository.formsOf(cut(type, 2), cut(country, 3)), FormRow::code);
            // serh1_form: … and substring(sub_name, 1, @lent) = ltrim(@desc) order by sub_name
            case NAME_SEARCH -> LegacyCollation.sortBy(repository.formsOf(cut(type, 2), cut(country, 3)).stream()
                    .filter(r -> prefix(r.name(), len, desc)).toList(), FormRow::name);
            // serh_allform: substring(sub_name, 1, @lent) = ltrim(@desc) order by sub_name
            case ALL_SEARCH -> LegacyCollation.sortBy(repository.allForms().stream()
                    .filter(r -> prefix(r.name(), len, desc)).toList(), FormRow::name);
            // serh_wrdform: sub_name like @m_word, @m_word nvarchar(20) = '%' + ltrim(@desc) + '%'
            case LIKE_SEARCH -> {
                String pattern = cut("%" + ltrim(desc) + "%", WORD_PATTERN);
                yield repository.allForms().stream().filter(r -> LegacyCollation.like(r.name(), pattern)).toList();
            }
            // serh_wrdform1: word ⋈ form, sub_typ6 = '2', substring(sub_code6, 1, 5) = @m_pays,
            //                substring(word.sub_desc6, 1, @lent) = ltrim(@desc)
            case WORD_SEARCH -> repository.wordJoinedForms(cut(pays, 5)).stream()
                    .filter(r -> prefix((String) r[1], len, desc))
                    .map(r -> (FormRow) r[0])
                    .toList();
        };
    }

    /** find_form @m_SUB_NO nvarchar(8), @M_SUB_TYP nvarchar(2) */
    @Transactional(readOnly = true)
    public List<FormRow> findForm(String number, String type) {
        return repository.findForm(cut(number, FORM_NO), cut(type, FORM_TYP));
    }

    /** insr_form @desc nvarchar(80) into SUB_NAME nvarchar(60) — a longer name fails the insert. */
    @Transactional
    public SaveResult insertForm(String description, String number, String type) {
        String name = cut(description, FORM_DESC_PARAM);
        if (name.length() > FORM_NAME_COLUMN) {
            return new SaveResult(false);
        }
        repository.insertForm(cut(type, FORM_TYP), cut(number, FORM_NO), name, LocalDate.now(clock));
        return new SaveResult(true);
    }

    /** upd_form @desc nvarchar(80), @m_sub_no nvarchar(8), @m_sub_typ nvarchar(2) */
    @Transactional
    public SaveResult updateForm(String description, String number, String type) {
        String name = cut(description, FORM_DESC_PARAM);
        if (name.length() > FORM_NAME_COLUMN) {
            return new SaveResult(false);
        }
        repository.updateForm(name, cut(number, FORM_NO), cut(type, FORM_TYP));
        return new SaveResult(true);
    }

    /** del_form */
    @Transactional
    public void deleteForm(String number, String type) {
        repository.deleteForm(cut(number, FORM_NO), cut(type, FORM_TYP));
    }

    /**
     * Command1 on the names list: {@code EXECUTE OP_FORM m_sub, today} inserts the next number of
     * that type/country with an empty name, then {@code max_form m_sub} gives code.Text =
     * Mid(m_sub, 1, 2) + max(sub_no). The row exists from here on; تسجيل only names it.
     */
    @Transactional
    public NextNumberResponse nextNumber(String sub) {
        String m = cut(sub, 5);
        String max = repository.formsWithPrefix(m).stream()
                .map(FormRow::number).filter(Objects::nonNull)
                .map(no -> LegacyWords.vbMid(no, 4, 5))
                .max(LegacyCollation::compare).orElse(null);
        if (max == null) {
            // op_form would insert a NULL row and VB stops on "Invalid use of Null" (max_form returns NULL).
            throw new BusinessException("تعذر توليد الرقم: لا توجد سجلات تحت " + m);
        }
        int next = sqlServerIntCast(max) + 1;
        String digits = String.valueOf(next);
        int pad = 5 - digits.length();
        if (pad < 0) {
            throw new BusinessException("لا يمكن الاضافة: تجاوز عدد السجلات تحت " + m + " الحد 99999");
        }
        String no1 = cut(m + "00000".substring(0, pad) + digits, 10);
        repository.insertForm(LegacyWords.vbMid(no1, 1, 2), LegacyWords.vbMid(no1, 3, 8), null, LocalDate.now(clock));
        String max1 = repository.formsWithPrefix(m).stream()
                .map(FormRow::number).filter(Objects::nonNull)
                .max(LegacyCollation::compare).orElseThrow();
        return new NextNumberResponse(LegacyWords.vbMid(m, 1, 2) + max1);
    }

    /** Command3 mod_typ "2" on countries / names: del_word m_code, '2' then div_word(m_code, m_desc, "2"). */
    @Transactional
    public void replaceWords(String code, String description) {
        String c = cut(code, 10);
        repository.deleteWords(c, "2");
        for (String word : LegacyWords.divWord(description)) {
            repository.insertWord(cut(word, 12), c, "2");
        }
    }

    /** Command3 mod_typ "1" on countries: Call div_word(m_code, m_desc, "2") without a preceding del_word. */
    @Transactional
    public void addWords(String code, String description) {
        String c = cut(code, 10);
        for (String word : LegacyWords.divWord(description)) {
            repository.insertWord(cut(word, 12), c, "2");
        }
    }

    // ─── POSITION (DBList5) ─────────────────────────────────────────────

    /** proc_pos @m_pos_no varchar(10) */
    @Transactional(readOnly = true)
    public List<PositionRow> positions(String number) {
        return repository.positions(cut(number, 10));
    }

    /** insr_pos @desc nvarchar(80), @m_sub_no nvarchar(10), today */
    @Transactional
    public void insertPosition(String description, String number) {
        repository.insertPosition(cut(number, 10), cut(description, 80), LocalDate.now(clock));
    }

    /** upd_position: set pos_nam = @desc where pos_no = @m_sub_no AND pos_nam = @desc1 */
    @Transactional
    public void updatePosition(String description, String number, String oldDescription) {
        String no = cut(number, 10);
        List<String> names = matchingNames(no, cut(oldDescription, 80));
        if (!names.isEmpty()) {
            repository.updatePositions(cut(description, 80), no, names);
        }
    }

    /** del_position: where POS_no = @m_sub_no and POS_NAM = @m_POS_NAM */
    @Transactional
    public void deletePosition(String number, String name) {
        String no = cut(number, 10);
        List<String> names = matchingNames(no, cut(name, 80));
        if (!names.isEmpty()) {
            repository.deletePositions(no, names);
        }
    }

    private List<String> matchingNames(String number, String name) {
        return repository.positions(number).stream().map(PositionRow::name)
                .filter(n -> LegacyCollation.equal(n, name)).distinct().toList();
    }

    // ─── REL_FORM (DBList6) / SUBJECT (DBList7) ─────────────────────────

    /** rel_form_proc @m_rlf_form nvarchar(10), @m_rel nvarchar(2) */
    @Transactional(readOnly = true)
    public List<FormRelationRow> formRelations(String form, String relation) {
        return repository.formRelations(cut(form, 10), cut(relation, 2));
    }

    /** subject_proc @m_sub_form nvarchar(10), @m_rel nvarchar(2) */
    @Transactional(readOnly = true)
    public List<SubjectRelationRow> subjectRelations(String form, String relation) {
        return repository.subjectRelations(cut(form, 10), cut(relation, 2));
    }

    /** insr_rel_form @m_RLF_FRM1 nvarchar(10), @m_RLF_FRM2 nvarchar(10), @m_rel nvarchar(2) */
    @Transactional
    public void insertFormRelation(RelationWriteRequest r) {
        repository.insertFormRelation(cut(r.first(), 10), cut(r.second(), 10), cut(r.relation(), 2));
    }

    /** insr_subject @m_frm nvarchar(10), @m_mcnz nvarchar(9), @m_rel nvarchar(2) */
    @Transactional
    public void insertSubjectRelation(RelationWriteRequest r) {
        try {
            repository.insertSubjectRelation(cut(r.first(), 10), cut(r.second(), 9), cut(r.relation(), 2));
        } catch (DataIntegrityViolationException e) {
            throw new BusinessException("لا يمكن الربط: الواصفة " + r.second() + " غير موجودة في المكنز");
        }
    }

    /** upd_rfl_dte — an empty date box is stored as NULL. */
    @Transactional
    public void updateFormRelationDates(RelationWriteRequest r) {
        repository.updateFormRelationDates(cut(r.first(), 10), cut(r.second(), 10), cut(r.relation(), 2), r.start(), r.end());
    }

    /** upd_sub_dte */
    @Transactional
    public void updateSubjectRelationDates(RelationWriteRequest r) {
        repository.updateSubjectRelationDates(cut(r.first(), 10), cut(r.second(), 9), cut(r.relation(), 2), r.start(), r.end());
    }

    /** del_rel_form */
    @Transactional
    public void deleteFormRelation(String first, String second, String relation) {
        repository.deleteFormRelation(cut(first, 10), cut(second, 10), cut(relation, 2));
    }

    /** del_subject */
    @Transactional
    public void deleteSubjectRelation(String form, String macnz, String relation) {
        repository.deleteSubjectRelation(cut(form, 10), cut(macnz, 9), cut(relation, 2));
    }

    // ─── MACNZ picker (DBList8 over frm_mcnz) ───────────────────────────

    @Transactional(readOnly = true)
    public List<MacnzRow> macnz(MacnzQuery query, String text, Integer lent) {
        return switch (query) {
            case ALL -> repository.allMacnz();
            // serh_macnz @desc nvarchar(40): substring(sub_desc, 1, @lent) = ltrim(@desc) order by sub_desc
            case PREFIX -> {
                String desc = cut(text, MACNZ_SEARCH_DESC);
                int len = lent == null ? 0 : Math.max(0, lent);
                yield LegacyCollation.sortBy(repository.allMacnz().stream()
                        .filter(r -> prefix(r.description(), len, desc)).toList(), MacnzRow::description);
            }
            // serh_wrdmacnz @desc nvarchar(50): sub_desc like @m_word nvarchar(20)
            case WORD -> {
                String pattern = cut("%" + ltrim(cut(text, SEARCH_DESC)) + "%", WORD_PATTERN);
                yield repository.allMacnz().stream().filter(r -> LegacyCollation.like(r.description(), pattern)).toList();
            }
        };
    }

    // ─── helpers ────────────────────────────────────────────────────────

    /** substring(column, 1, @lent) = ltrim(@desc) under the legacy collation; NULL never matches. */
    private static boolean prefix(String value, int lent, String desc) {
        return value != null && LegacyCollation.equal(LegacyCollation.left(value, lent), ltrim(desc));
    }

    /** T-SQL CAST(nvarchar AS int): blanks around the digits are ignored and '' is 0. */
    static int sqlServerIntCast(String s) {
        String t = LegacyWords.vbTrim(s);
        if (t.isEmpty()) {
            return 0;
        }
        try {
            return Integer.parseInt(t.startsWith("+") ? t.substring(1) : t);
        } catch (NumberFormatException e) {
            throw new BusinessException("لا يمكن الاضافة: ارقام السجلات ليست رقمية (" + t + ")");
        }
    }

    static String ltrim(String s) {
        int i = 0;
        while (i < s.length() && s.charAt(i) == ' ') {
            i++;
        }
        return s.substring(i);
    }

    /** nvarchar(n) parameter: silently truncated; NULL becomes "". */
    static String cut(String s, int max) {
        String v = nz(s);
        return v.length() > max ? v.substring(0, max) : v;
    }

    private static String nz(String s) {
        return s == null ? "" : s;
    }
}
