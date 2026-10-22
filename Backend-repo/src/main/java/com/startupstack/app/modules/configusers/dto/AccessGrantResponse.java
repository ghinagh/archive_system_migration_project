package com.startupstack.app.modules.configusers.dto;

import java.time.Instant;

/** Proof that the key was accepted; sent back in the X-Config-Users-Access header. */
public record AccessGrantResponse(String token, Instant expiresAt) {}
