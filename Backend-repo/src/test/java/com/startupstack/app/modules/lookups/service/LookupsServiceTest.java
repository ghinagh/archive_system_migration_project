package com.startupstack.app.modules.lookups.service;

import com.startupstack.app.modules.lookups.dto.ArraysResponse;
import com.startupstack.app.modules.lookups.dto.CodingResponse;
import com.startupstack.app.modules.lookups.dto.MacnzResponse;
import com.startupstack.app.modules.lookups.entity.ArraysEntity;
import com.startupstack.app.modules.lookups.entity.MacnzEntity;
import com.startupstack.app.modules.lookups.mapper.LookupsMapper;
import com.startupstack.app.modules.lookups.repository.ArraysRepository;
import com.startupstack.app.modules.lookups.repository.CodingRepository;
import com.startupstack.app.modules.lookups.repository.MacnzRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class LookupsServiceTest {

    @Mock
    private ArraysRepository arraysRepository;
    @Mock
    private MacnzRepository macnzRepository;
    @Mock
    private CodingRepository codingRepository;
    @Mock
    private LookupsMapper lookupsMapper;
    @InjectMocks
    private LookupsService lookupsService;

    @Test
    void getAllArrays_returnsAllEntries() {
        ArraysEntity entity = new ArraysEntity();
        entity.setArTyp("01");
        entity.setArCode(1.0);
        entity.setArDesc("نوع");

        ArraysResponse response = new ArraysResponse();
        response.setType("01");
        response.setDescription("نوع");

        when(arraysRepository.findAll()).thenReturn(List.of(entity));
        when(lookupsMapper.toArraysResponseList(List.of(entity))).thenReturn(List.of(response));

        List<ArraysResponse> result = lookupsService.getAllArrays(null);

        assertEquals(1, result.size());
        assertEquals("نوع", result.get(0).getDescription());
    }

    @Test
    void getAllSubjects_returnsAllEntries() {
        MacnzEntity entity = new MacnzEntity();
        entity.setSubCode("001");
        entity.setSubDesc("تاريخ");

        MacnzResponse response = new MacnzResponse();
        response.setCode("001");
        response.setDescription("تاريخ");

        when(macnzRepository.findAll()).thenReturn(List.of(entity));
        when(lookupsMapper.toMacnzResponseList(List.of(entity))).thenReturn(List.of(response));

        List<MacnzResponse> result = lookupsService.getAllSubjects();

        assertEquals(1, result.size());
        assertEquals("تاريخ", result.get(0).getDescription());
    }

    @Test
    void getAllCoding_returnsAllEntries() {
        when(codingRepository.findAll()).thenReturn(List.of());
        when(lookupsMapper.toCodingResponseList(List.of())).thenReturn(List.of());

        List<CodingResponse> result = lookupsService.getAllCoding();

        assertTrue(result.isEmpty());
    }
}
