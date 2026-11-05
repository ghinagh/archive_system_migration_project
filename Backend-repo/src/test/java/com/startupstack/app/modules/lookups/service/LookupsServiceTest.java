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
        // findAllRows(): every MACNZ row that has a code, in stored order (legacy rows repeat codes)
        com.startupstack.app.modules.lookups.repository.MacnzRepository.Row row =
                org.mockito.Mockito.mock(com.startupstack.app.modules.lookups.repository.MacnzRepository.Row.class);
        when(row.getCode()).thenReturn("001");
        when(row.getDescription()).thenReturn("تاريخ");
        when(macnzRepository.findAllRows()).thenReturn(List.of(row));

        List<MacnzResponse> result = lookupsService.getAllSubjects();

        assertEquals(1, result.size());
        assertEquals("001", result.get(0).getCode());
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
