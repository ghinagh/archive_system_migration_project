package com.startupstack.app.modules.formthesaurus.dto;

import java.time.LocalDate;

/**
 * One condition tmp_file.frm appended to crit1 (all AND-ed):
 * <ul>
 *   <li>FROM — ( tmp_date >= date or tmp_date is null )  (M_tmp_date)</li>
 *   <li>TO — ( tmp_date <= date or tmp_date is null )  (M_tmp_date1)</li>
 *   <li>USER — tmp_user_no = 'text'  (m_user_no)</li>
 *   <li>WORD — tmp_file_name + tmp_rmrk like '%text%'  (m_word)</li>
 *   <li>FINAL — tmp_final = 1  (Option1 "منجز")</li>
 *   <li>NOT_FINAL — (tmp_final = 0 or tmp_final is null)  (Option2 "غيرمنجز")</li>
 * </ul>
 */
public record AdditionalFileCriterion(Kind kind, LocalDate date, String text) {

    public enum Kind { FROM, TO, USER, WORD, FINAL, NOT_FINAL }
}
