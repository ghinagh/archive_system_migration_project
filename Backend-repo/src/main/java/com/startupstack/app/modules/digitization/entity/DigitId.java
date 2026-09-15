package com.startupstack.app.modules.digitization.entity;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode
public class DigitId implements Serializable {

    private String docNo;
    private Integer serial;
}
