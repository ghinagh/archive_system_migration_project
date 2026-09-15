package com.startupstack.app.modules.staff.repository;

import com.startupstack.app.modules.staff.entity.Person1Entity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface Person1Repository extends JpaRepository<Person1Entity, String>,
                                           JpaSpecificationExecutor<Person1Entity> {
}
