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
public class RelFormId implements Serializable {

    private String rlfForm1;
    private String rlfForm2;
}
