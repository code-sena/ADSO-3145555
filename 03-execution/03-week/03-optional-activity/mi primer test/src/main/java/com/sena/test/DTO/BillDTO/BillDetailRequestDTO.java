package com.sena.test.DTO.BillDTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BillDetailRequestDTO {
private int quantity;
private Long productId;
}
