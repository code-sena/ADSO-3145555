package com.sena.test.Controller.BillController;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sena.test.DTO.BillDTO.BillRequestDTO;
import com.sena.test.DTO.BillDTO.BillResponseDTO;
import com.sena.test.IService.IBillService.IBillService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/bills")
@RequiredArgsConstructor
public class BillController {

    private final IBillService billService;

    // CREATE
    @PostMapping
    public ResponseEntity<BillResponseDTO> create(
            @RequestBody BillRequestDTO dto) {

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(billService.create(dto));
    }

    // READ ALL
    @GetMapping
    public ResponseEntity<List<BillResponseDTO>> findAll() {
        return ResponseEntity.ok(billService.findAll());
    }

    // READ BY ID
    @GetMapping("/{id}")
    public ResponseEntity<BillResponseDTO> findById(
            @PathVariable Long id) {

        return ResponseEntity.ok(billService.findById(id));
    }
}