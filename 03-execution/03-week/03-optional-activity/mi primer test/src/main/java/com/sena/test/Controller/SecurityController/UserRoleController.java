package com.sena.test.Controller.SecurityController;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sena.test.IService.ISecurityService.IUserRoleService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/user-role")
@RequiredArgsConstructor
public class UserRoleController {

    private final IUserRoleService userRoleService;

    // Asignar rol
    @PostMapping("/assign")
    public ResponseEntity<Void> assignRole(
            @RequestParam Long userId,
            @RequestParam Long roleId) {

        userRoleService.assignRole(userId, roleId);
        return ResponseEntity.ok().build();
    }

    // Quitar rol
    @DeleteMapping("/remove")
    public ResponseEntity<Void> removeRole(
            @RequestParam Long userId,
            @RequestParam Long roleId) {

        userRoleService.removeRole(userId, roleId);
        return ResponseEntity.noContent().build();
    }

    // Obtener roles de un usuario
    @GetMapping("/{userId}")
    public ResponseEntity<List<String>> getRoles(@PathVariable Long userId) {

        return ResponseEntity.ok(userRoleService.getRolesByUser(userId));
    }
}