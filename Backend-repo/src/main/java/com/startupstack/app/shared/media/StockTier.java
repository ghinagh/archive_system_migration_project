package com.startupstack.app.shared.media;

/**
 * The two storage tiers the legacy archive keeps for every tape, distinguished by
 * {@code ranjpath.rjp_typ}. USER_INTERFACE1.frm resolves them through two near-identical
 * functions that differ only in which value they match:
 *
 * <ul>
 *   <li>{@code high_stock_path()} (:6448-6466) — {@code rjp_typ = 1}, the broadcast master.
 *       Stored as the demand's {@code dmd_path} (Command12_Click:3187) and fed to ffmpeg.</li>
 *   <li>{@code low_stock_path()} (:6602-6621) — {@code rjp_typ = 2}, the low-res proxy, used
 *       for player preview (Form_Load:5545, datagrid1_DblClick:4897).</li>
 * </ul>
 *
 * Serving the wrong tier means either streaming a broadcast master to a browser or handing
 * ffmpeg a proxy to cut a delivery clip from, so callers must always state which they want.
 */
public enum StockTier {

    /** The broadcast master — {@code rjp_typ = 1}. Extension comes from {@code DIGIT.DIG_TYP_HIGH}. */
    HIGH(1),

    /** The low-res preview proxy — {@code rjp_typ = 2}. Extension comes from {@code DIGIT.DIG_TYP}. */
    LOW(2);

    private final int rjpTyp;

    StockTier(int rjpTyp) {
        this.rjpTyp = rjpTyp;
    }

    public int rjpTyp() {
        return rjpTyp;
    }
}
