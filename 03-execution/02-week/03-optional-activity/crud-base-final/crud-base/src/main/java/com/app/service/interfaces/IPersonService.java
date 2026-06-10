package com.app.service.interfaces;

import com.app.entity.Person;
import java.util.List;

public interface IPersonService {
    List<Person> getAll();
    Person getById(Long id);
    Person save(Person person);
    Person update(Long id, Person person);
    void delete(Long id);
}
