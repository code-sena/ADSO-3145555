package com.sena.test.service;

import com.sena.test.entity.User;
import java.util.List;

public interface IUserService {
    User guardar(User user);
    List<User> listar();
    User buscarPorId(Long id);
    User actualizar(Long id, User user);
    void eliminar(Long id);
}