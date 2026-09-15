package com.startupstack.app.shared.wordindex;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Embeddable
@Getter
@Setter
@EqualsAndHashCode
public class WordId implements Serializable {

    @Column(name = "SUB_CODE6", length = 10)
    private String subCode6;

    @Column(name = "SUB_DESC6", length = 12)
    private String subDesc6;

    @Column(name = "SUB_TYP6", length = 1)
    private String subTyp6;
}
