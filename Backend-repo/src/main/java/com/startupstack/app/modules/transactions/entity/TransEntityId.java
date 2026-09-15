package com.startupstack.app.modules.transactions.entity;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@EqualsAndHashCode
public class TransEntityId implements Serializable {

    private Double trsOpno;
    private Double trsNo;
}
