package com.startupstack.app.modules.catalogue.dto;

import java.time.LocalDateTime;

public record TmpFileAddResponse(
        String tmpFadNo,
        Double tmpSer,
        String tmpFileName,
        String tmpRmrk,
        String tmpMk,
        LocalDateTime tmpDate,
        String tmpUserNo,
        String userName,
        Integer tmpFinal
) {}
