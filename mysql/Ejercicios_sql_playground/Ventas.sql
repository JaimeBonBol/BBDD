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

