package com.sena.test.controller;

import com.sena.test.entity.Role;
import com.sena.test.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/role")
@CrossOrigin("*")
public class RoleController {

    @Autowired
    private IRoleService roleService;

    @GetMapping
    public List<Role> listar() {
        return roleService.listar();
    }

    @PostMapping
    public Role guardar(@RequestBody Role role) {
        return roleService.guardar(role);
    }

    @GetMapping("/{id}")
    public Role buscarPorId(@PathVariable Long id) {
        return roleService.buscarPorId(id);
    }

    @PutMapping("/{id}")
    public Role actualizar(@PathVariable Long id, @RequestBody Role role) {
        return roleService.actualizar(id, role);
    }

    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable Long id) {
        roleService.eliminar(id);
    }
}