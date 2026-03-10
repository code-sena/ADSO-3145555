package com.sena.test.features.ordering.service;

import com.sena.test.features.ordering.entity.Order;
import java.util.List;

public interface IOrderService {
    Order crearPedido(Order order);
    List<Order> listarPedidos();
    Order cambiarEstado(Long id, String nuevoEstado);
}