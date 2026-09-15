package com.startupstack.app.modules.digitization.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

/** Command19 "test" — dry-run result for one demand: does its source tape exist and decode? */
@Getter
@AllArgsConstructor
public class DemandTestResult {
    private Integer id;
    private String demandNo;
    private boolean ok;
    private String message;
}
