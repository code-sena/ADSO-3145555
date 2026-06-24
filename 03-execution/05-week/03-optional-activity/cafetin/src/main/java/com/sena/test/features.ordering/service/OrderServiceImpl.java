package com.sena.test.features.ordering.service;

import com.sena.test.features.ordering.entity.Order;
import com.sena.test.features.ordering.repository.IOrderRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class OrderServiceImpl implements IOrderService {

    private final IOrderRepository orderRepository;

    public OrderServiceImpl(IOrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    @Override
    public Order crearPedido(Order order) {
        order.setEstado("PENDIENTE");
        return orderRepository.save(order);
    }

    @Override
    public List<Order> listarPedidos() {
        return orderRepository.findAll();
    }

    @Override
    public Order cambiarEstado(Long id, String nuevoEstado) {
        Order order = orderRepository.findById(id).orElseThrow(() -> new RuntimeException("No existe"));
        order.setEstado(nuevoEstado);
        return orderRepository.save(order);
    }
}