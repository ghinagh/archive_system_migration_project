package com.startupstack.app.modules.users.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserResponse {

    private String userNo;
    private String userName;
    private String userLevel;
    private Integer userPermission;
    private String userEnt;
    private String userDoc;
    private String configPath;
    private Integer startPage;
    private Integer passwordChangeFlag;
    private String compressedVideoPath;
    private String videoPath;
    private Integer company;
    private String secondaryVideoPath;
    private Integer wilayaScope;
}
