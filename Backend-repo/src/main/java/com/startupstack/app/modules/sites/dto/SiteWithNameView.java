package com.startupstack.app.modules.sites.dto;

import java.time.LocalDateTime;

public interface SiteWithNameView {

    String getSiteNo();
    String getDescription();
    String getLevelNo();
    String getLevel();
    String getProcess();
    String getDocNo();
    LocalDateTime getStartDate();
    LocalDateTime getEndDate();
    Integer getFree();
    String getType();
    Integer getWilyaNo();
    String getStatus();
    String getUser();
    Integer getPermission();
    String getAccessLevel();
    String getKind();
    String getFormName();
}
