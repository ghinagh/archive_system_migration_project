package com.startupstack.app.modules.formthesaurus.service;

import com.startupstack.app.modules.formthesaurus.config.FormThesaurusProperties;
import com.startupstack.app.modules.formthesaurus.dto.AccessGrantResponse;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.PermissionDeniedException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Clock;
import java.time.Instant;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * The ARCHIVE.frm Frame3 "كلمة السر" gate in front of coding.frm (M2_Click).
 *
 * <p>Legacy checked the key on the client ({@code LTrim(m_user_password.Text) = password1}). Here
 * the key never leaves the server: a correct key yields a grant token bound to the signed-in user,
 * and every المكنز الشكلي endpoint requires it — so neither a direct Angular route nor a direct
 * API call opens the screen without the key.
 */
@Service
public class FormThesaurusAccessService {

    public static final String HEADER = "X-Form-Thesaurus-Access";

    private record Grant(String username, Instant expiresAt) {}

    private final FormThesaurusProperties properties;
    private final Map<String, Grant> grants = new ConcurrentHashMap<>();
    private final Clock clock;

    @Autowired
    public FormThesaurusAccessService(FormThesaurusProperties properties) {
        this(properties, Clock.systemUTC());
    }

    FormThesaurusAccessService(FormThesaurusProperties properties, Clock clock) {
        this.properties = properties;
        this.clock = clock;
    }

    /** Command20_Click / m_user_password Enter. */
    public AccessGrantResponse grant(String key) {
        String username = requireUser();
        if (!ltrim(key).equals(properties.getAccessKey())) {
            throw new BusinessException("كلمة السر غير صحيحة");
        }
        Instant now = clock.instant();
        grants.values().removeIf(g -> !g.expiresAt().isAfter(now));
        String token = UUID.randomUUID().toString();
        Instant expiresAt = now.plus(properties.getAccessTtl());
        grants.put(token, new Grant(username, expiresAt));
        return new AccessGrantResponse(token, expiresAt);
    }

    public void verify(String token) {
        String username = requireUser();
        Grant grant = token == null ? null : grants.get(token);
        if (grant == null || !grant.username().equals(username) || !grant.expiresAt().isAfter(clock.instant())) {
            throw new PermissionDeniedException("يجب ادخال كلمة السر لفتح المكنز الشكلي");
        }
    }

    /** Command6 "خروج" (Unload coding) — the next opening asks for the key again. */
    public void revoke(String token) {
        if (token != null) {
            grants.remove(token);
        }
    }

    private static String requireUser() {
        String username = SecurityUtils.getCurrentUsername();
        if (username == null) {
            throw new PermissionDeniedException("يجب تسجيل الدخول");
        }
        return username;
    }

    /** VB LTrim: leading blanks only. */
    static String ltrim(String s) {
        if (s == null) {
            return "";
        }
        int start = 0;
        while (start < s.length() && s.charAt(start) == ' ') {
            start++;
        }
        return s.substring(start);
    }
}
