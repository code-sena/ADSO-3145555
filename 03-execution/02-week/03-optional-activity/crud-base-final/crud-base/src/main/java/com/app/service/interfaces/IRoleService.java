package com.app.service.interfaces;

import com.app.entity.Role;
import java.util.List;

public interface IRoleService {
    List<Role> getAll();
    Role getById(Long id);
    Role save(Role role);
    Role update(Long id, Role role);
    void delete(Long id);
}
