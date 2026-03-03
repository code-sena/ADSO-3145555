package com.sena.test.Service.BillService;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sena.test.DTO.BillDTO.BillDetailRequestDTO;
import com.sena.test.DTO.BillDTO.BillDetailResponseDTO;
import com.sena.test.DTO.BillDTO.BillRequestDTO;
import com.sena.test.DTO.BillDTO.BillResponseDTO;
import com.sena.test.Entity.Bill.Bill;
import com.sena.test.Entity.Bill.BillDetail;
import com.sena.test.Entity.Inventory.Product;
import com.sena.test.Entity.Security.User;
import com.sena.test.IRepository.IBillRepository.IBillRepository;
import com.sena.test.IRepository.IInventoryRepository.IProductRepository;
import com.sena.test.IRepository.ISecurityRepository.IUserRepository;
import com.sena.test.IService.IBillService.IBillService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class BillService implements IBillService {

    private final IBillRepository billRepository;
    private final IUserRepository userRepository;
    private final IProductRepository productRepository;

    @Override
    public BillResponseDTO create(BillRequestDTO dto) {

        User user = userRepository.findById(dto.getUserId())
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        Bill bill = new Bill();
        bill.setDate(dto.getDate());
        bill.setUser(user);

        List<BillDetail> details = new ArrayList<>();
        double total = 0;

        for (BillDetailRequestDTO detailDTO : dto.getDetails()) {

            Product product = productRepository.findById(detailDTO.getProductId())
                    .orElseThrow(() -> new RuntimeException("Producto no encontrado"));

            BillDetail detail = new BillDetail();
            detail.setQuantity(detailDTO.getQuantity());
            detail.setPrice(product.getPrice());
            detail.setProduct(product);
            detail.setBill(bill);

            total += product.getPrice() * detailDTO.getQuantity();
            details.add(detail);
        }

        bill.setTotal(total);
        bill.setDetails(details);

        Bill savedBill = billRepository.save(bill);

        return mapToDTO(savedBill);
    }

    @Override
    public List<BillResponseDTO> findAll() {
        return billRepository.findAll()
                .stream()
                .map(this::mapToDTO)
                .toList();
    }

    @Override
    public BillResponseDTO findById(Long id) {
        Bill bill = billRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Factura no encontrada"));

        return mapToDTO(bill);
    }

    private BillResponseDTO mapToDTO(Bill bill) {

        List<BillDetailResponseDTO> details = bill.getDetails()
                .stream()
                .map(detail -> new BillDetailResponseDTO(
                        detail.getId(),
                        detail.getQuantity(),
                        detail.getPrice(),
                        detail.getProduct().getName()
                ))
                .toList();

        return new BillResponseDTO(
                bill.getId(),
                bill.getDate(),
                bill.getUser().getUsername(),
                bill.getTotal(),
                details
        );
    }
}