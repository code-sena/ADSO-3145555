package com.sena.test.features.inventory.repository;

import com.sena.test.features.inventory.entity.Inventory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IInventoryRepository extends JpaRepository<Inventory, Long> {
    // Aquí podrías crear un método para buscar por producto si lo necesitas
}