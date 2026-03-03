package com.sena.test.Service.InventoryService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sena.test.DTO.InventoryDTO.ProductRequestDTO;
import com.sena.test.DTO.InventoryDTO.ProductResponseDTO;
import com.sena.test.Entity.Inventory.Category;
import com.sena.test.Entity.Inventory.Product;
import com.sena.test.IRepository.IInventoryRepository.ICategoryRepository;
import com.sena.test.IRepository.IInventoryRepository.IProductRepository;
import com.sena.test.IService.IInventoryService.IProductService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProductService implements IProductService {

    private final IProductRepository productRepository;
    private final ICategoryRepository categoryRepository;

    @Override
    public ProductResponseDTO save(ProductRequestDTO dto) {
        validateName(dto.getName(), null);
        Product product = buildProduct(new Product(), dto);
        return mapToDTO(productRepository.save(product));
    }

    @Override
    public List<ProductResponseDTO> findAll() {
        return productRepository.findAll()
                .stream()
                .map(this::mapToDTO)
                .toList();
    }

    @Override
    public ProductResponseDTO findById(Long id) {
        return mapToDTO(findProductById(id));
    }

    @Override
    public ProductResponseDTO update(Long id, ProductRequestDTO dto) {
        Product product = findProductById(id);
        validateName(dto.getName(), product.getName());
        product = buildProduct(product, dto);
        return mapToDTO(productRepository.save(product));
    }

    @Override
    public void delete(Long id) {
        Product product = findProductById(id);
        product.getCategories().clear();
        productRepository.delete(product);
    }

    

    private Product findProductById(Long id) {
        return productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Producto no encontrado"));
    }

    private void validateName(String newName, String currentName) {
        if ((currentName == null || !currentName.equals(newName))
                && productRepository.existsByName(newName)) {
            throw new RuntimeException("El nombre ya está en uso");
        }
    }

    private Product buildProduct(Product product, ProductRequestDTO dto) {

        List<Category> categories = categoryRepository
                .findAllById(dto.getCategoryIds() == null
                        ? List.of()
                        : dto.getCategoryIds());

        product.setName(dto.getName());
        product.setPrice(dto.getPrice());
        product.setStock(dto.getStock());
        product.setCategories(categories);

        return product;
    }

    private ProductResponseDTO mapToDTO(Product product) {
        return new ProductResponseDTO(
                product.getId(),
                product.getName(),
                product.getPrice(),
                product.getStock(),
                product.getCategories()
                        .stream()
                        .map(Category::getName)
                        .toList()
        );
    }
}