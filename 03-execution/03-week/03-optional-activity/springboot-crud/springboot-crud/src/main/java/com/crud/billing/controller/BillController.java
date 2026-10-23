package com.crud.billing.controller;

import com.crud.billing.dto.BillingDTOs.*;
import com.crud.billing.entity.Bill.BillStatus;
import com.crud.billing.service.BillService;
import com.crud.shared.ApiResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/billing/bills")
@RequiredArgsConstructor
@Tag(name = "Billing - Bills", description = "CRUD for Bill entity")
public class BillController {

    private final BillService billService;

    @GetMapping
    @Operation(summary = "Get all bills")
    public ResponseEntity<ApiResponse<List<BillResponse>>> findAll() {
        return ResponseEntity.ok(ApiResponse.ok(billService.findAll()));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get bill by ID")
    public ResponseEntity<ApiResponse<BillResponse>> findById(@PathVariable Long id) {
        return ResponseEntity.ok(ApiResponse.ok(billService.findById(id)));
    }

    @GetMapping("/user/{userId}")
    @Operation(summary = "Get bills by user")
    public ResponseEntity<ApiResponse<List<BillResponse>>> findByUser(@PathVariable Long userId) {
        return ResponseEntity.ok(ApiResponse.ok(billService.findByUser(userId)));
    }

    @PostMapping
    @Operation(summary = "Create a bill with details")
    public ResponseEntity<ApiResponse<BillResponse>> create(@Valid @RequestBody BillRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.ok("Bill created", billService.create(request)));
    }

    @PatchMapping("/{id}/status")
    @Operation(summary = "Update bill status")
    public ResponseEntity<ApiResponse<BillResponse>> updateStatus(@PathVariable Long id, @RequestParam BillStatus status) {
        return ResponseEntity.ok(ApiResponse.ok("Status updated", billService.updateStatus(id, status)));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Delete a bill")
    public ResponseEntity<ApiResponse<Void>> delete(@PathVariable Long id) {
        billService.delete(id);
        return ResponseEntity.ok(ApiResponse.ok("Bill deleted", null));
    }
}
