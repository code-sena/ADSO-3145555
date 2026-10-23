package com.sena.test.Service.SecurityService;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.sena.test.Entity.Security.Role;
import com.sena.test.Entity.Security.User;
import com.sena.test.Entity.Security.UserRole;
import com.sena.test.IRepository.ISecurityRepository.IRoleRepository;
import com.sena.test.IRepository.ISecurityRepository.IUserRepository;
import com.sena.test.IRepository.ISecurityRepository.IUserRoleRepository;
import com.sena.test.IService.ISecurityService.IUserRoleService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserRoleService implements IUserRoleService {

    private final IUserRoleRepository userRoleRepository;
    private final IUserRepository userRepository;
    private final IRoleRepository roleRepository;

    //ASSIGN ROLE 
    @Override
    public void assignRole(Long userId, Long roleId) {

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        Role role = roleRepository.findById(roleId)
                .orElseThrow(() -> new RuntimeException("Rol no encontrado"));

        UserRole userRole = new UserRole();
        userRole.setUser(user);
        userRole.setRole(role);

        userRoleRepository.save(userRole);
    }

    // REMOVE ROLE 
    @Override
    public void removeRole(Long userId, Long roleId) {

        userRoleRepository.deleteByUser_IdAndRole_Id(userId, roleId);
    }

    // GET ROLES BY USER 
    @Override
    public List<String> getRolesByUser(Long userId) {

        return userRoleRepository.findByUser_Id(userId)
                .stream()
                .map(userRole -> userRole.getRole().getName())
                .collect(Collectors.toList());
    }
}