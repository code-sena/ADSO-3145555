package com.app.service.impl;

import com.app.entity.Role;
import com.app.repository.IRoleRepository;
import com.app.service.interfaces.IRoleService;
import com.app.utils.Constants;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleService implements IRoleService {

    private final IRoleRepository repository;

    public RoleService(IRoleRepository repository) {
        this.repository = repository;
    }

    public List<Role> getAll() {
        return repository.findAll();
    }

    public Role getById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException(Constants.NOT_FOUND + id));
    }

    public Role save(Role role) {
        return repository.save(role);
    }

    public Role update(Long id, Role role) {
        Role existing = getById(id);
        existing.setName(role.getName());
        existing.setDescription(role.getDescription());
        return repository.save(existing);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}
