package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.Text1Request;
import com.startupstack.app.modules.catalogue.dto.Text1Response;
import com.startupstack.app.modules.catalogue.entity.Text1Entity;
import com.startupstack.app.modules.catalogue.entity.Text1Id;
import com.startupstack.app.modules.catalogue.repository.Text1Repository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class Text1Service {

    private final Text1Repository text1Repository;

    public Text1Service(Text1Repository text1Repository) {
        this.text1Repository = text1Repository;
    }

    @Transactional(readOnly = true)
    public List<Text1Response> getByAppNo(String appNo) {
        return text1Repository.findByTxtNo(appNo).stream()
                .map(this::toResponse)
                .toList();
    }

    @Transactional
    public Text1Response create(String appNo, Text1Request request) {
        Text1Id id = new Text1Id();
        id.setTxtNo(appNo);
        id.setTxtSerNo(request.txtSerNo());
        if (text1Repository.existsById(id)) {
            return toResponse(text1Repository.findById(id).orElseThrow());
        }
        Text1Entity entity = new Text1Entity();
        entity.setTxtNo(appNo);
        entity.setTxtSerNo(request.txtSerNo());
        entity.setTxtDescN(request.txtDescN());
        entity.setTxtRltvN(request.txtRltvN());
        entity.setTxtRltvTyp(request.txtRltvTyp());
        entity.setTxtText(request.txtText());
        entity.setTxtNbpage(request.txtNbpage());
        return toResponse(text1Repository.save(entity));
    }

    @Transactional
    public Text1Response update(String appNo, String serNo, Text1Request request) {
        Text1Entity entity = text1Repository.findByTxtNoAndTxtSerNo(appNo, serNo)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "Text1 entry not found for appNo=" + appNo + ", serNo=" + serNo));
        entity.setTxtDescN(request.txtDescN());
        entity.setTxtRltvN(request.txtRltvN());
        entity.setTxtRltvTyp(request.txtRltvTyp());
        entity.setTxtText(request.txtText());
        entity.setTxtNbpage(request.txtNbpage());
        return toResponse(text1Repository.save(entity));
    }

    @Transactional
    public void delete(String appNo, String serNo) {
        Text1Id id = new Text1Id();
        id.setTxtNo(appNo);
        id.setTxtSerNo(serNo);
        if (!text1Repository.existsById(id)) {
            throw new ResourceNotFoundException(
                    "Text1 entry not found for appNo=" + appNo + ", serNo=" + serNo);
        }
        text1Repository.deleteByTxtNoAndTxtSerNo(appNo, serNo);
    }

    private Text1Response toResponse(Text1Entity entity) {
        return new Text1Response(
                entity.getTxtNo(),
                entity.getTxtSerNo(),
                entity.getTxtDescN(),
                entity.getTxtRltvN(),
                entity.getTxtRltvTyp(),
                entity.getTxtText(),
                entity.getTxtNbpage()
        );
    }
}
