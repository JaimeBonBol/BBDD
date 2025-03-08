DROP DATABASE IF EXISTS TorneosDragonBall;
/*Creación de base de datos TorneosDragonBall.*/
CREATE DATABASE IF NOT EXISTS TorneosDragonBall;
USE TorneosDragonBall;

/*Creación de tabla Torneos.*/
CREATE TABLE IF NOT EXISTS Torneos(
    id_torneo INT AUTO_INCREMENT,
    nombre VARCHAR(100) UNIQUE,
    ubicacion VARCHAR(100),
    fecha_inicio DATE,
    fecha_fin DATE NULL,
    PRIMARY KEY (id_torneo)
);

/*Creación de tabla Participantes.*/
CREATE TABLE IF NOT EXISTS Participantes(
    id_participante INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    edad INT CHECK (edad > 18 AND edad < 150),
    raza VARCHAR(30),
    id_torneo INT,
    PRIMARY KEY (id_participante),
    FOREIGN KEY (id_torneo) REFERENCES Torneos(id_torneo)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/*Insertar datos en la tabla Torneos.*/
INSERT INTO Torneos (nombre, ubicacion, fecha_inicio)
VALUES
("Torneo1", "Cordoba", '2025-03-07'),
("Torneo2", "Malaga", '2025-03-14'),
("Torneo3", "Granada", '2025-03-21');

/*Insertar datos en la tabla Participantes.*/
INSERT INTO Participantes (nombre, edad, raza, id_torneo)
VALUES
("Manuel", "20", "Humano", 1),
("Pepe", 24, "Humano", 2),
("Lola", 30, "Humano", 3);

/*Actualizar ubicacones de torneos.*/
UPDATE Torneos
SET ubicacion = 'Sevilla'
WHERE ubicacion = 'Malaga';

/*Eliminar un torneo.*/
DELETE FROM Torneos
WHERE nombre = 'Torneo1';