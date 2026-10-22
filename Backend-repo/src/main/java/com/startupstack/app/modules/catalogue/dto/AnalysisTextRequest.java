package com.startupstack.app.modules.catalogue.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/** Form2.frm m_txt_text (Esc): the text of one descriptor serial + relation number. */
public record AnalysisTextRequest(
        @NotBlank @Size(max = 2) String serNo,
        @NotBlank @Size(max = 2) String relNo,
        @Size(max = 9) String descNo,
        String text) {}
