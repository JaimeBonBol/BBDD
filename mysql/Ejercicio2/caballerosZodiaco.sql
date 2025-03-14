DROP DATABASE IF EXISTS CaballerosDelZodiaco;

CREATE DATABASE IF NOT EXISTS CaballerosDelZodiaco;
USE CaballerosDelZodiaco;

CREATE TABLE IF NOT EXISTS Constelaciones(
    ID INT AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Descripcion VARCHAR(250),
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS Caballeros_del_Zodiaco(
    ID INT AUTO_INCREMENT,
    Nombre VARCHAR(100),
    SignoZodiacal VARCHAR(100),
    ConstelacionID INT,
    PRIMARY KEY (ID),
    FOREIGN KEY (ConstelacionID) REFERENCES Constelaciones(ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Constelaciones (Nombre, Descripcion)
VALUES
("Andromeda", "Se halla al sur del ecuador de nuestra galaxia"),
("Apus", "Constelación del sur"),
("Aquarius", "Ninguna estrella de magnitud 3"),
("Eagle", "Pequeña pero hermosa"),
("Altar", "Conocida como Ara");

INSERT INTO Caballeros_del_Zodiaco (Nombre, SignoZodiacal, ConstelacionID)
VALUES
("Mu", "Aries", 1),
("Milo", "Escorpio", 2),
("Aldebarán", "Tauro", 3),
("Camus", "Acuario", 4),
("Shaka", "Virgo", 5);

ALTER TABLE Caballeros_del_Zodiaco
CHANGE COLUMN SignoZodiacal Zodiaco VARCHAR(100);

ALTER TABLE Constelaciones
ADD Estrella_Principal VARCHAR(100);

ALTER TABLE Caballeros_del_Zodiaco
RENAME TO Caballeros;

ALTER TABLE Caballeros
MODIFY COLUMN Nombre VARCHAR(100) NOT NULL;

UPDATE Constelaciones
SET Descripcion = "Andrómeda es una constelación del hemisferio norte, cerca del Polo Norte Celeste, conocida por su vínculo con la mitología griega y la galaxia de Andrómeda (M31), una de las más grandes y brillantes observables desde la Tierra."
WHERE Nombre = "Andromeda";