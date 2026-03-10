package com.sena.test.features.ordering.entity;

import com.sena.test.entity.User; // Importamos tu User original
import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private LocalDateTime fecha;
    private String estado;
    private Double total;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    public Order() { this.fecha = LocalDateTime.now(); }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public LocalDateTime getFecha() { return fecha; }
    public void setFecha(LocalDateTime fecha) { this.fecha = fecha; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    public Double getTotal() { return total; }
    public void setTotal(Double total) { this.total = total; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}