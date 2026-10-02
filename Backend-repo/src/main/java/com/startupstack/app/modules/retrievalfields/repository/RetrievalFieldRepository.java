package com.startupstack.app.modules.retrievalfields.repository;

import com.startupstack.app.modules.retrievalfields.entity.RetrievalFieldEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface RetrievalFieldRepository extends JpaRepository<RetrievalFieldEntity, UUID> {

    List<RetrievalFieldEntity> findByModule(String module);

    List<RetrievalFieldEntity> findByModuleAndEnabledTrue(String module);

    List<RetrievalFieldEntity> findByModuleAndEnabledTrueOrderByCategoryAscDisplayOrderAsc(String module);

    boolean existsByModuleAndFieldKey(String module, String fieldKey);

    Optional<RetrievalFieldEntity> findByModuleAndFieldKey(String module, String fieldKey);
}
