package com.sena.test.features.registration.service;

import com.sena.test.features.registration.entity.Ficha;
import com.sena.test.features.registration.entity.Program;
import com.sena.test.features.registration.repository.IFichaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class RegistrationServiceImpl implements IRegistrationService {

    @Autowired
    private IFichaRepository fichaRepository;

    @Override
    public List<Ficha> listarFichas() {
        return fichaRepository.findAll();
    }

    @Override
    public Ficha guardarFicha(Ficha ficha) {
        return fichaRepository.save(ficha);
    }

    @Override
    public List<Program> listarProgramas() {
        // Aquí podrías agregar un repositorio para Program si lo necesitas
        return null;
    }
}