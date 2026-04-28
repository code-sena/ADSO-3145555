package com.sena.test.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;
    private String password;

    @OneToOne
    @JoinColumn(name = "person_id")
    private Person person;

    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;

    public User() {}

    public User(Long id, String username, String password, Person person, Role role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.person = person;
        this.role = role;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public Person getPerson() { return person; }
    public void setPerson(Person person) { this.person = person; }

    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }
}