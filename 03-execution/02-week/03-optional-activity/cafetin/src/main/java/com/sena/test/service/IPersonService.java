package com.sena.test.service;

import com.sena.test.entity.Person;
import java.util.List;

public interface IPersonService {
    Person guardar(Person person);
    List<Person> listar();
    Person buscarPorId(Long id);
    Person actualizar(Long id, Person person);
    void eliminar(Long id);
}