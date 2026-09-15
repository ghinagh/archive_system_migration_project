package com.startupstack.app.modules.digitization.dto;

import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * Starts a batch delivery over the chosen demands — legacy Command5 "ارسل الى EDLC" and
 * Command14 "تنفيد", both of which iterate the queue acting only on rows with
 * {@code dmd_chek = 1}. Ids that are not queued are skipped rather than rejected, matching
 * the legacy {@code If m_chek = 1} gate.
 */
@Getter
@Setter
public class DeliveryJobRequest {

    @NotEmpty
    private List<Integer> ids;
}
