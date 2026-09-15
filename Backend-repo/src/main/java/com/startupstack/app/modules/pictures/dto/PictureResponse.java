package com.startupstack.app.modules.pictures.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class PictureResponse {

    private String picNo;
    private String picNgNo;
    private String picPosNo;
    private String picDoc;
    private LocalDateTime picDocDte;
    private String picEnt;
    private LocalDateTime picEntDte;
    private String picPrs;
    private LocalDateTime picDte;
    private String picTit;
    private String picCot;
    private String picGeo;
    private Double picTyp;
    private Double picForm;
    private Double picLen;
    private Double picLarge;
    private Double picQualty;
    private Double picSub;
    private String picRmrk;
    private Double picCopy;
    private String picLbn;
    private String picPage;
    private String picLine;
    private Double picTyp1;
    private Double picBrind;
    private Double picChoice;
}
