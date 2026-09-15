package com.startupstack.app.modules.sites.service;

import com.startupstack.app.modules.sites.dto.Form1Response;
import com.startupstack.app.modules.sites.entity.Form1Entity;
import com.startupstack.app.modules.sites.repository.Form1Repository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class Form1ServiceTest {

    @Mock
    private Form1Repository form1Repository;
    @InjectMocks
    private Form1Service form1Service;

    @Test
    void findAll_withType_filtersByFormType() {
        Form1Entity entity = new Form1Entity();
        entity.setFormType("01");
        entity.setFormNo("F0000001");
        entity.setName("نموذج الأرشفة");
        when(form1Repository.findByFormType("01")).thenReturn(List.of(entity));

        List<Form1Response> result = form1Service.findAll("01");

        assertEquals(1, result.size());
        assertEquals("نموذج الأرشفة", result.get(0).getName());
        verify(form1Repository, never()).findAll();
    }

    @Test
    void findAll_noType_returnsAllForms() {
        Form1Entity entity = new Form1Entity();
        entity.setFormType("02");
        entity.setFormNo("F0000002");
        when(form1Repository.findAll()).thenReturn(List.of(entity));

        List<Form1Response> result = form1Service.findAll(null);

        assertEquals(1, result.size());
        verify(form1Repository, never()).findByFormType(any());
    }
}
