package com.startupstack.app.modules.digitization.dto;

import lombok.Getter;
import lombok.Setter;

/**
 * "معالجة طلبات معينة" Frame2 تعديل (Command9) — matches upd_result1's parameter list
 * exactly. No validation here: the legacy handler only guards on a non-empty رقم الطلب
 * (checked in the service before this DTO is even used), never on these four fields.
 */
@Getter
@Setter
public class ManageResultRequest {
    private String person;
    private String cote;
    private String permit;
    private String subject;
}
