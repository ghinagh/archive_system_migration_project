package com.startupstack.app.modules.borrowing.entity;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@EqualsAndHashCode
public class BorrowingId implements Serializable {

    private String iarNo;
    private Double serial;
    private Double borrowingType;
}
