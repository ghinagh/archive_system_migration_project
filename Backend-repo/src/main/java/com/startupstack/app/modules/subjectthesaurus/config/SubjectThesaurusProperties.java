package com.startupstack.app.modules.subjectthesaurus.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.time.Duration;

/**
 * "المكنز الموضوعي" (legacy Form5.frm) access rules.
 */
@Data
@ConfigurationProperties(prefix = "app.subject-thesaurus")
public class SubjectThesaurusProperties {

    /**
     * ARCHIVE.frm M6_Click: {@code password1 = "891045"} — the key typed in the Frame3
     * "كلمة السر" box before Form5 opens.
     */
    private String accessKey = "891045";

    /**
     * Form5 Command1 / Command3 / Command4 (اضافة / تسجيل / الغاء) run only
     * {@code If box_user_no = "244"}; every other user's click does nothing.
     */
    private String writerUserNo = "244";

    /** Lifetime of one successful key entry (one opening of the screen). */
    private Duration accessTtl = Duration.ofHours(12);
}
