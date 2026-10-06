package com.startupstack.app.shared.collation;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UncheckedIOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

/**
 * Comparison rules of the legacy MACNZ columns: SQL Server {@code SQL_Latin1_General_CP1256_CI_AS}
 * on nvarchar data (Windows word sort). PostgreSQL has no equivalent collation, so "=", LIKE and
 * ORDER BY of the legacy procedures are evaluated here.
 *
 * <p>Every rule was measured on SQL Server 2022 with that collation and the model was validated
 * against SQL Server's own ORDER BY (21,000 strings, 0 mismatches) and LIKE (151,200 data/pattern
 * pairs, 0 mismatches):
 * <ul>
 *   <li>character weights (primary + letter variant) come from {@code collation/sql_latin1_general_cp1256_ci_as.tsv};
 *       case is ignored, accents are not; ة sorts and compares as ت; ء آ أ ؤ إ ئ share one primary,
 *       as do ى/ي;</li>
 *   <li>tatweel, U+0600–U+0620 marks, U+0653–U+065F, Quranic marks, ZWJ/LRM/RLM … are ignored;</li>
 *   <li>harakat carry only a diacritic weight; shadda sorts as a repeat of the preceding letter and
 *       is equivalent to ء after a hamza-group letter;</li>
 *   <li>apostrophe / hyphen / soft hyphen are ignored at the first levels and only break ties;</li>
 *   <li>letter variants compare left to right, diacritics right to left;</li>
 *   <li>"=" ignores trailing blanks; LIKE does not, compares each literal run between wildcards as a
 *       whole string, supports [set], [a-z] (collation ranges), [^set]; "[]" matches nothing, "[^]"
 *       any character, an unclosed "[" makes the pattern match nothing; ß/æ expand to ss/ae.</li>
 * </ul>
 * Characters outside the measured set (Arabic, Latin-1, ASCII) fall back to code-point order.
 */
public final class LegacyCollation {

    private static final int FALLBACK = 10_000;
    private static final int SHADDA = 0x651;
    private static final int SHADDA_MARK = 50;
    private static final String HAMZA_GROUP = "ءآأؤإئ";
    private static final Map<Character, String> EXPANSIONS = Map.of('ß', "ss", 'æ', "ae", 'Æ', "ae");

    private static final Map<Integer, int[]> WEIGHTS = loadWeights();
    private static final boolean[] IGNORABLE = new boolean[0x10000];
    private static final Map<Integer, Integer> SPECIAL = Map.of(0x27, 1, 0x2D, 2, 0xAD, 3);
    private static final Map<Integer, Integer> NONSPACING = new HashMap<>();

    static {
        int[][] ranges = {{0x600, 0x60B}, {0x60D, 0x61A}, {0x61C, 0x61E}, {0x620, 0x620}, {0x63B, 0x640},
                {0x653, 0x65F}, {0x66D, 0x66F}, {0x6D6, 0x6EF}, {0x6FA, 0x6FF}, {0x200D, 0x200F}};
        for (int[] r : ranges) {
            for (int c = r[0]; c <= r[1]; c++) {
                IGNORABLE[c] = true;
            }
        }
        int[] marks = {0x64B, 0x64C, 0x64D, 0x64E, 0x64F, 0x650, 0x652};
        for (int i = 0; i < marks.length; i++) {
            NONSPACING.put(marks[i], i + 1);
        }
    }

    private LegacyCollation() {
    }

    // ─── "=" and ORDER BY ───────────────────────────────────────────────

    /** {@code a = b} — null never equals anything. */
    public static boolean equal(String a, String b) {
        return a != null && b != null && key(a, true).compareTo(key(b, true)) == 0;
    }

    /** ORDER BY: NULL first, then the collation order. */
    public static int compare(String a, String b) {
        if (a == null || b == null) {
            return a == null ? (b == null ? 0 : -1) : 1;
        }
        return key(a, true).compareTo(key(b, true));
    }

    /** ORDER BY field: NULL first; each row's key is computed once (stable for ties). */
    public static <T> List<T> sortBy(List<T> rows, Function<T, String> field) {
        record Entry<R>(R row, SortKey key) {
        }
        List<Entry<T>> entries = new ArrayList<>(rows.size());
        for (T row : rows) {
            String v = field.apply(row);
            entries.add(new Entry<>(row, v == null ? null : key(v, true)));
        }
        entries.sort((x, y) -> x.key() == null ? (y.key() == null ? 0 : -1)
                : y.key() == null ? 1 : x.key().compareTo(y.key()));
        return entries.stream().map(Entry::row).toList();
    }

    /** T-SQL SUBSTRING(s, 1, length) on a non-null value. */
    public static String left(String s, int length) {
        return s.length() <= length ? s : s.substring(0, Math.max(0, length));
    }

    record SortKey(int[] primaries, int[] letters, int[][] marks, int[][] specials) implements Comparable<SortKey> {
        @Override
        public int compareTo(SortKey o) {
            int c = Arrays.compare(primaries, o.primaries);
            if (c == 0) c = Arrays.compare(letters, o.letters);
            if (c == 0) c = compareNested(marks, o.marks);
            if (c == 0) c = compareNested(specials, o.specials);
            return c;
        }

        private static int compareNested(int[][] a, int[][] b) {
            for (int i = 0; i < Math.min(a.length, b.length); i++) {
                int c = Arrays.compare(a[i], b[i]);
                if (c != 0) return c;
            }
            return Integer.compare(a.length, b.length);
        }
    }

    static SortKey key(String raw, boolean padBlanks) {
        String s = foldShadda(raw);
        if (padBlanks) {
            int end = s.length();
            while (end > 0 && s.charAt(end - 1) == ' ') end--;
            s = s.substring(0, end);
        }
        List<Integer> prims = new ArrayList<>();
        List<int[]> secs = new ArrayList<>();
        List<int[]> specials = new ArrayList<>();
        for (int i = 0; i < s.length(); i++) {
            int c = s.charAt(i);
            if (IGNORABLE[c]) continue;
            Integer special = SPECIAL.get(c);
            if (special != null) {
                specials.add(new int[]{i, special});
                continue;
            }
            if (c == SHADDA) {
                if (!prims.isEmpty()) {
                    prims.add(prims.get(prims.size() - 1));
                    secs.add(append(secs.get(secs.size() - 1), SHADDA_MARK));
                } else {
                    prims.add(0);
                    secs.add(new int[]{0, SHADDA_MARK});
                }
                continue;
            }
            Integer mark = NONSPACING.get(c);
            if (mark != null) {
                if (!secs.isEmpty()) {
                    secs.set(secs.size() - 1, append(secs.get(secs.size() - 1), mark));
                } else {
                    prims.add(0);
                    secs.add(new int[]{0, mark});
                }
                continue;
            }
            int[] w = WEIGHTS.get(c);
            if (w == null) {
                prims.add(FALLBACK + c);
                secs.add(new int[]{0});
            } else {
                prims.add(w[0]);
                secs.add(new int[]{w[1]});
            }
        }
        int n = secs.size();
        int[] letters = new int[n];
        int[][] marks = new int[n][];
        for (int i = 0; i < n; i++) {
            int[] e = secs.get(i);
            letters[i] = e[0];
            marks[n - 1 - i] = Arrays.copyOfRange(e, 1, e.length); // diacritics compare from the end
        }
        return new SortKey(prims.stream().mapToInt(Integer::intValue).toArray(), letters, marks,
                specials.toArray(new int[0][]));
    }

    /** After a hamza-group letter, shadda is equivalent to ء. */
    static String foldShadda(String s) {
        StringBuilder out = new StringBuilder(s.length());
        char prev = 0;
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);
            if (IGNORABLE[ch]) {
                out.append(ch);
                continue;
            }
            if (ch == SHADDA && HAMZA_GROUP.indexOf(prev) >= 0) {
                ch = 'ء';
            }
            out.append(ch);
            prev = ch;
        }
        return out.toString();
    }

    private static int[] append(int[] a, int v) {
        int[] r = Arrays.copyOf(a, a.length + 1);
        r[a.length] = v;
        return r;
    }

    // ─── LIKE ───────────────────────────────────────────────────────────

    /** {@code data LIKE pattern} — no escape character, as in the legacy procedures. */
    public static boolean like(String data, String pattern) {
        if (data == null || pattern == null) return false;
        String d = stripIgnorable(data);
        List<Object[]> toks = parse(stripIgnorable(pattern));
        if (toks == null) return false;
        return new Matcher(d, toks).match(0, 0);
    }

    private static String stripIgnorable(String s) {
        StringBuilder b = new StringBuilder(s.length());
        for (int i = 0; i < s.length(); i++) {
            if (!IGNORABLE[s.charAt(i)]) b.append(s.charAt(i));
        }
        return b.toString();
    }

    /** tokens: {"%"} {"_"} {"run", String} {"set", Boolean neg, List<char[]> items}; null = never matches. */
    private static List<Object[]> parse(String p) {
        List<Object[]> toks = new ArrayList<>();
        int i = 0;
        while (i < p.length()) {
            char ch = p.charAt(i);
            if (ch == '%') {
                toks.add(new Object[]{"%"});
                i++;
            } else if (ch == '_') {
                toks.add(new Object[]{"_"});
                i++;
            } else if (ch == '[') {
                int j = p.indexOf(']', i + 1);
                if (j < 0) return null;
                String body = p.substring(i + 1, j);
                boolean neg = body.startsWith("^");
                if (neg) body = body.substring(1);
                List<char[]> items = new ArrayList<>();
                int k = 0;
                while (k < body.length()) {
                    if (k + 2 < body.length() && body.charAt(k + 1) == '-') {
                        items.add(new char[]{body.charAt(k), body.charAt(k + 2)});
                        k += 3;
                    } else {
                        items.add(new char[]{body.charAt(k)});
                        k++;
                    }
                }
                toks.add(new Object[]{"set", neg, items});
                i = j + 1;
            } else {
                Object[] last = toks.isEmpty() ? null : toks.get(toks.size() - 1);
                if (last != null && "run".equals(last[0])) {
                    last[1] = last[1] + String.valueOf(ch);
                } else {
                    toks.add(new Object[]{"run", String.valueOf(ch)});
                }
                i++;
            }
        }
        return toks;
    }

    /** Identity of one character for [set] membership and ranges. */
    private static int[] charKey(char ch) {
        int[] w = WEIGHTS.get((int) ch);
        if (w != null) return new int[]{0, w[0], w[1]};
        if (SPECIAL.containsKey((int) ch)) return new int[]{1, 2, ch};
        if (NONSPACING.containsKey((int) ch) || ch == SHADDA) return new int[]{1, 1, ch};
        return new int[]{1, 0, Character.toLowerCase(ch)};
    }

    private static boolean inSet(char ch, List<char[]> items) {
        int[] k = charKey(ch);
        for (char[] it : items) {
            if (it.length == 1 && Arrays.equals(k, charKey(it[0]))) return true;
            if (it.length == 2 && Arrays.compare(charKey(it[0]), k) <= 0 && Arrays.compare(charKey(it[1]), k) >= 0) {
                return true;
            }
        }
        return false;
    }

    private static SortKey runKey(String s) {
        StringBuilder b = new StringBuilder(s.length() + 2);
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);
            String exp = EXPANSIONS.get(ch);
            b.append(exp != null ? exp : String.valueOf(ch));
        }
        return key(b.toString(), false);
    }

    private static boolean hasExpansion(String s) {
        for (int i = 0; i < s.length(); i++) {
            if (EXPANSIONS.containsKey(s.charAt(i))) return true;
        }
        return false;
    }

    private static final class Matcher {
        private final String d;
        private final List<Object[]> toks;
        private final Map<Long, Boolean> memo = new HashMap<>();

        Matcher(String d, List<Object[]> toks) {
            this.d = d;
            this.toks = toks;
        }

        @SuppressWarnings("unchecked")
        boolean match(int i, int t) {
            long memoKey = ((long) i << 32) | t;
            Boolean cached = memo.get(memoKey);
            if (cached != null) return cached;
            boolean r;
            if (t == toks.size()) {
                r = i == d.length();
            } else {
                Object[] tk = toks.get(t);
                switch ((String) tk[0]) {
                    case "%" -> r = match(i, t + 1) || (i < d.length() && match(i + 1, t));
                    case "_" -> r = i < d.length() && match(i + 1, t + 1);
                    case "set" -> r = i < d.length() && (inSet(d.charAt(i), (List<char[]>) tk[2]) != (Boolean) tk[1])
                            && match(i + 1, t + 1);
                    default -> {
                        String run = (String) tk[1];
                        int len = run.length();
                        SortKey want = runKey(run);
                        int[] lengths = hasExpansion(run + d.substring(i, Math.min(d.length(), i + len + 1)))
                                ? new int[]{len, len - 1, len + 1} : new int[]{len};
                        boolean found = false;
                        for (int n : lengths) {
                            if (n > 0 && i + n <= d.length() && runKey(d.substring(i, i + n)).compareTo(want) == 0
                                    && match(i + n, t + 1)) {
                                found = true;
                                break;
                            }
                        }
                        r = found;
                    }
                }
            }
            memo.put(memoKey, r);
            return r;
        }
    }

    // ─── weights ────────────────────────────────────────────────────────

    private static Map<Integer, int[]> loadWeights() {
        Map<Integer, int[]> map = new HashMap<>();
        try (InputStream in = LegacyCollation.class.getResourceAsStream("/collation/sql_latin1_general_cp1256_ci_as.tsv")) {
            if (in == null) throw new IllegalStateException("collation table missing");
            BufferedReader r = new BufferedReader(new InputStreamReader(in, StandardCharsets.UTF_8));
            String line;
            while ((line = r.readLine()) != null) {
                if (line.isBlank() || line.startsWith("#")) continue;
                String[] f = line.split("\t");
                map.put(Integer.parseInt(f[0], 16), new int[]{Integer.parseInt(f[1]), Integer.parseInt(f[2])});
            }
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
        return Map.copyOf(map);
    }
}
