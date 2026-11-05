package com.app.controller;

import com.app.entity.UserRole;
import com.app.service.interfaces.IUserRoleService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user-roles")
public class UserRoleController {

    private final IUserRoleService service;

    public UserRoleController(IUserRoleService service) {
        this.service = service;
    }

    @GetMapping
    public List<UserRole> getAll() {
        return service.getAll();
    }

    @GetMapping("/{id}")
    public UserRole getById(@PathVariable Long id) {
        return service.getById(id);
    }

    @PostMapping
    public UserRole save(@RequestBody UserRole userRole) {
        return service.save(userRole);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}
