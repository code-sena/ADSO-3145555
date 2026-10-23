package com.app.service.impl;

import com.app.entity.User;
import com.app.repository.IUserRepository;
import com.app.service.interfaces.IUserService;
import com.app.utils.Constants;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService implements IUserService {

    private final IUserRepository repository;

    public UserService(IUserRepository repository) {
        this.repository = repository;
    }

    public List<User> getAll() {
        return repository.findAll();
    }

    public User getById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException(Constants.NOT_FOUND + id));
    }

    public User save(User user) {
        return repository.save(user);
    }

    public User update(Long id, User user) {
        User existing = getById(id);
        existing.setUsername(user.getUsername());
        existing.setPassword(user.getPassword());
        existing.setPerson(user.getPerson());
        return repository.save(existing);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}
