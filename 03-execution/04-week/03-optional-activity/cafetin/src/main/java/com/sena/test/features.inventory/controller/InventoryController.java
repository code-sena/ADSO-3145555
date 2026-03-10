package com.sena.test.features.inventory.controller;

import com.sena.test.features.inventory.entity.Inventory;
import com.sena.test.features.inventory.service.IInventoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/inventory")
public class InventoryController {

    @Autowired
    private IInventoryService inventoryService;

    @GetMapping
    public List<Inventory> listar() {
        return inventoryService.listarTodo();
    }

    @PostMapping
    public Inventory crear(@RequestBody Inventory inventory) {
        return inventoryService.guardar(inventory);
    }
}