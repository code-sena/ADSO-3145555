package com.sena.test.IRepository.IInventoryRepository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sena.test.Entity.Inventory.Product;

public interface IProductRepository extends JpaRepository<Product, Long>{

   List<Product> findByCategories_Id(Long categoryId);
     boolean existsByName(String name);
}
