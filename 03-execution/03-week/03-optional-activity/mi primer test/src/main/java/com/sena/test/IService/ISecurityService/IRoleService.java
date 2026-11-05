package com.sena.test.IService.ISecurityService;

import java.util.List;

import com.sena.test.DTO.SecurityDTO.RoleDTO;

public interface IRoleService {

        RoleDTO save (RoleDTO dto);

        List<RoleDTO> findAll();
        
        RoleDTO update (Long id, RoleDTO dto );

        void delete (Long id);

}
