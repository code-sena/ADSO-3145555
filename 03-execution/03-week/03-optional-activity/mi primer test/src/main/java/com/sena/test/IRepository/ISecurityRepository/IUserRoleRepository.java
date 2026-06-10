package com.sena.test.IRepository.ISecurityRepository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sena.test.Entity.Security.UserRole;

public interface IUserRoleRepository  extends JpaRepository<UserRole, Long>{

    List<UserRole> findByUser_Id(Long userId);
void deleteByUser_IdAndRole_Id(Long userId, Long roleId);
}
