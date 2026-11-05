package com.sena.test.IService.IInventoryService;

import java.util.List;

import com.sena.test.DTO.InventoryDTO.CategoryRequestDTO;
import com.sena.test.DTO.InventoryDTO.CategoryResponseDTO;

public interface ICategoryService {
    CategoryResponseDTO save (CategoryRequestDTO dto);

    List<CategoryResponseDTO> findAll();
    CategoryResponseDTO findById(Long id);
    CategoryResponseDTO update (Long id, CategoryRequestDTO dto );

    void delete (Long id);
    

}
