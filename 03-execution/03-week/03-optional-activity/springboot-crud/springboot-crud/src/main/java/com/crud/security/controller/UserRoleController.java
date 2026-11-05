package com.crud.security.controller;

import com.crud.security.dto.SecurityDTOs.*;
import com.crud.security.service.UserRoleService;
import com.crud.shared.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/security/user-roles")
@RequiredArgsConstructor
@Tag(name = "Security - UserRoles", description = "CRUD for UserRole entity")
public class UserRoleController {

    private final UserRoleService userRoleService;

    @GetMapping
    @Operation(summary = "Get all user-role assignments")
    public ResponseEntity<ApiResponse<List<UserRoleResponse>>> findAll() {
        return ResponseEntity.ok(ApiResponse.ok(userRoleService.findAll()));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get user-role by ID")
    public ResponseEntity<ApiResponse<UserRoleResponse>> findById(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.ok(userRoleService.findById(id)));
    }

    @GetMapping("/user/{userId}")
    @Operation(summary = "Get roles by user ID")
    public ResponseEntity<ApiResponse<List<UserRoleResponse>>> findByUser(@PathVariable Long userId) {
        return ResponseEntity.ok(ApiResponse.ok(userRoleService.findByUserId(userId)));
    }

    @PostMapping
    @Operation(summary = "Assign role to user")
    public ResponseEntity<ApiResponse<UserRoleResponse>> create(@Valid @RequestBody UserRoleRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.ok("Role assigned successfully", userRoleService.create(request)));
    }

    @PutMapping("/{id}")
    @Operation(summary = "Update user-role assignment")
    public ResponseEntity<ApiResponse<UserRoleResponse>> update(@PathVariable Long id, @Valid @RequestBody UserRoleRequest request) {
        return ResponseEntity.ok(ApiResponse.ok("Assignment updated", userRoleService.update(id, request)));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Remove role assignment")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable Long id) {
        userRoleService.delete(id);
        return ResponseEntity.ok(ApiResponse.ok("Assignment removed", null));
    }
}
