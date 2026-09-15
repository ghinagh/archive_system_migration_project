package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.TmpFileAddRequest;
import com.startupstack.app.modules.catalogue.dto.TmpFileAddResponse;
import com.startupstack.app.modules.catalogue.entity.TmpFileAddEntity;
import com.startupstack.app.modules.catalogue.entity.TmpFileAddId;
import com.startupstack.app.modules.catalogue.repository.TmpFileAddRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class TmpFileAddServiceTest {

    @Mock
    private TmpFileAddRepository tmpFileAddRepository;
    @InjectMocks
    private TmpFileAddService tmpFileAddService;

    @BeforeEach
    void setUp() {
        SecurityContextHolder.getContext().setAuthentication(
                new UsernamePasswordAuthenticationToken("librarian1", null));
    }

    @AfterEach
    void tearDown() {
        SecurityContextHolder.clearContext();
    }

    @Test
    void findAll_delegatesToRepositoryWithSpecification() {
        TmpFileAddEntity entity = new TmpFileAddEntity();
        entity.setTmpFadNo("MN000001");
        entity.setTmpSer(1.0);
        when(tmpFileAddRepository.findAll(any(Specification.class))).thenReturn(List.of(entity));

        List<TmpFileAddResponse> result = tmpFileAddService.findAll("MN000001", null, null);

        assertEquals(1, result.size());
        assertEquals("MN000001", result.get(0).tmpFadNo());
    }

    @Test
    void create_noExistingEntries_assignsSerialOne() {
        TmpFileAddRequest request = new TmpFileAddRequest("MN000001", "scan.tif", "remark", "mk", null);
        when(tmpFileAddRepository.findByTmpFadNo("MN000001")).thenReturn(List.of());
        when(tmpFileAddRepository.save(any(TmpFileAddEntity.class))).thenAnswer(inv -> inv.getArgument(0));

        TmpFileAddResponse result = tmpFileAddService.create(request);

        assertEquals(1.0, result.tmpSer());
        assertEquals("librarian1", result.tmpUserNo());
        assertEquals(0, result.tmpFinal());
    }

    @Test
    void create_existingEntries_assignsNextSerialAfterMax() {
        TmpFileAddRequest request = new TmpFileAddRequest("MN000001", "scan.tif", "remark", "mk", null);
        TmpFileAddEntity e1 = new TmpFileAddEntity();
        e1.setTmpSer(1.0);
        TmpFileAddEntity e2 = new TmpFileAddEntity();
        e2.setTmpSer(3.0);
        when(tmpFileAddRepository.findByTmpFadNo("MN000001")).thenReturn(List.of(e1, e2));
        when(tmpFileAddRepository.save(any(TmpFileAddEntity.class))).thenAnswer(inv -> inv.getArgument(0));

        TmpFileAddResponse result = tmpFileAddService.create(request);

        assertEquals(4.0, result.tmpSer());
    }

    @Test
    void finalize_existing_setsFinalFlag() {
        TmpFileAddEntity entity = new TmpFileAddEntity();
        entity.setTmpFadNo("MN000001");
        entity.setTmpSer(1.0);
        when(tmpFileAddRepository.findById(any(TmpFileAddId.class))).thenReturn(Optional.of(entity));
        when(tmpFileAddRepository.save(entity)).thenReturn(entity);

        TmpFileAddResponse result = tmpFileAddService.finalize("MN000001", 1.0);

        assertEquals(1, result.tmpFinal());
    }

    @Test
    void finalize_nonExistent_throwsResourceNotFound() {
        when(tmpFileAddRepository.findById(any(TmpFileAddId.class))).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> tmpFileAddService.finalize("MISSING", 1.0));
    }

    @Test
    void delete_existing_deletes() {
        when(tmpFileAddRepository.existsById(any(TmpFileAddId.class))).thenReturn(true);

        tmpFileAddService.delete("MN000001", 1.0);

        verify(tmpFileAddRepository).deleteById(any(TmpFileAddId.class));
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(tmpFileAddRepository.existsById(any(TmpFileAddId.class))).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> tmpFileAddService.delete("MISSING", 1.0));
        verify(tmpFileAddRepository, never()).deleteById(any());
    }
}
