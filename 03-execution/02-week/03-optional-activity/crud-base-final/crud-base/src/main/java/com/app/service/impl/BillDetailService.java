package com.app.service.impl;

import com.app.entity.BillDetail;
import com.app.repository.IBillDetailRepository;
import com.app.service.interfaces.IBillDetailService;
import com.app.utils.Constants;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BillDetailService implements IBillDetailService {

    private final IBillDetailRepository repository;

    public BillDetailService(IBillDetailRepository repository) {
        this.repository = repository;
    }

    public List<BillDetail> getAll() {
        return repository.findAll();
    }

    public BillDetail getById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException(Constants.NOT_FOUND + id));
    }

    public BillDetail save(BillDetail billDetail) {
        return repository.save(billDetail);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}
