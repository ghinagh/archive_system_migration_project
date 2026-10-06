package com.startupstack.app.modules.authors.dto;

/** The SQL the Form8 MSRDC "auther" control can be holding — DBList1 always shows its rows. */
public enum AuthorCodingQuery {
    /** RecordSource / reset: select * from auther order by aut_no */
    BY_NUMBER,
    /** After the add/edit duplicate check: select * from auther (no order) */
    UNORDERED,
    /** serh_auther1 — F10 / بحث (F10) */
    PREFIX,
    /** serh_auther2 — بحث كلمة */
    WORD
}
