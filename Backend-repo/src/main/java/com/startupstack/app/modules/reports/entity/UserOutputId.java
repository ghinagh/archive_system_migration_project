package com.startupstack.app.modules.reports.entity;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode
public class UserOutputId implements Serializable {

    private String institutionNo;
    private String userNo;
    private Integer outputNum;
}
