package com.app.service.interfaces;

import com.app.entity.User;
import java.util.List;

public interface IUserService {
    List<User> getAll();
    User getById(Long id);
    User save(User user);
    User update(Long id, User user);
    void delete(Long id);
}
