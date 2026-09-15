package com.startupstack.app.modules.reports.repository;

import com.startupstack.app.modules.reports.entity.UserOutputEntity;
import com.startupstack.app.modules.reports.entity.UserOutputId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface UserOutputRepository extends JpaRepository<UserOutputEntity, UserOutputId>,
                                              JpaSpecificationExecutor<UserOutputEntity> {

    List<UserOutputEntity> findByUserNo(String userNo);
}
