package com.startupstack.app.modules.formthesaurus.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.time.Duration;

/** "المكنز الشكلي" (legacy coding.frm) access rules. */
@Data
@ConfigurationProperties(prefix = "app.form-thesaurus")
public class FormThesaurusProperties {

    /** ARCHIVE.frm M2_Click: {@code password1 = "891045"} — the Frame3 key before coding.frm opens. */
    private String accessKey = "891045";

    /** Lifetime of one successful key entry (one opening of the screen). */
    private Duration accessTtl = Duration.ofHours(12);
}
