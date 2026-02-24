package com.sena.test.Repository;


import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sena.test.Entity.Person;

public interface IPersonRepository extends JpaRepository<Person, Long> { 
    Optional<Person> findByEmail(String email);
        
    Optional<Person> findByIdentidad(String identidad);
}