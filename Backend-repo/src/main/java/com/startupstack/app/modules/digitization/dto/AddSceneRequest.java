package com.startupstack.app.modules.digitization.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

/**
 * Convenience request for the archive-search cockpit's "add scene to request" workflow —
 * collapses the legacy op_demand/max_demand/max_demand_ser/upd_demand4/insr_demand4 stored
 * procedure chain (USER_INTERFACE1.frm Command15_Click) into one call. Pass the {@code demandNo}
 * returned by the first call back in on subsequent calls to keep appending scenes to the same
 * request; leave it blank to start a new request.
 */
@Getter
@Setter
public class AddSceneRequest {

    @Size(max = 7)
    private String demandNo;

    @NotBlank
    @Size(max = 7)
    private String machineNo;

    @Size(max = 6)
    private String machineStock;

    @Size(max = 100)
    private String description;

    @NotNull
    private BigDecimal inSeconds;

    @NotNull
    private BigDecimal outSeconds;

    @Size(max = 100)
    private String path;

    /**
     * The record's {@code DIGIT.DIG_TYP_HIGH}. The persisted {@code dmd_path} must address the
     * broadcast master, because that is what the delivery pipelines cut from — legacy
     * Command12_Click:3187 builds it as {@code high_stock_path() + stock + "." + dig_typ_high}.
     * Blank falls back to the configured default.
     */
    @Size(max = 3)
    private String highExtension;
}
