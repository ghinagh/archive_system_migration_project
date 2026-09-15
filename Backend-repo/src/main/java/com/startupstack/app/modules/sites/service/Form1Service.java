package com.startupstack.app.modules.sites.service;

import com.startupstack.app.modules.sites.dto.Form1Response;
import com.startupstack.app.modules.sites.entity.Form1Entity;
import com.startupstack.app.modules.sites.repository.Form1Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class Form1Service {

    private final Form1Repository form1Repository;

    public Form1Service(Form1Repository form1Repository) {
        this.form1Repository = form1Repository;
    }

    @Transactional(readOnly = true)
    public List<Form1Response> findAll(String type) {
        List<Form1Entity> entities = type != null
                ? form1Repository.findByFormType(type)
                : form1Repository.findAll();
        return entities.stream().map(this::toResponse).toList();
    }

    private Form1Response toResponse(Form1Entity entity) {
        Form1Response r = new Form1Response();
        r.setFormType(entity.getFormType());
        r.setFormNo(entity.getFormNo());
        r.setName(entity.getName());
        r.setDate(entity.getDate());
        return r;
    }
}
