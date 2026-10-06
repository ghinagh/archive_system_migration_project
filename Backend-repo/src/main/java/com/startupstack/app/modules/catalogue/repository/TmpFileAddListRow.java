package com.startupstack.app.modules.catalogue.repository;

import java.time.LocalDateTime;

/**
 * One tmp_fileadd row for the temp-files listing, read without the (tmp_fad_no, tmp_ser) entity
 * identity: legacy tmp_ser is a nullable float that tmp_file.frm never used to identify a row, so
 * rows without a serial must still be listed.
 */
public interface TmpFileAddListRow {
    String getTmpFadNo();

    Double getTmpSer();

    String getTmpFileName();

    String getTmpRmrk();

    String getTmpMk();

    LocalDateTime getTmpDate();

    String getTmpUserNo();

    String getUserName();

    Integer getTmpFinal();
}
