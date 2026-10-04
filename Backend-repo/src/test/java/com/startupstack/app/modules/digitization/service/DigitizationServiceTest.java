package com.startupstack.app.modules.digitization.service;

import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.digitization.dto.AddSceneRequest;
import com.startupstack.app.modules.digitization.dto.DemandRequest;
import com.startupstack.app.modules.digitization.dto.DemandResponse;
import com.startupstack.app.modules.digitization.dto.DigitRequest;
import com.startupstack.app.modules.digitization.dto.DigitResponse;
import com.startupstack.app.modules.digitization.entity.DemandEntity;
import com.startupstack.app.modules.digitization.entity.DigitEntity;
import com.startupstack.app.modules.digitization.entity.DigitId;
import com.startupstack.app.modules.digitization.mapper.DemandMapper;
import com.startupstack.app.modules.digitization.mapper.DigitMapper;
import com.startupstack.app.modules.digitization.mapper.ResultMapper;
import com.startupstack.app.modules.digitization.repository.DemandRepository;
import com.startupstack.app.modules.digitization.repository.DigitRepository;
import com.startupstack.app.modules.digitization.repository.ResultRepository;
import com.startupstack.app.modules.users.entity.UserEntity;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.media.MediaService;
import com.startupstack.app.shared.media.StockTier;
import com.startupstack.app.modules.digitization.config.DemandProperties;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Spy;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class DigitizationServiceTest {

    @Mock private DigitRepository digitRepository;
    @Mock private DemandRepository demandRepository;
    @Mock private ResultRepository resultRepository;
    @Mock private CatalogueRepository catalogueRepository;
    @Mock private UserRepository userRepository;
    @Mock private DigitMapper digitMapper;
    @Mock private DemandMapper demandMapper;
    @Mock private ResultMapper resultMapper;
    @Mock private MediaService mediaService;
    @Spy private DemandProperties demandProperties = new DemandProperties();
    @InjectMocks
    private DigitizationService digitizationService;

    @Test
    void createRecord_validatesParentCatalogue() {
        DigitRequest request = new DigitRequest();
        request.setDocNo("DOC0001");
        request.setSerial(1);

        when(catalogueRepository.findById("DOC0001")).thenReturn(Optional.of(new CatalogueEntity()));
        when(digitMapper.toEntity(request)).thenReturn(new DigitEntity());
        when(digitRepository.save(any())).thenReturn(new DigitEntity());
        when(digitMapper.toResponse(any())).thenReturn(new DigitResponse());

        digitizationService.createRecord(request);

        verify(catalogueRepository).findById("DOC0001");
        verify(digitRepository).save(any());
    }

    @Test
    void createRecord_withInvalidCatalogue_throwsResourceNotFound() {
        DigitRequest request = new DigitRequest();
        request.setDocNo("INVALID");

        when(catalogueRepository.findById("INVALID")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class,
                () -> digitizationService.createRecord(request));
    }

    @Test
    void createDemand_validatesUserAndCatalogue() {
        DemandRequest request = new DemandRequest();
        request.setDemandNo("DMD0001");
        request.setSerial(1);
        request.setUserNo("001");
        request.setMachineNo("MCH0001");

        DemandEntity entity = new DemandEntity();
        when(demandMapper.toEntity(request)).thenReturn(entity);
        when(userRepository.findById("001")).thenReturn(Optional.of(new UserEntity()));
        when(catalogueRepository.findById("MCH0001")).thenReturn(Optional.of(new CatalogueEntity()));
        when(demandRepository.save(entity)).thenReturn(entity);
        when(demandMapper.toResponse(entity)).thenReturn(new DemandResponse());

        digitizationService.createDemand(request);

        verify(userRepository).findById("001");
        verify(catalogueRepository).findById("MCH0001");
    }

    @Test
    void findRecordById_nonExistent_throwsResourceNotFound() {
        when(digitRepository.findById(any(DigitId.class))).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class,
                () -> digitizationService.findRecordById("NONE", 1));
    }

    @Test
    void deleteRecord_nonExistent_throwsResourceNotFound() {
        when(digitRepository.existsById(any(DigitId.class))).thenReturn(false);

        assertThrows(ResourceNotFoundException.class,
                () -> digitizationService.deleteRecord("NONE", 1));
    }

    @Test
    void addScene_withoutDemandNo_generatesNewNumberAndSerialOne() {
        AddSceneRequest request = new AddSceneRequest();
        request.setMachineNo("MCH0001");
        request.setMachineStock("H01");
        request.setInSeconds(new BigDecimal("10"));
        request.setOutSeconds(new BigDecimal("40"));

        when(catalogueRepository.findById("MCH0001")).thenReturn(Optional.of(new CatalogueEntity()));
        when(demandRepository.findMaxNumericDemandNo()).thenReturn(5);
        when(demandRepository.save(any(DemandEntity.class))).thenAnswer(inv -> inv.getArgument(0));
        when(demandMapper.toResponse(any(DemandEntity.class))).thenReturn(new DemandResponse());

        digitizationService.addScene(request);

        ArgumentCaptor<DemandEntity> captor = ArgumentCaptor.forClass(DemandEntity.class);
        verify(demandRepository).save(captor.capture());
        assertEquals("0000006", captor.getValue().getDemandNo());
        assertEquals(1, captor.getValue().getSerial());
        assertEquals(new BigDecimal("30"), captor.getValue().getOutputSize());
    }

    @Test
    void addScene_withExistingDemandNo_incrementsSerial() {
        AddSceneRequest request = new AddSceneRequest();
        request.setDemandNo("0000006");
        request.setMachineNo("MCH0001");
        request.setInSeconds(new BigDecimal("0"));
        request.setOutSeconds(new BigDecimal("15"));

        when(catalogueRepository.findById("MCH0001")).thenReturn(Optional.of(new CatalogueEntity()));
        when(demandRepository.findMaxSerialForDemandNo("0000006")).thenReturn(2);
        when(demandRepository.save(any(DemandEntity.class))).thenAnswer(inv -> inv.getArgument(0));
        when(demandMapper.toResponse(any(DemandEntity.class))).thenReturn(new DemandResponse());

        digitizationService.addScene(request);

        ArgumentCaptor<DemandEntity> captor = ArgumentCaptor.forClass(DemandEntity.class);
        verify(demandRepository).save(captor.capture());
        assertEquals("0000006", captor.getValue().getDemandNo());
        assertEquals(3, captor.getValue().getSerial());
    }

    @Test
    void addScene_outBeforeIn_throwsBusinessException() {
        AddSceneRequest request = new AddSceneRequest();
        request.setMachineNo("MCH0001");
        request.setInSeconds(new BigDecimal("20"));
        request.setOutSeconds(new BigDecimal("5"));

        when(catalogueRepository.findById("MCH0001")).thenReturn(Optional.of(new CatalogueEntity()));

        assertThrows(BusinessException.class, () -> digitizationService.addScene(request));
        verify(demandRepository, never()).save(any());
    }

    @Test
    void addScene_withInvalidCatalogue_throwsResourceNotFound() {
        AddSceneRequest request = new AddSceneRequest();
        request.setMachineNo("INVALID");
        request.setInSeconds(new BigDecimal("0"));
        request.setOutSeconds(new BigDecimal("5"));

        when(catalogueRepository.findById("INVALID")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> digitizationService.addScene(request));
    }

    @Test
    void addScene_withoutExplicitPath_resolvesViaMediaService() {
        AddSceneRequest request = new AddSceneRequest();
        request.setMachineNo("MCH0001");
        request.setMachineStock("H01");
        request.setInSeconds(new BigDecimal("0"));
        request.setOutSeconds(new BigDecimal("5"));

        when(catalogueRepository.findById("MCH0001")).thenReturn(Optional.of(new CatalogueEntity()));
        when(demandRepository.findMaxNumericDemandNo()).thenReturn(0);
        when(mediaService.resolveStockPath("H01", StockTier.HIGH, null)).thenReturn("/media/vol1/H01");
        when(demandRepository.save(any(DemandEntity.class))).thenAnswer(inv -> inv.getArgument(0));
        when(demandMapper.toResponse(any(DemandEntity.class))).thenReturn(new DemandResponse());

        digitizationService.addScene(request);

        ArgumentCaptor<DemandEntity> captor = ArgumentCaptor.forClass(DemandEntity.class);
        verify(demandRepository).save(captor.capture());
        assertEquals("/media/vol1/H01", captor.getValue().getPath());
    }
}
