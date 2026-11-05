package com.startupstack.app.modules.lookups.repository;

import com.startupstack.app.modules.lookups.entity.MacnzEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface MacnzRepository extends JpaRepository<MacnzEntity, String>,
                                         JpaSpecificationExecutor<MacnzEntity> {

    /** One MACNZ row, read without the entity: legacy MACNZ has no key. */
    interface Row {
        String getCode();
        String getLevel();
        String getDescription();
        Double getLogic();
    }

    /**
     * Every MACNZ row with a code, as stored. findAll() can't be used: real legacy data has rows with
     * a NULL SUB_CODE (Hibernate returns them as null elements, which broke name lookups on the
     * analysis page) and repeated codes (Hibernate collapses them into one instance).
     */
    @Query(value = "SELECT \"SUB_CODE\" AS code, \"SUB_LEVEL\" AS level, \"SUB_DESC\" AS description, "
            + "\"SUB_LOGIC\" AS logic FROM \"MACNZ\" WHERE \"SUB_CODE\" IS NOT NULL ORDER BY ctid", nativeQuery = true)
    List<Row> findAllRows();
}
