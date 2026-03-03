package com.sena.test.IService.ISecurityService;

import java.util.List;

import com.sena.test.DTO.SecurityDTO.PersonRequestDTO;
import com.sena.test.DTO.SecurityDTO.PersonResponseDTO;

public interface IPersonService {

    PersonResponseDTO save(PersonRequestDTO dto);

    List<PersonResponseDTO> findAll();// Devuelve una lista de dto de salida 

    PersonResponseDTO findById(Long id); // Devuelve un solo  de dto de salida 

    PersonResponseDTO update (Long id, PersonRequestDTO dto ); //actuliza

    void delete (Long id ); // elimina 

}
