package com.sena.test.serviceImpl;

import com.sena.test.entity.User;
import com.sena.test.repository.UserRepository;
import com.sena.test.service.IUserService;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class UserServiceImpl implements IUserService {

    private final UserRepository userRepository;

    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public User guardar(User user) {
        return userRepository.save(user);
    }

    @Override
    public List<User> listar() {
        return userRepository.findAll();
    }

    @Override
    public User buscarPorId(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    @Override
    public User actualizar(Long id, User user) {
        user.setId(id);
        return userRepository.save(user);
    }

    @Override
    public void eliminar(Long id) {
        userRepository.deleteById(id);
    }
}