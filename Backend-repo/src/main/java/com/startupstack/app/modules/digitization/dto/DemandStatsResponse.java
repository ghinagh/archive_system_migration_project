package com.startupstack.app.modules.digitization.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

/** Command15 "عدد ومدة المشاهد" — count and total duration (seconds) of the currently filtered demands. */
@Getter
@AllArgsConstructor
public class DemandStatsResponse {
    private long count;
    private long totalDurationSeconds;
}
