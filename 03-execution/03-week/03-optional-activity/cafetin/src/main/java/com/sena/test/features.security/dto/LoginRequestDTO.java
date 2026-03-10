package com.sena.test.features.security.dto;

public class LoginRequestDTO {

    private String username;
    private String password;

    // Constructor vacío
    public LoginRequestDTO() {
    }

    // Constructor con parámetros
    public LoginRequestDTO(String username, String password) {
        this.username = username;
        this.password = password;
    }

    // --- GETTERS Y SETTERS MANUALES ---

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}