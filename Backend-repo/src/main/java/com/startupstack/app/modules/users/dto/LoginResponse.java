package com.startupstack.app.modules.users.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class LoginResponse {

    private final String  token;
    private final String  username;
    private final String  level;
    /** Bitmask of granted permissions — see PermissionConstants. */
    private final Integer permission;
    /** True when USER_PWD=1; token is a 10-minute OTP, not a full JWT. */
    private final Boolean requiresPasswordChange;
}
