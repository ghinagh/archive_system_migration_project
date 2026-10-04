package com.startupstack.app.modules.digitization.service;

import com.startupstack.app.modules.digitization.dto.DeliveryJobStatus;
import com.startupstack.app.modules.digitization.entity.DemandEntity;
import com.startupstack.app.modules.digitization.repository.DemandRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.media.FfmpegService;
import com.startupstack.app.shared.media.MediaService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.api.io.TempDir;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

/**
 * new_vdpreview.frm start / newstart / copy loops (Command9 / Command4 / Command5): grid order,
 * dmd_chek = 1 only, legacy output names, dmd_path untouched, failures reported by stock number.
 */
@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
class DemandQueueJobTest {

    @Mock private DemandRepository demandRepository;
    @Mock private MediaService mediaService;
    @Mock private FfmpegService ffmpegService;
    @Mock private EdlcGateway edlcGateway;
    @InjectMocks
    private DeliveryJobService jobs;

    @TempDir
    Path tmp;
    Path out;

    @BeforeEach
    void setUp() throws Exception {
        out = Files.createDirectories(tmp.resolve("archive"));
        when(mediaService.archiveDirectory()).thenReturn(out);
        when(ffmpegService.checkPlayable(anyString())).thenReturn(true);
    }

    private DemandEntity row(int id, Integer checked, String sourceName, String stock) throws Exception {
        DemandEntity e = new DemandEntity();
        e.setId(id);
        e.setDemandNo("0000009");
        e.setSerial(id + 1);
        e.setChecked(checked);
        e.setMachineStock(stock);
        e.setDescription("Desc" + id + "   ");
        e.setInputSize(new BigDecimal("5"));
        e.setOutputSize(new BigDecimal("10"));
        if (sourceName != null) {
            Path src = tmp.resolve(sourceName);
            Files.writeString(src, "video");
            e.setPath(src.toString());
        } else {
            e.setPath(tmp.resolve("missing.avi").toString());
        }
        return e;
    }

    private DeliveryJobStatus run(List<DemandEntity> rows, String mechanism, boolean clip) {
        List<Integer> ids = rows.stream().map(DemandEntity::getId).toList();
        when(demandRepository.findAllById(ids)).thenReturn(rows);
        DeliveryJobStatus status = jobs.start(ids);
        jobs.runQueueProcess(status.getJobId(), ids, mechanism, clip, "order");
        return jobs.getStatus(status.getJobId());
    }

    @Test
    void copy_namesDescClipSerial_skipsUnselected_keepsPath() throws Exception {
        DemandEntity a = row(1, 1, "a.avi", "000123");
        DemandEntity b = row(2, null, "b.avi", "000124");
        String pathBefore = a.getPath();

        DeliveryJobStatus s = run(List.of(a, b), "COPY", false);

        assertTrue(Files.exists(out.resolve("orderDesc1 Clip 2.avi")));
        assertEquals(2, a.getChecked());
        assertNull(b.getChecked());
        assertEquals(pathBefore, a.getPath());
        assertEquals(1, s.getTotal());
        assertEquals(1, s.getSucceeded());
        assertTrue(s.getFailedStockNumbers().isEmpty());
    }

    @Test
    void copy_clip_usesLegacyZeroIndexAndCollisionLoop() throws Exception {
        DemandEntity a = row(1, 1, "a.avi", "000123");
        DemandEntity b = row(2, 1, "b.avi", "000124");

        run(List.of(a, b), "COPY", true);

        assertTrue(Files.exists(out.resolve("order_0.avi")));
        assertTrue(Files.exists(out.resolve("order_1_0.avi")));
    }

    @Test
    void newstart_cutsThenRenamesToDescClipSerialWithSourceExtension() throws Exception {
        DemandEntity a = row(1, 1, "a.mp4", "000123");
        doAnswer(inv -> {
            Files.writeString(Path.of((String) inv.getArgument(1)), "clip");
            return null;
        }).when(ffmpegService).legacyNewstart(anyString(), anyString(), any(), any());

        DeliveryJobStatus s = run(List.of(a), "NEWSTART", false);

        verify(ffmpegService).legacyNewstart(eq(a.getPath()), eq(out.resolve("order_1.mp4").toString()),
                eq(new BigDecimal("5")), eq(new BigDecimal("10")));
        assertTrue(Files.exists(out.resolve("orderDesc1 Clip 2.mp4")));
        assertFalse(Files.exists(out.resolve("order_1.mp4")));
        assertEquals(2, a.getChecked());
        assertEquals(1, s.getSucceeded());
    }

    @Test
    void newstart_missingSource_reportsStockAndLeavesRowSelected() throws Exception {
        DemandEntity a = row(1, 1, null, "000123");

        DeliveryJobStatus s = run(List.of(a), "NEWSTART", false);

        assertEquals(List.of("000123"), s.getFailedStockNumbers());
        assertEquals(1, a.getChecked());
        verify(ffmpegService, never()).legacyNewstart(any(), any(), any(), any());
    }

    @Test
    void start_encodesToDescClipSerialAvi() throws Exception {
        DemandEntity a = row(1, 1, "a.mpg", "000123");

        run(List.of(a), "START", false);

        verify(ffmpegService).legacyStartEncode(a.getPath(), out.resolve("orderDesc1 Clip 2.avi").toString(),
                new BigDecimal("5"), new BigDecimal("10"));
        assertEquals(2, a.getChecked());
    }

    @Test
    void start_failedEncode_isNotMarkedDone() throws Exception {
        DemandEntity a = row(1, 1, "a.avi", "000123");
        doThrow(new BusinessException("ffmpeg exited with code 1"))
                .when(ffmpegService).legacyStartEncode(any(), any(), any(), any());

        DeliveryJobStatus s = run(List.of(a), "START", false);

        assertEquals(1, a.getChecked());
        assertEquals(List.of("000123"), s.getFailedStockNumbers());
    }

    @Test
    void start_clip_mergesEveryScene_intoNameAvi() throws Exception {
        DemandEntity a = row(1, 1, "a.avi", "000123");
        DemandEntity b = row(2, 1, "b.avi", "000124");

        run(List.of(a, b), "START", true);

        verify(ffmpegService, times(2)).legacyStartEncode(any(), any(), any(), any());
        verify(ffmpegService).mergeConcat(anyList(), eq(out.resolve("order.avi").toString()));
        assertEquals(2, a.getChecked());
        assertEquals(2, b.getChecked());
    }

    @Test
    void nothingSelected_isFlagged() throws Exception {
        DeliveryJobStatus s = run(List.of(row(1, null, "a.avi", "1"), row(2, 2, "b.avi", "2")), "COPY", false);

        assertTrue(s.isNothingSelected());
        assertEquals(DeliveryJobStatus.State.COMPLETED, s.getState());
    }

    @Test
    void legacyPathStock_followsMidStrFormula() {
        assertEquals("000123", DemandQueueService.legacyPathStock("123"));
        assertEquals("123", DemandQueueService.legacyPathStock("000123"));
        assertEquals("000007", DemandQueueService.legacyPathStock("7"));
        assertNull(DemandQueueService.legacyPathStock("A12"));
    }

    @Test
    void padDemandNo_padsToSeven() {
        assertEquals("0000123", DemandQueueService.padDemandNo("123"));
        assertEquals("1234567", DemandQueueService.padDemandNo("1234567"));
        assertNull(DemandQueueService.padDemandNo(" "));
    }
}
