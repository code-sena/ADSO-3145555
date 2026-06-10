package com.crud.inventory.dto;

import jakarta.validation.constraints.*;
import lombok.*;
import java.math.BigDecimal;

public class InventoryDTOs {

    @Data @NoArgsConstructor @AllArgsConstructor @Builder
    public static class CategoryRequest {
        @NotBlank(message = "Category name is required")
        private String name;
        private String description;
    }

    @Data @NoArgsConstructor @AllArgsConstructor @Builder
    public static class CategoryResponse {
        private Long id;
        private String name;
        private String description;
    }

    @Data @NoArgsConstructor @AllArgsConstructor @Builder
    public static class ProductRequest {
        @NotBlank(message = "Product name is required")
        private String name;
        private String description;
        @NotNull(message = "Price is required")
        @DecimalMin(value = "0.0", inclusive = false)
        private BigDecimal price;
        @Min(0)
        private Integer stock;
        @NotNull(message = "Category ID is required")
        private Long categoryId;
    }

    @Data @NoArgsConstructor @AllArgsConstructor @Builder
    public static class ProductResponse {
        private Long id;
        private String name;
        private String description;
        private BigDecimal price;
        private Integer stock;
        private CategoryResponse category;
    }
}
