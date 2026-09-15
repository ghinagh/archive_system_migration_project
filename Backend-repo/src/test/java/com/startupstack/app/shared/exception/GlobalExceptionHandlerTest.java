package com.startupstack.app.shared.exception;

import com.startupstack.app.shared.response.ApiResponse;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.junit.jupiter.api.Assertions.*;

class GlobalExceptionHandlerTest {

    private final GlobalExceptionHandler handler = new GlobalExceptionHandler();

    @Test
    void handleResourceNotFound_returns404() {
        ResourceNotFoundException ex = new ResourceNotFoundException("Not found");

        ResponseEntity<ApiResponse<Void>> response = handler.handleResourceNotFound(ex);

        assertEquals(HttpStatus.NOT_FOUND, response.getStatusCode());
        assertFalse(response.getBody().isSuccess());
        assertEquals("Not found", response.getBody().getMessage());
    }

    @Test
    void handleIllegalArgument_returns401() {
        IllegalArgumentException ex = new IllegalArgumentException("Invalid credentials");

        ResponseEntity<ApiResponse<Void>> response = handler.handleIllegalArgument(ex);

        assertEquals(HttpStatus.UNAUTHORIZED, response.getStatusCode());
        assertFalse(response.getBody().isSuccess());
    }

    @Test
    void handleGeneral_returns500_withGenericMessage() {
        Exception ex = new RuntimeException("unexpected");

        ResponseEntity<ApiResponse<Void>> response = handler.handleGeneral(ex);

        assertEquals(HttpStatus.INTERNAL_SERVER_ERROR, response.getStatusCode());
        assertEquals("An unexpected error occurred", response.getBody().getMessage());
    }
}
