package com.crud;

import com.crud.inventory.entity.Category;
import com.crud.inventory.entity.Product;
import com.crud.inventory.repository.CategoryRepository;
import com.crud.inventory.repository.ProductRepository;
import com.crud.security.entity.Person;
import com.crud.security.entity.Role;
import com.crud.security.entity.User;
import com.crud.security.entity.UserRole;
import com.crud.security.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
@RequiredArgsConstructor
public class DataSeeder implements CommandLineRunner {

    private final PersonRepository personRepository;
    private final RoleRepository roleRepository;
    private final UserRepository userRepository;
    private final UserRoleRepository userRoleRepository;
    private final CategoryRepository categoryRepository;
    private final ProductRepository productRepository;

    @Override
    public void run(String... args) {
        // Security
        Person p1 = personRepository.save(Person.builder().firstName("Ana").lastName("García").email("ana@mail.com").phone("300-1111").build());
        Person p2 = personRepository.save(Person.builder().firstName("Luis").lastName("Pérez").email("luis@mail.com").phone("300-2222").build());

        Role admin = roleRepository.save(Role.builder().name("ADMIN").description("Full access").build());
        Role user_role = roleRepository.save(Role.builder().name("USER").description("Limited access").build());

        User u1 = userRepository.save(User.builder().username("ana.garcia").password("pass123").active(true).person(p1).build());
        User u2 = userRepository.save(User.builder().username("luis.perez").password("pass123").active(true).person(p2).build());

        userRoleRepository.save(UserRole.builder().user(u1).role(admin).build());
        userRoleRepository.save(UserRole.builder().user(u2).role(user_role).build());

        // Inventory
        Category electronics = categoryRepository.save(Category.builder().name("Electronics").description("Electronic devices").build());
        Category office = categoryRepository.save(Category.builder().name("Office").description("Office supplies").build());

        productRepository.save(Product.builder().name("Laptop Pro").description("High-end laptop").price(new BigDecimal("1200.00")).stock(10).category(electronics).build());
        productRepository.save(Product.builder().name("Wireless Mouse").description("Ergonomic wireless mouse").price(new BigDecimal("25.00")).stock(50).category(electronics).build());
        productRepository.save(Product.builder().name("Desk Organizer").description("Bamboo desk organizer").price(new BigDecimal("15.00")).stock(30).category(office).build());
    }
}
