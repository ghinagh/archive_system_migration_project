package com.startupstack.app.modules.sites.repository;

import com.startupstack.app.modules.sites.entity.Form1Entity;
import com.startupstack.app.modules.sites.entity.Form1Id;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface Form1Repository extends JpaRepository<Form1Entity, Form1Id> {

    List<Form1Entity> findByFormType(String formType);
}
