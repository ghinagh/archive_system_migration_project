package com.startupstack.app.modules.configusers.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.time.Duration;

/** "معالجة المستخدمين" (legacy config_users.frm) access rules. */
@Data
@ConfigurationProperties(prefix = "app.config-users")
public class ConfigUsersProperties {

    /** ARCHIVE.frm m31_Click: {@code password1 = "261015"} — the Frame3 key before config_users opens. */
    private String accessKey = "261015";

    /** Lifetime of one successful key entry (one opening of the screen). */
    private Duration accessTtl = Duration.ofHours(12);
}
