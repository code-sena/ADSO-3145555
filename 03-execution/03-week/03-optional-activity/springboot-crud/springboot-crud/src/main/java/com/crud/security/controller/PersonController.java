package com.crud.security.controller;

import com.crud.security.dto.SecurityDTOs.*;
import com.crud.security.service.PersonService;
import com.crud.shared.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/security/persons")
@RequiredArgsConstructor
@Tag(name = "Security - Persons", description = "CRUD for Person entity")
public class PersonController {

    private final PersonService personService;

    @GetMapping
    @Operation(summary = "Get all persons")
    public ResponseEntity<ApiResponse<List<PersonResponse>>> findAll() {
        return ResponseEntity.ok(ApiResponse.ok(personService.findAll()));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get person by ID")
    public ResponseEntity<ApiResponse<PersonResponse>> findById(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.ok(personService.findById(id)));
    }

    @PostMapping
    @Operation(summary = "Create a person")
    public ResponseEntity<ApiResponse<PersonResponse>> create(@Valid @RequestBody PersonRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.ok("Person created successfully", personService.create(request)));
    }

    @PutMapping("/{id}")
    @Operation(summary = "Update a person")
    public ResponseEntity<ApiResponse<PersonResponse>> update(@PathVariable Long id, @Valid @RequestBody PersonRequest request) {
        return ResponseEntity.ok(ApiResponse.ok("Person updated successfully", personService.update(id, request)));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Delete a person")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable Long id) {
        personService.delete(id);
        return ResponseEntity.ok(ApiResponse.ok("Person deleted successfully", null));
    }
}
