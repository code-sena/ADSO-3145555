package com.sena.test.features.security.controller;

import com.sena.test.features.security.dto.LoginRequestDTO;
import com.sena.test.features.security.service.ISecurityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth") // Nueva ruta para seguridad
public class AuthController {

    @Autowired
    private ISecurityService securityService;

    @PostMapping("/login")
    public String login(@RequestBody LoginRequestDTO loginRequest) {
        // Esto valida el RF1.4 y RNF5 de tus requerimientos
        boolean isAuthenticated = securityService.authenticate(loginRequest);
        return isAuthenticated ? "Acceso Concedido al Cafetín" : "Error: Usuario o Clave incorrecta";
    }
}