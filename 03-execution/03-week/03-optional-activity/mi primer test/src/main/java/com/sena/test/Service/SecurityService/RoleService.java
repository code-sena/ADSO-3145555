package com.sena.test.Service.SecurityService;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.sena.test.DTO.SecurityDTO.RoleDTO;
import com.sena.test.Entity.Security.Role;
import com.sena.test.IRepository.ISecurityRepository.IRoleRepository;
import com.sena.test.IService.ISecurityService.IRoleService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RoleService implements IRoleService {

    private final IRoleRepository roleRepository;

    // ===================== CREATE =====================
    @Override
    public RoleDTO save(RoleDTO dto) {

        if (roleRepository.findByName(dto.getName()).isPresent()) {
            throw new RuntimeException("El rol ya existe");
        }

        Role role = new Role();
        role.setName(dto.getName());

        return mapToDTO(roleRepository.save(role));
    }

    // READ ALL 
    @Override
    public List<RoleDTO> findAll() {
        return roleRepository.findAll()
                .stream()
                .map(this::mapToDTO)
                .collect(Collectors.toList());
    }

    // UPDATE 
    @Override
    public RoleDTO update(Long id, RoleDTO dto) {

        Role role = roleRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Rol no encontrado con id: " + id));

        // Validar si el nombre cambió y ya existe
        if (!role.getName().equals(dto.getName()) &&
                roleRepository.findByName(dto.getName()).isPresent()) {
            throw new RuntimeException("El nombre del rol ya está en uso");
        }

        role.setName(dto.getName());

        return mapToDTO(roleRepository.save(role));
    }

    // DELETE 
    @Override
    public void delete(Long id) {

        if (!roleRepository.existsById(id)) {
            throw new RuntimeException("Rol no encontrado con id: " + id);
        }

        roleRepository.deleteById(id);
    }

    // MAPPER 
    private RoleDTO mapToDTO(Role role) {
        return new RoleDTO(
                role.getId(),
                role.getName());
    }
}