package com.startupstack.app.modules.subjectthesaurus.repository;

import com.startupstack.app.modules.lookups.entity.MacnzEntity;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;

/**
 * The MACNZ / WORD statements of "المكنز الموضوعي" (legacy Form5.frm).
 *
 * <p>The legacy procedures compared and sorted MACNZ under SQL_Latin1_General_CP1256_CI_AS, which
 * PostgreSQL cannot reproduce (ة = ت, ignored tatweel, hamza-group ordering, [set] wildcards …).
 * Their WHERE / ORDER BY are therefore applied by {@code LegacyCollation} on the rows read here;
 * writes address the exact stored codes that matched. Writes are plain INSERT/UPDATE/DELETE, like
 * the procedures, never a JPA merge.
 */
public interface SubjectThesaurusRepository extends Repository<MacnzEntity, String> {

    /** Every MACNZ row, in table order (serh_wrdmacnz has no ORDER BY). */
    @Query(value = "SELECT \"SUB_CODE\" AS code, \"SUB_LEVEL\" AS level, \"SUB_DESC\" AS description FROM \"MACNZ\"",
            nativeQuery = true)
    List<ThesaurusTermView> findAllRows();

    /** insr_macnz: insert into macnz (sub_desc, sub_code, sub_level) values (@desc, @m_code, @m_leve) */
    @Modifying
    @Query(value = "INSERT INTO \"MACNZ\" (\"SUB_DESC\", \"SUB_CODE\", \"SUB_LEVEL\") "
            + "VALUES (:description, :code, :level)", nativeQuery = true)
    int insert(@Param("description") String description, @Param("code") String code,
               @Param("level") String level);

    /** upd_macnz: update macnz set sub_desc = @desc where sub_code = @m_code (codes resolved by the collation). */
    @Modifying
    @Query(value = "UPDATE \"MACNZ\" SET \"SUB_DESC\" = :description WHERE \"SUB_CODE\" IN (:codes)", nativeQuery = true)
    int updateDescription(@Param("description") String description, @Param("codes") Collection<String> codes);

    /** del_macnz: delete from macnz where sub_code = @code (codes resolved by the collation). */
    @Modifying
    @Query(value = "DELETE FROM \"MACNZ\" WHERE \"SUB_CODE\" IN (:codes)", nativeQuery = true)
    int deleteByCodes(@Param("codes") Collection<String> codes);

    /** op_macnz: insert into macnz (sub_code, sub_level, sub_logic, sub_desc) values (@m_no1, '3', 0, space(40)) */
    @Modifying
    @Query(value = "INSERT INTO \"MACNZ\" (\"SUB_CODE\", \"SUB_LEVEL\", \"SUB_LOGIC\", \"SUB_DESC\") "
            + "VALUES (:code, '3', 0, repeat(' ', 40))", nativeQuery = true)
    int insertLevelThreePlaceholder(@Param("code") String code);

    /** insr_word: insert into word (sub_typ6, sub_code6, sub_desc6) values (@m_typ, @m_no, @desc) */
    @Modifying
    @Query(value = "INSERT INTO \"WORD\" (\"SUB_TYP6\", \"SUB_CODE6\", \"SUB_DESC6\") "
            + "VALUES (:type, :code, :word)", nativeQuery = true)
    int insertWord(@Param("word") String word, @Param("code") String code, @Param("type") String type);
}
