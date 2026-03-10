package com.sena.test.service;

import com.sena.test.entity.Product;
import java.util.List;

public interface IProductService {
    Product guardar(Product product);
    List<Product> listar();
    Product buscarPorId(Long id);
    Product actualizar(Long id, Product product);
    void eliminar(Long id);
}