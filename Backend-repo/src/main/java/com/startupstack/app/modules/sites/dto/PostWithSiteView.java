package com.startupstack.app.modules.sites.dto;

import java.time.LocalDateTime;

public interface PostWithSiteView {

    String getSerial();
    String getFormNo();
    String getSiteNo();
    String getDocNo();
    LocalDateTime getStartDate();
    LocalDateTime getEndDate();
    Integer getWilyaNo();
    Integer getStatus();
    String getLevelNo();
    Integer getType();
    String getUser();
    Integer getPermission();
    String getPostLevel();
    String getSiteDescription();
    String getSiteLevel();
}
