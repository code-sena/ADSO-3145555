package com.sena.test.features.registration.repository;

import com.sena.test.features.registration.entity.Ficha;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IFichaRepository extends JpaRepository<Ficha, Long> {
}