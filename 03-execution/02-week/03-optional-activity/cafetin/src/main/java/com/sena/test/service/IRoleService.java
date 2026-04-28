package com.sena.test.service;

import com.sena.test.entity.Role;
import java.util.List;

public interface IRoleService {
    Role guardar(Role role);
    List<Role> listar();
    Role buscarPorId(Long id);
    Role actualizar(Long id, Role role);
    void eliminar(Long id);
}