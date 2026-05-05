package com.sena.test.features.inventory.service;

import com.sena.test.features.inventory.entity.Inventory;
import com.sena.test.features.inventory.repository.IInventoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class InventoryServiceImpl implements IInventoryService {

    @Autowired
    private IInventoryRepository inventoryRepository;

    @Override
    public List<Inventory> listarTodo() {
        return inventoryRepository.findAll();
    }

    @Override
    public Inventory guardar(Inventory inventory) {
        return inventoryRepository.save(inventory);
    }

    @Override
    public void descontarStock(Long productId, Integer cantidad) {
        // Aquí iría la lógica para restar productos cuando se hace una venta
    }
}