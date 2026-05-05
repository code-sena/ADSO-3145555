package com.sena.test.features.ordering.controller;

import com.sena.test.features.ordering.entity.Order;
import com.sena.test.features.ordering.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    @Autowired
    private IOrderService orderService;

    @PostMapping
    public Order crear(@RequestBody Order order) {
        return orderService.crearPedido(order);
    }

    @GetMapping
    public List<Order> listar() {
        return orderService.listarPedidos();
    }

    @PutMapping("/{id}/status")
    public Order actualizarEstado(@PathVariable Long id, @RequestParam String estado) {
        return orderService.cambiarEstado(id, estado);
    }
}