package com.startupstack.app.modules.users.service;

import com.startupstack.app.config.security.JwtUtil;
import com.startupstack.app.modules.users.dto.LoginRequest;
import com.startupstack.app.modules.users.dto.LoginResponse;
import com.startupstack.app.modules.users.dto.UserRequest;
import com.startupstack.app.modules.users.dto.UserResponse;
import com.startupstack.app.modules.users.entity.UserEntity;
import com.startupstack.app.modules.users.mapper.UserMapper;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock
    private UserRepository userRepository;
    @Mock
    private UserMapper userMapper;
    @Mock
    private JwtUtil jwtUtil;
    @Mock
    private PasswordEncoder passwordEncoder;
    @InjectMocks
    private UserService userService;

    private UserEntity testUser;

    @BeforeEach
    void setUp() {
        testUser = new UserEntity();
        testUser.setUserNo("001");
        testUser.setUserName("admin");
        testUser.setUserPassword("$2a$10$hashedpassword");
        testUser.setUserLevel("A");
    }

    @Test
    void login_withValidCredentials_returnsToken() {
        LoginRequest request = new LoginRequest();
        request.setUsername("admin");
        request.setPassword("password123");

        when(userRepository.findByUserName("admin")).thenReturn(Optional.of(testUser));
        when(passwordEncoder.matches("password123", testUser.getUserPassword())).thenReturn(true);
        when(jwtUtil.generateToken("admin", null, null, null, "A", null)).thenReturn("jwt-token-123");

        LoginResponse response = userService.login(request);

        assertNotNull(response);
        assertEquals("jwt-token-123", response.getToken());
        assertEquals("admin", response.getUsername());
        assertEquals("A", response.getLevel());
    }

    @Test
    void login_withNonExistentUser_throwsResourceNotFound() {
        LoginRequest request = new LoginRequest();
        request.setUsername("unknown");
        request.setPassword("pass");

        when(userRepository.findByUserName("unknown")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> userService.login(request));
    }

    @Test
    void login_withWrongPassword_throwsIllegalArgument() {
        LoginRequest request = new LoginRequest();
        request.setUsername("admin");
        request.setPassword("wrongpass");

        when(userRepository.findByUserName("admin")).thenReturn(Optional.of(testUser));
        when(passwordEncoder.matches("wrongpass", testUser.getUserPassword())).thenReturn(false);

        assertThrows(IllegalArgumentException.class, () -> userService.login(request));
    }

    @Test
    void findById_withExistingUser_returnsResponse() {
        UserResponse expected = new UserResponse();
        expected.setUserNo("001");

        when(userRepository.findById("001")).thenReturn(Optional.of(testUser));
        when(userMapper.toResponse(testUser)).thenReturn(expected);

        UserResponse response = userService.findById("001");

        assertEquals("001", response.getUserNo());
    }

    @Test
    void findById_withMissingUser_throwsResourceNotFound() {
        when(userRepository.findById("999")).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class, () -> userService.findById("999"));
    }

    @Test
    void create_withNewUserNo_encodesPasswordAndSaves() {
        UserRequest request = new UserRequest();
        request.setUserNo("002");
        request.setUserPassword("plainpass");

        UserEntity mapped = new UserEntity();
        mapped.setUserNo("002");
        UserResponse expected = new UserResponse();
        expected.setUserNo("002");

        when(userRepository.existsById("002")).thenReturn(false);
        when(userMapper.toEntity(request)).thenReturn(mapped);
        when(passwordEncoder.encode("plainpass")).thenReturn("$2a$10$encoded");
        when(userRepository.save(mapped)).thenReturn(mapped);
        when(userMapper.toResponse(mapped)).thenReturn(expected);

        UserResponse response = userService.create(request);

        assertEquals("002", response.getUserNo());
        assertEquals("$2a$10$encoded", mapped.getUserPassword());
        verify(userRepository).save(mapped);
    }

    @Test
    void create_withDuplicateUserNo_throwsBusinessException() {
        UserRequest request = new UserRequest();
        request.setUserNo("001");
        request.setUserPassword("plainpass");

        when(userRepository.existsById("001")).thenReturn(true);

        assertThrows(BusinessException.class, () -> userService.create(request));
        verify(userRepository, never()).save(any());
    }

    @Test
    void create_withoutPassword_throwsBusinessException() {
        UserRequest request = new UserRequest();
        request.setUserNo("003");

        when(userRepository.existsById("003")).thenReturn(false);

        assertThrows(BusinessException.class, () -> userService.create(request));
        verify(userRepository, never()).save(any());
    }

    @Test
    void update_withBlankPassword_keepsExistingHash() {
        UserRequest request = new UserRequest();
        request.setUserNo("001");
        request.setUserName("Updated Name");

        UserResponse expected = new UserResponse();
        expected.setUserNo("001");

        when(userRepository.findById("001")).thenReturn(Optional.of(testUser));
        when(userRepository.save(testUser)).thenReturn(testUser);
        when(userMapper.toResponse(testUser)).thenReturn(expected);

        userService.update("001", request);

        assertEquals("$2a$10$hashedpassword", testUser.getUserPassword());
        verify(passwordEncoder, never()).encode(any());
    }

    @Test
    void update_withNewPassword_reEncodesPassword() {
        UserRequest request = new UserRequest();
        request.setUserNo("001");
        request.setUserPassword("newpass");

        when(userRepository.findById("001")).thenReturn(Optional.of(testUser));
        when(passwordEncoder.encode("newpass")).thenReturn("$2a$10$newhash");
        when(userRepository.save(testUser)).thenReturn(testUser);
        when(userMapper.toResponse(testUser)).thenReturn(new UserResponse());

        userService.update("001", request);

        assertEquals("$2a$10$newhash", testUser.getUserPassword());
    }

    @Test
    void delete_withExistingUser_removesRecord() {
        when(userRepository.existsById("001")).thenReturn(true);

        userService.delete("001");

        verify(userRepository).deleteById("001");
    }

    @Test
    void delete_withMissingUser_throwsResourceNotFound() {
        when(userRepository.existsById("999")).thenReturn(false);

        assertThrows(ResourceNotFoundException.class, () -> userService.delete("999"));
        verify(userRepository, never()).deleteById(any());
    }
}
