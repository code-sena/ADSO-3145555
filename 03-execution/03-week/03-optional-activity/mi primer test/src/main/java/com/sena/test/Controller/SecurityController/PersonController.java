package com.sena.test.Controller.SecurityController;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sena.test.DTO.SecurityDTO.PersonRequestDTO;
import com.sena.test.DTO.SecurityDTO.PersonResponseDTO;
import com.sena.test.IService.ISecurityService.IPersonService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/person")
@RequiredArgsConstructor
public class PersonController {

    private final IPersonService personService;

    // CREATE
    @PostMapping
    public ResponseEntity<PersonResponseDTO> save(@RequestBody PersonRequestDTO dto) {
        PersonResponseDTO response = personService.save(dto);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    //READ ALL
    @GetMapping
    public ResponseEntity<List<PersonResponseDTO>> findAll() {
        return ResponseEntity.ok(personService.findAll());
    }

    //READ BY ID
    @GetMapping("/{id}")
    public ResponseEntity<PersonResponseDTO> findById(@PathVariable Long id) {
        return ResponseEntity.ok(personService.findById(id));
    }

    // UPDATE
    @PutMapping("/{id}")
    public ResponseEntity<PersonResponseDTO> update(
            @PathVariable Long id,
            @RequestBody PersonRequestDTO dto) {

        return ResponseEntity.ok(personService.update(id, dto));
    }

    //DELETE
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        personService.delete(id);
        return ResponseEntity.noContent().build();
    }
}