package com.startupstack.app.modules.admin.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "TEMP")
public class TempSchemaEntity {

    @Id
    @Column(name = "FIELD_NAME", length = 10)
    private String fieldName;

    @Column(name = "FIELD_TYPE", length = 1)
    private String fieldType;

    @Column(name = "FIELD_LEN")
    private Double fieldLen;

    @Column(name = "FIELD_DEC")
    private Double fieldDec;
}
