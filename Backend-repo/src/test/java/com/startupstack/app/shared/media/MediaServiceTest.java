package com.startupstack.app.shared.media;

import com.startupstack.app.modules.admin.entity.RanjpathEntity;
import com.startupstack.app.modules.admin.repository.RanjpathRepository;
import com.startupstack.app.shared.exception.BusinessException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.api.io.TempDir;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.core.io.Resource;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class MediaServiceTest {

    @Mock
    private RanjpathRepository ranjpathRepository;

    @TempDir
    Path tempDir;

    private MediaProperties properties;
    private MediaService mediaService;

    @BeforeEach
    void setUp() {
        properties = new MediaProperties();
        properties.setBasePath(tempDir.resolve("base").toString());
        properties.setExtension(".tif");
        properties.setArchivePath(tempDir.resolve("archive").toString());
        mediaService = new MediaService(properties, ranjpathRepository);
    }

    @Test
    void resolveStockPath_matchesDbRange_usesRangePath() {
        RanjpathEntity range = new RanjpathEntity();
        range.setRjpNoFrom("1");
        range.setRjpNoTo("100");
        range.setRjpPath(tempDir.resolve("vol1").toString());
        when(ranjpathRepository.findAll()).thenReturn(List.of(range));

        String path = mediaService.resolveStockPath("50");

        assertEquals(tempDir.resolve("vol1") + "/50.tif", path);
    }

    @Test
    void resolveStockPath_outsideAllDbRanges_fallsBackToBasePath() {
        RanjpathEntity range = new RanjpathEntity();
        range.setRjpNoFrom("1");
        range.setRjpNoTo("100");
        range.setRjpPath(tempDir.resolve("vol1").toString());
        when(ranjpathRepository.findAll()).thenReturn(List.of(range));

        String path = mediaService.resolveStockPath("500");

        assertEquals(properties.getBasePath() + "/500.tif", path);
    }

    @Test
    void resolveStockPath_emptyDbRanges_usesConfiguredVolumeRanges() {
        when(ranjpathRepository.findAll()).thenReturn(List.of());
        MediaProperties.VolumeRange vr = new MediaProperties.VolumeRange();
        vr.setFrom(1);
        vr.setTo(100);
        vr.setPath(tempDir.resolve("configured-vol").toString());
        properties.setVolumes(List.of(vr));

        String path = mediaService.resolveStockPath("42");

        assertEquals(tempDir.resolve("configured-vol") + "/42.tif", path);
    }

    @Test
    void resolveStockPath_nonNumericStockNo_fallsBackToBasePath() {
        String path = mediaService.resolveStockPath("ABC123");

        assertEquals(properties.getBasePath() + "/ABC123.tif", path);
    }

    @Test
    void fileExists_existingFile_returnsTrue() throws IOException {
        when(ranjpathRepository.findAll()).thenReturn(List.of());
        Files.createDirectories(tempDir.resolve("base"));
        Files.writeString(tempDir.resolve("base/10.tif"), "data");

        assertTrue(mediaService.fileExists("10"));
    }

    @Test
    void fileExists_missingFile_returnsFalse() {
        when(ranjpathRepository.findAll()).thenReturn(List.of());

        assertFalse(mediaService.fileExists("999"));
    }

    @Test
    void loadAsResource_missingFile_returnsNull() {
        when(ranjpathRepository.findAll()).thenReturn(List.of());

        assertNull(mediaService.loadAsResource("999", StockTier.LOW, "tif"));
    }

    @Test
    void loadAsResource_existingFile_returnsResource() throws IOException {
        when(ranjpathRepository.findAll()).thenReturn(List.of());
        Files.createDirectories(tempDir.resolve("base"));
        Files.writeString(tempDir.resolve("base/10.tif"), "data");

        Resource resource = mediaService.loadAsResource("10", StockTier.LOW, "tif");

        assertNotNull(resource);
        assertTrue(resource.exists());
    }

    @Test
    void copyToArchive_missingSourceFile_throwsBusinessException() {
        when(ranjpathRepository.findAll()).thenReturn(List.of());

        assertThrows(BusinessException.class, () -> mediaService.copyToArchive("999"));
    }

    @Test
    void copyToArchive_existingSourceFile_copiesAndReturnsDestination() throws IOException {
        when(ranjpathRepository.findAll()).thenReturn(List.of());
        Files.createDirectories(tempDir.resolve("base"));
        Files.writeString(tempDir.resolve("base/10.tif"), "data");

        String destination = mediaService.copyToArchive("10");

        assertEquals(tempDir.resolve("archive").resolve("10.tif").toString(), destination);
        assertTrue(Files.exists(Path.of(destination)));
    }
}
