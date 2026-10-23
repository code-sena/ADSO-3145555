package com.app.service.interfaces;

import com.app.entity.Bill;
import java.util.List;

public interface IBillService {
    List<Bill> getAll();
    Bill getById(Long id);
    Bill save(Bill bill);
    Bill update(Long id, Bill bill);
    void delete(Long id);
}
