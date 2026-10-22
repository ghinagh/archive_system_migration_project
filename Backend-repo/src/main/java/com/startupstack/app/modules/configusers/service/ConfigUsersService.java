package com.startupstack.app.modules.configusers.service;

import com.startupstack.app.modules.configusers.dto.FieldRow;
import com.startupstack.app.modules.configusers.dto.FormTypeRow;
import com.startupstack.app.modules.configusers.dto.RangeRow;
import com.startupstack.app.modules.configusers.repository.ConfigUsersRepository;
import com.startupstack.app.shared.exception.BusinessException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * "معالجة المستخدمين" — legacy config_users.frm (ARCHIVE.frm m31, key 261015).
 *
 * <p>Three editable DataGrids and no buttons: DataGrid1 on config (RESULT), DataGrid3 on the
 * per-user display fields (t_bnkout), DataGrid2 on ranjpath (ranj), and the "نوع الاستمارة"
 * DataCombo on VIEW_CODING38. DataGrid1 DblClick shows a user's fields, F4 creates them, F3 deletes
 * them.
 */
@Service
public class ConfigUsersService {

    /** DataGrid1 columns (Column00 … Column09) and their legacy widths: char(n), or 0 for int. */
    static final Map<String, Integer> GRID1 = new LinkedHashMap<>();

    static {
        GRID1.put("user_no", 3);
        GRID1.put("user_name", 50);
        GRID1.put("user_password", 15);
        GRID1.put("user_cnf_path", 100);
        GRID1.put("user_start", 0);
        GRID1.put("USER_PWD", 0);
        GRID1.put("user_cmpvd", 100);
        GRID1.put("user_video_path", 100);
        GRID1.put("user_company", 0);
        GRID1.put("user_video_path1", 100);
    }

    /** DataGrid2 columns: rjp_nofrom char(10), rjp_noto char(10), rjp_path char(200), rjp_typ int. */
    static final Map<String, Integer> GRID2 = Map.of("rjp_nofrom", 10, "rjp_noto", 10, "rjp_path", 200, "rjp_typ", 0);

    /** DataGrid3 editable columns → user_bnkout column, width (Column00 user_no / Column01 المتسلسل are Locked). */
    static final Map<String, String> GRID3 = Map.of("user_out_choice", "user_out_choice", "user_out_index", "user_index");

    private final ConfigUsersRepository repository;

    public ConfigUsersService(ConfigUsersRepository repository) {
        this.repository = repository;
    }

    // ─── m_ist_no / coding38 ───

    @Transactional(readOnly = true)
    public List<FormTypeRow> formTypes() {
        return repository.formTypes();
    }

    // ─── DataGrid1 (RESULT: select config.* from config) ───

    @Transactional(readOnly = true)
    public List<Map<String, Object>> users() {
        return repository.configRows();
    }

    @Transactional
    public void updateUser(Map<String, Object> original, String column, String text) {
        if (original == null || !GRID1.containsKey(column)) throw new BusinessException("عمود غير معروف");
        Object value = convert(column, GRID1.get(column), text);
        if ("user_no".equals(column) && value != null
                && !String.valueOf(value).trim().equals(String.valueOf(original.get("user_no")).trim())
                && repository.userNoExists(value)) {
            throw new BusinessException("تعذر حفظ القيمة: رقم المستخدم " + String.valueOf(value).trim() + " موجود سابقا");
        }
        int n;
        try {
            n = repository.updateConfig(column, value, original);
        } catch (DataIntegrityViolationException e) {
            throw new BusinessException("تعذر حفظ القيمة: " + rootMessage(e));
        }
        located(n);
    }

    @Transactional
    public void insertUser(Map<String, String> values) {
        Map<String, Object> cols = new LinkedHashMap<>();
        for (Map.Entry<String, String> e : values.entrySet()) {
            if (GRID1.containsKey(e.getKey()) && e.getValue() != null) {
                cols.put(e.getKey(), convert(e.getKey(), GRID1.get(e.getKey()), e.getValue()));
            }
        }
        if (cols.isEmpty()) return;
        if (cols.get("user_no") != null && repository.userNoExists(cols.get("user_no"))) {
            throw new BusinessException("تعذر حفظ السجل: رقم المستخدم " + String.valueOf(cols.get("user_no")).trim() + " موجود سابقا");
        }
        try {
            repository.insertConfig(cols);
        } catch (DataIntegrityViolationException e) {
            throw new BusinessException("تعذر حفظ السجل: " + rootMessage(e));
        }
    }

    @Transactional
    public void deleteUser(Map<String, Object> original) {
        int n;
        try {
            n = repository.deleteConfig(original);
        } catch (DataIntegrityViolationException e) {
            throw new BusinessException("تعذر حذف السجل: " + rootMessage(e));
        }
        located(n);
    }

    // ─── DataGrid3 (t_bnkout) ───

    /** Form_Load: t_bnkout = select … from view_user_bnkout (every user's bnkout fields). */
    @Transactional(readOnly = true)
    public List<FieldRow> allFields() {
        return repository.allUserFields();
    }

    /**
     * datagrid1_DblClick: Mid(m_ist_no.BoundText, 3, 2) = "01" → execute proc_user_bnkout, else
     * execute proc_user_pout — both with (DataGrid1.Columns(0), Mid(BoundText, 3, 2)).
     */
    @Transactional(readOnly = true)
    public List<FieldRow> userFields(String userNo, String formType) {
        String ist = ist(formType);
        String user = param(userNo, 3);
        return "01".equals(ist) ? repository.procUserBnkout(user, ist) : repository.procUserPout(user, ist);
    }

    /**
     * DataGrid1_KeyUp F4: when serh_user_bnkout finds no fields for the user and form type, one
     * insr_user_bnkout per bnkout row with out_chioce 1 or 2 ("01") or per pout row of that out_ist.
     * Each insert is its own statement, as cn.Execute ran them. Returns how many were created.
     */
    public int createFields(String userNo, String formType) {
        String ist = ist(formType);
        String user = param(userNo, 3);
        List<Object[]> source;
        if ("01".equals(ist)) {
            if (repository.countUserFields(user, ist) > 0) return 0;
            source = repository.bnkoutChoices();
        } else {
            int n;
            try {
                n = Integer.parseInt(ist.trim());
            } catch (NumberFormatException e) {
                throw new BusinessException("نوع الاستمارة غير صالح: " + ist);
            }
            source = repository.poutChoices(n);
            if (repository.countUserFields(user, ist) > 0) return 0;
        }
        if (source.isEmpty()) {
            // BNKOUT2/pout1.Resultset.MoveFirst on an empty resultset — a VB runtime error in legacy
            throw new BusinessException("لا توجد حقول عرض (out_chioce = 1 او 2) لنوع الاستمارة " + ist);
        }
        int created = 0;
        for (Object[] r : source) {
            int num = outNum(r[0]);
            // @m_out_index char(3): the quoted VB text of out_indx3, truncated by the parameter
            String index = param(vbText(r[1]), 3);
            if (repository.userFieldExists(user, num, ist)) {
                throw new BusinessException("تعذر اضافة الحقل " + num + ": الحقل مضاف سابقا لهذا المستخدم");
            }
            try {
                repository.insertUserField(user, num, index, ist);
            } catch (DataIntegrityViolationException e) {
                throw new BusinessException("تعذر اضافة الحقل " + num + ": " + rootMessage(e));
            }
            created++;
        }
        return created;
    }

    /**
     * DataGrid1_KeyUp F3: InputBox "هل تريد الغاء حقول العرض (ن/ك)" answered "y" or "ن" →
     * execute del_user_bnkout (user, Mid(BoundText, 3, 2)).
     */
    @Transactional
    public int deleteFields(String userNo, String formType) {
        return repository.deleteUserFields(param(userNo, 3), ist(formType));
    }

    @Transactional
    public void updateField(FieldRow row, String column, String text) {
        String col = GRID3.get(column);
        if (row == null || col == null) throw new BusinessException("عمود غير معروف");
        Object value = "user_index".equals(col) ? convert(col, 3, text) : convert(col, 0, text);
        int n;
        try {
            n = repository.updateUserField(col, value, row);
        } catch (DataIntegrityViolationException e) {
            throw new BusinessException("تعذر حفظ القيمة: " + rootMessage(e));
        }
        located(n);
    }

    // ─── DataGrid2 (ranj: select ranjpath.* from ranjpath) ───

    @Transactional(readOnly = true)
    public List<RangeRow> ranges() {
        return repository.ranges();
    }

    @Transactional
    public void updateRange(Integer rjpNo, String column, String text) {
        if (rjpNo == null || !GRID2.containsKey(column)) throw new BusinessException("عمود غير معروف");
        located(repository.updateRange(rjpNo, column, convert(column, GRID2.get(column), text)));
    }

    @Transactional
    public void insertRange(Map<String, String> values) {
        Map<String, Object> cols = new LinkedHashMap<>();
        for (String c : ConfigUsersRepository.RANGE_COLUMNS) {
            String t = values.get(c);
            if (t != null) cols.put(c, convert(c, GRID2.get(c), t));
        }
        if (cols.isEmpty()) return;
        repository.insertRange(cols);
    }

    @Transactional
    public void deleteRange(Integer rjpNo) {
        if (rjpNo == null) throw new BusinessException("السجل غير موجود");
        located(repository.deleteRange(rjpNo));
    }

    // ─── conversions the ADO field assignment / proc parameters perform ───

    /** A DataGrid cell text written to a char(width) or int (width 0) field. */
    static Object convert(String column, int width, String text) {
        String t = text == null ? "" : text;
        if (width == 0) {
            if (t.isBlank()) return null;
            try {
                return Integer.parseInt(t.trim());
            } catch (NumberFormatException e) {
                throw new BusinessException("قيمة غير صالحة للحقل " + column + ": " + t);
            }
        }
        if (t.length() > width) {
            throw new BusinessException("القيمة اطول من الحقل " + column + " (" + width + ")");
        }
        return t;
    }

    /** A char(n) procedure parameter: longer text is silently cut to n characters. */
    static String param(String text, int n) {
        String t = text == null ? "" : text;
        return t.length() > n ? t.substring(0, n) : t;
    }

    /** Mid(m_ist_no.BoundText, 3, 2). */
    static String ist(String formType) {
        String t = formType == null ? "" : formType;
        if (t.length() < 3) return "";
        return t.substring(2, Math.min(4, t.length()));
    }

    /** VB's text of a recordset value: Null → "", a whole float without decimals. */
    static String vbText(Object v) {
        if (v == null) return "";
        if (v instanceof Double d) {
            return d == Math.rint(d) && !d.isInfinite() ? String.valueOf(d.longValue()) : String.valueOf(d);
        }
        if (v instanceof Number n) return n.toString();
        return v.toString();
    }

    /** @m_out_num int receiving "'" & out_num & "'": '' converts to 0, a fraction is a conversion error. */
    static int outNum(Object v) {
        String t = vbText(v).trim();
        if (t.isEmpty()) return 0;
        try {
            return Integer.parseInt(t);
        } catch (NumberFormatException e) {
            throw new BusinessException("رقم الحقل غير صالح: " + t);
        }
    }

    private static void located(int n) {
        if (n == 0) throw new BusinessException("تعذر ايجاد السجل للتعديل (تغير او حذف)");
        if (n > 1) throw new BusinessException("اكثر من سجل مطابق — لم يتم الحفظ");
    }

    private static String rootMessage(Throwable e) {
        Throwable t = e;
        while (t.getCause() != null) t = t.getCause();
        String m = t.getMessage();
        return m == null ? "" : m.split("\n")[0];
    }
}
