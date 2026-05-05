CREATE INDEX idx_usuario_estado ON usuarios(estado);
CREATE INDEX idx_rutas_co2 ON rutas(co2_ahorrado);
CREATE INDEX idx_uso_rutas_usuario ON uso_rutas(id_usuario);
CREATE INDEX idx_reporte_estado ON reporte_obstaculos(estado);
