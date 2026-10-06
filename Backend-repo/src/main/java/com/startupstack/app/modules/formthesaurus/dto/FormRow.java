package com.startupstack.app.modules.formthesaurus.dto;

/** A form row (SUB_TYP, SUB_NO, SUB_NAME) with sub_cod = SUB_TYP + SUB_NO (NULL if either is NULL). */
public record FormRow(String type, String number, String name, String code) {}
