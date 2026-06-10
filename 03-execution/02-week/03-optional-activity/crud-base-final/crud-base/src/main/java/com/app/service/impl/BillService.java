package com.app.service.impl;

import com.app.entity.Bill;
import com.app.repository.IBillRepository;
import com.app.service.interfaces.IBillService;
import com.app.utils.Constants;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BillService implements IBillService {

    private final IBillRepository repository;

    public BillService(IBillRepository repository) {
        this.repository = repository;
    }

    public List<Bill> getAll() {
        return repository.findAll();
    }

    public Bill getById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException(Constants.NOT_FOUND + id));
    }

    public Bill save(Bill bill) {
        return repository.save(bill);
    }

    public Bill update(Long id, Bill bill) {
        Bill existing = getById(id);
        existing.setBillNumber(bill.getBillNumber());
        existing.setIssueDate(bill.getIssueDate());
        existing.setTotal(bill.getTotal());
        existing.setStatus(bill.getStatus());
        existing.setUser(bill.getUser());
        return repository.save(existing);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}
