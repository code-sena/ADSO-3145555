# Módulo 3. Infraestructura, Ambientes e Inventario

## Descripción General

Este módulo tiene como propósito administrar la infraestructura física y tecnológica utilizada en los procesos de formación del SENA, permitiendo controlar los ambientes de aprendizaje, su disponibilidad, capacidad, ubicación y los recursos asociados.

La información gestionada por este módulo servirá de base para los procesos de programación académica, asignación de instructores, gestión de fichas, ejecución de proyectos formativos y control institucional.

---

# Objetivos

## Objetivo General

Gestionar los ambientes de aprendizaje y los recursos institucionales necesarios para el desarrollo de la formación profesional integral.

## Objetivos Específicos

* Registrar y administrar ambientes de aprendizaje.
* Controlar la disponibilidad de ambientes.
* Gestionar inventarios de recursos físicos y tecnológicos.
* Mantener actualizada la información de infraestructura institucional.
* Facilitar la programación académica.
* Garantizar la trazabilidad de los recursos institucionales.

---

# Alcance

El módulo permitirá:

* Registrar regionales, centros y sedes.
* Registrar ambientes de formación.
* Gestionar recursos e inventario.
* Controlar mantenimientos.
* Gestionar reservas de ambientes.
* Consultar disponibilidad.
* Generar reportes de ocupación y uso.

---

# Estructura Organizacional SENA

La infraestructura deberá estar asociada a la estructura institucional.

```text
SENA
└── Regional
    └── Centro de Formación
        └── Sede
            └── Bloque
                └── Piso
                    └── Ambiente
```

---

# Gestión de Ambientes

## Definición

Un ambiente de aprendizaje es el espacio físico o virtual donde se desarrolla el proceso de formación.

## Información del Ambiente

### Identificación

* Código del ambiente.
* Nombre.
* Descripción.
* Tipo de ambiente.
* Centro de formación asociado.
* Sede.
* Ubicación física.

### Características

* Capacidad máxima de aprendices.
* Capacidad máxima de instructores.
* Área física.
* Disponibilidad.
* Estado.

---

# Tipos de Ambientes

## Ambientes de Formación

* Aula convencional.
* Aula móvil.
* Aula virtual.

## Ambientes Tecnológicos

* Sala de sistemas.
* Laboratorio de software.
* Laboratorio de redes.
* Laboratorio de inteligencia artificial.

## Ambientes Especializados

* Taller industrial.
* Laboratorio electrónico.
* Laboratorio de automatización.
* Laboratorio de química.
* Laboratorio de física.

## Ambientes Administrativos

* Sala de reuniones.
* Auditorio.
* Sala de conferencias.

---

# Reglas de Negocio para Ambientes

## RN-001

Todo ambiente debe pertenecer a una sede y centro de formación.

## RN-002

El código del ambiente debe ser único dentro del centro de formación.

## RN-003

Un ambiente solo podrá estar activo o inactivo.

## RN-004

Un ambiente en mantenimiento no podrá ser asignado a horarios.

## RN-005

Un ambiente fuera de servicio no podrá ser reservado.

## RN-006

La capacidad máxima del ambiente no podrá ser superada por la cantidad de aprendices programados.

## RN-007

Los ambientes especializados solo podrán ser asignados a programas que requieran dichas características.

## RN-008

Toda modificación de información deberá quedar registrada en auditoría.

---

# Gestión de Inventario

## Definición

Permite administrar los recursos físicos y tecnológicos disponibles en cada ambiente.

## Categorías de Inventario

### Equipos Tecnológicos

* Computadores.
* Portátiles.
* Servidores.
* Impresoras.
* Escáneres.
* Tablets.

### Equipos Audiovisuales

* Video Beam.
* Pantallas.
* Televisores.
* Sistemas de sonido.

### Equipos Especializados

* PLC.
* Equipos CNC.
* Sensores.
* Equipos de laboratorio.

### Mobiliario

* Mesas.
* Sillas.
* Escritorios.
* Archivadores.

---

# Información del Recurso

## Datos Básicos

* Código de inventario.
* Número de placa.
* Serial.
* Nombre.
* Marca.
* Modelo.
* Categoría.

## Datos Administrativos

* Fecha de adquisición.
* Valor de compra.
* Proveedor.
* Garantía.

## Estado

* Nuevo.
* Operativo.
* En mantenimiento.
* Dañado.
* Dado de baja.

---

# Reglas de Negocio para Inventario

## RN-009

Todo recurso debe tener un identificador único.

## RN-010

Todo recurso debe pertenecer a una categoría.

## RN-011

Todo recurso debe estar asociado a un ambiente o almacén.

## RN-012

Un recurso dado de baja no podrá ser asignado.

## RN-013

Los cambios de ubicación deben registrarse en auditoría.

## RN-014

No se permitirá eliminar recursos con historial de uso.

## RN-015

Los recursos en mantenimiento no podrán ser utilizados en programación académica.

---

# Mantenimiento

## Objetivo

Gestionar actividades preventivas y correctivas sobre ambientes y recursos.

## Tipos

### Preventivo

Actividades programadas para evitar fallas.

### Correctivo

Actividades realizadas para solucionar fallas existentes.

---

# Reglas de Negocio para Mantenimiento

## RN-016

Todo mantenimiento debe estar asociado a un responsable.

## RN-017

Durante un mantenimiento activo el ambiente quedará bloqueado.

## RN-018

Todo mantenimiento debe generar trazabilidad histórica.

## RN-019

Al finalizar un mantenimiento debe actualizarse el estado del recurso o ambiente.

---

# Reservas y Disponibilidad

## Objetivo

Permitir la asignación de ambientes para actividades académicas e institucionales.

## Reglas de Negocio

### RN-020

No se podrán realizar reservas sobre ambientes ocupados.

### RN-021

No se podrán generar reservas sobre ambientes en mantenimiento.

### RN-022

Las reservas deben respetar la capacidad máxima del ambiente.

### RN-023

Los conflictos de horario deben ser detectados automáticamente.

### RN-024

Toda reserva deberá estar asociada a una ficha, instructor o evento institucional.

---

# Integración con Otros Módulos

## Estructura Institucional

Obtiene regionales, centros y sedes.

## Programas de Formación

Determina los tipos de ambientes requeridos para la ejecución de competencias y resultados de aprendizaje.

## Oferta y Fichas

Permite asignar ambientes a grupos de formación.

## Instructores

Asocia instructores a ambientes programados.

## Horarios

Consulta disponibilidad y bloqueos.

## Auditoría

Registra cambios realizados sobre infraestructura e inventario.

---

# Indicadores de Gestión

* Porcentaje de ocupación de ambientes.
* Porcentaje de utilización de recursos.
* Ambientes disponibles por centro.
* Equipos en mantenimiento.
* Equipos fuera de servicio.
* Costos de mantenimiento.
* Tasa de uso por programa de formación.
* Disponibilidad institucional.
