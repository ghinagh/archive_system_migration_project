package com.startupstack.app.modules.users.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserRequest {

    @NotBlank
    @Size(max = 3)
    private String userNo;

    @Size(max = 50)
    private String userName;

    private String userPassword;

    @Size(max = 1)
    private String userLevel;

    private Integer userPermission;

    @Size(max = 2)
    private String userEnt;

    @Size(max = 2)
    private String userDoc;

    @Size(max = 100)
    private String configPath;

    private Integer startPage;

    private Integer passwordChangeFlag;

    @Size(max = 100)
    private String compressedVideoPath;

    @Size(max = 100)
    private String videoPath;

    private Integer company;

    @Size(max = 100)
    private String secondaryVideoPath;

    private Integer wilayaScope;
}
