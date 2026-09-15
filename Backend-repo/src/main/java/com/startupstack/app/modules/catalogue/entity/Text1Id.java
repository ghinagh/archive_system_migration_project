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
public class Text1Id implements Serializable {

    private String txtNo;
    private String txtSerNo;
}
