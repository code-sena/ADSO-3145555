package com.app.service.interfaces;

import com.app.entity.BillDetail;
import java.util.List;

public interface IBillDetailService {
    List<BillDetail> getAll();
    BillDetail getById(Long id);
    BillDetail save(BillDetail billDetail);
    void delete(Long id);
}
