package com.sena.test.features.registration.service;

import com.sena.test.features.registration.entity.Ficha;
import com.sena.test.features.registration.entity.Program;
import java.util.List;

public interface IRegistrationService {
    List<Program> listarProgramas();
    List<Ficha> listarFichas();
    Ficha guardarFicha(Ficha ficha);
}