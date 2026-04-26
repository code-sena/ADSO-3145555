# 🌸 SchoolMS — Repositorios del Proyecto

Sistema de Gestión Académica desarrollado con Spring Boot, PostgreSQL y HTML/CSS/JS.

---

## 🔗 Repositorios

| Capa | Tecnología | Repositorio |
|---|---|---|
| 🗄️ Base de Datos | PostgreSQL + Docker | [Base-de-Datos](https://github.com/sharithsaavedra1/Base-de-Datos) |
| ⚙️ Backend | Java + Spring Boot | [Backend-Java](https://github.com/sharithsaavedra1/Backend-Java) |
| 🖥️ Frontend | HTML / CSS / JS | [front-end-java](https://github.com/sharithsaavedra1/front-end-java) |

---

## 🗄️ Base de Datos

> PostgreSQL en contenedor Docker con esquema DDL y datos iniciales DML.

🔗 **Repo:** https://github.com/sharithsaavedra1/Base-de-Datos

**Ramas disponibles:**
- `main` — producción
- `develop` — desarrollo
- `qa` — pruebas
- `staging` — preproducción

---

## ⚙️ Backend

> API REST con Spring Boot 3.2.4, Java 17, JPA/Hibernate y Swagger.

🔗 **Repo:** https://github.com/sharithsaavedra1/Backend-Java

**Endpoints principales:**
- `GET/POST/PUT/DELETE /api/students`
- `GET/POST/PUT/DELETE /api/teachers`
- `GET/POST/PUT/DELETE /api/enrollments`

**Swagger UI:** http://localhost:8080/swagger-ui.html

**Ramas disponibles:**
- `main` — producción
- `develop` — desarrollo
- `qa` — pruebas
- `staging` — preproducción

---

## 🖥️ Frontend

> Interfaz web en HTML, CSS y JavaScript puro que consume la API REST.

🔗 **Repo:** https://github.com/sharithsaavedra1/front-end-java

**Ramas disponibles:**
- `main` — producción
- `develop` — desarrollo
- `qa` — pruebas
- `staging` — preproducción

---

## 🚀 Cómo correr el proyecto

```bash
# 1. Levantar la base de datos
cd school-database
docker-compose up -d

# 2. Correr el backend (desde IntelliJ)
# Abrir SchoolApplication.java → ▶️ Run

# 3. Abrir el frontend
# Abrir index.html con Live Server en VS Code
```

---

## 🔄 CI/CD — GitHub Actions

| Repo | Workflow | Estado |
|---|---|---|
| Base de Datos | 🐳 Docker CI | [![Docker CI](https://github.com/sharithsaavedra1/Base-de-Datos/actions/workflows/docker-ci.yml/badge.svg)](https://github.com/sharithsaavedra1/Base-de-Datos/actions/workflows/docker-ci.yml) |
| Backend | 🌸 Backend CI/CD | [![Backend CI](https://github.com/sharithsaavedra1/Backend-Java/actions/workflows/backend-ci.yml/badge.svg)](https://github.com/sharithsaavedra1/Backend-Java/actions/workflows/backend-ci.yml) |
| Frontend | 🌸 Frontend CI | [![Frontend CI](https://github.com/sharithsaavedra1/front-end-java/actions/workflows/frontend-ci.yml/badge.svg)](https://github.com/sharithsaavedra1/front-end-java/actions/workflows/frontend-ci.yml) |

---

*Desarrollado por **Sharith Saavedra** · Arquitectura de Software · 2026*
