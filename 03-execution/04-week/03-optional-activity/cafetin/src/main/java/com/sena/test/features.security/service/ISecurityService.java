package com.sena.test.features.security.service;

import com.sena.test.features.security.dto.LoginRequestDTO;
import com.sena.test.entity.User; // Importamos tu entidad User original

public interface ISecurityService {
    // Para el Login
    boolean authenticate(LoginRequestDTO loginRequest);

    // Para el CRUD: Cifrar contraseña antes de guardar un usuario nuevo
    String encryptPassword(String password);
}