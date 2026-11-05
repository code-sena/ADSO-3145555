package com.app.controller;

import com.app.entity.Bill;
import com.app.service.interfaces.IBillService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/bills")
public class BillController {

    private final IBillService service;

    public BillController(IBillService service) {
        this.service = service;
    }

    @GetMapping
    public List<Bill> getAll() {
        return service.getAll();
    }

    @GetMapping("/{id}")
    public Bill getById(@PathVariable Long id) {
        return service.getById(id);
    }

    @PostMapping
    public Bill save(@RequestBody Bill bill) {
        return service.save(bill);
    }

    @PutMapping("/{id}")
    public Bill update(@PathVariable Long id, @RequestBody Bill bill) {
        return service.update(id, bill);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}
