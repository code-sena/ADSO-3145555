package com.sena.test.IService.IBillService;
 
import java.util.List;

import com.sena.test.DTO.BillDTO.BillRequestDTO;
import com.sena.test.DTO.BillDTO.BillResponseDTO ;

public interface IBillService
 {
 BillResponseDTO  create (BillRequestDTO dto );
 
 List<BillResponseDTO> findAll();
 BillResponseDTO  findById(Long id);
 
}
