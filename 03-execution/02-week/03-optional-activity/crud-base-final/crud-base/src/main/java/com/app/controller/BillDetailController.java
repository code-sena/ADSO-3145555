package com.app.controller;

import com.app.entity.BillDetail;
import com.app.service.interfaces.IBillDetailService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/bill-details")
public class BillDetailController {

    private final IBillDetailService service;

    public BillDetailController(IBillDetailService service) {
        this.service = service;
    }

    @GetMapping
    public List<BillDetail> getAll() {
        return service.getAll();
    }

    @GetMapping("/{id}")
    public BillDetail getById(@PathVariable Long id) {
        return service.getById(id);
    }

    @PostMapping
    public BillDetail save(@RequestBody BillDetail billDetail) {
        return service.save(billDetail);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}
