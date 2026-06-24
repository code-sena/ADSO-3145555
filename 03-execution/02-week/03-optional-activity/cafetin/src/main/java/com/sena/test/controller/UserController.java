package com.sena.test.controller;

import com.sena.test.entity.User;
import com.sena.test.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/user")
@CrossOrigin("*")
public class UserController {

    @Autowired
    private IUserService userService;

    @GetMapping
    public List<User> listar() {
        return userService.listar();
    }

    @PostMapping
    public User guardar(@RequestBody User user) {
        return userService.guardar(user);
    }

    @GetMapping("/{id}")
    public User buscarPorId(@PathVariable Long id) {
        return userService.buscarPorId(id);
    }

    @PutMapping("/{id}")
    public User actualizar(@PathVariable Long id, @RequestBody User user) {
        return userService.actualizar(id, user);
    }

    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable Long id) {
        userService.eliminar(id);
    }
}