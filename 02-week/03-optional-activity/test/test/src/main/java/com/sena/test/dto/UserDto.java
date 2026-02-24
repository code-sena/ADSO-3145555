package com.sena.test.dto;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDto {
    private Long personId;   
    private String username; 
    private String password; 
}
