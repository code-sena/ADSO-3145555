package com.sena.test.controller;

import com.sena.test.entity.Product;
import com.sena.test.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/product")
@CrossOrigin("*")
public class ProductController {

    @Autowired
    private IProductService productService;

    @GetMapping
    public List<Product> listar() {
        return productService.listar();
    }

    @PostMapping
    public Product guardar(@RequestBody Product product) {
        return productService.guardar(product);
    }

    @GetMapping("/{id}")
    public Product buscarPorId(@PathVariable Long id) {
        return productService.buscarPorId(id);
    }

    @PutMapping("/{id}")
    public Product actualizar(@PathVariable Long id, @RequestBody Product product) {
        return productService.actualizar(id, product);
    }

    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable Long id) {
        productService.eliminar(id);
    }
}