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
public class BillRequestDTO {
private LocalDate date ;
private Long userId;
private List <BillDetailRequestDTO> details ;
}
