DROP DATABASE IF EXISTS Talleres;
CREATE DATABASE IF NOT EXISTS Talleres;
USE Talleres;

-- La Pk simpre tiene que ser NOT NULL, a no ser que sea AUTO INCREMENT.
CREATE TABLE IF NOT EXISTS COCHES(
    mat VARCHAR(8) NOT NULL,
    marca VARCHAR(15),
    an_fab INT(4),
    PRIMARY KEY (mat)
);

CREATE TABLE IF NOT EXISTS MECANICOS(
    dni VARCHAR(9) NOT NULL,
    nombre VARCHAR(15),
    puesto VARCHAR(15),
    parcial BOOLEAN,
    PRIMARY KEY (dni)
);

CREATE TABLE IF NOT EXISTS TRABAJOS(
    id_trabajo INT AUTO_INCREMENT,
    mat VARCHAR(8),
    dni VARCHAR(9),
    horas FLOAT CHECK(horas > 0.5),
    fecha_rep DATE,
    PRIMARY KEY(id_trabajo),
    FOREIGN KEY (mat) REFERENCES COCHES(mat)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (dni) REFERENCES MECANICOS(dni)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS CLIENTES(
    id_cliente VARCHAR(10) NOT NULL,
    nombre VARCHAR(50),
    telefono INT (15),
    PRIMARY KEY (id_cliente)
);

CREATE TABLE IF NOT EXISTS PIEZAS(
    id_pieza VARCHAR(10) NOT NULL,
    nombre VARCHAR(50),
    precio FLOAT,
    PRIMARY KEY (id_pieza)
);

CREATE TABLE IF NOT EXISTS FACTURAS(
    id_factura VARCHAR(10) NOT NULL,
    id_cliente VARCHAR(10),
    fecha_emision DATE,
    total FLOAT,
    PRIMARY KEY (id_factura),
    FOREIGN KEY(id_cliente) REFERENCES CLIENTES(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


ALTER TABLE COCHES
ADD modelo VARCHAR(50);

-- Primero hay que eliminar la pk.

ALTER TABLE TRABAJOS
DROP COLUMN id_trabajo;

ALTER TABLE TRABAJOS
ADD CONSTRAINT pk_trabajos PRIMARY KEY (mat, dni);

ALTER TABLE COCHES
MODIFY COLUMN an_fab VARCHAR(2);