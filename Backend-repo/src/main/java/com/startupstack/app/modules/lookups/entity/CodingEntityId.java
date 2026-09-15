package com.startupstack.app.modules.lookups.entity;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@EqualsAndHashCode
public class CodingEntityId implements Serializable {

    private String subLeve;
    private String subCode;
}
