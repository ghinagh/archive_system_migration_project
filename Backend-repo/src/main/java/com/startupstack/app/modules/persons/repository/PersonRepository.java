package com.startupstack.app.modules.persons.repository;

import com.startupstack.app.modules.persons.entity.PersonEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface PersonRepository extends JpaRepository<PersonEntity, String>,
                                          JpaSpecificationExecutor<PersonEntity> {
}
