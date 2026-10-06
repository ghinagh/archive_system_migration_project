package com.startupstack.app.shared.collation;

import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Expected values are SQL Server 2022 results under SQL_Latin1_General_CP1256_CI_AS (nvarchar),
 * recorded from the legacy-oracle probes.
 */
class LegacyCollationTest {

    private static List<String> sorted(String... items) {
        List<String> l = new ArrayList<>(List.of(items));
        l.sort(LegacyCollation::compare);
        return l;
    }

    @Test
    void equality_rules() {
        assertTrue(LegacyCollation.equal("التـعليم", "التعليم"));       // tatweel ignored
        assertTrue(LegacyCollation.equal("مدرسة", "مدرست"));            // ة = ت
        assertTrue(LegacyCollation.equal("abc ", "abc"));               // trailing blanks padded
        assertTrue(LegacyCollation.equal("ECONOMY", "economy"));        // case-insensitive
        assertTrue(LegacyCollation.equal("آّ", "آء"));                   // shadda after hamza group = ء
        assertFalse(LegacyCollation.equal("بّ", "بء"));
        assertFalse(LegacyCollation.equal("مَدرسة", "مدرسة"));           // harakat significant
        assertFalse(LegacyCollation.equal("أ", "ا"));
        assertFalse(LegacyCollation.equal("ؤ", "ئ"));
        assertFalse(LegacyCollation.equal("ة", "ه"));
        assertFalse(LegacyCollation.equal("é", "e"));                   // accent-sensitive
        assertFalse(LegacyCollation.equal("co-op", "coop"));
        assertFalse(LegacyCollation.equal(null, null));
    }

    @Test
    void order_matches_sqlServer() {
        assertEquals(List.of("a", "a-", "a  b", "a b", "a b c", "a.b", "a/b", "a0", "a1b", "aa", "ab", "-ab", "a'b", "a-b", "abc", "ac"),
                sorted("ab", "a b", "a  b", "a-b", "a'b", "a.b", "a/b", "aa", "ac", "a", "a b c", "abc", "a-", "-ab", "a0", "a1b"));
        assertEquals(List.of("الإعلام", "الآمن", "الأمن", "الامن", "الشءون", "الشؤون", "الشئون", "الشؤون السياسية", "الشون", "الشوون"),
                sorted("الشؤون", "الشئون", "الشؤون السياسية", "الشءون", "الشون", "الشوون", "الإعلام", "الأمن", "الامن", "الآمن"));
        assertEquals(List.of("با", "بَا", "بب", "بَب"), sorted("بَب", "بب", "بَا", "با"));
        assertEquals(List.of("مَدرسة", "مدرسه", "مدرسى", "مدرسي", "مّدرسة"),
                sorted("مّدرسة", "مدرسي", "مدرسى", "مدرسه", "مَدرسة"));
        assertTrue(LegacyCollation.compare("بَت", "بتَ") < 0);
        assertTrue(LegacyCollation.compare("أَت", "ءتَ") > 0);
        assertTrue(LegacyCollation.compare("ببَ", "بَب") > 0);
        assertTrue(LegacyCollation.compare(null, "ا") < 0);
    }

    @Test
    void like_matches_sqlServer() {
        Object[][] cases = {
                {"مَدرس", "مدرس", false}, {"مَدرس", "م_درس", true}, {"مَدرس", "م_رس", false}, {"مّدرس", "ممدرس", false},
                {"مّدرس", "م_درس", true}, {"co-op", "coop", false}, {"co-op", "co_op", true}, {"ß", "ss", true},
                {"ss", "ß", true}, {"æ", "ae", true}, {"abc ", "abc", false}, {"abc", "abc ", false},
                {"abc", "[a-c]bc", true}, {"Bbc", "[a-c]bc", true}, {"تعلم", "[ب-ث]علم", true}, {"ةعلم", "[ب-ث]علم", true},
                {"أمن", "[ا-ي]من", false}, {"ءمن", "[ء-ي]من", true}, {"a]b", "a]b", true}, {"a[b", "a[[]b", true},
                {"a]b", "a[]]b", false}, {"ab", "a[]b", false}, {"a-b", "a[-]b", true}, {"axb", "a[^]b", true},
                {"aب", "a[^ا]", true}, {"aـب", "a_", true}, {"aـب", "a__", false}, {"التـعليم", "%تعليم%", true},
                {"ab", "a%%b", true}, {"", "%", true}, {"", "_", false}, {"é", "e", false}, {"É", "é", true},
                {"1", "١", false}, {"a b", "a_b", true}, {"الاقتصاد", "%ة%", true}, {"abc", "%ة%", false},
                {"آّؤذا", "آء%", true}, {"أأّذث", "%ء_%", false}, {"[x] قوس", "[x", false}, {"الأمن", "%[اأ]من%", true}};
        for (Object[] c : cases) {
            assertEquals(c[2], LegacyCollation.like((String) c[0], (String) c[1]), c[0] + " LIKE " + c[1]);
        }
    }
}
