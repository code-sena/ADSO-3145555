package com.app.service.interfaces;

import com.app.entity.UserRole;
import java.util.List;

public interface IUserRoleService {
    List<UserRole> getAll();
    UserRole getById(Long id);
    UserRole save(UserRole userRole);
    void delete(Long id);
}
