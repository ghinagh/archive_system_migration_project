package com.startupstack.app.modules.catalogue.entity;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode
public class TimeDescriptorId implements Serializable {

    private String tmAppNo;
    private String tmSerNo;
    private String tmRltvNo;
}
