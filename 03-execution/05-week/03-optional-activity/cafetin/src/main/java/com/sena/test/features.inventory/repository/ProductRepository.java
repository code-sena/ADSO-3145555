package com.sena.test.repository;

import com.sena.test.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    // Aquí no necesitas escribir código, JpaRepository ya te da todo para Product
}