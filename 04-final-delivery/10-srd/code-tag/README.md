# Código, tags y copias de respaldo — SRD

## Repositorios originales de trabajo

SRD se reorganizó en cinco repositorios independientes. Se conserva SRD-v1 como índice y repositorio histórico. El instructor debe poder contrastar todos los originales con la entrega.

| Componente | Repositorio | Visibilidad comprobada | Acceso `ariel5253` | Tag `final-delivery-2026` | ZIP de main | ZIP completo |
|---|---|---|---|---|---|---|
| Histórico/índice | [jsgh1/SRD-v1](https://github.com/jsgh1/SRD-v1) | Público | Lectura; **solicita escritura** | Pendiente | Pendiente | Pendiente |
| Backend | [jsgh1/SRD-Backend](https://github.com/jsgh1/SRD-Backend) | Público | Lectura; **solicita escritura** | Pendiente | Pendiente | Pendiente |
| Frontend web/móvil/escritorio | [jsgh1/SRD-Frontend](https://github.com/jsgh1/SRD-Frontend) | Público | Lectura; **solicita escritura** | Pendiente | Pendiente | Pendiente |
| Bases de datos | [jsgh1/SRD-Database](https://github.com/jsgh1/SRD-Database) | Público | Lectura; **solicita escritura** | Pendiente | Pendiente | Pendiente |
| Infraestructura Docker | [jsgh1/SRD-Docker-Infra](https://github.com/jsgh1/SRD-Docker-Infra) | Público | Lectura; **solicita escritura** | Pendiente | Pendiente | Pendiente |
| Entregables documentales | [jsgh1/SRD-Docs](https://github.com/jsgh1/SRD-Docs) | Público | Lectura; **solicita escritura** | Pendiente | Pendiente | Pendiente |

**Auditoría del 5 de noviembre de 2026:** los seis repositorios figuran públicos. La consulta de permisos de `ariel5253` devolvió `read` en cada uno. La guía pide permiso de escritura y debe configurarse por un propietario del repositorio.

## Política de versiones

1. Integrar cambios **validados** de `dev` a `main` mediante PR y pruebas, sin commits directos a ramas principales.
2. Comprobar archivos e historial en busca de contraseñas, tokens, llaves y `.env` reales. Rotar cualquier secreto expuesto antes de difundir respaldos.
3. En cada repositorio crear un tag **anotado** llamado `final-delivery-2026` sobre el commit final de `main`.
4. Generar por repositorio `<repo>-final-delivery-2026-main.zip` (árbol exacto del tag) y `<repo>-full-export.zip` (todas las referencias y el historial).
5. Cargar los ZIP al **Release `final-delivery` de este fork**, no al Pull Request; enlazar sus URL en esta tabla.
6. Registrar el SHA-256 real de cada ZIP en [SHA256SUMS.txt](SHA256SUMS.txt). No declarar hashes antes de generar los archivos.

## Estado actual

**Pendiente de congelación del código.** La comparación remota mostró que `dev` contiene cambios aún no integrados en `main` en los cinco repositorios separados. No se crearon tags ni archivos ZIP, y no se declara esta tarea como terminada.

Enlaces de trabajo: [Backend/dev](https://github.com/jsgh1/SRD-Backend/tree/dev), [Frontend/dev](https://github.com/jsgh1/SRD-Frontend/tree/dev), [Database/dev](https://github.com/jsgh1/SRD-Database/tree/dev), [Docker-Infra/dev](https://github.com/jsgh1/SRD-Docker-Infra/tree/dev), [Docs/dev](https://github.com/jsgh1/SRD-Docs/tree/dev).
