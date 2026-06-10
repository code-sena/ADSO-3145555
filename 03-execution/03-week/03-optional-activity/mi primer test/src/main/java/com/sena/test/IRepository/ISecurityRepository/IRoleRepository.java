package com.sena.test.IRepository.ISecurityRepository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sena.test.Entity.Security.Role;

public interface IRoleRepository extends JpaRepository<Role, Long> {

    Optional<Role> findByName (String name);
  
}
