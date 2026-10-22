package com.startupstack.app.modules.catalogue.repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.startupstack.app.modules.catalogue.entity.TmpFileAddEntity;
import com.startupstack.app.modules.catalogue.entity.TmpFileAddId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.time.LocalDateTime;
import java.util.List;

public interface TmpFileAddRepository extends JpaRepository<TmpFileAddEntity, TmpFileAddId>,
        JpaSpecificationExecutor<TmpFileAddEntity> {

    List<TmpFileAddEntity> findByTmpFadNo(String tmpFadNo);

    /**
     * The temp-files listing: every column plus the documenter's name (blank when tmp_user_no names no
     * config user), with the same optional filters as before. Rows whose tmp_ser is NULL are included.
     */
    @Query(value = "SELECT t.tmp_fad_no AS tmpFadNo, t.tmp_ser AS tmpSer, t.tmp_file_name AS tmpFileName, "
            + "t.tmp_rmrk AS tmpRmrk, t.tmp_mk AS tmpMk, t.tmp_date AS tmpDate, t.tmp_user_no AS tmpUserNo, "
            + "c.user_name AS userName, t.tmp_final AS tmpFinal "
            + "FROM tmp_fileadd t LEFT JOIN config c ON c.user_no = t.tmp_user_no "
            + "WHERE (CAST(:fadNo AS varchar) IS NULL OR t.tmp_fad_no = CAST(:fadNo AS varchar)) "
            + "AND (CAST(:userNo AS varchar) IS NULL OR t.tmp_user_no = CAST(:userNo AS varchar)) "
            + "AND (CAST(:finalStatus AS integer) IS NULL OR t.tmp_final = CAST(:finalStatus AS integer))",
            nativeQuery = true)
    List<TmpFileAddListRow> findListRows(@Param("fadNo") String fadNo, @Param("userNo") String userNo,
                                         @Param("finalStatus") Integer finalStatus);

    /** op_tmp: select @max1 = max(tmp_ser) from tmp_fileadd where tmp_user_no = @m_user_no (case/trailing-blank insensitive). */
    @Query(value = "SELECT max(t.tmp_ser) FROM tmp_fileadd t "
            + "WHERE rtrim(lower(t.tmp_user_no)) = rtrim(lower(CAST(:userNo AS varchar)))", nativeQuery = true)
    Double findMaxSerialOfUser(@Param("userNo") String userNo);

    /**
     * op_tmp: insert into tmp_fileadd (tmp_ser, tmp_user_no, tmp_fad_no, tmp_date, tmp_final) values (…, 0).
     * A plain INSERT: legacy tmp_fileadd has no key, so the (tmp_fad_no, tmp_ser) entity save must not merge.
     */
    @Modifying
    @Query(value = "INSERT INTO tmp_fileadd (tmp_ser, tmp_user_no, tmp_fad_no, tmp_date, tmp_final) "
            + "VALUES (:ser, CAST(:userNo AS char(3)), :fadNo, :date, 0)", nativeQuery = true)
    void insertOp(@Param("ser") double ser, @Param("userNo") String userNo, @Param("fadNo") String fadNo,
                  @Param("date") LocalDateTime date);

    /**
     * tmp_fileadd has no key in the legacy schema, so (tmp_fad_no, tmp_ser) can repeat; the
     * entity's composite id is not unique. إنجاز marks every matching row.
     */
    @Modifying
    @Query(value = "UPDATE tmp_fileadd SET tmp_final = 1 WHERE tmp_fad_no = :no AND tmp_ser = :ser", nativeQuery = true)
    int finalizeRows(@Param("no") String no, @Param("ser") Double ser);

    /** The grid's AllowDelete removes the selected record — one physical row, even among duplicates. */
    @Modifying
    @Query(value = "DELETE FROM tmp_fileadd WHERE ctid = (SELECT ctid FROM tmp_fileadd "
            + "WHERE tmp_fad_no = :no AND tmp_ser = :ser LIMIT 1)", nativeQuery = true)
    int deleteOneRow(@Param("no") String no, @Param("ser") Double ser);
}
