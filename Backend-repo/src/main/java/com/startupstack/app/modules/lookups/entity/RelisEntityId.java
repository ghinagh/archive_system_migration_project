package com.startupstack.app.modules.lookups.entity;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@EqualsAndHashCode
public class RelisEntityId implements Serializable {
    private String subCode1;
    private String subCode2;
}
