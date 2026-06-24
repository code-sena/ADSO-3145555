package com.sena.test.features.inventory.service;

import com.sena.test.features.inventory.entity.Inventory;
import java.util.List;

public interface IInventoryService {
    List<Inventory> listarTodo();
    Inventory guardar(Inventory inventory);
    void descontarStock(Long productId, Integer cantidad); // Para cuando alguien compra
}