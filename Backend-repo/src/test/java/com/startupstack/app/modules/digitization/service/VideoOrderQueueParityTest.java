package com.startupstack.app.modules.digitization.service;

import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.digitization.dto.AddSceneRequest;
import com.startupstack.app.modules.digitization.dto.DemandResponse;
import com.startupstack.app.modules.digitization.dto.DemandTestResult;
import com.startupstack.app.modules.digitization.entity.DemandEntity;
import com.startupstack.app.modules.digitization.mapper.DemandMapper;
import com.startupstack.app.modules.digitization.repository.DemandRepository;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.media.MediaService;
import com.startupstack.app.shared.media.StockTier;
import org.junit.jupiter.api.io.TempDir;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

/**
 * "طلبيات الفيديو" (new_vdpreview.frm) legacy-parity rules: dmd_path is never rewritten by
 * fulfilment, only dmd_chek = 1 rows are processed, and queue-added scenes follow
 * upd_demand2/insr_demand1 (no cap, dmd_chek NULL, date only).
 */
@ExtendWith(MockitoExtension.class)
class VideoOrderQueueParityTest {

    @Mock private DemandRepository demandRepository;
    @Mock private CatalogueRepository catalogueRepository;
    @Mock private UserRepository userRepository;
    @Mock private DemandMapper demandMapper;
    @Mock private MediaService mediaService;
    @InjectMocks
    private DigitizationService digitizationService;

    private static DemandEntity demand(int id, Integer checked, String path) {
        DemandEntity e = new DemandEntity();
        e.setId(id);
        e.setDemandNo("0000007");
        e.setSerial(id);
        e.setMachineStock("000123");
        e.setChecked(checked);
        e.setPath(path);
        return e;
    }

    @TempDir
    Path tmp;

    private String sourceFile(String name) throws Exception {
        Path f = tmp.resolve(name);
        Files.writeString(f, "video");
        return f.toString();
    }

    @Test
    void fulfilDemand_copiesFromDmdPathKeepsItAndMarksDone() throws Exception {
        String source = sourceFile("000123.avi");
        DemandEntity row = demand(1, 1, source);
        String out = tmp.resolve("out.avi").toString();
        when(demandRepository.findById(1)).thenReturn(Optional.of(row));
        when(mediaService.archiveClipPathFor(any(), any(), eq("avi"))).thenReturn(out);
        when(demandRepository.save(any(DemandEntity.class))).thenAnswer(inv -> inv.getArgument(0));
        when(demandMapper.toResponse(any(DemandEntity.class))).thenReturn(new DemandResponse());

        digitizationService.fulfilDemand(1, "COPY");

        assertEquals(source, row.getPath());
        assertEquals(2, row.getChecked());
        assertTrue(Files.exists(Path.of(out)));
    }

    @Test
    void fulfilDemand_rejectsRowNotSelected() {
        when(demandRepository.findById(1)).thenReturn(Optional.of(demand(1, null, "/high/000123.avi")));

        assertThrows(BusinessException.class, () -> digitizationService.fulfilDemand(1, "COPY"));
        verify(mediaService, never()).archiveClipPathFor(any(), any(), any());
        verify(demandRepository, never()).save(any());
    }

    @Test
    void bulkFulfil_processesOnlySelectedRowsAndKeepsPaths() throws Exception {
        String a = sourceFile("a.avi");
        DemandEntity selected = demand(1, 1, a);
        DemandEntity fresh = demand(2, null, "/high/b.avi");
        DemandEntity done = demand(3, 2, "/high/c.avi");
        when(demandRepository.findById(1)).thenReturn(Optional.of(selected));
        when(demandRepository.findById(2)).thenReturn(Optional.of(fresh));
        when(demandRepository.findById(3)).thenReturn(Optional.of(done));
        when(mediaService.archiveClipPathFor(any(), any(), any())).thenReturn(tmp.resolve("out.avi").toString());

        digitizationService.bulkFulfil(List.of(1, 2, 3), "COPY", false);

        verify(mediaService, times(1)).archiveClipPathFor(any(), any(), any());
        assertEquals(2, selected.getChecked());
        assertNull(fresh.getChecked());
        assertEquals(2, done.getChecked());
        assertEquals(a, selected.getPath());
        @SuppressWarnings("unchecked")
        ArgumentCaptor<List<DemandEntity>> saved = ArgumentCaptor.forClass(List.class);
        verify(demandRepository).saveAll(saved.capture());
        assertEquals(List.of(selected), saved.getValue());
    }

    @Test
    void bulkFulfil_withNothingSelected_writesNothing() {
        when(demandRepository.findById(2)).thenReturn(Optional.of(demand(2, null, "/high/b.avi")));

        digitizationService.bulkFulfil(List.of(2), "COPY", false);

        verify(demandRepository, never()).saveAll(anyList());
    }

    @Test
    void testDemands_skipsRowsNotSelected() {
        when(demandRepository.findById(2)).thenReturn(Optional.of(demand(2, null, "/high/b.avi")));
        when(demandRepository.findById(3)).thenReturn(Optional.of(demand(3, 2, "/high/c.avi")));

        List<DemandTestResult> results = digitizationService.testDemands(List.of(2, 3));

        assertTrue(results.isEmpty());
    }

    @Test
    void addQueueScene_followsUpdDemand2_noCapNullCheckDateOnly() {
        AddSceneRequest request = new AddSceneRequest();
        request.setMachineNo("MCH0001");
        request.setMachineStock("000123");
        request.setDescription("  it's a/b: scene");
        request.setInSeconds(new BigDecimal("100"));
        request.setOutSeconds(new BigDecimal("1300"));
        request.setHighExtension("avi");

        when(catalogueRepository.findById("MCH0001")).thenReturn(Optional.of(new CatalogueEntity()));
        when(demandRepository.findMaxNumericDemandNo()).thenReturn(41);
        when(mediaService.resolveStockPath("000123", StockTier.HIGH, "avi")).thenReturn("/high/000123.avi");
        when(demandRepository.save(any(DemandEntity.class))).thenAnswer(inv -> inv.getArgument(0));
        when(demandMapper.toResponse(any(DemandEntity.class))).thenReturn(new DemandResponse());

        digitizationService.addQueueScene(request);

        ArgumentCaptor<DemandEntity> captor = ArgumentCaptor.forClass(DemandEntity.class);
        verify(demandRepository).save(captor.capture());
        DemandEntity saved = captor.getValue();
        assertEquals("0000042", saved.getDemandNo());
        assertEquals(1, saved.getSerial());
        assertNull(saved.getChecked());
        assertNull(saved.getTime1());
        assertEquals(LocalDate.now().atStartOfDay(), saved.getDate());
        assertEquals(new BigDecimal("1200"), saved.getOutputSize());
        assertEquals(0, saved.getHours());
        assertEquals(20, saved.getMinutes());
        assertEquals(0, saved.getSeconds());
        assertEquals("/high/000123.avi", saved.getPath());
        assertEquals("it s a b  scene", saved.getDescription());
    }

    @Test
    void addQueueScene_appendsNextSerialToExistingDemand() {
        AddSceneRequest request = new AddSceneRequest();
        request.setDemandNo("0000042");
        request.setMachineNo("MCH0001");
        request.setInSeconds(new BigDecimal("0"));
        request.setOutSeconds(new BigDecimal("10"));

        when(catalogueRepository.findById("MCH0001")).thenReturn(Optional.of(new CatalogueEntity()));
        when(demandRepository.findMaxSerialForDemandNo("0000042")).thenReturn(3);
        when(demandRepository.save(any(DemandEntity.class))).thenAnswer(inv -> inv.getArgument(0));
        when(demandMapper.toResponse(any(DemandEntity.class))).thenReturn(new DemandResponse());

        digitizationService.addQueueScene(request);

        ArgumentCaptor<DemandEntity> captor = ArgumentCaptor.forClass(DemandEntity.class);
        verify(demandRepository).save(captor.capture());
        assertEquals("0000042", captor.getValue().getDemandNo());
        assertEquals(4, captor.getValue().getSerial());
    }
}
