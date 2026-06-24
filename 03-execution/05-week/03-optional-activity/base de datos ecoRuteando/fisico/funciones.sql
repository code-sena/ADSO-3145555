CREATE OR REPLACE FUNCTION registrar_usuario(p_nombre VARCHAR, p_correo VARCHAR, p_pass VARCHAR)
RETURNS VOID AS $$
BEGIN
    INSERT INTO usuarios(nombre, correo, password_hash, acepto_terminos)
    VALUES (p_nombre, p_correo, p_pass, TRUE);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION crear_ruta(p_nombre VARCHAR, p_inicio VARCHAR, p_destino VARCHAR)
RETURNS VOID AS $$
BEGIN
    INSERT INTO rutas(nombre,punto_inicio,punto_destino,fecha)
    VALUES (p_nombre,p_inicio,p_destino,CURRENT_DATE);
END;
$$ LANGUAGE plpgsql;
