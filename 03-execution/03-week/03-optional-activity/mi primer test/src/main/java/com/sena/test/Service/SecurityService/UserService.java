package com.sena.test.Service.SecurityService;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.sena.test.DTO.SecurityDTO.PersonResponseDTO;
import com.sena.test.DTO.SecurityDTO.UserRequestDTO;
import com.sena.test.DTO.SecurityDTO.UserResponseDTO;
import com.sena.test.Entity.Security.Person;
import com.sena.test.Entity.Security.User;
import com.sena.test.IRepository.ISecurityRepository.IPersonRepository;
import com.sena.test.IRepository.ISecurityRepository.IUserRepository;
import com.sena.test.IService.ISecurityService.IUserService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService implements IUserService {

    private final IUserRepository userRepository;
    private final IPersonRepository personRepository;

    // CREATE 
    @Override
    public UserResponseDTO save(UserRequestDTO dto) {

        if (userRepository.existsByUsername(dto.getUsername())) {
            throw new RuntimeException("El username ya existe");
        }

        Person person = personRepository.findById(dto.getPersonId())
                .orElseThrow(() -> new RuntimeException("Persona no encontrada"));

        User user = new User();
        user.setUsername(dto.getUsername());
        user.setPassword(dto.getPassword());
        user.setPerson(person);

        return mapToDTO(userRepository.save(user));
    }

    // READ ALL 
        @Override
    public List<UserResponseDTO> findAll() {
        return userRepository.findAll()
                .stream()
                .map(this::mapToDTO)
                .collect(Collectors.toList());
    }

    // READ BY ID 
    @Override
    public UserResponseDTO findById(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        return mapToDTO(user);
    }

    //  UPDATE 
    @Override
    public UserResponseDTO update(Long id, UserRequestDTO dto) {

        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        if (!user.getUsername().equals(dto.getUsername())
                && userRepository.existsByUsername(dto.getUsername())) {
            throw new RuntimeException("El username ya está en uso");
        }

        Person person = personRepository.findById(dto.getPersonId())
                .orElseThrow(() -> new RuntimeException("Persona no encontrada"));

        user.setUsername(dto.getUsername());
        user.setPassword(dto.getPassword());
        user.setPerson(person);

        return mapToDTO(userRepository.save(user));
    }

    //  DELETE 
    @Override
    public void delete(Long id) {

        if (!userRepository.existsById(id)) {
            throw new RuntimeException("Usuario no encontrado");
        }

        userRepository.deleteById(id);
    }

    //  MAPPER
    private UserResponseDTO mapToDTO(User user) {

        PersonResponseDTO personDTO = new PersonResponseDTO(
                user.getPerson().getId(),
                user.getPerson().getFirstName(),
                user.getPerson().getLastName(),
                user.getPerson().getEmail(),
                user.getPerson().getIdentidad());

        return new UserResponseDTO(
                user.getId(),
                user.getUsername(),
                personDTO);
    }
}