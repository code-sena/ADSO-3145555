package com.sena.test.utils;

import java.util.HashMap;
import java.util.Map;

public class MemoryGameUtils {

    // RF: Traducción de productos para el juego interactivo
    public static Map<String, String> getVocabulary() {
        Map<String, String> vocabulary = new HashMap<>();
        vocabulary.put("Café", "Coffee");
        vocabulary.put("Empanada", "Pasty");
        vocabulary.put("Jugo", "Juice");
        vocabulary.put("Pastel", "Cake");
        return vocabulary;
    }
}