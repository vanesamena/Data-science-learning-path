-- Fuente: https://josejuansanchez.org/bd/ejercicios-consultas-sql/index.html#modelo-entidadrelaci%C3%B3n-2

-- 1.3 Gestión de ventas
-- Cargar la base de datos de 1.3 Gestión de ventas-base de datos.

USE ventas;

-- 1.3.3 Consultas sobre una tabla
--  1. Devuelve un listado con todos los pedidos que se han realizado. Los pedidos deben estar ordenados por la fecha de realización, 
-- mostrando en primer lugar los pedidos más recientes.
SELECT * FROM pedido ORDER BY fecha ASC;

-- 2. Devuelve todos los datos de los dos pedidos de mayor valor.
SELECT * FROM pedido 
ORDER BY total desc LIMIT 2;

-- 3. Devuelve un listado con los identificadores de los clientes que han realizado algún pedido. 
-- Tenga en cuenta que no debe mostrar identificadores que estén repetidos.
SELECT DISTINCT(p.id_cliente) FROM cliente c
JOIN pedido p on p.id_cliente = c.id;

-- 4. Devuelve un listado de todos los pedidos que se realizaron durante el año 2017, cuya cantidad total sea superior a 500€.
SELECT * FROM pedido
WHERE year(fecha)=2017 and total > 500;

-- 5. Devuelve un listado con el nombre y los apellidos de los comerciales que tienen una comisión entre 0.05 y 0.11.
SELECT nombre, apellido1, apellido2 FROM comercial
WHERE comisión BETWEEN 0.05 and 0.11;

-- 6. Devuelve el valor de la comisión de mayor valor que existe en la tabla comercial.
SELECT MAX(comisión) FROM comercial;

-- 7. Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo segundo apellido no es NULL. 
-- El listado deberá estar ordenado alfabéticamente por apellidos y nombre.
SELECT id, nombre, apellido1 FROM cliente
WHERE id in (SELECT id FROM cliente WHERE apellido2 is null);

-- 8. Devuelve un listado de los nombres de los clientes que empiezan por A y terminan por n y también los nombres que empiezan por P. 
-- El listado deberá estar ordenado alfabéticamente.
SELECT nombre FROM cliente
WHERE nombre LIKE 'A%n' OR nombre LIKE 'P%'
ORDER BY nombre;

-- 9. Devuelve un listado de los nombres de los clientes que no empiezan por A. El listado deberá estar ordenado alfabéticamente.
SELECT nombre FROM cliente
WHERE nombre LIKE 'A%'
ORDER BY nombre;

-- 10. Devuelve un listado con los nombres de los comerciales que terminan por el o o. 
-- Tenga en cuenta que se deberán eliminar los nombres repetidos.
SELECT DISTINCT nombre FROM comercial
WHERE nombre LIKE '%el' OR nombre LIKE '%o';

-- 1.3.4 Consultas multitabla (Composición interna)
-- Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.
-- 1. Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido. 
-- El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.
SELECT DISTINCT(p.id_cliente), c.nombre, c.apellido1, c.apellido2 FROM cliente c
JOIN pedido p on p.id_cliente = c.id
ORDER BY c.nombre;

-- 2. Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. 
-- El resultado debe mostrar todos los datos de los pedidos y del cliente. 
-- El listado debe mostrar los datos de los clientes ordenados alfabéticamente.
SELECT  * FROM cliente c
JOIN pedido p on p.id_cliente = c.id
ORDER BY c.nombre;

-- 3. Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. 
-- El resultado debe mostrar todos los datos de los pedidos y de los comerciales. 
-- El listado debe mostrar los datos de los comerciales ordenados alfabéticamente.
SELECT * FROM comercial co 
JOIN pedido p on co.id = p.id_comercial
ORDER BY co.nombre;

-- 4. Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado 
-- y con los datos de los comerciales asociados a cada pedido.
SELECT * FROM cliente c
JOIN pedido p on p.id_cliente = c.id
JOIN comercial co on co.id = p.id_comercial;

-- 5. Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, cuya cantidad esté entre 300 € y 1000 €.
SELECT p.id_cliente, c.nombre, c.apellido1, c.apellido2, p.total, p.fecha FROM cliente c
JOIN pedido p on p.id_cliente = c.id
WHERE year(p.fecha) = 2017 and p.total BETWEEN 300 AND 1000;

-- 6. Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún pedido realizado por María Santana Moreno.
SELECT concat(co.nombre, ' ', co.apellido1, ' ', co.apellido2) as Comercial
FROM comercial co 
JOIN pedido p on co.id = p.id_comercial 
JOIN cliente c on p.id_cliente = c.id
WHERE concat(c.nombre, ' ', c.apellido1, ' ', c.apellido2) = 'María Santana Moreno';

-- 7. Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega.
SELECT concat(c.nombre, ' ', c.apellido1, ' ', c.apellido2) as Cliente
FROM cliente c
JOIN pedido p on p.id_cliente = c.id
JOIN comercial co on co.id = p.id_comercial
WHERE concat(co.nombre, ' ', co.apellido1, ' ', co.apellido2) = 'Daniel Sáez Vega';

-- 1.3.5 Consultas multitabla (Composición externa)
-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

-- 1. Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado. 
-- Este listado también debe incluir los clientes que no han realizado ningún pedido. 
-- El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los clientes.

SELECT c.id, concat(c.nombre, ' ', c.apellido1, ' ', c.apellido2) as Cliente, p.id as id_pedido, p.total, p.fecha FROM cliente c
LEFT JOIN pedido p on p.id_cliente = c.id
ORDER BY c.apellido1, c.apellido2, c.nombre;

-- 2. Devuelve un listado con todos los comerciales junto con los datos de los pedidos que han realizado. 
-- Este listado también debe incluir los comerciales que no han realizado ningún pedido. 
-- El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los comerciales.
SELECT concat(co.nombre, ' ', co.apellido1, ' ', co.apellido2) as Comercial, p.id as id_pedido, p.total, p.fecha
FROM comercial co LEFT JOIN pedido p on co.id = p.id_comercial 
ORDER BY co.apellido1, co.apellido2, co.nombre;

-- 3. Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.
SELECT * FROM cliente c 
LEFT JOIN pedido p on p.id_cliente = c.id
WHERE p.id_cliente is null;

-- 4. Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.
SELECT * FROM  comercial co 
LEFT JOIN pedido p on co.id = p.id_comercial 
WHERE p.id_comercial is null;

-- 5. Devuelve un listado con los clientes que no han realizado ningún pedido y de los comerciales que no han participado en ningún pedido. 
-- Ordene el listado alfabéticamente por los apellidos y el nombre. 
-- En en listado deberá diferenciar de algún modo los clientes y los comerciales.
SELECT concat(co.nombre, ' ', co.apellido1, ' ', co.apellido2) as Comercial,  
CASE
	WHEN co.id>0 THEN 'Comercial'
END as Origen
FROM  comercial co 
LEFT JOIN pedido p on co.id = p.id_comercial 
WHERE p.id_comercial is null
union
SELECT concat(c.nombre, ' ', c.apellido1, ' ', c.apellido2) as Cliente, 
CASE
	WHEN c.id>0 THEN 'Cliente'
END as Origen
FROM cliente c 
LEFT JOIN pedido p on p.id_cliente = c.id
WHERE p.id_cliente is null;

-- 6. ¿Se podrían realizar las consultas anteriores con NATURAL LEFT JOIN o NATURAL RIGHT JOIN? Justifique su respuesta.
-- 1.3.6 Consultas resumen
-- 1. Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.
SELECT count(total) FROM pedido;

-- 2. Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.
SELECT AVG(total) FROM pedido;

-- 3. Calcula el número total de comerciales distintos que aparecen en la tabla pedido.
SELECT DISTINCT(id_comercial) FROM pedido;

-- 4. Calcula el número total de clientes que aparecen en la tabla cliente.
SELECT COUNT(id) FROM cliente;
-- 5. Calcula cuál es la mayor cantidad que aparece en la tabla pedido.
SELECT MAX(total) from pedido;

-- 6. Calcula cuál es la menor cantidad que aparece en la tabla pedido.
SELECT MIN(total) from pedido;

-- 7. Calcula cuál es el valor máximo de categoría para cada una de las ciudades que aparece en la tabla cliente.
SELECT ciudad, max(categoría) FROM cliente
GROUP BY ciudad;

-- 8. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes. 
-- Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes cantidades el mismo día. 
-- Se pide que se calcule cuál es el pedido de máximo valor para cada uno de los días en los que un cliente ha realizado un pedido. 
-- Muestra el identificador del cliente, nombre, apellidos, la fecha y el valor de la cantidad.

SELECT c.id,  concat(c.nombre, ' ', c.apellido1, ' ', c.apellido2) as Cliente, p.fecha, sum(p.total) as valor, count(p.total) as cantidad
FROM cliente c JOIN pedido p on p.id_cliente = c.id
GROUP BY c.id, fecha;

-- 9. Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes, 
-- teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen la cantidad de 2000 €.

SELECT sum(total) as valor, count(total) as cantidad
FROM pedido
GROUP BY id_cliente, fecha
HAVING valor>2000
ORDER BY cantidad desc
LIMIT 1;

-- 10. Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales durante la fecha 2016-08-17. 
-- Muestra el identificador del comercial, nombre, apellidos y total.
SELECT co.id, concat(co.nombre, ' ', co.apellido1, ' ', co.apellido2) as Comercial, sum(p.total) as valor, count(p.total) as cantidad
FROM comercial co JOIN pedido p on co.id = p.id_comercial
GROUP BY p.id_comercial;

-- 11. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes.
-- Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido. 
-- Estos clientes también deben aparecer en el listado indicando que el número de pedidos realizados es 0.
SELECT c.id,  concat(c.nombre, ' ', c.apellido1, ' ', c.apellido2) as Cliente, p.fecha, count(p.total) as cantidad
FROM cliente c LEFT JOIN pedido p on p.id_cliente = c.id
GROUP BY c.id;

-- 12. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos 
-- que ha realizado cada uno de clientes durante el año 2017.
SELECT c.id,  concat(c.nombre, ' ', c.apellido1, ' ', c.apellido2) as Cliente, p.fecha, count(p.total) as cantidad
FROM cliente c JOIN pedido p on p.id_cliente = c.id
WHERE year(p.fecha)>2017
GROUP BY c.id;

-- 13. Devuelve un listado que muestre el identificador de cliente, nombre, primer apellido 
-- y el valor de la máxima cantidad del pedido realizado por cada uno de los clientes. 
-- El resultado debe mostrar aquellos clientes que no han realizado ningún pedido indicando que la máxima cantidad de sus pedidos realizados es 0. Puede hacer uso de la función IFNULL.

SELECT c.id,  concat(c.nombre, ' ', c.apellido1) as Cliente, p.fecha, count(p.total) as cantidad
FROM cliente c LEFT JOIN pedido p on p.id_cliente = c.id
GROUP BY c.id;

-- 14. Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.
SELECT year(fecha) as anio, max(total) as maximo
FROM pedido
GROUP BY year(fecha);

-- 15. Devuelve el número total de pedidos que se han realizado cada año.
SELECT year(fecha) as anio, count(total) as cantidad
FROM pedido
GROUP BY year(fecha);

-- 1.3.7 Subconsultas
-- 1.3.7.1 Con operadores básicos de comparación

-- 1. Devuelve un listado con todos los pedidos que ha realizado Adela Salas Díaz. (Sin utilizar INNER JOIN).
SELECT * FROM pedido 
WHERE id_cliente = (SELECT id FROM cliente
					WHERE concat(nombre, ' ', apellido1, ' ', apellido2) = 'Adela Salas Díaz');

-- 2. Devuelve el número de pedidos en los que ha participado el comercial Daniel Sáez Vega. (Sin utilizar INNER JOIN)
SELECT count(*) as cantidad FROM pedido 
WHERE id_cliente = (SELECT id FROM comercial
					WHERE concat(nombre, ' ', apellido1, ' ', apellido2) = 'Daniel Sáez Vega');

-- 3. Devuelve los datos del cliente que realizó el pedido más caro en el año 2019. (Sin utilizar INNER JOIN)
SELECT * FROM cliente 
WHERE id = ( SELECT id_cliente FROM pedido
			GROUP BY id_cliente
			ORDER BY max(total) DESC
			LIMIT 1);

-- 4. Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz Santana.
SELECT min(total) as valor_minimo, fecha FROM pedido 
WHERE id_cliente = (SELECT id FROM cliente
					WHERE concat(nombre, ' ', apellido1, ' ', apellido2) = 'Pepe Ruiz Santana');

-- 5. Devuelve un listado con los datos de los clientes y los pedidos, de todos los clientes que han realizado un pedido durante el año 2017 
-- con un valor mayor o igual al valor medio de los pedidos realizados durante ese mismo año.
SELECT * FROM cliente c
JOIN pedido p on p.id_cliente = c.id
WHERE p.total > ( SELECT AVG(total) FROM pedido 
				WHERE year(fecha) = 2017)
                and year(fecha) = 2017;

-- 1.3.7.2 Subconsultas con ALL y ANY
-- 6. Devuelve el pedido más caro que existe en la tabla pedido si hacer uso de MAX, ORDER BY ni LIMIT.
SELECT * from pedido 
WHERE total  >= ALL (SELECT total FROM pedido);

-- 7. Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando ANY o ALL).
SELECT * FROM cliente
WHERE id != all (SELECT DISTINCT id_cliente FROM pedido);

-- 8. Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando ANY o ALL).
SELECT * FROM comercial
WHERE id != all (SELECT DISTINCT id_comercial FROM pedido);

-- 1.3.7.3 Subconsultas con IN y NOT IN
-- 9. Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando IN o NOT IN).
SELECT * FROM cliente
WHERE id not in (SELECT DISTINCT id_cliente FROM pedido);

-- 10. Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando IN o NOT IN).
SELECT * FROM comercial
WHERE id not in (SELECT DISTINCT id_comercial FROM pedido);

-- 1.3.7.4 Subconsultas con EXISTS y NOT EXISTS
-- 11. Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando EXISTS o NOT EXISTS).

SELECT nombre, apellido1, apellido2 FROM cliente c
WHERE NOT EXISTS (SELECT * FROM pedido p 
					WHERE p.id_cliente = c.id);


-- 12. Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando EXISTS o NOT EXISTS).
SELECT nombre, apellido1, apellido2 FROM comercial co
WHERE NOT EXISTS (SELECT * FROM pedido p 
					WHERE p.id_comercial = co.id);