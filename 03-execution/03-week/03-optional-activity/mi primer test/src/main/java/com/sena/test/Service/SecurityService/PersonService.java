package com.sena.test.Service.SecurityService;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.sena.test.DTO.SecurityDTO.PersonRequestDTO;
import com.sena.test.DTO.SecurityDTO.PersonResponseDTO;
import com.sena.test.Entity.Security.Person;
import com.sena.test.IRepository.ISecurityRepository.IPersonRepository;
import com.sena.test.IService.ISecurityService.IPersonService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PersonService implements IPersonService {

    private final IPersonRepository personRepository;

    // CREATE 
    @Override
    public PersonResponseDTO save(PersonRequestDTO dto) {

        if (personRepository.existsByEmail(dto.getEmail())) {
            throw new RuntimeException("El email ya existe");
        }

        if (personRepository.existsByIdentidad(dto.getIdentidad())) {
            throw new RuntimeException("La identidad ya existe");
        }

        Person person = new Person();
        person.setFirstName(dto.getFirstName());
        person.setLastName(dto.getLastName());
        person.setEmail(dto.getEmail());
        person.setIdentidad(dto.getIdentidad());

        return mapToDTO(personRepository.save(person));
    }

    //  READ ALL 
    @Override
    public List<PersonResponseDTO> findAll() {
        return personRepository.findAll()
                .stream()
                .map(this::mapToDTO)
                .collect(Collectors.toList());
    }

    // READ BY ID 
    @Override
    public PersonResponseDTO findById(Long id) {
        Person person = personRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Persona no encontrada con id: " + id));

        return mapToDTO(person);
    }

    //  UPDATE 
    @Override
    public PersonResponseDTO update(Long id, PersonRequestDTO dto) {

        Person person = personRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Persona no encontrada con id: " + id));

        // Validar email si cambió
        if (!person.getEmail().equals(dto.getEmail()) &&
                personRepository.existsByEmail(dto.getEmail())) {
            throw new RuntimeException("El email ya está en uso");
        }

        // Validar identidad si cambió
        if (!person.getIdentidad().equals(dto.getIdentidad()) &&
                personRepository.existsByIdentidad(dto.getIdentidad())) {
            throw new RuntimeException("La identidad ya está en uso");
        }

        person.setFirstName(dto.getFirstName());
        person.setLastName(dto.getLastName());
        person.setEmail(dto.getEmail());
        person.setIdentidad(dto.getIdentidad());

        return mapToDTO(personRepository.save(person));
    }

    //  DELETE
    @Override
    public void delete(Long id) {

        if (!personRepository.existsById(id)) {
            throw new RuntimeException("No se puede eliminar. Persona no encontrada con id: " + id);
        }

        personRepository.deleteById(id);
    }

    //  MAPPER 
    private PersonResponseDTO mapToDTO(Person person) {
        return new PersonResponseDTO(
                person.getId(),
                person.getFirstName(),
                person.getLastName(),
                person.getEmail(),
                person.getIdentidad());
    }
}