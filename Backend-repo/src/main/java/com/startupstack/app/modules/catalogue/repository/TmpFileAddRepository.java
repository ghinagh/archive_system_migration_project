package com.startupstack.app.modules.catalogue.repository;

import com.startupstack.app.modules.catalogue.entity.TmpFileAddEntity;
import com.startupstack.app.modules.catalogue.entity.TmpFileAddId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface TmpFileAddRepository extends JpaRepository<TmpFileAddEntity, TmpFileAddId>,
        JpaSpecificationExecutor<TmpFileAddEntity> {

    List<TmpFileAddEntity> findByTmpFadNo(String tmpFadNo);
}
