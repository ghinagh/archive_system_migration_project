package com.startupstack.app.modules.catalogue.dto;

import jakarta.validation.constraints.Size;

/** Form2.frm m_mn_result (Esc → upd_mn_result): main.MN_RESULT, char(1000). */
public record AbstractRequest(@Size(max = 1000) String result) {}
