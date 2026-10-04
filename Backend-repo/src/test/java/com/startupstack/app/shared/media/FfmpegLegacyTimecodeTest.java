package com.startupstack.app.shared.media;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertEquals;

/** new_vdpreview.frm Command4's hh:mm:ss (Int / VB Mod with half-to-even rounding / 2-digit pad). */
class FfmpegLegacyTimecodeTest {

    @Test
    void formatsLikeLegacy() {
        assertEquals("00:00:00", FfmpegService.legacyTimecode(null));
        assertEquals("00:00:05", FfmpegService.legacyTimecode(new BigDecimal("5")));
        assertEquals("00:01:05", FfmpegService.legacyTimecode(new BigDecimal("65")));
        assertEquals("01:00:01", FfmpegService.legacyTimecode(new BigDecimal("3601")));
        assertEquals("00:00:13", FfmpegService.legacyTimecode(new BigDecimal("12.6")));
        assertEquals("00:00:12", FfmpegService.legacyTimecode(new BigDecimal("12.5")));
    }
}
