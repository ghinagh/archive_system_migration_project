package com.startupstack.app.modules.reports.repository;

import com.startupstack.app.modules.reports.entity.ReportTemplateEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface ReportTemplateRepository extends JpaRepository<ReportTemplateEntity, Integer>,
                                                  JpaSpecificationExecutor<ReportTemplateEntity> {

    List<ReportTemplateEntity> findByOutputNumOrderByIdAsc(Double outputNum);
}
