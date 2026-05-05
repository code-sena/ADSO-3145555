package com.sena.test.features.registration.controller;

import com.sena.test.features.registration.entity.Ficha;
import com.sena.test.features.registration.service.IRegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/registration")
public class RegistrationController {

    @Autowired
    private IRegistrationService registrationService;

    @GetMapping("/fichas")
    public List<Ficha> getFichas() {
        return registrationService.listarFichas();
    }

    @PostMapping("/fichas")
    public Ficha crearFicha(@RequestBody Ficha ficha) {
        return registrationService.guardarFicha(ficha);
    }
}