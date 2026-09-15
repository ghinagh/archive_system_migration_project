package com.startupstack.app.modules.lookups.repository;

import com.startupstack.app.modules.lookups.entity.ArraysEntity;
import com.startupstack.app.modules.lookups.entity.ArraysEntityId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface ArraysRepository extends JpaRepository<ArraysEntity, ArraysEntityId>,
                                          JpaSpecificationExecutor<ArraysEntity> {

    /**
     * Replaces view_arrays, view_array01-04, view_array1-2:
     * filters ARRAYS by type code (AR_TYP). Each legacy view was a fixed-type subset.
     */
    List<ArraysEntity> findByArTyp(String arTyp);
}
