package com.app.service.impl;

import com.app.entity.Category;
import com.app.repository.ICategoryRepository;
import com.app.service.interfaces.ICategoryService;
import com.app.utils.Constants;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService implements ICategoryService {

    private final ICategoryRepository repository;

    public CategoryService(ICategoryRepository repository) {
        this.repository = repository;
    }

    public List<Category> getAll() {
        return repository.findAll();
    }

    public Category getById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException(Constants.NOT_FOUND + id));
    }

    public Category save(Category category) {
        return repository.save(category);
    }

    public Category update(Long id, Category category) {
        Category existing = getById(id);
        existing.setName(category.getName());
        existing.setDescription(category.getDescription());
        return repository.save(existing);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}
