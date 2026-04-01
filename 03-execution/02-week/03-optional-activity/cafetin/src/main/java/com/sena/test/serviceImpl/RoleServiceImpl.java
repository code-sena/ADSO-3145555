package com.sena.test.serviceImpl;

import com.sena.test.entity.Role;
import com.sena.test.repository.RoleRepository;
import com.sena.test.service.IRoleService;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class RoleServiceImpl implements IRoleService {

    private final RoleRepository roleRepository;

    public RoleServiceImpl(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    @Override
    public Role guardar(Role role) {
        return roleRepository.save(role);
    }

    @Override
    public List<Role> listar() {
        return roleRepository.findAll();
    }

    @Override
    public Role buscarPorId(Long id) {
        return roleRepository.findById(id).orElse(null);
    }

    @Override
    public Role actualizar(Long id, Role role) {
        role.setId(id);
        return roleRepository.save(role);
    }

    @Override
    public void eliminar(Long id) {
        roleRepository.deleteById(id);
    }
}