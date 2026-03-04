package com.sena.test.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "type_document")
@Data // Si usas Lombok, si no, genera Getters y Setters manualmente
public class TypeDocument {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, length = 10, nullable = false)
    private String code;

    @Column(length = 50, nullable = false)
    private String name;

    private Boolean status = true;
}