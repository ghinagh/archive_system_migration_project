package com.startupstack.app.modules.subjectthesaurus.dto;

import java.time.Instant;

/** Proof that the key was accepted; sent back in the X-Subject-Thesaurus-Access header. */
public record AccessGrantResponse(String token, Instant expiresAt) {}
