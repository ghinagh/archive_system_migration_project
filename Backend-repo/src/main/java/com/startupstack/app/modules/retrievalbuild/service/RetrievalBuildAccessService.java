package com.startupstack.app.modules.retrievalbuild.service;

import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.PermissionDeniedException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * The two ARCHIVE.frm keys in front of the retrieval-field screens:
 * <ul>
 *   <li>{@link Gate#FORM4} — m9_Click "ملف بناء الاسترجاعات": InputBox, key "a5g5" or "ش5ل5" → Form4;</li>
 *   <li>{@link Gate#CAT_OUT} — M32_Click "معالجة حقول الاسترجاع": Frame3, password1 "261015" → CAT_OUTFRM.</li>
 * </ul>
 * Neither checks the user. The key is verified here, never in the browser; a correct key yields a
 * grant token for the signed-in user that the screen's calls carry, so a typed URL or a direct API
 * call does not open the screen without it.
 */
@Service
public class RetrievalBuildAccessService {

    public static final String HEADER = "X-Retrieval-Build-Access";

    public enum Gate { FORM4, CAT_OUT }

    private static final Map<Gate, List<String>> KEYS = Map.of(
            Gate.FORM4, List.of("a5g5", "ش5ل5"),
            Gate.CAT_OUT, List.of("261015"));

    private static final Duration TTL = Duration.ofHours(8);

    private record Grant(Gate gate, String username, Instant expiresAt) {}

    private final Map<String, Grant> grants = new ConcurrentHashMap<>();

    /** Wrong key: legacy simply does not open the form (InputBox / Frame3 closes). */
    public String grant(Gate gate, String key) {
        String username = requireUser();
        String typed = key == null ? "" : key.stripLeading();
        if (gate == Gate.FORM4) typed = typed.strip();     // InputBox value compared as typed
        if (!KEYS.get(gate).contains(typed)) {
            throw new BusinessException("كلمة السر غير صحيحة");
        }
        Instant now = Instant.now();
        grants.values().removeIf(g -> !g.expiresAt().isAfter(now));
        String token = UUID.randomUUID().toString();
        grants.put(token, new Grant(gate, username, now.plus(TTL)));
        return token;
    }

    public void verify(Gate gate, String token) {
        String username = requireUser();
        Grant g = token == null ? null : grants.get(token);
        if (g == null || g.gate() != gate || !g.username().equals(username) || !g.expiresAt().isAfter(Instant.now())) {
            throw new PermissionDeniedException("يجب ادخال كلمة السر");
        }
    }

    public void revoke(String token) {
        if (token != null) grants.remove(token);
    }

    private static String requireUser() {
        String username = SecurityUtils.getCurrentUsername();
        if (username == null) throw new PermissionDeniedException("يجب تسجيل الدخول");
        return username;
    }
}
