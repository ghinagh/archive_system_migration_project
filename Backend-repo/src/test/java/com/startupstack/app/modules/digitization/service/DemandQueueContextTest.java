package com.startupstack.app.modules.digitization.service;

import com.startupstack.app.modules.digitization.config.DemandProperties;
import com.startupstack.app.modules.digitization.dto.DemandQueueContext;
import com.startupstack.app.modules.digitization.mapper.DemandMapper;
import com.startupstack.app.modules.digitization.repository.DemandRepository;
import com.startupstack.app.modules.lookups.repository.CodingRepository;
import com.startupstack.app.modules.users.entity.UserEntity;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.exception.BusinessException;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.authentication.TestingAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;

/**
 * new_vdpreview.frm's two gates, strictly: the user filter unlocks only for
 * {@code box_user_no = "244"}; "start" and F5 only for {@code box_user_start = 1}.
 * user_level (the migrated admin flag) grants neither.
 */
@ExtendWith(MockitoExtension.class)
class DemandQueueContextTest {

    @Mock private DemandRepository demandRepository;
    @Mock private UserRepository userRepository;
    @Mock private CodingRepository codingRepository;
    @Mock private DemandMapper demandMapper;
    @Mock private DeliveryJobService deliveryJobService;

    private DemandQueueService service;

    @BeforeEach
    void setUp() {
        service = new DemandQueueService(demandRepository, userRepository, codingRepository,
                demandMapper, new DemandProperties(), deliveryJobService);
        SecurityContextHolder.getContext().setAuthentication(new TestingAuthenticationToken("u", null, "ROLE_USER"));
    }

    @AfterEach
    void tearDown() {
        SecurityContextHolder.clearContext();
    }

    private void currentUser(String userNo, Integer userStart, String level) {
        UserEntity u = new UserEntity();
        u.setUserNo(userNo);
        u.setUserName("name");
        u.setUserStart(userStart);
        u.setUserLevel(level);
        when(userRepository.findByUserName("u")).thenReturn(Optional.of(u));
    }

    @Test
    void user244_seesAllUsers_butIsNotAnOperatorWithoutUserStart1() {
        currentUser("244", null, null);
        DemandQueueContext ctx = service.context();
        assertTrue(ctx.isCanSeeAllUsers());
        assertFalse(ctx.isCanOperate());
    }

    @Test
    void userStart1_isOperator_butLockedToOwnOrders() {
        currentUser("012", 1, null);
        DemandQueueContext ctx = service.context();
        assertFalse(ctx.isCanSeeAllUsers());
        assertTrue(ctx.isCanOperate());
    }

    @Test
    void adminLevel_grantsNeitherRight() {
        currentUser("ADM", null, "A");
        DemandQueueContext ctx = service.context();
        assertFalse(ctx.isCanSeeAllUsers());
        assertFalse(ctx.isCanOperate());
    }

    @Test
    void userStartOtherThan1_isNotOperator() {
        currentUser("013", 2, null);
        assertFalse(service.context().isCanOperate());
    }

    @Test
    void userPicker_refusedUnlessUnlocked() {
        currentUser("ADM", 1, "A");
        assertThrows(BusinessException.class, () -> service.users("a"));
    }
}
