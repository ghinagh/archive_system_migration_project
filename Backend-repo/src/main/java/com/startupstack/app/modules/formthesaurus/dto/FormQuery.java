package com.startupstack.app.modules.formthesaurus.dto;

/**
 * The form RecordSources of coding.frm.
 * <ul>
 *   <li>COUNTRIES — "select * from pay_form" (pays1 / frm_mcnz)</li>
 *   <li>COUNTRY_SEARCH — execute serh_form desc, lent</li>
 *   <li>NAMES — execute nam_form v_typ, v_cod</li>
 *   <li>NAME_SEARCH — execute serh1_form v_typ, v_cod, desc, lent</li>
 *   <li>ALL_SEARCH — execute serh_allform desc, lent</li>
 *   <li>LIKE_SEARCH — execute serh_wrdform desc, lent</li>
 *   <li>WORD_SEARCH — execute serh_wrdform1 desc, lent, pays</li>
 * </ul>
 */
public enum FormQuery {
    COUNTRIES,
    COUNTRY_SEARCH,
    NAMES,
    NAME_SEARCH,
    ALL_SEARCH,
    LIKE_SEARCH,
    WORD_SEARCH
}
