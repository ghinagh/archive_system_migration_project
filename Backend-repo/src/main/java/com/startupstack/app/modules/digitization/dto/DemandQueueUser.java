package com.startupstack.app.modules.digitization.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/** One entry of the queue's user picker (legacy DBList1: ListField user_name, BoundColumn user_no). */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DemandQueueUser {
    private String userNo;
    private String userName;
}
