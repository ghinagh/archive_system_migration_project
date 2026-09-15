package com.startupstack.app.shared.util;

/**
 * Strips the characters legacy refuses to carry into a filename.
 *
 * <p>USER_INTERFACE1.frm Command15_Click (:3488-3505) walks the scene description character
 * by character and replaces each of these with a space before storing it, because that
 * description later becomes the output filename in the delivery pipelines (Command5's
 * {@code ARCHIVE_…} clip and Command14's {@code <desc> Clip <ser>}). Without it a description
 * containing a slash or a colon produces an unwritable path — or worse, writes outside the
 * intended directory.
 *
 * <p>Applied server-side as well as in the cockpit: the value reaches a filesystem path
 * regardless of which client sent it.
 */
public final class FilenameSanitiser {

    /** Legacy's list verbatim, including the Arabic question mark (U+061F). */
    private static final String UNSAFE = ":\n\r\"/?<>*\\|؟";

    private FilenameSanitiser() {
    }

    /** Returns {@code value} with every legacy-unsafe character replaced by a space. */
    public static String sanitise(String value) {
        if (value == null || value.isEmpty()) {
            return value;
        }
        StringBuilder sb = new StringBuilder(value.length());
        for (char c : value.toCharArray()) {
            sb.append(UNSAFE.indexOf(c) >= 0 ? ' ' : c);
        }
        return sb.toString();
    }
}
