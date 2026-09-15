package com.startupstack.app.modules.users.service;

import com.startupstack.app.config.security.JwtUtil;
import com.startupstack.app.modules.users.dto.ChangePasswordRequest;
import com.startupstack.app.modules.users.dto.LoginRequest;
import com.startupstack.app.modules.users.dto.LoginResponse;
import com.startupstack.app.modules.users.dto.UserRequest;
import com.startupstack.app.modules.users.dto.UserResponse;
import com.startupstack.app.modules.users.entity.UserEntity;
import com.startupstack.app.modules.users.mapper.UserMapper;
import com.startupstack.app.modules.users.repository.UserRepository;
import com.startupstack.app.modules.users.specification.UserSpecification;
import com.startupstack.app.shared.exception.BusinessException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final UserMapper userMapper;
    private final JwtUtil jwtUtil;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository,
                       UserMapper userMapper,
                       JwtUtil jwtUtil,
                       PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.userMapper = userMapper;
        this.jwtUtil = jwtUtil;
        this.passwordEncoder = passwordEncoder;
    }

    @Transactional(readOnly = true)
    public Page<UserResponse> findAll(String level, String ent, Pageable pageable) {
        Specification<UserEntity> spec = UserSpecification.hasUserLevel(level)
                .and(UserSpecification.hasUserEnt(ent));
        return userRepository.findAll(spec, pageable).map(userMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public UserResponse findById(String userNo) {
        UserEntity entity = userRepository.findById(userNo)
                .orElseThrow(() -> new ResourceNotFoundException("User not found: " + userNo));
        return userMapper.toResponse(entity);
    }

    @Transactional
    public UserResponse create(UserRequest request) {
        if (userRepository.existsById(request.getUserNo())) {
            throw new BusinessException("User number already exists: " + request.getUserNo());
        }
        if (request.getUserPassword() == null || request.getUserPassword().isBlank()) {
            throw new BusinessException("Password is required for a new user");
        }
        UserEntity entity = userMapper.toEntity(request);
        entity.setUserPassword(passwordEncoder.encode(request.getUserPassword()));
        return userMapper.toResponse(userRepository.save(entity));
    }

    @Transactional
    public UserResponse update(String userNo, UserRequest request) {
        UserEntity entity = userRepository.findById(userNo)
                .orElseThrow(() -> new ResourceNotFoundException("User not found: " + userNo));
        userMapper.updateEntity(request, entity);
        if (request.getUserPassword() != null && !request.getUserPassword().isBlank()) {
            entity.setUserPassword(passwordEncoder.encode(request.getUserPassword()));
        }
        return userMapper.toResponse(userRepository.save(entity));
    }

    @Transactional
    public void delete(String userNo) {
        if (!userRepository.existsById(userNo)) {
            throw new ResourceNotFoundException("User not found: " + userNo);
        }
        userRepository.deleteById(userNo);
    }

    public LoginResponse login(LoginRequest request) {
        UserEntity user = userRepository.findByUserName(request.getUsername())
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        String storedPassword = user.getUserPassword() != null ? user.getUserPassword().trim() : "";

        if (isBCryptHash(storedPassword)) {
            if (!passwordEncoder.matches(request.getPassword(), storedPassword)) {
                throw new IllegalArgumentException("Invalid credentials");
            }
        } else {
            // Legacy plain-text comparison for pre-migration passwords
            if (!storedPassword.equals(request.getPassword())) {
                throw new IllegalArgumentException("Invalid credentials");
            }
            // Upgrade to BCrypt on successful login
            user.setUserPassword(passwordEncoder.encode(request.getPassword()));
            userRepository.save(user);
        }

        if (user.getUserPwd() != null && user.getUserPwd() == 1) {
            String otpToken = jwtUtil.generateOtpToken(user.getUserName());
            return new LoginResponse(otpToken, user.getUserName(), user.getUserLevel(),
                    user.getUserPermission(), true);
        }

        String token = jwtUtil.generateToken(user.getUserName(), user.getUserPermission(),
                user.getUserEnt(), user.getUserDoc(), user.getUserLevel(), user.getSiteWly());
        return new LoginResponse(token, user.getUserName(), user.getUserLevel(), user.getUserPermission(), false);
    }

    @Transactional
    public LoginResponse changePassword(String otpToken, ChangePasswordRequest request) {
        if (!jwtUtil.validateOtpToken(otpToken)) {
            throw new IllegalArgumentException("Invalid or expired one-time token");
        }
        if (!request.newPassword().equals(request.confirmPassword())) {
            throw new IllegalArgumentException("Passwords do not match");
        }

        String username = jwtUtil.extractUsername(otpToken);
        UserEntity user = userRepository.findByUserName(username)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        user.setUserPassword(passwordEncoder.encode(request.newPassword()));
        user.setUserPwd(0);
        userRepository.save(user);

        String token = jwtUtil.generateToken(user.getUserName(), user.getUserPermission(),
                user.getUserEnt(), user.getUserDoc(), user.getUserLevel(), user.getSiteWly());
        return new LoginResponse(token, user.getUserName(), user.getUserLevel(), user.getUserPermission(), false);
    }

    @Transactional
    public int migratePasswords(String authenticatedUsername) {
        UserEntity caller = userRepository.findByUserName(authenticatedUsername)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        if (!"A".equals(caller.getUserLevel() != null ? caller.getUserLevel().trim() : null)) {
            throw new AccessDeniedException("Only administrators can migrate passwords");
        }

        List<UserEntity> users = userRepository.findAll();
        int migrated = 0;

        for (UserEntity user : users) {
            String raw = user.getUserPassword() != null ? user.getUserPassword().trim() : "";
            if (!raw.isEmpty() && !isBCryptHash(raw)) {
                user.setUserPassword(passwordEncoder.encode(raw));
                userRepository.save(user);
                migrated++;
            }
        }

        return migrated;
    }

    private boolean isBCryptHash(String value) {
        return value.startsWith("$2a$") || value.startsWith("$2b$");
    }
}
