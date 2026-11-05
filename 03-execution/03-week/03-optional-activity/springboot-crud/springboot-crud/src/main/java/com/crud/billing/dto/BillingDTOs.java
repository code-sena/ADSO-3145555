package com.crud.billing.dto;

import com.crud.billing.entity.Bill.BillStatus;
import com.crud.inventory.dto.InventoryDTOs.ProductResponse;
import com.crud.security.dto.SecurityDTOs.UserResponse;
import jakarta.validation.constraints.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public class BillingDTOs {

    // ─── BillDetail ──────────────────────────────────────
    @Data @NoArgsConstructor @AllArgsConstructor @Builder
    public static class BillDetailRequest {
        @NotNull(message = "Product ID is required")
        private Long productId;
        @Min(value = 1, message = "Quantity must be at least 1")
        private Integer quantity;
        @NotNull
        @DecimalMin("0.0")
        private BigDecimal unitPrice;
    }

    @Data @NoArgsConstructor @AllArgsConstructor @Builder
    public static class BillDetailResponse {
        private Long id;
        private ProductResponse product;
        private Integer quantity;
        private BigDecimal unitPrice;
        private BigDecimal subtotal;
    }

    // ─── Bill ─────────────────────────────────────────────
    @Data @NoArgsConstructor @AllArgsConstructor @Builder
    public static class BillRequest {
        @NotNull(message = "User ID is required")
        private Long userId;
        private LocalDate date;
        private BillStatus status;
        @NotEmpty(message = "Bill must have at least one detail")
        private List<BillDetailRequest> details;
    }

    @Data @NoArgsConstructor @AllArgsConstructor @Builder
    public static class BillResponse {
        private Long id;
        private LocalDate date;
        private BillStatus status;
        private BigDecimal total;
        private UserResponse user;
        private List<BillDetailResponse> details;
    }
}
