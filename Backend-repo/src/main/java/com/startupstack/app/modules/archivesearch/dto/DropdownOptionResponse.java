package com.startupstack.app.modules.archivesearch.dto;

/**
 * Generic dropdown option response for search filters.
 * Maps database value/label pairs to UI dropdown options.
 */
public record DropdownOptionResponse(
        String value,      // BoundColumn value (SUB_CODE, AUT_NO, etc.)
        String label       // ListField display text (SUB_DESC, AUT_NAM, etc.)
) {
}
