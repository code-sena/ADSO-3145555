package com.crud.security.service;

import com.crud.security.dto.SecurityDTOs.*;
import com.crud.security.entity.Person;
import com.crud.security.entity.User;
import com.crud.security.repository.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class UserService {

    private final UserRepository userRepository;
    private final PersonService personService;

    @Transactional(readOnly = true)
    public List<UserResponse> findAll() {
        return userRepository.findAll().stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public UserResponse findById(Long id) {
        return toResponse(findEntityById(id));
    }

    public UserResponse create(UserRequest request) {
        Person person = personService.findEntityById(request.getPersonId());
        User user = User.builder()
                .username(request.getUsername())
                .password(request.getPassword()) // NOTE: hash in production with BCrypt
                .active(request.getActive() != null ? request.getActive() : true)
                .person(person)
                .build();
        return toResponse(userRepository.save(user));
    }

    public UserResponse update(Long id, UserRequest request) {
        User user = findEntityById(id);
        Person person = personService.findEntityById(request.getPersonId());
        user.setUsername(request.getUsername());
        if (request.getPassword() != null && !request.getPassword().isBlank()) {
            user.setPassword(request.getPassword());
        }
        user.setActive(request.getActive() != null ? request.getActive() : user.getActive());
        user.setPerson(person);
        return toResponse(userRepository.save(user));
    }

    public void delete(Long id) {
        if (!userRepository.existsById(id)) {
            throw new EntityNotFoundException("User not found with id: " + id);
        }
        userRepository.deleteById(id);
    }

    public User findEntityById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("User not found with id: " + id));
    }

    public UserResponse toResponse(User user) {
        return UserResponse.builder()
                .id(user.getId())
                .username(user.getUsername())
                .active(user.getActive())
                .person(personService.toResponse(user.getPerson()))
                .build();
    }
}
