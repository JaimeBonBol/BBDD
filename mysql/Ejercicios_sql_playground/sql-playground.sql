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

/*
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
*/