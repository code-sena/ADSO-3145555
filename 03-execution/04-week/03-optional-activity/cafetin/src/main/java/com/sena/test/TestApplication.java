package com.sena.test;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class TestApplication {

	public static void main(String[] args) {
		SpringApplication.run(TestApplication.class, args);

		// Esto aparecerá en la consola al final del arranque
		System.out.println("\n" + "=".repeat(40));
		System.out.println("☕ SISTEMA CAFETÍN SENA ARRANCADO");
		System.out.println("🚀 Módulos cargados: Security, Inventory, Ordering, Registration");
		System.out.println("=".repeat(40));
	}

}