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
public class DateSubjectId implements Serializable {

    private String dteAppNo;
    private String dteSerNo;
    private String dteRelNo;
}
