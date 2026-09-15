package com.startupstack.app.modules.reports.dto;

import java.util.List;
import java.util.Map;

public record TemplateExecutionResponse(
        Integer templateNum,
        String title,
        List<ColumnMeta> columns,
        List<Map<String, Object>> rows,
        int totalRows
) {}
