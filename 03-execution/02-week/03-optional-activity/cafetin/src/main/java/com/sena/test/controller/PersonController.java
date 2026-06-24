package com.sena.test.controller;

import com.sena.test.entity.Person;
import com.sena.test.service.IPersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/person")
@CrossOrigin("*")
public class PersonController {

    @Autowired
    private IPersonService personService;

    @GetMapping
    public List<Person> listar() {
        return personService.listar();
    }

    @PostMapping
    public Person guardar(@RequestBody Person person) {
        return personService.guardar(person);
    }

    @GetMapping("/{id}")
    public Person buscarPorId(@PathVariable Long id) {
        return personService.buscarPorId(id);
    }

    @PutMapping("/{id}")
    public Person actualizar(@PathVariable Long id, @RequestBody Person person) {
        return personService.actualizar(id, person);
    }

    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable Long id) {
        personService.eliminar(id);
    }
}