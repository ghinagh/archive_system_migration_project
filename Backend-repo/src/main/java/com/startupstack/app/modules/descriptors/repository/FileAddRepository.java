package com.startupstack.app.modules.descriptors.repository;

import com.startupstack.app.modules.descriptors.entity.FileAddEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;
import java.util.UUID;

public interface FileAddRepository extends JpaRepository<FileAddEntity, UUID>,
                                           JpaSpecificationExecutor<FileAddEntity> {

    List<FileAddEntity> findByAppNo(String appNo);

    void deleteByAppNoAndSerialNo(String appNo, String serialNo);
}
