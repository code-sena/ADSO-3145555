package com.app.controller;

import com.app.entity.Person;
import com.app.service.interfaces.IPersonService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/persons")
public class PersonController {

    private final IPersonService service;

    public PersonController(IPersonService service) {
        this.service = service;
    }

    @GetMapping
    public List<Person> getAll() {
        return service.getAll();
    }

    @GetMapping("/{id}")
    public Person getById(@PathVariable Long id) {
        return service.getById(id);
    }

    @PostMapping
    public Person save(@RequestBody Person person) {
        return service.save(person);
    }

    @PutMapping("/{id}")
    public Person update(@PathVariable Long id, @RequestBody Person person) {
        return service.update(id, person);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}
