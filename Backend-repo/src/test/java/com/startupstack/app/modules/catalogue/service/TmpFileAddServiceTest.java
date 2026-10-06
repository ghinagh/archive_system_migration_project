package com.startupstack.app.modules.catalogue.service;

import com.startupstack.app.modules.catalogue.dto.TmpFileAddRequest;
import com.startupstack.app.modules.catalogue.dto.TmpFileAddResponse;
import com.startupstack.app.modules.catalogue.entity.TmpFileAddEntity;
import com.startupstack.app.modules.catalogue.entity.TmpFileAddId;
import com.startupstack.app.modules.catalogue.repository.TmpFileAddRepository;
import com.startupstack.app.modules.users.entity.UserEntity;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;

import java.time.Clock;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class TmpFileAddServiceTest {

    @Mock
    private TmpFileAddRepository tmpFileAddRepository;
    @Mock
    private UserRepository userRepository;
    private TmpFileAddService tmpFileAddService;

    @BeforeEach
    void setUp() {
        tmpFileAddService = new TmpFileAddService(tmpFileAddRepository, userRepository,
                Clock.fixed(Instant.parse("2026-10-06T09:00:00Z"), ZoneOffset.UTC));
        SecurityContextHolder.getContext().setAuthentication(
                new UsernamePasswordAuthenticationToken("librarian1", null));
    }

    @AfterEach
    void tearDown() {
        SecurityContextHolder.clearContext();
    }

    private static com.startupstack.app.modules.catalogue.repository.TmpFileAddListRow listRow(String no, Double ser, String user, String name) {
        com.startupstack.app.modules.catalogue.repository.TmpFileAddListRow r =
                org.mockito.Mockito.mock(com.startupstack.app.modules.catalogue.repository.TmpFileAddListRow.class);
        when(r.getTmpFadNo()).thenReturn(no);
        when(r.getTmpSer()).thenReturn(ser);
        when(r.getTmpUserNo()).thenReturn(user);
        when(r.getUserName()).thenReturn(name);
        return r;
    }

    @Test
    void findAll_delegatesToRepositoryWithFilters() {
        var row = listRow("MN000001", 1.0, "ADM", "admin");
        when(tmpFileAddRepository.findListRows("MN000001", null, null)).thenReturn(List.of(row));

        List<TmpFileAddResponse> result = tmpFileAddService.findAll("MN000001", null, null);

        assertEquals(1, result.size());
        assertEquals("MN000001", result.get(0).tmpFadNo());
        assertEquals(1.0, result.get(0).tmpSer());
        assertEquals("admin", result.get(0).userName());
    }

    @Test
    void findAll_listsRowsWithoutSerialAndMissingUsers() {
        var row = listRow("MN000002", null, "ZZZ", null);
        when(tmpFileAddRepository.findListRows(null, null, null)).thenReturn(List.of(row));

        List<TmpFileAddResponse> result = tmpFileAddService.findAll(null, null, null);

        assertEquals(1, result.size());
        org.junit.jupiter.api.Assertions.assertNull(result.get(0).tmpSer());
        org.junit.jupiter.api.Assertions.assertNull(result.get(0).userName());
    }

    private void loggedInAs(String username, String userNo, String userName) {
        SecurityContextHolder.getContext().setAuthentication(
                new UsernamePasswordAuthenticationToken(username, null, List.of()));
        UserEntity u = new UserEntity();
        u.setUserNo(userNo);
        u.setUserName(userName);
        when(userRepository.findByUserName(username)).thenReturn(Optional.of(u));
    }

    @Test
    void create_isOpTmp_configUserNo_todayNotFinal_noRequestFields() {
        loggedInAs("admin", "ADM", "admin");
        when(tmpFileAddRepository.findMaxSerialOfUser("ADM")).thenReturn(null);

        TmpFileAddResponse result = tmpFileAddService.create(new TmpFileAddRequest("9998887"));

        // none for this user → 1; the 3-character user number, not the login name
        verify(tmpFileAddRepository).insertOp(1.0, "ADM", "9998887", LocalDateTime.of(2026, 10, 6, 0, 0));
        verify(tmpFileAddRepository, never()).save(any());
        assertEquals(1.0, result.tmpSer());
        assertEquals("ADM", result.tmpUserNo());
        assertEquals(0, result.tmpFinal());
        assertNull(result.tmpFileName());
        assertNull(result.tmpRmrk());
        assertNull(result.tmpMk());
    }

    @Test
    void create_serialIsPerUser_truncatedMaxPlusOne_paddedChars() {
        loggedInAs("ab", "AB", "ab");
        when(tmpFileAddRepository.findMaxSerialOfUser("AB ")).thenReturn(7.6);

        TmpFileAddResponse result = tmpFileAddService.create(new TmpFileAddRequest("123"));

        // declare @max1 int: 7.6 → 7, + 1; @m_user_no char(3), @m_code char(7)
        verify(tmpFileAddRepository).insertOp(8.0, "AB ", "123    ", LocalDateTime.of(2026, 10, 6, 0, 0));
        verify(tmpFileAddRepository, never()).findByTmpFadNo(any());
        assertEquals(8.0, result.tmpSer());
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

    @org.junit.jupiter.api.Test
    void userName_validUserShown_missingOrNullUserBlank() {
        com.startupstack.app.modules.catalogue.entity.TmpFileAddEntity e = new com.startupstack.app.modules.catalogue.entity.TmpFileAddEntity();
        com.startupstack.app.modules.users.entity.UserEntity user = org.mockito.Mockito.mock(com.startupstack.app.modules.users.entity.UserEntity.class);
        org.mockito.Mockito.when(user.getUserName()).thenReturn("admin");
        e.setUser(user);
        org.junit.jupiter.api.Assertions.assertEquals("admin", TmpFileAddService.userName(e));
        // a lazy proxy for a tmp_user_no that names no config row
        com.startupstack.app.modules.users.entity.UserEntity missing = org.mockito.Mockito.mock(com.startupstack.app.modules.users.entity.UserEntity.class);
        org.mockito.Mockito.when(missing.getUserName()).thenThrow(new jakarta.persistence.EntityNotFoundException("ZZZ"));
        e.setUser(missing);
        org.junit.jupiter.api.Assertions.assertNull(TmpFileAddService.userName(e));
        e.setUser(null);
        org.junit.jupiter.api.Assertions.assertNull(TmpFileAddService.userName(e));
    }
}
