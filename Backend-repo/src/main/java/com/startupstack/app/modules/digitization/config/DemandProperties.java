package com.startupstack.app.modules.digitization.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Limits governing what may be queued as a single scene.
 *
 * <p>Legacy USER_INTERFACE1.frm Command15_Click (:3520, :3612) gates the insert on
 * {@code If m_len_mch < 400 Or box_user_start < 2}: an ordinary operator cannot queue a scene
 * of 400 seconds or more, while a user below privilege level 2 is exempt. Note the MsgBox
 * beside that test says 500 — a genuine inconsistency in the original source. 400 is
 * authoritative because it is what the code enforced; both numbers are configurable here so
 * the client can settle it without a code change.
 */
@Data
@ConfigurationProperties(prefix = "app.demand")
public class DemandProperties {

    /** Legacy's 400-second ceiling on a single scene. */
    private int maxSceneSeconds = 400;

    /** Legacy {@code box_user_start} threshold — users below this level bypass the cap. */
    private int privilegedUserStartLevel = 2;
}
