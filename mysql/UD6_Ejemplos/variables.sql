-- VARIABLES LOCALES:

DELIMITER //

CREATE PROCEDURE ejemplo_variables()
BEGIN
	DECLARE mi_variable INT DEFAULT 10;
	DECLARE otra_variable VARCHAR(50);
    
	SET otra_variable = 'Hola mundo';
    
	-- Puedes usar las variables como parte de tu lógica
	SELECT mi_variable, otra_variable;
END //

DELIMITER ;






--  VARIABLES DE USUARIO (@nombre_variable)

-- Asignamos un valor a una variable de usuario
SET @nombre = 'Juan';

-- Usamos la variable
SELECT CONCAT('Hola ', @nombre);  -- Resultado: 'Hola Juan'

-- Modificamos el valor
SET @nombre = 'Luisa';
SELECT @nombre;  -- Resultado: 'Luisa'






-- VARIABLES DEL SISTEMA (@@nombre_variable)

-- Ver el valor actual de autocommit (a nivel de sesión)
SELECT @@autocommit;  -- Ejemplo: 1 (true)

-- Cambiar autocommit solo para esta sesión
SET @@SESSION.autocommit = 0;

-- Cambiar autocommit a nivel global (requiere privilegios)
SET @@GLOBAL.autocommit = 0;

SET @@SESSION.autocommit = 1;

SET @@GLOBAL.autocommit = 1;


SELECT @@autocommit; 


/*
MÁS EJEMPLOS: 

+ @@autocommit : Controla si cada instrucción SQL se ejecuta y se confirma automáticamente (COMMIT) o si debes confirmar los cambios manualmente.

+ @@max_connections : Define el número máximo de conexiones simultáneas que el servidor MySQL permite.

+ @@time_zone : Define la zona horaria por defecto que utiliza el servidor MySQL para operaciones de fecha y hora.

+ @@sql_mode : Controla el comportamiento del parser y ejecución SQL en MySQL, como si se permiten valores inválidos o cómo se tratan los errores.
*/
