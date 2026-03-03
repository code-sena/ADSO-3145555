package com.sena.test.features.ordering.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDateTime fecha;
    private Double total;
    private String estado;

    private Double pagoCon; // Lo que entrega el aprendiz
    private Double cambio;  // Las vueltas calculadas

    public Order() {
        this.fecha = LocalDateTime.now();
        this.estado = "PENDIENTE";
    }

    // --- GETTERS Y SETTERS ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public LocalDateTime getFecha() { return fecha; }
    public void setFecha(LocalDateTime fecha) { this.fecha = fecha; }
    public Double getTotal() { return total; }
    public void setTotal(Double total) { this.total = total; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    public Double getPagoCon() { return pagoCon; }
    public void setPagoCon(Double pagoCon) { this.pagoCon = pagoCon; }
    public Double getCambio() { return cambio; }
    public void setCambio(Double cambio) { this.cambio = cambio; }
}