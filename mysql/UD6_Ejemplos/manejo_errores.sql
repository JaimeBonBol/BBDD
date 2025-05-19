DROP DATABASE IF EXISTS tienda;
CREATE DATABASE IF NOT EXISTS tienda;
USE tienda;

CREATE TABLE IF NOT EXISTS productos(
    id INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    stock INT DEFAULT 0,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS log_errores (
    id INT AUTO_INCREMENT,
    mensaje_error VARCHAR(255),
    procedimiento VARCHAR(100),
    PRIMARY KEY (id)
);


DELIMITER //
CREATE PROCEDURE insertar_productos(IN p_id INT, IN p_nombre VARCHAR(255))
BEGIN
    INSERT INTO productos (id, nombre) VALUES (p_id, p_nombre);
END //
DELIMITER ;

CALL insertar_productos(1, "Libro");
CALL insertar_productos(2, "Monitor");
CALL insertar_productos(3, "Estuche");

SELECT * FROM productos;



DELIMITER //
CREATE PROCEDURE insertar_producto(IN p_id INT, IN p_nombre VARCHAR(255))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO log_errores (mensaje_error, procedimiento)
        VALUES ('Error durante la inserción de datos', 'actualizar_stock');
        SELECT 'Ha ocurrido un error durante la inserción de datos.' AS mensaje;
    END;

    INSERT INTO productos (id, nombre) VALUES (p_id, p_nombre);
END //
DELIMITER ;

CALL insertar_producto(1, "Libro");



DELIMITER //

CREATE PROCEDURE actualizar_stock(IN p_id INT, IN p_stock INT)
BEGIN
    IF p_stock < 0 THEN
        INSERT INTO log_errores (mensaje_error, procedimiento)
        VALUES ('El stock no puede ser negativo', 'insertar_producto');
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El stock no puede ser negativo.';
    END IF;

    UPDATE productos SET stock = p_stock WHERE id = p_id;
END //

DELIMITER ;


CALL actualizar_stock(2, 5);
CALL actualizar_stock(2, -1);

SELECT * FROM productos;

SELECT * FROM log_errores;