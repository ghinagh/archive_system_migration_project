package com.startupstack.app.modules.authors.repository;

import com.startupstack.app.modules.authors.entity.AuthorEntity;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * The AUTHER statements Form8 (المؤلفين ودور النشر) issues, one per legacy procedure. Writes are
 * plain INSERT/UPDATE/DELETE (not JPA save) so an insert on an existing AUT_NO fails like
 * insr_auther against uq_auther_no instead of silently merging into the existing row.
 */
public interface AuthorCodingRepository extends Repository<AuthorEntity, Double> {

    @Query(value = "SELECT * FROM \"AUTHER\" ORDER BY \"AUT_NO\"", nativeQuery = true)
    List<AuthorEntity> findAllOrderByNumber();

    @Query(value = "SELECT * FROM \"AUTHER\"", nativeQuery = true)
    List<AuthorEntity> findAllUnordered();

    /**
     * serh_auther1: substring(aut_nam,1,@lent) = ltrim(@desc) order by aut_nam. SQL Server's
     * "=" ignores trailing blanks and the column is _CI_, hence rtrim + lower.
     */
    @Query(value = "SELECT * FROM \"AUTHER\" "
            + "WHERE rtrim(substr(lower(\"AUT_NAM\"), 1, :length)) = lower(:prefix) "
            + "ORDER BY \"AUT_NAM\"", nativeQuery = true)
    List<AuthorEntity> findByNamePrefix(@Param("prefix") String prefix, @Param("length") int length);

    /** serh_auther2: aut_nam like @m_word order by aut_nam — user-typed % and _ stay wildcards. */
    @Query(value = "SELECT * FROM \"AUTHER\" "
            + "WHERE lower(\"AUT_NAM\") LIKE lower(:pattern) ESCAPE '' "
            + "ORDER BY \"AUT_NAM\"", nativeQuery = true)
    List<AuthorEntity> findByNameLike(@Param("pattern") String pattern);

    /** insr_auther */
    @Transactional
    @Modifying
    @Query(value = "INSERT INTO \"AUTHER\" (\"AUT_NAM\", \"AUT_NO\") VALUES (:name, :number)", nativeQuery = true)
    int insert(@Param("name") String name, @Param("number") Double number);

    /** upd_auther */
    @Transactional
    @Modifying
    @Query(value = "UPDATE \"AUTHER\" SET \"AUT_NAM\" = :name WHERE \"AUT_NO\" = :number", nativeQuery = true)
    int updateName(@Param("name") String name, @Param("number") Double number);

    /** del_auther */
    @Transactional
    @Modifying
    @Query(value = "DELETE FROM \"AUTHER\" WHERE \"AUT_NO\" = :number", nativeQuery = true)
    int deleteByNumber(@Param("number") Double number);
}
