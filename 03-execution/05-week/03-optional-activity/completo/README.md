# 📦 Proyecto Final - Base de Datos MySQL

## 📁 Estructura del proyecto

```
base_de_datos_proyecto_final/
 ├── 00_COMPLETO.sql     ← Ejecutar este para levantar todo de una vez
 ├── 01_DDL.sql          ← Solo estructura (CREATE TABLE)
 ├── 02_DML.sql          ← Solo datos (INSERT)
 └── 03_FUNCIONES.sql    ← Funciones almacenadas
```

---

## 🗃️ Tablas

| Tabla    | Descripción                        |
|----------|------------------------------------|
| persona  | Datos personales del usuario       |
| usuario  | Credenciales vinculadas a persona  |

---

## ⚙️ Funciones disponibles

| Función                        | Parámetro    | Retorna                  |
|--------------------------------|-------------|--------------------------|
| `obtener_nombre(id)`           | INT          | VARCHAR - nombre         |
| `obtener_edad(id)`             | INT          | INT - edad               |
| `obtener_nombre_completo(id)`  | INT          | VARCHAR - nombre+apellido|
| `obtener_username(id_persona)` | INT          | VARCHAR - username       |

---

## 🚀 Cómo ejecutar

1. Abre MySQL Workbench o tu cliente SQL
2. Ejecuta `00_COMPLETO.sql` para levantar todo desde cero
3. O ejecuta los archivos en orden: `01` → `02` → `03`

---

## ✅ Mejoras aplicadas respecto al original

- Se agregó `CHECK (edad >= 0)` en persona
- Se agregó `UNIQUE` en correo
- La FK ahora tiene `ON DELETE CASCADE` y `ON UPDATE CASCADE`
- Las funciones tienen `READS SQL DATA` (buena práctica)
- Se agregaron `LIMIT 1` para evitar errores con múltiples resultados
- Se agregaron 2 funciones nuevas: `obtener_nombre_completo` y `obtener_username`
- Se agregó verificación final con SELECT de prueba
