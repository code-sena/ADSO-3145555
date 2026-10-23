package com.sena.test.IService.IInventoryService;

import java.util.List;

import com.sena.test.DTO.InventoryDTO.ProductRequestDTO;
import com.sena.test.DTO.InventoryDTO.ProductResponseDTO;

public interface IProductService {

    ProductResponseDTO save( ProductRequestDTO dto);
    
    List<ProductResponseDTO> findAll();

    ProductResponseDTO findById( Long id );

    ProductResponseDTO update (Long id , ProductRequestDTO dto );

    void delete (Long id );

}
