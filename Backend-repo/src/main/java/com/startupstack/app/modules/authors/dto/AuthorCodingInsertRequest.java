package com.startupstack.app.modules.authors.dto;

/**
 * Form8 Command3 in add mode: insr_auther(desc.Text, code.Text). The number travels as the raw
 * code.Text string because legacy passed it quoted and let SQL Server convert it to float.
 */
public record AuthorCodingInsertRequest(String number, String name) {
}
