/* CONSULTAS SENCILLAS */

-- 1.Devuelve un listado con todos los pedidos que se han realizado. Los pedidos deben estar ordenados por la fecha de realización, mostrando en primer lugar los pedidos más recientes.

SELECT * 
FROM pedido
ORDER BY fecha DESC;

-- 2.Devuelve todos los datos de los dos pedidos de mayor valor.

SELECT * FROM pedido
ORDER BY total DESC
LIMIT 2;

-- 3.Devuelve un listado con los identificadores de los clientes que han realizado algún pedido. Tenga en cuenta que no debe mostrar identificadores que estén repetidos.

SELECT DISTINCT(id_cliente)
FROM pedido;

-- 4.Devuelve un listado de todos los pedidos que se realizaron durante el año 2017, cuya cantidad total sea superior a 500€.

SELECT * FROM pedido
WHERE YEAR(fecha) = 2017 AND total > 500.0;

SELECT * FROM pedido
WHERE fecha BETWEEN '2017-01-01' AND '2017-12-31' 
AND total > 500.0;

-- 5.Devuelve un listado con el nombre y los apellidos de los comerciales que tienen una comisión entre 0.05 y 0.11.

-- Así estaría los apellidos concatenados.
SELECT nombre , CONCAT(apellido1, ' ', apellido2) AS apellidos, comision
FROM comercial
WHERE comision BETWEEN 0.05 AND 0.11;

SELECT id, nombre , apellido1, apellido2, comision
FROM comercial
WHERE comision BETWEEN 0.05 AND 0.11;

-- 6.Devuelve el valor de la comisión de mayor valor que existe en la tabla comercial.

SELECT MAX(comision)
FROM comercial;

-- Para recortar a dos decimales el resultado.
SELECT TRUNCATE(MAX(comision),2)
FROM comercial;

-- 7.Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo segundo apellido no es NULL. El listado deberá estar ordenado alfabéticamente por apellidos y nombre.

SELECT id, nombre, apellido1
FROM cliente
WHERE apellido2  IS NOT NULL
ORDER BY apellido1 ASC, nombre ASC;

-- 8.Devuelve un listado de los nombres de los clientes que empiezan por A y terminan por n y también los nombres que empiezan por P. El listado deberá estar ordenado alfabéticamente.

SELECT nombre
FROM cliente
WHERE (nombre LIKE 'A%n' OR nombre LIKE 'P%')
ORDER BY nombre ASC;

-- 9.Devuelve un listado de los nombres de los clientes que no empiezan por A. El listado deberá estar ordenado alfabéticamente.

SELECT nombre
FROM cliente
WHERE nombre NOT LIKE 'A%'
ORDER BY nombre ASC;

-- 10.Devuelve un listado con los nombres de los comerciales que terminan por el o o. Tenga en cuenta que se deberán eliminar los nombres repetidos.

SELECT DISTINCT(nombre)
FROM comercial
WHERE (nombre LIKE '%el' OR nombre LIKE '%o');



-- COMPOSICIÓN INTERNA

-- 1.Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido. El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.

SELECT DISTINCT c.id, c.apellido1, c.apellido2, c.nombre
FROM cliente AS c
JOIN pedido AS p
ON c.id = p.id_cliente
ORDER BY c.apellido1, c.apellido2;

-- 2.Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. El resultado debe mostrar todos los datos de los pedidos y del cliente. El listado debe mostrar los datos de los clientes ordenados alfabéticamente.

SELECT p.*, c.*
FROM pedido AS p
JOIN cliente AS c
ON p.id_cliente = c.id
ORDER BY c.nombre, c.apellido1, c.apellido2;

-- 3.Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. El resultado debe mostrar todos los datos de los pedidos y de los comerciales. El listado debe mostrar los datos de los comerciales ordenados alfabéticamente.

SELECT  c.*, p.*
FROM pedido AS p
JOIN comercial AS c
ON p.id_comercial = c.id
ORDER BY c.nombre, c.apellido1, c.apellido2;

-- 4.Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y con los datos de los comerciales asociados a cada pedido.

SELECT cl.*, p.*, co.*
FROM cliente AS cl
JOIN pedido AS p
ON cl.id = p.id_cliente
JOIN comercial AS co 
ON p.id_comercial = co.id;

-- 5.Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, cuya cantidad esté entre 300 € y 1000 €.

SELECT c.*, p.*
FROM cliente AS c
JOIN pedido AS p
ON c.id = p.id_cliente
WHERE fecha BETWEEN '2017-01-01' AND '2017-12-31'
AND total BETWEEN 300 AND 1000;

-- 6.Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún pedido realizado por María Santana Moreno.

SELECT DISTINCT co.apellido1, co.apellido2, co.nombre
FROM comercial AS co
JOIN pedido AS p
ON co.id =p.id_comercial
JOIN cliente AS cl
ON p.id_cliente = cl.id
WHERE cl.nombre LIKE 'María' AND cl.apellido1 LIKE 'Santana' AND cl.apellido2 LIKE 'Moreno';

-- 7.Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega.

SELECT DISTINCT cl.apellido1, cl.apellido2, cl.nombre 
FROM cliente AS cl
JOIN pedido AS p 
ON p.id_cliente = cl.id
JOIN comercial AS co
ON p.id_comercial = co.id
WHERE co.nombre LIKE 'Daniel' AND co.apellido1 LIKE 'Sáez' AND co.apellido2 LIKE 'Vega';



-- COMPOSICIÓN EXTERNA

-- 1.Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado. Este listado también debe incluir los clientes que no han realizado ningún pedido. El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los clientes.

-- En SQL, la tabla que aparece primero después de FROM es la tabla de la izquierda, y la que aparece después de LEFT JOIN es la de la derecha.


SELECT cl.apellido1, cl.apellido2, cl.nombre, p.*
FROM  cliente AS cl
LEFT JOIN pedido AS p ON cl.id = p.id_cliente
ORDER BY cl.apellido1, cl.apellido2, cl.nombre;


-- 2.Devuelve un listado con todos los comerciales junto con los datos de los pedidos que han realizado. Este listado también debe incluir los comerciales que no han realizado ningún pedido. El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los comerciales.

SELECT co.*, p.*
FROM comercial AS co
LEFT JOIN pedido AS p
ON co.id =p.id_comercial
ORDER BY co.apellido1, co.apellido2, co.nombre;

-- 3.Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.

SELECT cl.*, p.*
FROM cliente AS cl
LEFT JOIN pedido AS p 
ON cl.id = p.id_cliente
WHERE p.id_cliente IS NULL;

-- 4.Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.

SELECT co.*, p.*
FROM comercial AS co
LEFT JOIN pedido AS p
ON co.id = p.id_comercial
WHERE p.id_comercial IS NULL;

-- 5.Devuelve un listado con los clientes que no han realizado ningún pedido y de los comerciales que no han participado en ningún pedido. Ordene el listado alfabéticamente por los apellidos y el nombre. En en listado deberá diferenciar de algún modo los clientes y los comerciales.




-- CONSULTAS RESUMEN.

