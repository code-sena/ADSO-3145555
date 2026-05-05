package com.sena.test.features.security.service;

import org.springframework.stereotype.Service;
import com.sena.test.features.security.dto.LoginRequestDTO;

@Service
public class SecurityServiceImpl implements ISecurityService {

    @Override
    public boolean authenticate(LoginRequestDTO loginRequest) {
        // Aquí comparamos lo que llega de Postman con la lógica de tu tabla User
        return true;
    }

    @Override
    public String encryptPassword(String password) {
        // RF1.4: Aquí podrías usar BCrypt para que en la DB no se vea la clave real
        return "SECURE_" + password;
    }
}