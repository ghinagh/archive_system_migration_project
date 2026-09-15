package com.startupstack.app.shared.annotation;

import com.startupstack.app.shared.constants.PermissionConstants;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Declares the minimum permission bitmask required to invoke the annotated endpoint.
 *
 * Apply to any @PostMapping, @PutMapping, @DeleteMapping, or @GetMapping method.
 * The value must be one of the constants from {@link PermissionConstants}.
 *
 * <pre>
 *   {@literal @}DeleteMapping("/{id}")
 *   {@literal @}Permission(PermissionConstants.PERM_DELETE)
 *   public ResponseEntity<ApiResponse<Void>> delete(@PathVariable String id) { ... }
 * </pre>
 *
 * Admin users (userLevel = "A") always pass the check regardless of their bitmask.
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Permission {

    /** The required permission bitmask (from {@link PermissionConstants}). */
    int value();
}
