package com.startupstack.app.modules.authors.service;

import com.startupstack.app.modules.authors.dto.AuthorCodingInsertRequest;
import com.startupstack.app.modules.authors.dto.AuthorCodingQuery;
import com.startupstack.app.modules.authors.dto.AuthorCodingRow;
import com.startupstack.app.modules.authors.dto.AuthorCodingUpdateRequest;
import com.startupstack.app.modules.authors.entity.AuthorEntity;
import com.startupstack.app.modules.authors.repository.AuthorCodingRepository;
import com.startupstack.app.shared.exception.BusinessException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * "المؤلفين ودور النشر" — legacy Form8.frm (ARCHIVE.frm menu التــرميــز → m10, Ctrl+K).
 *
 * Each method is one statement the form sent through its MSRDC "auther" control or cn.Execute:
 * the list queries (RecordSource, serh_auther1 — also the Enter-key duplicate check —,
 * serh_auther2, "select * from auther") and insr_auther / upd_auther / del_auther. Parameter shaping
 * (VB Trim, the nvarchar(15)/(100) truncations) follows the legacy call sites so the same
 * text matches the same rows.
 */
@Service
public class AuthorCodingService {

    /** insr_auther / upd_auther @desc nvarchar(100). */
    static final int NAME_PARAM_LENGTH = 100;
    /** serh_auther2 @desc nvarchar(15) and its local @m_word nvarchar(15). */
    static final int WORD_PARAM_LENGTH = 15;

    private final AuthorCodingRepository repository;

    public AuthorCodingService(AuthorCodingRepository repository) {
        this.repository = repository;
    }

    @Transactional(readOnly = true)
    public List<AuthorCodingRow> list(AuthorCodingQuery query, String text) {
        List<AuthorEntity> rows = switch (query) {
            case BY_NUMBER -> repository.findAllOrderByNumber();
            case UNORDERED -> repository.findAllUnordered();
            case PREFIX -> {
                String prefix = vbTrim(text);
                yield repository.findByNamePrefix(prefix, prefix.length());
            }
            case WORD -> repository.findByNameLike(wordPattern(text));
        };
        return rows.stream().map(e -> new AuthorCodingRow(e.getAutNo(), e.getAutName())).toList();
    }

    public AuthorCodingRow insert(AuthorCodingInsertRequest request) {
        Double number = parseNumber(request.number());
        String name = nameParam(request.name());
        try {
            repository.insert(name, number);
        } catch (DataIntegrityViolationException e) {
            throw new BusinessException("لا يمكن التسجيل: الرقم " + formatNumber(number)
                    + " مستخدم سابقا لمؤلف او دار نشر اخرى");
        }
        return new AuthorCodingRow(number, name);
    }

    public void updateName(Double number, AuthorCodingUpdateRequest request) {
        repository.updateName(nameParam(request.name()), number);
    }

    public void delete(Double number) {
        try {
            repository.deleteByNumber(number);
        } catch (DataIntegrityViolationException e) {
            throw new BusinessException("لا يمكن الالغاء: المؤلف او دار النشر رقم " + formatNumber(number)
                    + " مستخدم في وثائق او كتب مسجلة");
        }
    }

    /** VB Trim / SQL LTRIM+RTRIM: blanks only, not other whitespace. */
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

    /**
     * serh_auther2: @desc nvarchar(15) receives desc.Text untrimmed, then
     * @m_word nvarchar(15) = '%' + ltrim(@desc) + '%' — both assignments truncate silently.
     */
    static String wordPattern(String raw) {
        String desc = truncate(raw == null ? "" : raw, WORD_PARAM_LENGTH);
        int start = 0;
        while (start < desc.length() && desc.charAt(start) == ' ') {
            start++;
        }
        return truncate("%" + desc.substring(start) + "%", WORD_PARAM_LENGTH);
    }

    /** code.Text → float(8): SQL Server converts an empty string to 0; non-numeric text was a runtime error. */
    static Double parseNumber(String raw) {
        String text = vbTrim(raw);
        if (text.isEmpty()) {
            return 0d;
        }
        try {
            double value = Double.parseDouble(text);
            if (Double.isNaN(value) || Double.isInfinite(value)) {
                throw new NumberFormatException(text);
            }
            return value;
        } catch (NumberFormatException e) {
            throw new BusinessException("الرقم غير صالح: " + text);
        }
    }

    private static String nameParam(String name) {
        return truncate(name == null ? "" : name, NAME_PARAM_LENGTH);
    }

    private static String truncate(String s, int max) {
        return s.length() > max ? s.substring(0, max) : s;
    }

    private static String formatNumber(Double number) {
        return number % 1 == 0 ? String.valueOf(number.longValue()) : String.valueOf(number);
    }
}
