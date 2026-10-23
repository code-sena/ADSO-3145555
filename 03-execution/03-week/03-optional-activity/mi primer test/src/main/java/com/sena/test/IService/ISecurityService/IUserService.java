package com.sena.test.IService.ISecurityService;

import java.util.List;

import com.sena.test.DTO.SecurityDTO.UserRequestDTO;
import com.sena.test.DTO.SecurityDTO.UserResponseDTO;

public interface IUserService {

    UserResponseDTO save(UserRequestDTO dto);

    List<UserResponseDTO> findAll();

    UserResponseDTO findById(Long id);
    
    UserResponseDTO update(Long id ,UserRequestDTO dto );
    
    void delete (Long id);


}
