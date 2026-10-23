package com.app.service.impl;

import com.app.entity.Person;
import com.app.repository.IPersonRepository;
import com.app.service.interfaces.IPersonService;
import com.app.utils.Constants;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PersonService implements IPersonService {

    private final IPersonRepository repository;

    public PersonService(IPersonRepository repository) {
        this.repository = repository;
    }

    public List<Person> getAll() {
        return repository.findAll();
    }

    public Person getById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException(Constants.NOT_FOUND + id));
    }

    public Person save(Person person) {
        return repository.save(person);
    }

    public Person update(Long id, Person person) {
        Person existing = getById(id);
        existing.setFirstName(person.getFirstName());
        existing.setLastName(person.getLastName());
        existing.setDni(person.getDni());
        existing.setEmail(person.getEmail());
        existing.setPhone(person.getPhone());
        return repository.save(existing);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}
