package com.sena.test.serviceImpl;

import com.sena.test.entity.Product;
import com.sena.test.repository.ProductRepository;
import com.sena.test.service.IProductService;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProductServiceImpl implements IProductService {

    private final ProductRepository productRepository;

    public ProductServiceImpl(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @Override
    public Product guardar(Product product) {
        return productRepository.save(product);
    }

    @Override
    public List<Product> listar() {
        return productRepository.findAll();
    }

    @Override
    public Product buscarPorId(Long id) {
        return productRepository.findById(id).orElse(null);
    }

    @Override
    public Product actualizar(Long id, Product product) {
        product.setId(id);
        return productRepository.save(product);
    }

    @Override
    public void eliminar(Long id) {
        productRepository.deleteById(id);
    }
}