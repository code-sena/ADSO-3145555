package com.sena.test.features.inventory.controller;

import com.sena.test.entity.Product;
import com.sena.test.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/products")
public class ProductController {

    @Autowired
    private ProductRepository productRepository;

    // 1. Probar conexión (GET http://localhost:8081/api/products/test)
    @GetMapping("/test")
    public String test() {
        return "¡Conexión exitosa con el módulo de Productos!";
    }

    // 2. Listar todos los productos (GET http://localhost:8081/api/products)
    @GetMapping
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    // 3. Crear un producto nuevo (POST http://localhost:8081/api/products)
    @PostMapping
    public Product createProduct(@RequestBody Product product) {
        return productRepository.save(product);
    }

    // 4. Actualizar un producto (PUT)
    @PutMapping
    public Product updateProduct(@RequestBody Product product) {
        return productRepository.save(product); // save() actualiza si el ID ya existe
    }

    // 5. Eliminar un producto (DELETE http://localhost:8081/api/products/1)
    @DeleteMapping("/{id}")
    public String deleteProduct(@PathVariable Long id) {
        productRepository.deleteById(id);
        return "Producto con ID " + id + " eliminado correctamente.";
    }
}