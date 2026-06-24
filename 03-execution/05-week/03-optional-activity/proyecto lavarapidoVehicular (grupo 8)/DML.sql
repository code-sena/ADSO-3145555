/* =================================================================
   PROYECTO : Lava Rápido Vehicular
   ARCHIVO  : Datos de prueba corregidos
   VERSIÓN  : 3.1
   CORRECCIONES:
     - Eliminado bloque duplicado de INSERT en usuario (operadores 4-10)
     - Corregido tipo_vehiculo a solo 'carro' y 'moto'
     - Orden de ejecución corregido respetando todas las FKs
   ================================================================= */


/* =================================================================
   SECCIÓN 3 — DATOS INICIALES DEL MARCO DE SEGURIDAD
   ================================================================= */

INSERT INTO roles (nombre_rol, descripcion) VALUES
    ('admin',    'Administra servicios, usuarios y configuración general'),
    ('operador', 'Ejecuta servicios de lavado asignados'),
    ('cliente',  'Solicita y paga servicios de lavado');

INSERT INTO permisos (nombre_permiso, descripcion) VALUES
    ('gestionar_servicios',  'Crear, editar y eliminar servicios del catálogo'),
    ('ver_reservas',         'Consultar listado completo de reservas'),
    ('asignar_operador',     'Asignar un operador a una reserva pendiente'),
    ('cancelar_reserva',     'Cancelar una reserva activa'),
    ('procesar_pago',        'Iniciar y confirmar transacciones con Wompi'),
    ('calificar_servicio',   'Enviar puntuación y comentario de una reserva'),
    ('gestionar_usuarios',   'Crear, activar y desactivar cuentas de usuario'),
    ('ver_auditoria',        'Consultar registros de auditoría y log de errores'),
    ('actualizar_ubicacion', 'Actualizar ubicación en tiempo real durante servicio'),
    ('ver_disponibilidad',   'Consultar disponibilidad de operadores');

INSERT INTO configuracion_seguridad (nombre_config, valor_config, descripcion) VALUES
    ('max_intentos_login',       '5',    'Intentos fallidos antes de bloquear la cuenta'),
    ('bloqueo_cuenta_minutos',   '30',   'Minutos de bloqueo tras superar intentos fallidos'),
    ('tiempo_expiracion_sesion', '3600', 'Segundos de inactividad antes de expirar sesión'),
    ('requiere_2fa',             'false','Activar doble factor de autenticación');

INSERT INTO politicas_contrasenas
    (min_longitud, max_longitud, requiere_mayusculas, requiere_minusculas,
     requiere_numeros, requiere_simbolos, caducidad_dias, activa)
VALUES
    (8, 20, TRUE, TRUE, TRUE, FALSE, 90, TRUE);


/* =================================================================
   TABLA: usuario
   3 admins (id 1-3), 3 operadores base (id 4-6),
   4 clientes (id 7-10), 7 operadores extra (id 11-17)
   Todo en un solo bloque para evitar duplicados.
   ================================================================= */
INSERT INTO usuario (correo, nombre, apellido, telefono, contrasena, documento, tipo_usuario, estado) VALUES
    ('admin1@lavarapido.com',     'José',      'Motta',     '3001234567', '$2b$12$hashed_admin1',    '12345678',  'admin',    TRUE),
    ('admin2@lavarapido.com',     'María',     'Vargas',    '3009876543', '$2b$12$hashed_admin2',    '87654321',  'admin',    TRUE),
    ('admin3@lavarapido.com',     'Carlos',    'Rueda',     '3101112233', '$2b$12$hashed_admin3',    '11223344',  'admin',    TRUE),
    ('operador1@lavarapido.com',  'Stiven',    'Perdomo',   '3112223344', '$2b$12$hashed_oper1',     '55667788',  'operador', TRUE),
    ('operador2@lavarapido.com',  'Andrés',    'Cárdenas',  '3123334455', '$2b$12$hashed_oper2',     '99887766',  'operador', TRUE),
    ('operador3@lavarapido.com',  'Luis',      'Fandiño',   '3134445566', '$2b$12$hashed_oper3',     '44332211',  'operador', TRUE),
    ('cliente1@gmail.com',        'Santiago',  'Gordo',     '3145556677', '$2b$12$hashed_cli1',      '22334455',  'cliente',  TRUE),
    ('cliente2@gmail.com',        'Valentina', 'Torres',    '3156667788', '$2b$12$hashed_cli2',      '66778899',  'cliente',  TRUE),
    ('cliente3@gmail.com',        'Felipe',    'Morales',   '3167778899', '$2b$12$hashed_cli3',      '33445566',  'cliente',  TRUE),
    ('cliente4@gmail.com',        'Daniela',   'Quintero',  '3178889900', '$2b$12$hashed_cli4',      '77889900',  'cliente',  TRUE),
    ('operador4@lavarapido.com',  'Camilo',    'Suárez',    '3189990011', '$2b$12$hashed_oper4',     '12312312',  'operador', TRUE),
    ('operador5@lavarapido.com',  'Jhon',      'Pedraza',   '3190001122', '$2b$12$hashed_oper5',     '23423423',  'operador', TRUE),
    ('operador6@lavarapido.com',  'Brayan',    'Niño',      '3200112233', '$2b$12$hashed_oper6',     '34534534',  'operador', TRUE),
    ('operador7@lavarapido.com',  'Esteban',   'Vargas',    '3211223344', '$2b$12$hashed_oper7',     '45645645',  'operador', TRUE),
    ('operador8@lavarapido.com',  'David',     'Fuentes',   '3222334455', '$2b$12$hashed_oper8',     '56756756',  'operador', TRUE),
    ('operador9@lavarapido.com',  'Manuel',    'Díaz',      '3233445566', '$2b$12$hashed_oper9',     '67867867',  'operador', TRUE),
    ('operador10@lavarapido.com', 'Sebastián', 'Arenas',    '3244556677', '$2b$12$hashed_oper10',    '78978978',  'operador', TRUE);


/* =================================================================
   TABLA: vehiculos
   tipo_vehiculo solo acepta 'carro' o 'moto'
   ================================================================= */
INSERT INTO vehiculos (fk_id_usuario, placa, marca, color, tipo_vehiculo, estado) VALUES
    (7,  'ABC123', 'Chevrolet', 'Blanco',   'moto',  TRUE),
    (7,  'XYZ789', 'Renault',   'Gris',     'carro', TRUE),
    (8,  'DEF456', 'Mazda',     'Negro',    'moto',  TRUE),
    (8,  'GHI012', 'Toyota',    'Rojo',     'moto',  TRUE),
    (9,  'JKL345', 'Kia',       'Azul',     'carro', TRUE),
    (9,  'MNO678', 'Hyundai',   'Blanco',   'moto',  TRUE),
    (10, 'PQR901', 'Ford',      'Negro',    'carro', TRUE),
    (10, 'STU234', 'Nissan',    'Plateado', 'moto',  TRUE),
    (7,  'VWX567', 'Volkswagen','Verde',    'moto',  TRUE),
    (9,  'YZA890', 'Suzuki',    'Naranja',  'carro', TRUE);


/* =================================================================
   TABLA: ubicacion
   ================================================================= */
INSERT INTO ubicacion (nombre, ciudad, departamento, latitud, longitud, estado) VALUES
    ('Cabecera del Llano', 'Bucaramanga', 'Santander',  7.1193700, -73.1227800, TRUE),
    ('El Centro',          'Bucaramanga', 'Santander',  7.1197500, -73.1136100, TRUE),
    ('Sotomayor',          'Bucaramanga', 'Santander',  7.1135200, -73.1198400, TRUE),
    ('La Rosita',          'Bucaramanga', 'Santander',  7.1268900, -73.1154300, TRUE),
    ('Álvarez',            'Bucaramanga', 'Santander',  7.1072300, -73.1243700, TRUE),
    ('San Francisco',      'Bucaramanga', 'Santander',  7.1310500, -73.1289600, TRUE),
    ('El Jardín',          'Bucaramanga', 'Santander',  7.1058700, -73.1178200, TRUE),
    ('Lagos del Cacique',  'Bucaramanga', 'Santander',  7.0987400, -73.1312500, TRUE),
    ('Provenza',           'Bucaramanga', 'Santander',  7.1224100, -73.1301800, TRUE),
    ('Antonia Santos',     'Bucaramanga', 'Santander',  7.1145600, -73.1089300, TRUE);


/* =================================================================
   TABLA: cliente_ubicacion
   ================================================================= */
INSERT INTO cliente_ubicacion (fk_id_usuario, fk_id_ubicacion, direccion_detallada, referencia, estado) VALUES
    (7,  1,  'Cra 33 # 48-12 Apto 301',   'Edificio Torres del Parque',    TRUE),
    (7,  2,  'Cll 36 # 20-45 Casa 5',      'Frente al parque principal',    TRUE),
    (8,  3,  'Cra 27 # 51-80',             'Casa esquinera color amarilla', TRUE),
    (8,  4,  'Cll 52 # 30-10 Apto 202',    'Conjunto Los Pinos entrada 2',  TRUE),
    (9,  5,  'Cra 15 # 44-22',             'Al lado de la farmacia',        TRUE),
    (9,  6,  'Cll 45 # 18-60 Casa 8',      'Portón negro segunda cuadra',   TRUE),
    (10, 7,  'Cra 22 # 39-15',             'Casa blanca con jardín',        TRUE),
    (10, 8,  'Cll 40 # 25-90 Apto 105',    'Torre B primer piso',           TRUE),
    (7,  9,  'Cra 38 # 50-34 Oficina 401', 'Edificio Empresarial Centro',   TRUE),
    (10, 10, 'Cll 31 # 12-50',             'Cerca al CAI del barrio',       TRUE);


/* =================================================================
   TABLA: servicios
   ================================================================= */
INSERT INTO servicios (nombre, descripcion, precio, duracion_minutos, estado) VALUES
    ('Lavado básico exterior',      'Lavado con agua y jabón de carrocería exterior',         25000.00, 30,  TRUE),
    ('Lavado completo',             'Exterior e interior, aspirado y aromatizado',            45000.00, 60,  TRUE),
    ('Lavado premium',              'Completo más encerado y brillado de llantas',            75000.00, 90,  TRUE),
    ('Lavado de motor',             'Desengrase y limpieza profunda del motor',               55000.00, 45,  TRUE),
    ('Lavado de tapicería',         'Extracción de manchas y limpieza de sillas y techo',    65000.00, 75,  TRUE),
    ('Lavado de camioneta básico',  'Exterior para vehículos tipo pickup o camioneta',        35000.00, 40,  TRUE),
    ('Lavado de camioneta full',    'Completo para pickup o camioneta con aspirado',          60000.00, 80,  TRUE),
    ('Descontaminación de pintura', 'Remoción de contaminantes adheridos a la carrocería',   85000.00, 100, TRUE),
    ('Lavado rápido express',       'Solo exterior sin secado, para emergencias',             15000.00, 15,  TRUE),
    ('Pulida y brillada',           'Pulido de carrocería y aplicación de cera protectora', 110000.00, 120, TRUE);


/* =================================================================
   TABLA: operadores
   id_usuario 4-6 son los 3 operadores base
   id_usuario 11-17 son los 7 operadores extra
   ================================================================= */
INSERT INTO operadores (fk_id_usuario, estado) VALUES
    (4,  TRUE),
    (5,  TRUE),
    (6,  TRUE),
    (11, TRUE),
    (12, TRUE),
    (13, TRUE),
    (14, TRUE),
    (15, TRUE),
    (16, TRUE),
    (17, TRUE);


/* =================================================================
   TABLA: disponibilidad
   ================================================================= */
INSERT INTO disponibilidad (fk_id_operador, dia_semana, disponible, hora_inicio, hora_fin) VALUES
    (1, 'lunes',     TRUE, '07:00', '15:00'),
    (1, 'martes',    TRUE, '07:00', '15:00'),
    (2, 'miercoles', TRUE, '08:00', '16:00'),
    (2, 'jueves',    TRUE, '08:00', '16:00'),
    (3, 'viernes',   TRUE, '09:00', '17:00'),
    (3, 'sabado',    TRUE, '08:00', '14:00'),
    (4, 'lunes',     TRUE, '10:00', '18:00'),
    (4, 'miercoles', TRUE, '10:00', '18:00'),
    (5, 'martes',    TRUE, '06:00', '14:00'),
    (5, 'sabado',    TRUE, '07:00', '13:00');


/* =================================================================
   TABLA: reservas
   ================================================================= */
INSERT INTO reservas (fk_id_usuario, fk_id_vehiculo, fk_id_direccion, fk_id_servicio, fecha_reserva, hora_reserva, estado, subtotal, total) VALUES
    (7,  1,  1, 1,  '2025-03-01', '08:00', 'finalizada',  25000.00,  25000.00),
    (7,  2,  2, 2,  '2025-03-05', '09:30', 'finalizada',  45000.00,  45000.00),
    (8,  3,  3, 3,  '2025-03-08', '10:00', 'finalizada',  75000.00,  75000.00),
    (8,  4,  4, 5,  '2025-03-10', '11:00', 'cancelada',   65000.00,  65000.00),
    (9,  5,  5, 2,  '2025-03-12', '14:00', 'finalizada',  45000.00,  45000.00),
    (9,  6,  6, 4,  '2025-03-15', '08:30', 'en_proceso',  55000.00,  55000.00),
    (10, 7,  7, 1,  '2025-03-18', '07:00', 'asignada',    25000.00,  25000.00),
    (10, 8,  8, 6,  '2025-03-20', '09:00', 'pendiente',   35000.00,  35000.00),
    (7,  9,  9, 9,  '2025-03-21', '10:30', 'pendiente',   15000.00,  15000.00),
    (9,  10, 5, 10, '2025-03-22', '15:00', 'pendiente',  110000.00, 110000.00);


/* =================================================================
   TABLA: asignaciones
   ================================================================= */
INSERT INTO asignaciones (fk_id_reserva, fk_id_operador, llegada_estimada, estado) VALUES
    (1, 1, '2025-03-01 08:10:00', 'completada'),
    (2, 2, '2025-03-05 09:45:00', 'completada'),
    (3, 3, '2025-03-08 10:15:00', 'completada'),
    (4, 4, '2025-03-10 11:20:00', 'cancelada'),
    (5, 5, '2025-03-12 14:10:00', 'completada'),
    (6, 1, '2025-03-15 08:45:00', 'aceptada'),
    (7, 2, '2025-03-18 07:15:00', 'asignada'),
    (8, 3, '2025-03-20 09:10:00', 'asignada'),
    (9, 4, '2025-03-21 10:45:00', 'asignada'),
    (5, 5, '2025-03-12 14:05:00', 'completada');


/* =================================================================
   TABLA: pagos
   ================================================================= */
INSERT INTO pagos (fk_id_reserva, metodo_pago, referencia_pago, estado_wompi, monto, estado, fecha_pago) VALUES
    (1, 'online', 'WOMPI-REF-001', 'APPROVED', 25000.00,  'aprobado',  '2025-03-01 07:55:00'),
    (2, 'online', 'WOMPI-REF-002', 'APPROVED', 45000.00,  'aprobado',  '2025-03-05 09:25:00'),
    (3, 'online', 'WOMPI-REF-003', 'APPROVED', 75000.00,  'aprobado',  '2025-03-08 09:55:00'),
    (4, 'online', 'WOMPI-REF-004', 'DECLINED', 65000.00,  'rechazado', '2025-03-10 10:58:00'),
    (5, 'online', 'WOMPI-REF-005', 'APPROVED', 45000.00,  'aprobado',  '2025-03-12 13:55:00'),
    (6, 'online', 'WOMPI-REF-006', 'APPROVED', 55000.00,  'aprobado',  '2025-03-15 08:25:00'),
    (7, 'online', 'WOMPI-REF-007', 'APPROVED', 25000.00,  'aprobado',  '2025-03-18 06:58:00'),
    (8, 'online', 'WOMPI-REF-008', 'DECLINED', 35000.00,  'rechazado', '2025-03-20 08:55:00'),
    (8, 'online', 'WOMPI-REF-009', 'APPROVED', 35000.00,  'aprobado',  '2025-03-20 09:02:00'),
    (9, 'online', 'WOMPI-REF-010', 'PENDING',  15000.00,  'pendiente', '2025-03-21 10:28:00');


/* =================================================================
   TABLA: calificaciones
   Solo reservas con estado 'finalizada' (ids 1, 2, 3, 5)
   ================================================================= */
INSERT INTO calificaciones (fk_id_reserva, fk_id_usuario, fk_id_operador, puntuacion, comentario) VALUES
    (1, 7, 1, 5, 'Excelente servicio, muy puntual y dejó el carro impecable.'),
    (2, 7, 2, 4, 'Buen trabajo, solo tardó un poco más de lo esperado.'),
    (3, 8, 3, 5, 'El mejor lavado que le han hecho a mi camioneta, muy recomendado.'),
    (5, 9, 5, 4, 'Muy buen servicio, el operador fue amable y cuidadoso.');


/* =================================================================
   TABLA: usuario_rol
   ================================================================= */
INSERT INTO usuario_rol (fk_id_usuario, fk_id_rol) VALUES
    (1,  1),
    (2,  1),
    (3,  1),
    (4,  2),
    (5,  2),
    (6,  2),
    (7,  3),
    (8,  3),
    (9,  3),
    (10, 3);


/* =================================================================
   TABLA: rol_permiso
   admin    → todos los permisos (ids 1-10)
   operador → ver_reservas(2), actualizar_ubicacion(9), ver_disponibilidad(10)
   cliente  → cancelar_reserva(4), procesar_pago(5), calificar_servicio(6)
   ================================================================= */
INSERT INTO rol_permiso (fk_id_rol, fk_id_permiso) VALUES
    (1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
    (1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
    (2, 2),
    (2, 9),
    (2, 10),
    (3, 4),
    (3, 5),
    (3, 6);


/* =================================================================
   TABLA: sesion_usuario
   ================================================================= */
INSERT INTO sesion_usuario (fk_id_usuario, fecha_inicio, fecha_fin, ip_origen, estado_sesion) VALUES
    (1,  '2025-03-01 07:00:00', '2025-03-01 09:00:00', '190.27.45.12',  'cerrada'),
    (4,  '2025-03-01 07:45:00', '2025-03-01 15:30:00', '181.53.22.88',  'cerrada'),
    (7,  '2025-03-01 07:50:00', '2025-03-01 08:10:00', '200.118.34.56', 'cerrada'),
    (8,  '2025-03-08 09:30:00', '2025-03-08 10:20:00', '192.168.1.102', 'cerrada'),
    (9,  '2025-03-12 13:45:00', '2025-03-12 14:20:00', '181.62.77.34',  'cerrada'),
    (2,  '2025-03-15 08:00:00', '2025-03-15 12:00:00', '190.27.45.99',  'cerrada'),
    (5,  '2025-03-15 08:20:00', '2025-03-15 16:10:00', '181.53.22.45',  'cerrada'),
    (10, '2025-03-18 06:50:00', '2025-03-18 07:10:00', '200.118.34.78', 'cerrada'),
    (7,  '2025-03-21 10:00:00', NULL,                  '200.118.34.56', 'activa'),
    (3,  '2025-03-21 09:30:00', NULL,                  '190.27.46.11',  'activa');


/* =================================================================
   TABLA: auditoria
   ================================================================= */
INSERT INTO auditoria (fk_id_usuario, accion, descripcion, ip_origen, modulo) VALUES
    (1,  'crear_servicio',      'Se creó el servicio Lavado básico exterior con precio 25000',   '190.27.45.12',  'admin_servicios'),
    (1,  'crear_servicio',      'Se creó el servicio Lavado completo con precio 45000',          '190.27.45.12',  'admin_servicios'),
    (2,  'actualizar_servicio', 'Se actualizó precio de Pulida y brillada de 100000 a 110000',  '190.27.45.99',  'admin_servicios'),
    (7,  'crear_reserva',       'Cliente creó reserva id 1 para lavado básico exterior',         '200.118.34.56', 'app_cliente'),
    (4,  'aceptar_asignacion',  'Operador aceptó asignación de reserva id 1',                   '181.53.22.88',  'app_operador'),
    (7,  'realizar_pago',       'Pago WOMPI-REF-001 aprobado por 25000 para reserva id 1',      '200.118.34.56', 'app_cliente'),
    (7,  'calificar_servicio',  'Cliente calificó reserva id 1 con puntuación 5',               '200.118.34.56', 'app_cliente'),
    (8,  'crear_reserva',       'Cliente creó reserva id 3 para lavado premium',                '192.168.1.102', 'app_cliente'),
    (3,  'desactivar_usuario',  'Admin desactivó cuenta de usuario por inactividad prolongada', '190.27.46.11',  'admin_usuarios'),
    (2,  'eliminar_servicio',   'Admin eliminó servicio descontinuado del catálogo',            '190.27.45.99',  'admin_servicios');


/* =================================================================
   TABLA: log_errores
   ================================================================= */
INSERT INTO log_errores (fk_id_usuario, tipo_error, descripcion, ip_origen) VALUES
    (7,    'pago_rechazado',      'Wompi retornó DECLINED para referencia WOMPI-REF-004, reserva id 4', '200.118.34.56'),
    (8,    'pago_rechazado',      'Wompi retornó DECLINED para referencia WOMPI-REF-008, reserva id 8', '192.168.1.102'),
    (NULL, 'login_fallido',       'Intento de acceso fallido con correo desconocido: hack@test.com',    '45.33.32.156'),
    (7,    'login_fallido',       'Contraseña incorrecta en intento de login para cliente1@gmail.com',  '200.118.34.56'),
    (7,    'login_fallido',       'Segundo intento fallido de login para cliente1@gmail.com',           '200.118.34.56'),
    (NULL, 'timeout_conexion',    'El servidor no respondió en 30s durante consulta de disponibilidad', '181.62.77.34'),
    (4,    'gps_no_disponible',   'No se pudo obtener coordenadas GPS del dispositivo del operador',    '181.53.22.88'),
    (9,    'sesion_expirada',     'Sesión expirada por inactividad, usuario redirigido al login',       '181.62.77.34'),
    (NULL, 'wompi_timeout',       'Wompi no respondió en 10s durante validación de transacción',        '200.118.34.78'),
    (10,   'formulario_invalido', 'El cliente envió fecha de reserva anterior a la fecha actual',       '200.118.34.78');
