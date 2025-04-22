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