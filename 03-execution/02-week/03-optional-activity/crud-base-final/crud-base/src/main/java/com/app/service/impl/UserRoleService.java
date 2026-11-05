package com.app.service.impl;

import com.app.entity.UserRole;
import com.app.repository.IUserRoleRepository;
import com.app.service.interfaces.IUserRoleService;
import com.app.utils.Constants;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserRoleService implements IUserRoleService {

    private final IUserRoleRepository repository;

    public UserRoleService(IUserRoleRepository repository) {
        this.repository = repository;
    }

    public List<UserRole> getAll() {
        return repository.findAll();
    }

    public UserRole getById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException(Constants.NOT_FOUND + id));
    }

    public UserRole save(UserRole userRole) {
        return repository.save(userRole);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}
