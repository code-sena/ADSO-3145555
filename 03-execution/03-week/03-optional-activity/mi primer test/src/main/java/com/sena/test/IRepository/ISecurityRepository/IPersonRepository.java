package com.sena.test.IRepository.ISecurityRepository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sena.test.Entity.Security.Person;

public interface IPersonRepository extends  JpaRepository<Person, Long>{
boolean  existsByEmail(String email);
boolean  existsByIdentidad(String identidad);

}
