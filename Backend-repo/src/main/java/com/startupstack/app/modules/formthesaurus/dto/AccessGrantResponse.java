package com.startupstack.app.modules.formthesaurus.dto;

import java.time.Instant;

/** Proof that the key was accepted; sent back in the X-Form-Thesaurus-Access header. */
public record AccessGrantResponse(String token, Instant expiresAt) {}
