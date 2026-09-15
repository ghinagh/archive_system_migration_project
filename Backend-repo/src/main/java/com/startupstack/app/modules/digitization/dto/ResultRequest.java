package com.startupstack.app.modules.digitization.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ResultRequest {

    @NotBlank
    @Size(max = 7)
    private String resultNo;

    @NotNull
    private Integer serial;

    @Size(max = 6)
    private String digitNo;

    @Size(max = 3)
    private String type;

    @Size(max = 2)
    private String type1;

    private LocalDateTime date;

    @Size(max = 3)
    private String userNo;

    @Size(max = 7)
    private String catalogueAppNo;

    @Size(max = 50)
    private String person;

    @Size(max = 3)
    private String cote;

    @Size(max = 2)
    private String permit;

    @Size(max = 50)
    private String subject;
}
