package com.startupstack.app.modules.sites.entity;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode
public class SubjectLinkId implements Serializable {

    private String subForm;
    private String subMcnz;
}
