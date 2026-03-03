package com.sena.test.DTO.InventoryDTO;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductRequestDTO {
private String name ;
private Double price;
private int stock;
private List<Long> categoryIds;

}
