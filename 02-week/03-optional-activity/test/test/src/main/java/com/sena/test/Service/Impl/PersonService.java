package com.sena.test.Service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sena.test.Entity.Person;
import com.sena.test.Repository.IPersonRepository;
import com.sena.test.Service.IPersonService;
import com.sena.test.dto.PersonDto;

@Service 
public class PersonService implements IPersonService { 
    @Autowired
    private IPersonRepository repository; 

    @Override
    public Person create(PersonDto dto) {

        if (repository.findByEmail(dto.getEmail()).isPresent()) { 
            throw new RuntimeException("El correo ya está registrado.");
        }

        if (repository.findByIdentidad(dto.getIdentidad()).isPresent()) { 
            throw new RuntimeException("La identidad ya está registrada.");
        }

        Person p = new Person();
        p.setFirstName(dto.getFirstName());
        p.setLastName(dto.getLastName());
        p.setEmail(dto.getEmail());
        p.setPassword(dto.getPassword());
        p.setIdentidad(dto.getIdentidad());

        return repository.save(p); 
    }

    @Override
    public List<Person> findAll() { 
        return repository.findAll();
    }

    @Override
    public Person findById(Long id) { 
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Persona no encontrada"));
    }

    @Override
    public Person update(Long id, PersonDto dto) {

        Person p = findById(id);

        p.setFirstName(dto.getFirstName());
        p.setLastName(dto.getLastName());
        p.setEmail(dto.getEmail());
        p.setPassword(dto.getPassword());
        p.setIdentidad(dto.getIdentidad());

        return repository.save(p);
    }

    @Override
    public void delete(Long id) {
        repository.deleteById(id);
    }
}