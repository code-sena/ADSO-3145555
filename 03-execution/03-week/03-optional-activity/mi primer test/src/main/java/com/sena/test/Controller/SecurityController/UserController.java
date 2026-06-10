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

import com.sena.test.DTO.SecurityDTO.UserRequestDTO;
import com.sena.test.DTO.SecurityDTO.UserResponseDTO;
import com.sena.test.IService.ISecurityService.IUserService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class UserController {

    private final IUserService userService;

    // CREATE 
    @PostMapping
    public ResponseEntity<UserResponseDTO> save(@RequestBody UserRequestDTO dto) {
        UserResponseDTO response = userService.save(dto);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    //  READ ALL
    @GetMapping
    public ResponseEntity<List<UserResponseDTO>> findAll() {
        return ResponseEntity.ok(userService.findAll());
    }

    //  READ BY ID 
    @GetMapping("/{id}")
    public ResponseEntity<UserResponseDTO> findById(@PathVariable Long id) {
        return ResponseEntity.ok(userService.findById(id));
    }

    // UPDATE
    @PutMapping("/{id}")
    public ResponseEntity<UserResponseDTO> update(
            @PathVariable Long id,
            @RequestBody UserRequestDTO dto) {

        return ResponseEntity.ok(userService.update(id, dto));
    }

    //  DELETE 
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        userService.delete(id);
        return ResponseEntity.noContent().build();
    }
}