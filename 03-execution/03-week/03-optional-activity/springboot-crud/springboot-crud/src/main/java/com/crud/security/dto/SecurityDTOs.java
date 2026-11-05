package com.crud.security.dto;

import jakarta.validation.constraints.*;
import lombok.*;
import java.time.LocalDate;

// ─── Person ───────────────────────────────────────────────
public class SecurityDTOs {

    @Data @NoArgsConstructor @AllArgsConstructor @Builder
    public static class PersonRequest {
        @NotBlank(message = "First name is required")
        private String firstName;
        @NotBlank(message = "Last name is required")
        private String lastName;
        @Email(message = "Email must be valid")
        private String email;
        private String phone;
    }

    @Data @NoArgsConstructor @AllArgsConstructor @Builder
    public static class PersonResponse {
        private Long id;
        private String firstName;
        private String lastName;
        private String email;
        private String phone;
    }

    // ─── Role ─────────────────────────────────────────────
    @Data @NoArgsConstructor @AllArgsConstructor @Builder
    public static class RoleRequest {
        @NotBlank(message = "Role name is required")
        private String name;
        private String description;
    }

    @Data @NoArgsConstructor @AllArgsConstructor @Builder
    public static class RoleResponse {
        private Long id;
        private String name;
        private String description;
    }

    // ─── User ─────────────────────────────────────────────
    @Data @NoArgsConstructor @AllArgsConstructor @Builder
    public static class UserRequest {
        @NotBlank(message = "Username is required")
        private String username;
        @NotBlank(message = "Password is required")
        @Size(min = 6, message = "Password must be at least 6 characters")
        private String password;
        private Boolean active;
        @NotNull(message = "Person ID is required")
        private Long personId;
    }

    @Data @NoArgsConstructor @AllArgsConstructor @Builder
    public static class UserResponse {
        private Long id;
        private String username;
        private Boolean active;
        private PersonResponse person;
    }

    // ─── UserRole ─────────────────────────────────────────
    @Data @NoArgsConstructor @AllArgsConstructor @Builder
    public static class UserRoleRequest {
        @NotNull(message = "User ID is required")
        private Long userId;
        @NotNull(message = "Role ID is required")
        private Long roleId;
        private LocalDate assignedAt;
    }

    @Data @NoArgsConstructor @AllArgsConstructor @Builder
    public static class UserRoleResponse {
        private Long id;
        private UserResponse user;
        private RoleResponse role;
        private LocalDate assignedAt;
    }
}
