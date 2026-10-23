package com.crud.security.service;

import com.crud.security.dto.SecurityDTOs.*;
import com.crud.security.entity.Role;
import com.crud.security.repository.RoleRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class RoleService {

    private final RoleRepository roleRepository;

    @Transactional(readOnly = true)
    public List<RoleResponse> findAll() {
        return roleRepository.findAll().stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public RoleResponse findById(Long id) {
        return toResponse(findEntityById(id));
    }

    public RoleResponse create(RoleRequest request) {
        Role role = Role.builder()
                .name(request.getName().toUpperCase())
                .description(request.getDescription())
                .build();
        return toResponse(roleRepository.save(role));
    }

    public RoleResponse update(Long id, RoleRequest request) {
        Role role = findEntityById(id);
        role.setName(request.getName().toUpperCase());
        role.setDescription(request.getDescription());
        return toResponse(roleRepository.save(role));
    }

    public void delete(Long id) {
        if (!roleRepository.existsById(id)) {
            throw new EntityNotFoundException("Role not found with id: " + id);
        }
        roleRepository.deleteById(id);
    }

    public Role findEntityById(Long id) {
        return roleRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Role not found with id: " + id));
    }

    public RoleResponse toResponse(Role role) {
        return RoleResponse.builder()
                .id(role.getId())
                .name(role.getName())
                .description(role.getDescription())
                .build();
    }
}
