package com.sena.test.features.ordering.service;

import com.sena.test.features.ordering.entity.Order;
import com.sena.test.features.ordering.repository.IOrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class OrderServiceImpl implements IOrderService {

    @Autowired
    private IOrderRepository orderRepository;

    @Override
    public Order crearPedido(Order order) {
        return orderRepository.save(order);
    }

    @Override
    public List<Order> listarPedidos() {
        return orderRepository.findAll();
    }

    @Override
    public Order cambiarEstado(Long id, String estado) {
        Order order = orderRepository.findById(id).orElseThrow();
        order.setEstado(estado);
        return orderRepository.save(order);
    }
}