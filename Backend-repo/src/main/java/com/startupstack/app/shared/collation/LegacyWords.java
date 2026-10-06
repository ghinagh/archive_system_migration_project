package com.startupstack.app.shared.collation;

import java.util.ArrayList;
import java.util.List;

/** The legacy VB string helpers shared by the thesaurus screens. */
public final class LegacyWords {

    private LegacyWords() {
    }

    /**
     * Form5.div_word / coding.div_word (identical in both forms): splits the description on blanks and returns the words insr_word receives —
     * leading "ال" / "لل" stripped repeatedly, a leading "أ" turned into "ا", kept when longer than
     * two characters and not starting with a digit. Ported literally, including the outer
     * {@code While i < L} that skips a one-character last word and the "وال" test that can never
     * match (it compares a two-character Mid).
     */
    public static List<String> divWord(String description) {
        List<String> words = new ArrayList<>();
        String swDesc = vbTrim(description);
        int len = swDesc.length();
        int i = 1;
        while (i < len) {
            StringBuilder word = new StringBuilder();
            while (!LegacyWords.vbMid(swDesc, i, 1).equals(" ") && i < len + 1) {
                word.append(LegacyWords.vbMid(swDesc, i, 1));
                i++;
            }
            String swDes = word.toString();
            int l1 = swDes.length();
            while (LegacyWords.vbMid(swDesc, i, 1).equals(" ") && i < len + 1) {
                i++;
            }
            if (l1 > 1) {
                boolean again = true;
                while (again) {
                    String two = LegacyWords.vbMid(swDes, 1, 2);
                    if (two.equals("ال") || two.equals("لل")) {
                        swDes = LegacyWords.vbMid(swDes, 3, swDes.length() - 2);
                    } else if (two.equals("وال")) {
                        swDes = LegacyWords.vbMid(swDes, 4, swDes.length() - 3);
                    } else if (LegacyWords.vbMid(swDes, 1, 1).equals("أ")) {
                        swDes = "ا" + LegacyWords.vbMid(swDes, 2, swDes.length() - 1);
                    } else {
                        again = false;
                    }
                }
            }
            // nb = InStr(1, "0123456789", Mid(sw_des, 1, 1)) — InStr of "" returns 1.
            String first = LegacyWords.vbMid(swDes, 1, 1);
            boolean digitOrEmpty = first.isEmpty() || "0123456789".contains(first);
            if (swDes.length() > 2 && !digitOrEmpty) {
                words.add(swDes);
            }
        }
        return words;
    }

    /** VB Mid(s, start, length) with a 1-based start; "" past the end. */
    public static String vbMid(String s, int start, int length) {
        if (s == null || start > s.length() || length <= 0) {
            return "";
        }
        int from = start - 1;
        return s.substring(from, Math.min(s.length(), from + length));
    }

    /** VB Trim / T-SQL LTRIM+RTRIM: blanks only. */
    public static String vbTrim(String s) {
        if (s == null) {
            return "";
        }
        int start = 0;
        int end = s.length();
        while (start < end && s.charAt(start) == ' ') {
            start++;
        }
        while (end > start && s.charAt(end - 1) == ' ') {
            end--;
        }
        return s.substring(start, end);
    }
}
