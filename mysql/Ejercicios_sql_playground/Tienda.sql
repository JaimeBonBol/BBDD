-- CONSULTAS SENCILLAS

-- 1.Lista el nombre de todos los productos que hay en la tabla producto.

SELECT nombre 
FROM producto;

-- 2.Lista los nombres y los precios de todos los productos de la tabla producto.

SELECT nombre, precio
FROM producto;

-- 3.Lista todas las columnas de la tabla producto.

SELECT * 
FROM producto;

-- 4.Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).

SELECT nombre,precio AS precio_euros, (precio * 1.15) AS precio_dólares
FROM producto;

-- 5.Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.

SELECT nombre AS nombre_de_producto, precio AS euros, (precio * 1.15) AS dólares
FROM producto;

-- 6.Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.

SELECT UPPER(nombre), precio
FROM producto;

-- 7.Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.

SELECT LOWER(nombre), precio
FROM producto;

-- 8.Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.

SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2))
FROM fabricante;

SELECT nombre, UPPER(LEFT(nombre, 2))
FROM fabricante;

-- 9.Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.

SELECT nombre, ROUND(precio)
FROM producto;


-- 10.Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.

SELECT nombre, TRUNCATE(precio,0)
FROM producto;

-- 11.Lista el código de los fabricantes que tienen productos en la tabla producto.

SELECT id_fabricante 
FROM producto;

-- 12.Lista el código de los fabricantes que tienen productos en la tabla producto, eliminando los códigos que aparecen repetidos.

SELECT DISTINCT(id_fabricante)
FROM producto;

-- 13.Lista los nombres de los fabricantes ordenados de forma ascendente.

SELECT nombre
FROM fabricante
ORDER BY nombre ASC;

-- 14.Lista los nombres de los fabricantes ordenados de forma descendente.

SELECT nombre 
FROM fabricante
ORDER BY nombre DESC;

-- 15.Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.

SELECT nombre, precio
FROM producto
ORDER BY nombre ASC, precio DESC;

-- 16.Devuelve una lista con las 5 primeras filas de la tabla fabricante.

SELECT * 
FROM fabricante 
LIMIT 5;

-- 17.Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.

-- Limita y muestra dos columnas a parte de la 3, el OFFSET es a partir de donde limita.
SELECT * 
FROM fabricante
LIMIT 2 OFFSET 3;

-- 18.Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)

SELECT nombre, precio
FROM producto
ORDER BY precio ASC
LIMIT 1;

SELECT nombre, MIN(precio)
FROM producto
GROUP BY nombre
ORDER BY MIN(precio) ASC
LIMIT 1;

-- 19.Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)

SELECT nombre, precio 
FROM producto
ORDER BY precio DESC
LIMIT 1;

-- 20.Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.

SELECT nombre
FROM producto
WHERE id_fabricante = 2;

-- 21.Lista el nombre de los productos que tienen un precio menor o igual a 120€.

SELECT nombre
FROM producto
WHERE precio <= 120;

-- 22.Lista el nombre de los productos que tienen un precio mayor o igual a 400€.

SELECT nombre
FROM producto
WHERE precio >= 400;

-- 23.Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.

SELECT nombre
FROM producto
WHERE NOT ( precio >= 400);

-- 24.Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.

SELECT * FROM producto
WHERE precio >= 80 AND precio <= 300;




-- SUBCONSULTAS

-- Ejerciccio 2.

-- SELECT MAX(precio) FROM producto WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre = 'Lenovo');

SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE id_fabricante = (SELECT id FROM fabricante WHERE nombre = 'Lenovo'));

-- Ejercicio 3.
/*
SELECT nombre, MAX(precio) AS precio_max
FROM producto 
WHERE id_fabricante = (
    SELECT id
    FROM fabricante
    WHERE nombre = 'Lenovo'
)
GROUP BY nombre
ORDER BY precio_max DESC
LIMIT 1;
*/
SELECT nombre 
FROM producto 
WHERE precio = (
    SELECT MAX(precio) AS precio_max
    FROM producto 
    WHERE id_fabricante = (
        SELECT id
        FROM fabricante
        WHERE nombre = 'Lenovo'
    )
);

-- Ejercicio 4

SELECT nombre 
FROM producto 
WHERE precio = (
    SELECT MIN(precio)
    FROM producto
    WHERE id_fabricante = (
        SELECT id
        FROM fabricante
        WHERE nombre LIKE 'Hewlett-Packard'
    )
);

-- Ejercicio5. Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.

SELECT *
FROM producto 
WHERE precio >= (
    SELECT MAX(precio)
    FROM producto
    WHERE id_fabricante = (
        SELECT id
        FROM fabricante
        WHERE nombre = 'Lenovo'
    )
)

-- Ej6.Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT *
FROM producto
WHERE id_fabricante = (
    SELECT id 
        FROM fabricante 
        WHERE nombre LIKE 'Asus'
    )
    AND precio > (
    SELECT AVG(precio)
    FROM producto
        WHERE id_fabricante = (
            SELECT id 
            FROM fabricante 
            WHERE nombre LIKE 'Asus'
        )
    )
;


SELECT fabricante.*, producto.*
FROM fabricante, producto
WHERE id_fabricante = (
    SELECT id 
        FROM fabricante 
        WHERE nombre LIKE 'Asus'
    )
    AND precio > (
    SELECT AVG(precio)
    FROM producto
        WHERE id_fabricante = (
            SELECT id 
            FROM fabricante 
            WHERE nombre LIKE 'Asus'
        )
    )AND producto.id_fabricante = fabricante.id;
;

SELECT *
FROM fabricante AS f
JOIN producto AS p
ON p.id_fabricante = f.id
WHERE p.precio > (
    SELECT AVG(precio)
        FROM producto
            WHERE id_fabricante = (
                SELECT id 
                FROM fabricante 
                WHERE nombre LIKE 'Asus'
        )
    AND f.nombre LIKE 'Asus');

-- 7.Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.

SELECT *
FROM producto AS p
WHERE p.precio >= ALL(
    SELECT precio 
    from producto
);

-- 8.Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.

SELECT * 
FROM producto 
WHERE precio <= ALL(
    SELECT precio
    FROM producto
);

-- 9.Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).

SELECT nombre
FROM fabricante AS f
WHERE id= ANY (
    SELECT id_fabricante
    FROM producto
);

SELECT nombre
FROM fabricante AS f
WHERE id IN (
    SELECT id_fabricante
    FROM producto
);

SELECT DISTINCT(f.nombre)
FROM fabricante AS f
JOIN producto AS p
ON f.id = p.id_fabricante;

-- 10.Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).

SELECT nombre
FROM fabricante
WHERE NOT id = ANY (
    SELECT id_fabricante
    FROM producto
);

-- 11.Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).

SELECT nombre
FROM fabricante
WHERE id IN (
    SELECT id_fabricante
    FROM producto
);

SELECT DISTINCT(f.nombre)
FROM fabricante AS f
JOIN producto AS p
ON f.id = p.id_fabricante;

-- 12.Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).

SELECT nombre
FROM fabricante
WHERE NOT id IN (
    SELECT id_fabricante
    FROM producto
);


-- 15.Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.

SELECT producto.nombre, producto.precio, fabricante.nombre
FROM fabricante
INNER JOIN producto
ON producto.id_fabricante = fabricante.id
WHERE producto.precio IN (
    SELECT MAX(precio)
    FROM producto
    WHERE producto.id_fabricante = fabricante.id
);

-- 16.Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de todos los productos de su mismo fabricante.

SELECT p.*
FROM producto AS p
INNER JOIN fabricante AS f
ON p.id_fabricante = f.id
WHERE p.precio >= (
    SELECT AVG(precio)
    FROM producto AS p
    WHERE p.id_fabricante = f.id
);

-- 17.Lista el nombre del producto más caro del fabricante Lenovo.

SELECT p.nombre
FROM producto AS p
JOIN fabricante AS f
ON p.id_fabricante = f.id
WHERE p.precio = (
    SELECT MAX(precio)
    FROM producto
    WHERE id_fabricante = (
        SELECT id 
        FROM fabricante
        WHERE nombre = 'Lenovo'
    )
);

-- 18.Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.

SELECT f.nombre, COUNT(p.id)
FROM fabricante f
JOIN producto p 
ON f.id = p.id_fabricante
GROUP BY f.id, f.nombre
HAVING COUNT(p.id) = (
    SELECT count(p.id)
    FROM producto AS p
    JOIN fabricante AS f
    ON p.id_fabricante = f.id
    WHERE id_fabricante = (
        SELECT id 
        FROM fabricante 
        WHERE nombre LIKE 'Lenovo'
    )
);

-- En el GROUP BY  el f.id lo agrupa para manener el orden pero podróia no agruparse.