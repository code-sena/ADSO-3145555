package com.sena.test.Service.InventoryService;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sena.test.DTO.InventoryDTO.CategoryRequestDTO;
import com.sena.test.DTO.InventoryDTO.CategoryResponseDTO;
import com.sena.test.Entity.Inventory.Category;
import com.sena.test.IRepository.IInventoryRepository.ICategoryRepository;
import com.sena.test.IService.IInventoryService.ICategoryService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class CategoryService implements ICategoryService {

    private final ICategoryRepository categoryRepository;

    // ===================== CREATE =====================
    @Override
    public CategoryResponseDTO save(CategoryRequestDTO dto) {

        if (categoryRepository.existsByName(dto.getName())) {
            throw new RuntimeException("La categoría ya existe");
        }

        Category category = new Category();
        category.setName(dto.getName());

        return mapToDTO(categoryRepository.save(category));
    }

    // ===================== READ ALL =====================
    @Override
    public List<CategoryResponseDTO> findAll() {
        return categoryRepository.findAll()
                .stream()
                .map(this::mapToDTO)
                .collect(Collectors.toList());
    }

    // ===================== READ BY ID =====================
    @Override
    public CategoryResponseDTO findById(Long id) {

        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Categoría no encontrada"));

        return mapToDTO(category);
    }

    // ===================== UPDATE =====================
    @Override
    public CategoryResponseDTO update(Long id, CategoryRequestDTO dto) {

        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Categoría no encontrada"));

        if (!category.getName().equals(dto.getName())
                && categoryRepository.existsByName(dto.getName())) {
            throw new RuntimeException("El nombre ya está en uso");
        }

        category.setName(dto.getName());

        return mapToDTO(categoryRepository.save(category));
    }

    // ===================== DELETE =====================
    @Override
    public void delete(Long id) {

        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Categoría no encontrada"));

        // romper relación ManyToMany correctamente
        category.getProducts().forEach(product ->
                product.getCategories().remove(category)
        );

        categoryRepository.delete(category);
    }

    // ===================== MAPPER =====================
    private CategoryResponseDTO mapToDTO(Category category) {
        return new CategoryResponseDTO(
                category.getId(),
                category.getName()
        );
    }
}