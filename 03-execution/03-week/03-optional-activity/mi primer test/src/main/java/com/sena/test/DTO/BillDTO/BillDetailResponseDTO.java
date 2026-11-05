package com.sena.test.DTO.BillDTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BillDetailResponseDTO {
private Long id;
private int quantity;
private Double price;
private String productName;
}
