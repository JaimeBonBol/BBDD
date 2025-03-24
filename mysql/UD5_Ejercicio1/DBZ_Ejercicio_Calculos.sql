DROP DATABASE IF EXISTS DBZ_Ejercicio_Calculos;
CREATE DATABASE IF NOT EXISTS DBZ_Ejercicio_Calculos;
USE DBZ_Ejercicio_Calculos;

CREATE TABLE IF NOT EXISTS Guerreros(
    id_guerrero INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    raza VARCHAR(100),
    nivel_poder INT,
    cantidad_transformaciones INT,
    PRIMARY KEY (id_guerrero)
);

INSERT INTO Guerreros (nombre, raza, nivel_poder, cantidad_transformaciones)
VALUES
("Goku", "Saiyan", 9000, 6),
("Vegeta", "Saiyan", 8500, 4),
("Gohan", "Saiyan", 8000, 4),
("Piccolo", "Namekiano", 7000, 1),
("Trunks", "Saiyan", 7500, 2),
("Freezer", "Emperador del mal", 10000, 5),
("Cell", "Bio_Androide", 8500, 3),
("Majin Buu", "Majin", 8000, 3),
("Goten", "Saiyan", 6000, 1),
("Krilin", "Humano", 5000, 0);

SELECT * FROM Guerreros;

SELECT nombre, nivel_poder, cantidad_transformaciones,
    CASE
        WHEN cantidad_transformaciones > 0 AND raza = 'Saiyan' THEN '¡Super Saiyan!'
        WHEN cantidad_transformaciones = 0 THEN 'Sin Transformaciones'
    END AS estado_transformacion
FROM Guerreros;


SELECT nombre, nivel_poder, cantidad_transformaciones,
    CASE 
        WHEN cantidad_transformaciones > 0 AND raza = 'Saiyan' THEN '¡Super Saiyan!'
        WHEN cantidad_transformaciones = 0 THEN 'Sin Transformaciones'
        ELSE nombre
    END AS estado_transformacion
FROM Guerreros;