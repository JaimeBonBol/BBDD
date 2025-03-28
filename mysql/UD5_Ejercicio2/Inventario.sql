DROP DATABASE IF EXISTS Inventario;
CREATE DATABASE Inventario;
USE Inventario;

CREATE TABLE productos(
    id_producto INT NOT NULL,
    nombre_producto VARCHAR(100),
    categoria ENUM('Electrónica', 'Ropa', 'Alimentos', 'Herramientas'),
    stock INT,
    precio_unitario FLOAT,
    PRIMARY KEY (id_producto)
);

INSERT INTO productos VALUES
(1, 'Smartphone', 'Electrónica', 25, 399.99),
(2, 'Camiseta', 'Ropa', 50, 19.99),
(3, 'Leche', 'Alimentos', 100, 1.50),
(4, 'Destornillador', 'Herramientas', 15, 9.99),
(5, 'Portátil', 'Electrónica', 10, 899.99),
(6, 'Pantalones', 'Ropa', 30, 29.99),
(7, 'Manzanas', 'Alimentos', 75, 0.50),
(8, 'Martillo', 'Herramientas', 20, 12.99),
(9, 'Tablet', 'Electrónica', 8, 299.99),
(10, 'Chaqueta', 'Ropa', 20, 49.99),
(11, 'Queso', 'Alimentos', 50, 2.99),
(12, 'Taladro', 'Herramientas', 12, 39.99),
(13, 'Altavoces', 'Electrónica', 18, 149.99),
(14, 'Bufanda', 'Ropa', 40, 14.99),
(15, 'Arroz', 'Alimentos', 90, 1.20),
(16, 'Destapacañerías', 'Herramientas', 5, 7.99),
(17, 'Televisor', 'Electrónica', 6, 699.99),
(18, 'Zapatos', 'Ropa', 35, 39.99),
(19, 'Pan', 'Alimentos', 120, 0.80),
(20, 'Cinta métrica', 'Herramientas', 10, 5.99),
(21, 'Auriculares', 'Electrónica', 22, 79.99),
(22, 'Vestido', 'Ropa', 15, 59.99),
(23, 'Cerveza', 'Alimentos', 65, 1.99),
(24, 'Llave inglesa', 'Herramientas', 8, 8.99),
(25, 'Monitor', 'Electrónica', 9, 199.99),
(26, 'Jersey', 'Ropa', 25, 34.99),
(27, 'Pasta', 'Alimentos', 80, 1.30),
(28, 'Destornillador eléctrico', 'Herramientas', 18, 24.99),
(29, 'Cámara', 'Electrónica', 7, 449.99),
(30, 'Gorra', 'Ropa', 50, 9.99);


-- 1.Encuentra todos los productos cuyo stock es menor a 10 unidades.
SELECT nombre_producto, stock
FROM productos
WHERE stock > 10;

-- 2.Encuentra todos los productos cuya categoría es Electrónica o Ropa.
SELECT nombre_producto, categoria
FROM productos
WHERE categoria IN ('Electrónica', 'Ropa');

-- 3.Encuentra todos los productos cuyo precio unitario es mayor a 100 euros.
SELECT nombre_producto, precio_unitario
FROM productos
WHERE precio_unitario > 100.0;

-- 4.Encuentra el producto con el precio unitario más alto.
SELECT MAX(precio_unitario)
FROM productos;

SELECT nombre_producto
FROM productos 
WHERE precio_unitario = (SELECT MAX(precio_unitario) FROM productos);

-- 5.Encuentra la categoría con el mayor valor total de stock.
SELECT categoria, stock
FROM productos 
WHERE stock = (
        SELECT MAX(stock)
        FROM productos
);

-- 6.Encuentra el promedio del precio unitario de todos los productos.
SELECT AVG(precio_unitario) AS promedio_precio_unitario_productos
FROM productos;

-- 7.Encuentra todos los productos cuyo nombre comienza con “A” y su stock es mayor a 0.
SELECT nombre_producto, stock
FROM productos
WHERE nombre_producto LIKE 'A%' AND stock > 0;

-- 8.Encuentra todos los productos que no pertenecen a la categoría Alimentos y su precio unitario es inferior a 50 euros.
SELECT nombre_producto, precio_unitario
FROM productos
WHERE NOT categoria = 'Alimentos' AND precio_unitario < 50;

-- 9.Encuentra todos los productos cuya cantidad en stock es un número par.
SELECT nombre_producto, stock
FROM productos
WHERE stock % 2 = 0;

-- 10.Encuentra todos los productos cuya categoría no contiene la palabra “Herramientas”.
SELECT nombre_producto, categoria
FROM productos
WHERE NOT categoria IN ('Herramientas');

-- 11.Encuentra todos los productos cuyo precio unitario está dentro del rango de 50 a 100 euros.
SELECT nombre_producto, precio_unitario
FROM productos
WHERE precio_unitario BETWEEN 50 AND 100;

-- 12.Encuentra el producto con la cantidad de stock más baja.
SELECT nombre_producto, stock
FROM productos
WHERE stock = (
    SELECT MIN(stock)
    FROM productos
);

-- 13.Encuentra la categoría con el menor valor total de stock.
SELECT categoria, MIN(stock) AS valor_total_stock
FROM productos
GROUP BY categoria
ORDER BY MIN(stock) ASC
LIMIT 1;

-- 14.Encuentra el número total de productos en cada categoría.
SELECT categoria, SUM(stock) AS total_productos
FROM productos
GROUP BY categoria;

-- 15.Encuentra todos los productos que tienen el mismo precio unitario que otro producto.
SELECT nombre_producto, precio_unitario 
FROM productos
WHERE precio_unitario IN (
    SELECT  precio_unitario
    FROM productos
    GROUP BY precio_unitario
    HAVING COUNT(*) > 1
)
ORDER BY precio_unitario;

-- 16.Encuentra todos los productos cuyo nombre contiene al menos tres vocales.
-- Este no se hace.

/*SELECT nombre_producto
FROM productos
WHERE nombre_producto 
        (LENGTH(nombre_producto) - LENGTH(REPLACE(LOWER(nombre_producto), 'a', ''))) 
 >=3;*/

 SELECT nombre_producto
FROM productos
WHERE 
    (LENGTH(nombre_producto) - LENGTH(REPLACE(LOWER(nombre_producto), 'a', ''))) +
    (LENGTH(nombre_producto) - LENGTH(REPLACE(LOWER(nombre_producto), 'e', ''))) +
    (LENGTH(nombre_producto) - LENGTH(REPLACE(LOWER(nombre_producto), 'i', ''))) +
    (LENGTH(nombre_producto) - LENGTH(REPLACE(LOWER(nombre_producto), 'o', ''))) +
    (LENGTH(nombre_producto) - LENGTH(REPLACE(LOWER(nombre_producto), 'u', ''))) >= 3;

SELECT nombre_producto
FROM productos
WHERE nombre_producto LIKE ("%a%e%") OR ("%e%a%");

-- 17.Encuentra todos los productos que tienen el mismo nombre de categoría que otro producto.
SELECT nombre_producto
FROM productos
WHERE nombre_producto IN (
    
)

-- SELECT * FROM productos LIMIT 3;
