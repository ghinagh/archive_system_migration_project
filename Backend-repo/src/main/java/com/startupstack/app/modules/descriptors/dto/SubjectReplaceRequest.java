package com.startupstack.app.modules.descriptors.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/** upd_analis: the new descriptor code for an existing ANALIS row (its serial is kept). */
public record SubjectReplaceRequest(@NotBlank @Size(max = 9) String descriptorNo) {}
