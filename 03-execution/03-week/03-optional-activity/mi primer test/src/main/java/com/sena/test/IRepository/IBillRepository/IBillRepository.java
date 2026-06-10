package com.sena.test.IRepository.IBillRepository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sena.test.Entity.Bill.Bill;

public interface IBillRepository  extends JpaRepository<Bill, Long>{
List<Bill> findByUserId(Long userId);
}
