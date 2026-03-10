package com.sena.test.utils;

public class ValidationUtils {

    // RF1.3: Validar que los datos de registro estén completos
    public static boolean isStringValid(String data) {
        return data != null && !data.trim().isEmpty();
    }
}