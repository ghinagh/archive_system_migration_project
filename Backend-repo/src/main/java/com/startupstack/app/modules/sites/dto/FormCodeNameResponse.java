package com.startupstack.app.modules.sites.dto;

/** A form row addressed by its full legacy code: SUB_TYP + SUB_NO (e.g. "0197100001"). */
public record FormCodeNameResponse(String code, String name) {}
