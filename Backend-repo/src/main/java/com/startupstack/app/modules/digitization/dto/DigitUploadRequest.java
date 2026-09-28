package com.startupstack.app.modules.digitization.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

/**
 * Metadata accompanying a physical file upload for the "استمارة التوثيق" screen (Form6.frm
 * DataGrid1 Column04 space-bar / {@code CommonDialog1.ShowOpen}).
 *
 * <p>Deliberately has no {@code digitNo} or {@code type} field: legacy never let the operator
 * type either — {@code DIG_DIG_NO} and the file extension in {@code DIG_TYP} are always derived
 * server-side from the uploaded file and the next number for the chosen class
 * (max_digit/op_digit, DDL :7018, :7332).
 */
@Getter
@Setter
public class DigitUploadRequest {

    @NotBlank
    @Size(max = 7)
    private String docNo;

    @NotNull
    private Integer serial;

    /**
     * Legacy {@code DIG_TYP1} — gates which class the file belongs to. Legacy's own upload flow
     * (Form6.frm:3574 {@code If m_dig_typ1 <> "04" Then}) never accepts "04" here; video arrives
     * through the separate tape/ranjpath pipeline, never this dialog.
     */
    @NotBlank
    @Size(max = 2)
    private String type1;

    @Size(max = 3)
    private String highType;

    private Integer durationHours;
    private Integer durationMinutes;
    private Integer durationSeconds;
    private Integer durationHours1;
    private Integer durationMinutes1;
    private Integer durationSeconds1;

    @Size(max = 6)
    private String chartNo;

    @Size(max = 6)
    private String newChartNo;

    @Size(max = 2)
    private String chartType;

    @Size(max = 10)
    private String chartGeo;

    private Integer choice;

    @Size(max = 8)
    private String chartNo1;

    @Size(max = 2)
    private String materialType;
}
