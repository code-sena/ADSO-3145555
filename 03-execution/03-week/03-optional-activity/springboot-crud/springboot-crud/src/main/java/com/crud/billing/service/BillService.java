package com.crud.billing.service;

import com.crud.billing.dto.BillingDTOs.*;
import com.crud.billing.entity.Bill;
import com.crud.billing.entity.BillDetail;
import com.crud.billing.repository.BillRepository;
import com.crud.inventory.entity.Product;
import com.crud.inventory.service.ProductService;
import com.crud.security.entity.User;
import com.crud.security.service.UserService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class BillService {

    private final BillRepository billRepository;
    private final UserService userService;
    private final ProductService productService;

    @Transactional(readOnly = true)
    public List<BillResponse> findAll() {
        return billRepository.findAll().stream().map(this::toResponse).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public BillResponse findById(Long id) {
        return toResponse(findEntityById(id));
    }

    @Transactional(readOnly = true)
    public List<BillResponse> findByUser(Long userId) {
        return billRepository.findByUserId(userId).stream().map(this::toResponse).collect(Collectors.toList());
    }

    public BillResponse create(BillRequest request) {
        User user = userService.findEntityById(request.getUserId());

        Bill bill = Bill.builder()
                .user(user)
                .date(request.getDate() != null ? request.getDate() : LocalDate.now())
                .status(request.getStatus() != null ? request.getStatus() : Bill.BillStatus.PENDING)
                .build();

        List<BillDetail> details = request.getDetails().stream().map(d -> {
            Product product = productService.findEntityById(d.getProductId());
            BigDecimal subtotal = d.getUnitPrice().multiply(BigDecimal.valueOf(d.getQuantity()));
            return BillDetail.builder()
                    .bill(bill)
                    .product(product)
                    .quantity(d.getQuantity())
                    .unitPrice(d.getUnitPrice())
                    .subtotal(subtotal)
                    .build();
        }).collect(Collectors.toList());

        bill.setDetails(details);
        bill.setTotal(details.stream().map(BillDetail::getSubtotal).reduce(BigDecimal.ZERO, BigDecimal::add));

        return toResponse(billRepository.save(bill));
    }

    public BillResponse updateStatus(Long id, Bill.BillStatus status) {
        Bill bill = findEntityById(id);
        bill.setStatus(status);
        return toResponse(billRepository.save(bill));
    }

    public void delete(Long id) {
        if (!billRepository.existsById(id)) throw new EntityNotFoundException("Bill not found: " + id);
        billRepository.deleteById(id);
    }

    private Bill findEntityById(Long id) {
        return billRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Bill not found: " + id));
    }

    private BillResponse toResponse(Bill bill) {
        List<BillDetailResponse> details = bill.getDetails().stream().map(d ->
                BillDetailResponse.builder()
                        .id(d.getId())
                        .product(productService.findById(d.getProduct().getId()))
                        .quantity(d.getQuantity())
                        .unitPrice(d.getUnitPrice())
                        .subtotal(d.getSubtotal())
                        .build()
        ).collect(Collectors.toList());

        return BillResponse.builder()
                .id(bill.getId())
                .date(bill.getDate())
                .status(bill.getStatus())
                .total(bill.getTotal())
                .user(userService.toResponse(bill.getUser()))
                .details(details)
                .build();
    }
}
