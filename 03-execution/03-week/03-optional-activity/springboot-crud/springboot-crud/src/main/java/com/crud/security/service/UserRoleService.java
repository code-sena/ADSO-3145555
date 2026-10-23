package com.crud.security.service;

import com.crud.security.dto.SecurityDTOs.*;
import com.crud.security.entity.Role;
import com.crud.security.entity.User;
import com.crud.security.entity.UserRole;
import com.crud.security.repository.UserRoleRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class UserRoleService {

    private final UserRoleRepository userRoleRepository;
    private final UserService userService;
    private final RoleService roleService;

    @Transactional(readOnly = true)
    public List<UserRoleResponse> findAll() {
        return userRoleRepository.findAll().stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public UserRoleResponse findById(Long id) {
        return toResponse(findEntityById(id));
    }

    @Transactional(readOnly = true)
    public List<UserRoleResponse> findByUserId(Long userId) {
        return userRoleRepository.findByUserId(userId).stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    public UserRoleResponse create(UserRoleRequest request) {
        User user = userService.findEntityById(request.getUserId());
        Role role = roleService.findEntityById(request.getRoleId());
        UserRole userRole = UserRole.builder()
                .user(user)
                .role(role)
                .assignedAt(request.getAssignedAt() != null ? request.getAssignedAt() : LocalDate.now())
                .build();
        return toResponse(userRoleRepository.save(userRole));
    }

    public UserRoleResponse update(Long id, UserRoleRequest request) {
        UserRole userRole = findEntityById(id);
        User user = userService.findEntityById(request.getUserId());
        Role role = roleService.findEntityById(request.getRoleId());
        userRole.setUser(user);
        userRole.setRole(role);
        if (request.getAssignedAt() != null) userRole.setAssignedAt(request.getAssignedAt());
        return toResponse(userRoleRepository.save(userRole));
    }

    public void delete(Long id) {
        if (!userRoleRepository.existsById(id)) {
            throw new EntityNotFoundException("UserRole not found with id: " + id);
        }
        userRoleRepository.deleteById(id);
    }

    private UserRole findEntityById(Long id) {
        return userRoleRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("UserRole not found with id: " + id));
    }

    private UserRoleResponse toResponse(UserRole ur) {
        return UserRoleResponse.builder()
                .id(ur.getId())
                .user(userService.toResponse(ur.getUser()))
                .role(roleService.toResponse(ur.getRole()))
                .assignedAt(ur.getAssignedAt())
                .build();
    }
}
