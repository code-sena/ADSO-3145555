package com.sena.test.DTO.BillDTO;

import java.time.LocalDate;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BillResponseDTO {

    private Long id;
private LocalDate  date ;
private String username ;
    private Double total;  
private List<BillDetailResponseDTO> details ;

}
