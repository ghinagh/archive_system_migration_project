package com.startupstack.app.modules.digitization.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * "مع تسجيل الطلب" — registers a usage request for one or more documents found on شاشة
 * البحث, collapsing the legacy op_result/max_result/insr_result stored-procedure chain
 * (user_interface.frm Command9 "نسخ الاختيار" / Command11 "نسخ الجدول") into one call.
 * All items share one result header (resultNo) and beneficiary/approving-body/entity/
 * subject, differing only by serial — exactly how a multi-row export became one request
 * with several lines in the legacy screen.
 */
@Getter
@Setter
public class LogUsageRequestBatch {

    @NotEmpty
    @Valid
    private List<LogUsageRequestItem> items;

    @NotBlank
    @Size(max = 50)
    private String person;

    @Size(max = 3)
    private String cote;

    @Size(max = 2)
    private String permit;

    @Size(max = 50)
    private String subject;
}
