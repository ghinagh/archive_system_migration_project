package com.startupstack.app.modules.formthesaurus.service;

import com.startupstack.app.modules.formthesaurus.dto.AdditionalFileCriterion;
import com.startupstack.app.modules.formthesaurus.dto.AdditionalFileRow;
import com.startupstack.app.modules.formthesaurus.repository.AdditionalFilesRepository;
import com.startupstack.app.modules.users.entity.UserEntity;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.collation.LegacyCollation;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.time.Clock;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * "ملفات اضافية للادخال" — legacy tmp_file.frm, opened by coding.frm Command7 ("الملفات الاضافية للادخال").
 *
 * <p>The form builds "create proc tmp_result as SELECT DISTINCT <the 8 columns> FROM tmp_fileadd" +
 * crit1 + "order by tmp_ser desc" and shows it in DataGrid1. {@link #search} evaluates that statement
 * for the conditions crit1 holds (AND-ed), with the legacy collation for "=" and LIKE.
 */
@Service
public class AdditionalFilesService {

    /** tmp_fileadd column widths (nvarchar(7), nvarchar(50), nvarchar(50), nvarchar(30), char(3)). */
    static final Map<String, Integer> WIDTH = Map.of("tmp_fad_no", 7, "tmp_file_name", 50, "tmp_rmrk", 50,
            "tmp_mk", 30, "tmp_user_no", 3);

    private final AdditionalFilesRepository repository;
    private final UserRepository userRepository;
    private final Clock clock;

    @Autowired
    public AdditionalFilesService(AdditionalFilesRepository repository, UserRepository userRepository) {
        this(repository, userRepository, Clock.systemDefaultZone());
    }

    AdditionalFilesService(AdditionalFilesRepository repository, UserRepository userRepository, Clock clock) {
        this.repository = repository;
        this.userRepository = userRepository;
        this.clock = clock;
    }

    /** execute tmp_result — SELECT DISTINCT … FROM tmp_fileadd WHERE <criteria> ORDER BY tmp_ser DESC */
    @Transactional(readOnly = true)
    public List<AdditionalFileRow> search(List<AdditionalFileCriterion> criteria) {
        List<AdditionalFileRow> rows = repository.all().stream()
                .filter(r -> criteria.stream().allMatch(c -> matches(r, c)))
                .sorted(Comparator.comparing(AdditionalFileRow::serial, Comparator.nullsLast(Comparator.<Double>reverseOrder())))
                .toList();
        // SELECT DISTINCT: rows equal under the column collation are one row
        List<AdditionalFileRow> distinct = new ArrayList<>();
        for (AdditionalFileRow r : rows) {
            boolean dup = false;
            for (int k = distinct.size() - 1; k >= 0 && Objects.equals(distinct.get(k).serial(), r.serial()); k--) {
                if (same(distinct.get(k), r)) { dup = true; break; }
            }
            if (!dup) distinct.add(r);
        }
        return distinct;
    }

    static boolean matches(AdditionalFileRow r, AdditionalFileCriterion c) {
        LocalDateTime d = c.date() == null ? null : c.date().atStartOfDay();
        return switch (c.kind()) {
            // ( tmp_DaTE >= convert(datetime, 'yyyy-mm-dd', 102) or tmp_date is null )
            case FROM -> r.date() == null || (d != null && !r.date().isBefore(d));
            case TO -> r.date() == null || (d != null && !r.date().isAfter(d));
            // tmp_user_no = 'text'
            case USER -> LegacyCollation.equal(r.userNo(), c.text());
            // tmp_file_name + tmp_rmrk like '%text%' (NULL + x is NULL)
            case WORD -> r.fileName() != null && r.remark() != null
                    && LegacyCollation.like(r.fileName() + r.remark(), "%" + (c.text() == null ? "" : c.text()) + "%");
            case FINAL -> Objects.equals(r.finalFlag(), 1);
            case NOT_FINAL -> r.finalFlag() == null || r.finalFlag() == 0;
        };
    }

    private static boolean same(AdditionalFileRow a, AdditionalFileRow b) {
        return eqText(a.fileNo(), b.fileNo()) && Objects.equals(a.finalFlag(), b.finalFlag())
                && eqText(a.fileName(), b.fileName()) && eqText(a.remark(), b.remark()) && eqText(a.place(), b.place())
                && Objects.equals(a.date(), b.date()) && eqText(a.userNo(), b.userNo()) && Objects.equals(a.serial(), b.serial());
    }

    private static boolean eqText(String a, String b) {
        return a == null ? b == null : b != null && LegacyCollation.equal(a, b);
    }

    /**
     * DataGrid1 KeyUp Insert: execute op_tmp Form2.Text1, box_user_no, today — the next tmp_ser of this
     * user (1 when none), tmp_final 0. @m_code char(7) and @m_user_no char(3) are blank-padded.
     */
    @Transactional
    public void insertOp(String fileNo) {
        String user = currentUserNo();
        String code = pad(fileNo == null ? "" : fileNo, 7);
        Double max = repository.maxSerial(user);
        // declare @max1 int: select @max1 = max(tmp_ser) truncates the float; NULL → 1, else + 1
        double serial = max == null ? 1 : (int) max.doubleValue() + 1;
        repository.insertOp(serial, user == null ? null : pad(user, 3), code,
                Timestamp.valueOf(LocalDate.now(clock).atStartOfDay()));
    }

    /** DataGrid1 cell edit (AllowUpdate): the new cell text written to the field, the row located by its original values. */
    @Transactional
    public void updateCell(AdditionalFileRow original, String column, String text) {
        String col = AdditionalFilesRepository.COLUMNS.get(column);
        if (col == null || original == null) throw new BusinessException("عمود غير معروف");
        Object value = convert(col, text);
        try {
            repository.updateColumn(col, value, original);
        } catch (DataIntegrityViolationException e) {
            throw new BusinessException("تعذر حفظ القيمة");
        }
    }

    /** DataGrid1 new row (AllowAddNew): the filled columns inserted, the others NULL. */
    @Transactional
    public void insertRow(Map<String, String> values) {
        Map<String, Object> cols = new LinkedHashMap<>();
        for (Map.Entry<String, String> e : values.entrySet()) {
            String col = AdditionalFilesRepository.COLUMNS.get(e.getKey());
            if (col != null && e.getValue() != null) cols.put(col, convert(col, e.getValue()));
        }
        if (cols.get("tmp_fad_no") == null) {
            throw new BusinessException("لا يمكن الحفظ: رقم الملف مطلوب (tmp_fad_no NOT NULL)");
        }
        try {
            repository.insert(cols);
        } catch (DataIntegrityViolationException e) {
            throw new BusinessException("تعذر حفظ السجل");
        }
    }

    /** DataGrid1 row delete (AllowDelete). */
    @Transactional
    public void deleteRow(AdditionalFileRow original) {
        repository.delete(original);
    }

    // ─── conversions the ADO field assignment performs ───

    static Object convert(String col, String text) {
        String t = text == null ? "" : text;
        switch (col) {
            case "tmp_date": {
                if (t.isBlank()) return null;
                LocalDate d = vbDate(t);
                // tmp_date smalldatetime: 1900-01-01 … 2079-06-06
                if (d == null || d.isBefore(LocalDate.of(1900, 1, 1)) || d.isAfter(LocalDate.of(2079, 6, 6))) {
                    throw new BusinessException("قيمة غير صالحة لحقل التاريخ: " + t);
                }
                return Timestamp.valueOf(d.atStartOfDay());
            }
            case "tmp_final": {
                if (t.isBlank()) return null;
                try {
                    return Integer.parseInt(t.trim());
                } catch (NumberFormatException e) {
                    throw new BusinessException("قيمة غير صالحة لحقل منجز: " + t);
                }
            }
            case "tmp_ser": {
                if (t.isBlank()) return null;
                try {
                    return Double.parseDouble(t.trim());
                } catch (NumberFormatException e) {
                    throw new BusinessException("قيمة غير صالحة لحقل المتسلسل: " + t);
                }
            }
            default: {
                Integer w = WIDTH.get(col);
                if (w != null && t.length() > w) throw new BusinessException("القيمة اطول من الحقل (" + w + ")");
                // tmp_user_no char(3): any value of up to 3 characters (no user check), blank-padded
                return "tmp_user_no".equals(col) ? pad(t, 3) : t;
            }
        }
    }

    private static final Pattern DATE = Pattern.compile("^\\s*(\\d{1,2})[/.-](\\d{1,2})[/.-](\\d{2}|\\d{4})\\s*$");

    /** VB CDate on the Arabic-locale dd/mm/yyyy text, falling back to mm/dd when dd/mm is impossible. */
    public static LocalDate vbDate(String text) {
        Matcher m = DATE.matcher(text);
        if (!m.matches()) return null;
        int a = Integer.parseInt(m.group(1));
        int b = Integer.parseInt(m.group(2));
        int y = Integer.parseInt(m.group(3));
        if (m.group(3).length() == 2) y += y < 30 ? 2000 : 1900;
        LocalDate d = date(y, b, a);
        return d != null ? d : date(y, a, b);
    }

    private static LocalDate date(int y, int month, int day) {
        try {
            return LocalDate.of(y, month, day);
        } catch (RuntimeException e) {
            return null;
        }
    }

    private static String pad(String s, int n) {
        return s.length() >= n ? s : s + " ".repeat(n - s.length());
    }

    private String currentUserNo() {
        String username = SecurityUtils.getCurrentUsername();
        return username == null ? null
                : userRepository.findByUserName(username).map(UserEntity::getUserNo).orElse(null);
    }
}
