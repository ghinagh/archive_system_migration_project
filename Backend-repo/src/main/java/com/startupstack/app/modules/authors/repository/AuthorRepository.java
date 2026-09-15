package com.startupstack.app.modules.authors.repository;

import com.startupstack.app.modules.authors.entity.AuthorEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface AuthorRepository extends JpaRepository<AuthorEntity, Double>,
                                          JpaSpecificationExecutor<AuthorEntity> {
}
