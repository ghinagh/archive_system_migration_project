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
public class Pout1Id implements Serializable {

    private String institution;
    private Double outputNum;
}
