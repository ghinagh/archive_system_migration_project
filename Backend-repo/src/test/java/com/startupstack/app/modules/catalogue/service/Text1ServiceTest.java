package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.Text1Request;
import com.startupstack.app.modules.catalogue.dto.Text1Response;
import com.startupstack.app.modules.catalogue.entity.Text1Entity;
import com.startupstack.app.modules.catalogue.entity.Text1Id;
import com.startupstack.app.modules.catalogue.repository.Text1Repository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class Text1ServiceTest {

    @Mock
    private Text1Repository text1Repository;
    @InjectMocks
    private Text1Service text1Service;

    @Test
    void getByAppNo_mapsAllEntities() {
        Text1Entity entity = new Text1Entity();
        entity.setTxtNo("MN000001");
        entity.setTxtSerNo("01");
        when(text1Repository.findByTxtNo("MN000001")).thenReturn(List.of(entity));

        List<Text1Response> result = text1Service.getByAppNo("MN000001");

        assertEquals(1, result.size());
        assertEquals("MN000001", result.get(0).appNo());
    }

    @Test
    void create_newComposite_savesEntity() {
        Text1Request request = new Text1Request("01", "DESC", "01", "T", "نص تجريبي", 1);
        when(text1Repository.existsById(any(Text1Id.class))).thenReturn(false);
        when(text1Repository.save(any(Text1Entity.class))).thenAnswer(inv -> inv.getArgument(0));

        Text1Response result = text1Service.create("MN000001", request);

        assertEquals("MN000001", result.appNo());
        verify(text1Repository).save(any(Text1Entity.class));
    }

    @Test
    void create_existingComposite_returnsExistingWithoutSaving() {
        Text1Request request = new Text1Request("01", "DESC", "01", "T", "نص تجريبي", 1);
        Text1Entity existing = new Text1Entity();
        existing.setTxtNo("MN000001");
        existing.setTxtSerNo("01");
        when(text1Repository.existsById(any(Text1Id.class))).thenReturn(true);
        when(text1Repository.findById(any(Text1Id.class))).thenReturn(Optional.of(existing));

        Text1Response result = text1Service.create("MN000001", request);

        assertEquals("MN000001", result.appNo());
        verify(text1Repository, never()).save(any());
    }

    @Test
    void update_existing_updatesFieldsAndSaves() {
        Text1Request request = new Text1Request("01", "DESC2", "02", "R", "نص محدث", 2);
        Text1Entity existing = new Text1Entity();
        existing.setTxtNo("MN000001");
        existing.setTxtSerNo("01");
        when(text1Repository.findByTxtNoAndTxtSerNo("MN000001", "01")).thenReturn(Optional.of(existing));
        when(text1Repository.save(existing)).thenReturn(existing);

        Text1Response result = text1Service.update("MN000001", "01", request);

        assertEquals("نص محدث", result.txtText());
        assertEquals("DESC2", existing.getTxtDescN());
    }

    @Test
    void update_nonExistent_throwsResourceNotFound() {
        Text1Request request = new Text1Request("01", "DESC", "01", "T", "نص", 1);
        when(text1Repository.findByTxtNoAndTxtSerNo("MISSING", "01")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> text1Service.update("MISSING", "01", request));
    }

    @Test
    void delete_existing_deletesByCompositeKey() {
        when(text1Repository.existsById(any(Text1Id.class))).thenReturn(true);

        text1Service.delete("MN000001", "01");

        verify(text1Repository).deleteByTxtNoAndTxtSerNo("MN000001", "01");
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(text1Repository.existsById(any(Text1Id.class))).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> text1Service.delete("MN000001", "01"));
        verify(text1Repository, never()).deleteByTxtNoAndTxtSerNo(any(), any());
    }
}
