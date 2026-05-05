package com.sena.test.features.registration.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "fichas")
public class Ficha {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String codigo;

    @ManyToOne
    @JoinColumn(name = "program_id")
    private Program program;

    public Ficha() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getCodigo() { return codigo; }
    public void setCodigo(String codigo) { this.codigo = codigo; }
    public Program getProgram() { return program; }
    public void setProgram(Program program) { this.program = program; }
}