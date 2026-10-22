package com.startupstack.app.modules.configusers.service;

import com.startupstack.app.modules.configusers.config.ConfigUsersProperties;
import com.startupstack.app.modules.configusers.dto.FieldRow;
import com.startupstack.app.modules.configusers.repository.ConfigUsersRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.PermissionDeniedException;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ConfigUsersServiceTest {

    @Mock
    private ConfigUsersRepository repository;
    private ConfigUsersService service;

    @BeforeEach
    void setUp() {
        service = new ConfigUsersService(repository);
    }

    @AfterEach
    void clear() {
        SecurityContextHolder.clearContext();
    }

    @Test
    void ist_isMidOfTheBoundText() {
        assertEquals("01", ConfigUsersService.ist("3801"));
        assertEquals("05", ConfigUsersService.ist("3805"));
        assertEquals("", ConfigUsersService.ist(""));
        assertEquals("", ConfigUsersService.ist(null));
    }

    @Test
    void doubleClick_choosesProcUserBnkoutFor01_elseProcUserPout() {
        service.userFields("ADM", "3801");
        verify(repository).procUserBnkout("ADM", "01");
        service.userFields("ADMX", "3802");   // @m_user_no char(3) cuts the text
        verify(repository).procUserPout("ADM", "02");
    }

    @Test
    void f4_createsEveryChosenBnkoutField_whenTheUserHasNone() {
        when(repository.countUserFields("ADM", "01")).thenReturn(0);
        when(repository.bnkoutChoices()).thenReturn(List.of(
                new Object[]{5.0, "001"}, new Object[]{7.0, "0123"}, new Object[]{null, null}));
        assertEquals(3, service.createFields("ADM", "3801"));
        verify(repository).insertUserField("ADM", 5, "001", "01");
        verify(repository).insertUserField("ADM", 7, "012", "01");   // @m_out_index char(3)
        verify(repository).insertUserField("ADM", 0, "", "01");      // '' → int 0, Null → ''
    }

    @Test
    void f4_doesNothing_whenSerhUserBnkoutFindsFields() {
        when(repository.countUserFields("ADM", "01")).thenReturn(4);
        assertEquals(0, service.createFields("ADM", "3801"));
        verify(repository, never()).insertUserField(anyString(), anyInt(), anyString(), anyString());
    }

    @Test
    void f4_otherFormType_readsPoutOfThatOutIst_withFloatIndexAsVbText() {
        when(repository.poutChoices(2)).thenReturn(List.<Object[]>of(new Object[]{12.0, 3.0}));
        when(repository.countUserFields("U01", "02")).thenReturn(0);
        assertEquals(1, service.createFields("U01", "3802"));
        verify(repository).insertUserField("U01", 12, "3", "02");
    }

    @Test
    void f4_withNoSourceFields_isAMessage() {
        when(repository.countUserFields("ADM", "01")).thenReturn(0);
        when(repository.bnkoutChoices()).thenReturn(List.of());
        assertThrows(BusinessException.class, () -> service.createFields("ADM", "3801"));
    }

    @Test
    void f4_fractionalOutNum_isAConversionError() {
        when(repository.countUserFields("ADM", "01")).thenReturn(0);
        when(repository.bnkoutChoices()).thenReturn(List.<Object[]>of(new Object[]{5.5, "1"}));
        assertThrows(BusinessException.class, () -> service.createFields("ADM", "3801"));
    }

    @Test
    void f3_deletesTheUsersFieldsOfTheFormType() {
        when(repository.deleteUserFields("ADM", "01")).thenReturn(3);
        assertEquals(3, service.deleteFields("ADM", "3801"));
    }

    @Test
    void grid1_cellConversions_followTheLegacyColumns() {
        assertEquals("abc", ConfigUsersService.convert("user_password", 15, "abc"));
        assertThrows(BusinessException.class, () -> ConfigUsersService.convert("user_password", 15, "1234567890123456"));
        assertThrows(BusinessException.class, () -> ConfigUsersService.convert("user_no", 3, "ABCD"));
        assertEquals(1, ConfigUsersService.convert("user_start", 0, " 1 "));
        assertNull(ConfigUsersService.convert("user_start", 0, ""));
        assertThrows(BusinessException.class, () -> ConfigUsersService.convert("USER_PWD", 0, "x"));
    }

    @Test
    void grid1_onlyTheTenLegacyColumnsAreEditable() {
        assertThrows(BusinessException.class, () -> service.updateUser(Map.of(), "user_level", "A"));
        assertThrows(BusinessException.class, () -> service.updateUser(Map.of(), "user_permition", "255"));
        when(repository.updateConfig(eq("user_name"), eq("x"), any())).thenReturn(1);
        service.updateUser(Map.of("user_no", "ADM"), "user_name", "x");
    }

    @Test
    void grid1_rowNotFoundOrAmbiguous_isAMessage() {
        when(repository.updateConfig(anyString(), any(), any())).thenReturn(0);
        assertThrows(BusinessException.class, () -> service.updateUser(Map.of(), "user_name", "x"));
        when(repository.deleteConfig(any())).thenReturn(2);
        assertThrows(BusinessException.class, () -> service.deleteUser(Map.of()));
    }

    @Test
    void grid1_newRow_insertsOnlyTheFilledLegacyColumns() {
        service.insertUser(Map.of("user_no", "U02", "user_password", "pw", "user_level", "A"));
        verify(repository).insertConfig(argThat(m -> m.size() == 2 && "U02".equals(m.get("user_no")) && "pw".equals(m.get("user_password"))));
    }

    @Test
    void grid3_editsChoiceAndIndex_only() {
        FieldRow row = new FieldRow("01", "ADM", 5, "x", 2, "001");
        when(repository.updateUserField("user_index", "002", row)).thenReturn(1);
        service.updateField(row, "user_out_index", "002");
        when(repository.updateUserField("user_out_choice", 1, row)).thenReturn(1);
        service.updateField(row, "user_out_choice", "1");
        assertThrows(BusinessException.class, () -> service.updateField(row, "user_out_desc", "y"));
        assertThrows(BusinessException.class, () -> service.updateField(row, "user_out_index", "0001"));
    }

    @Test
    void grid2_rangeColumns() {
        assertThrows(BusinessException.class, () -> ConfigUsersService.convert("rjp_nofrom", 10, "12345678901"));
        when(repository.updateRange(1, "rjp_typ", 2)).thenReturn(1);
        service.updateRange(1, "rjp_typ", "2");
        assertThrows(BusinessException.class, () -> service.updateRange(1, "rjp_no", "9"));
    }

    @Test
    void accessKey_261015_grantsAndTheGrantIsBoundToTheUser() {
        ConfigUsersAccessService access = new ConfigUsersAccessService(new ConfigUsersProperties());
        SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken("u1", null, List.of()));
        assertThrows(BusinessException.class, () -> access.grant("891045"));
        String token = access.grant("  261015").token();     // LTrim(m_user_password.Text) = password1
        access.verify(token);
        assertThrows(PermissionDeniedException.class, () -> access.verify(null));
        SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken("u2", null, List.of()));
        assertThrows(PermissionDeniedException.class, () -> access.verify(token));
    }
}
