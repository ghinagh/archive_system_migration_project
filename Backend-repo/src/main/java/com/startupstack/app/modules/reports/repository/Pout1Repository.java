package com.startupstack.app.modules.reports.repository;

import com.startupstack.app.modules.reports.entity.Pout1Entity;
import com.startupstack.app.modules.reports.entity.Pout1Id;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface Pout1Repository extends JpaRepository<Pout1Entity, Pout1Id>,
                                         JpaSpecificationExecutor<Pout1Entity> {
}
