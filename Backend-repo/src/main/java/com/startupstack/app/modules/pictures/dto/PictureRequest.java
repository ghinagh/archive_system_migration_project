package com.startupstack.app.modules.pictures.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class PictureRequest {

    @NotBlank
    @Size(max = 7)
    private String picNo;

    @Size(max = 6)
    private String picNgNo;

    @Size(max = 6)
    private String picPosNo;

    @Size(max = 3)
    private String picDoc;

    private LocalDateTime picDocDte;

    @Size(max = 3)
    private String picEnt;

    private LocalDateTime picEntDte;

    @Size(max = 3)
    private String picPrs;

    private LocalDateTime picDte;

    @Size(max = 100)
    private String picTit;

    @Size(max = 10)
    private String picCot;

    @Size(max = 10)
    private String picGeo;

    private Double picTyp;

    private Double picForm;

    private Double picLen;

    private Double picLarge;

    private Double picQualty;

    private Double picSub;

    @Size(max = 70)
    private String picRmrk;

    private Double picCopy;

    @Size(max = 5)
    private String picLbn;

    @Size(max = 5)
    private String picPage;

    @Size(max = 5)
    private String picLine;

    private Double picTyp1;

    private Double picBrind;

    private Double picChoice;
}
