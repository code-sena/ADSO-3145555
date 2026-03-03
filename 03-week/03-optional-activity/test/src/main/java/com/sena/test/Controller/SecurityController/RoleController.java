package com.sena.test.Controller.SecurityController;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sena.test.DTO.SecurityDTO.RoleDTO;
import com.sena.test.IService.ISecurityService.IRoleService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/role")
@RequiredArgsConstructor
public class RoleController {

    private final IRoleService roleService;

    // CREATE
    @PostMapping
    public ResponseEntity<RoleDTO> save(@RequestBody RoleDTO dto) {
        RoleDTO response = roleService.save(dto);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    //  READ ALL 
    @GetMapping
    public ResponseEntity<List<RoleDTO>> findAll() {
        return ResponseEntity.ok(roleService.findAll());
    }

    //  UPDATE 
    @PutMapping("/{id}")
    public ResponseEntity<RoleDTO> update(
            @PathVariable Long id,
            @RequestBody RoleDTO dto) {

        return ResponseEntity.ok(roleService.update(id, dto));
    }

    //  DELETE 
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        roleService.delete(id);
        return ResponseEntity.noContent().build();
    }
}