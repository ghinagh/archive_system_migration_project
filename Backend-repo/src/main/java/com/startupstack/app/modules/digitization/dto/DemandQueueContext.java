package com.startupstack.app.modules.digitization.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Who is using the "طلبيات الفيديو" queue and what new_vdpreview.frm lets them do:
 * {@code canSeeAllUsers} mirrors the {@code box_user_no = "244"} unlock of the user filter,
 * {@code canOperate} mirrors {@code box_user_start = 1} (the "start" button and F5 path panel).
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DemandQueueContext {
    private String userNo;
    private String userName;
    private boolean canSeeAllUsers;
    private boolean canOperate;
}
