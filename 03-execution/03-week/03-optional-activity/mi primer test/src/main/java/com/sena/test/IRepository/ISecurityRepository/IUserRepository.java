package com.sena.test.IRepository.ISecurityRepository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sena.test.Entity.Security.User;

public interface IUserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
    boolean existsByUsername (String username);

}
