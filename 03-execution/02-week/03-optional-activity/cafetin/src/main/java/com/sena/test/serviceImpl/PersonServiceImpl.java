package com.sena.test.serviceImpl;

import com.sena.test.entity.Person;
import com.sena.test.repository.PersonRepository;
import com.sena.test.service.IPersonService;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PersonServiceImpl implements IPersonService {

    private final PersonRepository personRepository;

    public PersonServiceImpl(PersonRepository personRepository) {
        this.personRepository = personRepository;
    }

    @Override
    public Person guardar(Person person) {
        return personRepository.save(person);
    }

    @Override
    public List<Person> listar() {
        return personRepository.findAll();
    }

    @Override
    public Person buscarPorId(Long id) {
        return personRepository.findById(id).orElse(null);
    }

    @Override
    public Person actualizar(Long id, Person person) {
        person.setId(id);
        return personRepository.save(person);
    }

    @Override
    public void eliminar(Long id) {
        personRepository.deleteById(id);
    }
}