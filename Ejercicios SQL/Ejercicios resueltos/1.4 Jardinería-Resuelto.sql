-- Fuente: https://josejuansanchez.org/bd/ejercicios-consultas-sql/index.html#modelo-entidadrelaci%C3%B3n-2

-- 1.4 Jardinería
-- Cargar la base de datos de 1.4 Jardinería-base de datos
USE jardineria;

--  1.4.4 Consultas sobre una tabla
--  1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
SELECT codigo_oficina, ciudad FROM oficina;

--  2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
SELECT ciudad, telefono FROM oficina
WHERE pais = 'España';

--  3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
SELECT nombre, apellido1, apellido2, email FROM empleado
WHERE codigo_jefe=7;

--  4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
SELECT puesto,  nombre, apellido1, apellido2, email FROM empleado
WHERE codigo_jefe is null;

--  5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
SELECT * FROM empleado
WHERE puesto != 'Representante Ventas';

--  6. Devuelve un listado con el nombre de los todos los clientes españoles.
SELECT * FROM cliente
WHERE pais = 'Spain';

--  7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
SELECT DISTINCT estado FROM pedido;

--  8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. 
--  Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
	--  • Utilizando la función YEAR de MySQL.
SELECT DISTINCT codigo_cliente FROM pedido
WHERE year(fecha_pedido)=2008;

	--  • Utilizando la función DATE_FORMAT de MySQL.
SELECT DISTINCT codigo_cliente FROM pedido
WHERE DATE_FORMAT(fecha_pedido, "%Y") = 2008;

	--  • Sin utilizar ninguna de las funciones anteriores.
SELECT DISTINCT codigo_cliente FROM pedido
WHERE fecha_pedido >'2008-01-01' and fecha_pedido < '2008-12-31';

--  9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega 
--  de los pedidos que no han sido entregados a tiempo.
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido
WHERE (fecha_esperada - fecha_entrega) <0;

--  10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos 
--  cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.
	--  • Utilizando la función ADDDATE de MySQL.
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido
WHERE ADDDATE(fecha_entrega, 2) <= fecha_esperada;
	--  • Utilizando la función DATEDIFF de MySQL.
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido
WHERE DATEDIFF(fecha_esperada , fecha_entrega) >= 2;

	--  • ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido
WHERE (fecha_esperada - fecha_entrega) >= 2;

--  11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
SELECT * FROM pedido
WHERE year(fecha_pedido) = 2009 AND estado = 'Rechazado';

--  12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
SELECT * FROM pedido
WHERE month(fecha_entrega) = 01;

--  13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
SELECT * FROM pago
WHERE forma_pago = 'PayPal' and year(fecha_pago) = 2008;

--  14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. 
--  Tenga en cuenta que no deben aparecer formas de pago repetidas.
SELECT DISTINCT forma_pago FROM pago;

--  15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. 
--  El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.

SELECT * FROM producto
WHERE gama = 'Ornamentales' AND cantidad_en_stock>100
ORDER BY precio_venta DESC;

--  16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid 
--  y cuyo representante de ventas tenga el código de empleado 11 o 30.
SELECT * FROM cliente
WHERE ciudad = 'Madrid' and codigo_empleado_rep_ventas in (11,30);


--  1.4.5 Consultas multitabla (Composición interna)
--  Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.
--  1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.

SELECT c.nombre_cliente, concat(e.nombre, ' ', apellido1) as rep_ventas 
FROM cliente c JOIN empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado;

--  2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT c.nombre_cliente, concat(e.nombre, ' ', apellido1) as rep_ventas 
FROM cliente c JOIN pago p on c.codigo_cliente = p.codigo_cliente
JOIN empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado;

--  3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT c.nombre_cliente, concat(e.nombre, ' ', apellido1) as rep_ventas
FROM cliente c 
JOIN empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE c.codigo_cliente not in (SELECT DISTINCT p.codigo_cliente FROM  cliente c JOIN pago p on c.codigo_cliente = p.codigo_cliente);

--  4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

SELECT c.nombre_cliente, concat(e.nombre, ' ', apellido1) as rep_ventas, o.ciudad as ciudad_oficina
FROM cliente c 
JOIN empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o on e.codigo_oficina = o.codigo_oficina
WHERE c.codigo_cliente in (SELECT DISTINCT p.codigo_cliente FROM  cliente c JOIN pago p on c.codigo_cliente = p.codigo_cliente);

--  5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT c.nombre_cliente, concat(e.nombre, ' ', apellido1) as rep_ventas, o.ciudad as ciudad_oficina
FROM cliente c 
JOIN empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o on e.codigo_oficina = o.codigo_oficina
WHERE c.codigo_cliente not in (SELECT DISTINCT p.codigo_cliente FROM  cliente c JOIN pago p on c.codigo_cliente = p.codigo_cliente);

--  6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
SELECT DISTINCT o.linea_direccion1, o.ciudad, o.codigo_oficina
FROM cliente c 
JOIN empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o on e.codigo_oficina = o.codigo_oficina
WHERE c.ciudad = 'Fuenlabrada';

--  7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT c.nombre_cliente, e.nombre as rep_ventas, o.ciudad as ciudad_oficina
FROM cliente c 
JOIN empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o on e.codigo_oficina = o.codigo_oficina;

--  8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
SELECT e.codigo_empleado, concat(e.nombre, e.apellido1) as nomnre_empleado, concat(j.nombre, j.apellido1) as nombre_jefe  FROM empleado e
JOIN empleado j on e.codigo_jefe = j.codigo_empleado;

--  9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.
SELECT e.codigo_empleado, concat(e.nombre, e.apellido1) as nomnre_empleado, concat(j.nombre, j.apellido1) as nombre_jefe, concat(k.nombre, k.apellido1) as nombre_jefe_del_jefe  FROM empleado e
JOIN empleado j on e.codigo_jefe = j.codigo_empleado JOIN empleado k on j.codigo_jefe = k.codigo_empleado ;

--  10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
SELECT DISTINCT c.nombre_cliente FROM cliente c
JOIN pedido p on c.codigo_cliente = p.codigo_cliente
WHERE DATEDIFF(p.fecha_esperada , p.fecha_entrega) < 0;

--  11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

SELECT c.nombre_cliente, pr.gama FROM cliente c
JOIN pedido p on c.codigo_cliente = p.codigo_cliente
JOIN detalle_pedido dp on p.codigo_pedido = dp.codigo_pedido
JOIN producto pr on dp.codigo_producto = pr.codigo_producto
GROUP BY c.nombre_cliente, pr.gama;


--  1.4.6 Consultas multitabla (Composición externa)
--  Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL LEFT JOIN y NATURAL RIGHT JOIN.
--  1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

SELECT c.codigo_cliente, c.nombre_cliente  FROM cliente c 
LEFT JOIN pago pa on c.codigo_cliente = pa.codigo_cliente
WHERE pa.codigo_cliente is null;

--  2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
SELECT c.codigo_cliente, c.nombre_cliente  FROM cliente c 
LEFT JOIN pedido p on c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente is null;

--  3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.

SELECT c.codigo_cliente, c.nombre_cliente FROM cliente c
LEFT JOIN pedido p on c.codigo_cliente = p.codigo_cliente
LEFT JOIN pago pa on c.codigo_cliente = pa.codigo_cliente
WHERE  p.codigo_cliente is null and pa.codigo_cliente is null;

--  4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
SELECT DISTINCT codigo_oficina FROM empleado WHERE codigo_oficina is null; 

--  5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
SELECT e.codigo_empleado, e.nombre, e.apellido1, e.apellido2  FROM empleado e 
LEFT JOIN cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE codigo_cliente is null;

--  6. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.
SELECT *  FROM empleado e 
LEFT JOIN oficina o on e.codigo_oficina = o.codigo_oficina
LEFT JOIN cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE codigo_cliente is null;

--  7. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
SELECT *  FROM empleado e 
LEFT JOIN oficina o on e.codigo_oficina = o.codigo_oficina
LEFT JOIN cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_cliente is null and o.codigo_oficina is null;

--  8. Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT * FROM producto p
LEFT JOIN detalle_pedido dp on p.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto is null;

--  9. Devuelve un listado de los productos que nunca han aparecido en un pedido. 
--  El resultado debe mostrar el nombre, la descripción y la imagen del producto.
SELECT p.nombre, p.descripcion FROM producto p
LEFT JOIN detalle_pedido dp on p.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto is null;

--  10. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas 
--  de algún cliente que haya realizado la compra de algún producto de la gama Frutales.

SELECT * FROM oficina 
WHERE codigo_oficina not in (SELECT codigo_oficina FROM empleado
			WHERE codigo_empleado in (SELECT DISTINCT codigo_empleado_rep_ventas 
										FROM cliente NATURAL JOIN (SELECT DISTINCT codigo_cliente 
																   FROM pedido NATURAL JOIN (SELECT dp.codigo_pedido 
																							 FROM detalle_pedido dp NATURAL JOIN producto p 
																							WHERE p.gama = 'Frutales') a) b));
															

--  11. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.

SELECT  * FROM cliente c NATURAL JOIN pedido p
LEFT JOIN pago pa on c.codigo_cliente= pa.codigo_cliente
WHERE  pa.codigo_cliente is null;

--  12. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.
SELECT concat(e.nombre, e.apellido1) as nomnre_empleado, concat(j.nombre, j.apellido1) as nombre_jefe FROM empleado e 
JOIN empleado j on e.codigo_jefe = j.codigo_empleado
LEFT JOIN cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_empleado_rep_ventas is null;


--  1.4.7 Consultas resumen
--  1. ¿Cuántos empleados hay en la compañía?
SELECT count(*) FROM empleado;

--  2. ¿Cuántos clientes tiene cada país?
SELECT pais, count(*) FROM cliente
GROUP BY pais;

--  3. ¿Cuál fue el pago medio en 2009?
SELECT avg(total) FROM pago WHERE year(fecha_pago) = 2009;

--  4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
SELECT estado, COUNT(*) as cantidad FROM pedido GROUP BY estado ORDER BY cantidad;

--  5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.
SELECT max(precio_venta) precio_venta FROM producto
UNION
SELECT min(precio_venta) precio_venta FROM producto;

--  6. Calcula el número de clientes que tiene la empresa.
SELECT count(*) FROM cliente;

--  7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?
SELECT count(*) FROM cliente WHERE ciudad = 'Madrid';

--  8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
SELECT count(*) FROM cliente
WHERE ciudad LIKE 'M%';

--  9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.
SELECT e.nombre, count(c.codigo_cliente) FROM empleado e 
join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
GROUP BY  e.nombre;

--  10. Calcula el número de clientes que no tiene asignado representante de ventas.
SELECT count(*) FROM cliente c LEFT JOIN empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE e.codigo_empleado is null;

--  11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. 
--  El listado deberá mostrar el nombre y los apellidos de cada cliente.
SELECT * FROM (SELECT codigo_cliente, nombre_cliente, min(fecha_pago) min_fecha_pago 
							FROM pago NATURAL JOIN cliente GROUP BY codigo_cliente) a
			NATURAL JOIN (SELECT codigo_cliente, nombre_cliente, max(fecha_pago) max_fecha_pago FROM pago NATURAL JOIN cliente GROUP BY codigo_cliente) b;

--  12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.
SELECT COUNT(DISTINCT codigo_producto) FROM detalle_pedido;

--  13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
SELECT sum(cantidad*precio_unidad) as total FROM detalle_pedido;

--  14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. 
--  El listado deberá estar ordenado por el número total de unidades vendidas.
SELECT dp.codigo_producto, p.nombre, sum(dp.cantidad) cantidad 
FROM detalle_pedido dp NATURAL JOIN producto p
GROUP BY dp.codigo_producto
ORDER BY cantidad DESC
limit 20;

--  15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. 
--  La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. 
--  El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.

SELECT sum(base_imponible) base_imponible_total, sum(IVA) IVA_total , sum(total) Total
from (SELECT p.precio_venta, dp.cantidad, 
	   (p.precio_venta*dp.cantidad)  base_imponible, 
       (p.precio_venta*dp.cantidad)*0.21 IVA, 
       ((p.precio_venta*dp.cantidad) + (p.precio_venta*dp.cantidad)*0.21) total
FROM producto p NATURAL JOIN detalle_pedido dp) a;

--  16. La misma información que en la pregunta anterior, pero agrupada por código de producto.
SELECT codigo_producto, sum(p.precio_venta), sum(dp.cantidad), 
	   sum(p.precio_venta*dp.cantidad)  base_imponible, 
       sum(p.precio_venta*dp.cantidad*0.21) IVA, 
       sum((p.precio_venta*dp.cantidad) + (p.precio_venta*dp.cantidad)*0.21) total
FROM producto p NATURAL JOIN detalle_pedido dp
GROUP BY codigo_producto;

--  17. La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.
SELECT codigo_producto, sum(p.precio_venta), sum(dp.cantidad), 
	   sum(p.precio_venta*dp.cantidad)  base_imponible, 
       sum(p.precio_venta*dp.cantidad*0.21) IVA, 
       sum((p.precio_venta*dp.cantidad) + (p.precio_venta*dp.cantidad)*0.21) total
FROM producto p NATURAL JOIN detalle_pedido dp
WHERE codigo_producto LIKE 'OR%'
GROUP BY codigo_producto;

--  18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. 
--  Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).
SELECT codigo_producto, nombre, sum(dp.cantidad) unidades_vendidas, 
	   sum(p.precio_venta*dp.cantidad)  base_imponible, 
       sum(p.precio_venta*dp.cantidad*0.21) IVA, 
       sum((p.precio_venta*dp.cantidad) + (p.precio_venta*dp.cantidad)*0.21) total
FROM producto p NATURAL JOIN detalle_pedido dp
GROUP BY codigo_producto
HAVING total >3000;

--  19. Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.
SELECT year(fecha_pago) anio , sum(total) total_pagos FROM pago 
GROUP BY year(fecha_pago);

--  1.4.8 Subconsultas

--  1.4.8.1 Con operadores básicos de comparación
--  1. Devuelve el nombre del cliente con mayor límite de crédito.

SELECT nombre_cliente FROM cliente
WHERE limite_credito = (SELECT max(limite_credito) FROM cliente);

--  2. Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT nombre FROM producto
WHERE precio_venta = (SELECT MAX(precio_venta) FROM producto);

--  3. Devuelve el nombre del producto del que se han vendido más unidades. 
--  (Tenga en cuenta que tendrá que calcular cuál es el número total de unidades que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido)

SELECT codigo_producto, nombre, sum(cantidad) as cantidad_total FROM detalle_pedido NATURAL JOIN producto 
GROUP BY codigo_producto ORDER BY cantidad_total DESC limit 1;

--  4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).
SELECT * FROM cliente c
WHERE EXISTS (SELECT * FROM pago p 
					WHERE p.codigo_cliente = c.codigo_cliente and c.limite_credito < p.total);

--  5. Devuelve el producto que más unidades tiene en stock.
SELECT nombre, cantidad_en_stock FROM producto
WHERE cantidad_en_stock = (SELECT MAX(cantidad_en_stock) from producto);

--  6. Devuelve el producto que menos unidades tiene en stock.
SELECT nombre, cantidad_en_stock FROM producto
WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) from producto);

--  7. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.
SELECT e.nombre, e.apellido1, e.apellido2, e.email FROM empleado e 
JOIN empleado j on e.codigo_jefe = j.codigo_empleado
WHERE  concat(j.nombre,' ', j.apellido1) = 'Alberto Soria';


--  1.4.8.2 Subconsultas con ALL y ANY
--  8. Devuelve el nombre del cliente con mayor límite de crédito.
SELECT * from cliente 
WHERE limite_credito  >= ALL (SELECT limite_credito FROM cliente);

--  9. Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT * FROM producto
WHERE precio_venta >= ALL (SELECT precio_venta from producto);

--  10. Devuelve el producto que menos unidades tiene en stock.
SELECT * FROM producto
WHERE cantidad_en_stock <= ALL (SELECT cantidad_en_stock from producto);

--  1.4.8.3 Subconsultas con IN y NOT IN
--  11. Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
SELECT nombre, apellido1, puesto FROM empleado
WHERE  codigo_empleado not in (SELECT codigo_empleado_rep_ventas FROM cliente);

--  12. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT * FROM cliente
WHERE codigo_cliente not in (SELECT codigo_cliente FROM pago);

--  13. Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.
SELECT * FROM cliente
WHERE codigo_cliente in (SELECT codigo_cliente FROM pago);

--  14. Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT * FROM producto
WHERE codigo_producto not in (SELECT codigo_producto FROM detalle_pedido);

--  15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
SELECT e.nombre, e.apellido1, e.apellido2, e.puesto, o.telefono FROM empleado e
JOIN oficina o on e.codigo_oficina = o.codigo_oficina
WHERE  codigo_empleado not in (SELECT codigo_empleado_rep_ventas FROM cliente);

--  16. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas 
--  de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
SELECT * FROM oficina
WHERE codigo_oficina in (SELECT codigo_oficina FROM empleado
						 WHERE codigo_empleado in (SELECT codigo_empleado_rep_ventas FROM cliente
												    WHERE codigo_cliente not in (SELECT DISTINCT codigo_cliente FROM pedido 
																			      WHERE codigo_pedido in (SELECT codigo_pedido FROM detalle_pedido
																									      WHERE codigo_producto in (SELECT codigo_producto FROM producto WHERE gama = 'Frutales')))));

--  17. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
SELECT * FROM cliente
WHERE codigo_cliente not in ( SELECT codigo_cliente FROM pago) and codigo_cliente in (SELECT codigo_cliente FROM pedido);

--  1.4.8.4 Subconsultas con EXISTS y NOT EXISTS
--  18. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT * FROM cliente c
WHERE NOT EXISTS (SELECT * FROM pago p WHERE c.codigo_cliente = p.codigo_cliente);

--  19. Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.
SELECT * FROM cliente c
WHERE EXISTS (SELECT * FROM pago p WHERE c.codigo_cliente = p.codigo_cliente);

--  20. Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT * FROM producto p
WHERE NOT EXISTS (SELECT * FROM detalle_pedido pe WHERE p.codigo_producto = pe.codigo_producto);

--  21. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
SELECT * FROM producto p
WHERE EXISTS (SELECT * FROM detalle_pedido pe WHERE p.codigo_producto = pe.codigo_producto);

--  1.4.9 Consultas variadas
--  1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. 
--  Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.

SELECT c.nombre_cliente, a.cant_pedidos FROM cliente c 
LEFT JOIN (SELECT codigo_cliente, count(codigo_pedido) cant_pedidos FROM pedido GROUP BY codigo_cliente) a on c.codigo_cliente = a.codigo_cliente;

--  2. Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. 
--  Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.
SELECT c.nombre_cliente, a.total_pagado FROM cliente c 
LEFT JOIN (SELECT codigo_cliente, sum(total) total_pagado FROM pago GROUP BY codigo_cliente) a on c.codigo_cliente = a.codigo_cliente;

--  3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.

SELECT nombre_cliente FROM cliente
WHERE codigo_cliente in (SELECT codigo_cliente FROM pedido WHERE year(fecha_pedido)=2008)
ORDER BY nombre_cliente;

--  4. Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas 
--  y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.
                              
SELECT c.codigo_cliente, c.nombre_cliente, c.codigo_empleado_rep_ventas,  concat(e.nombre,' ', e.apellido1) empleado, o.telefono 
FROM cliente c  LEFT JOIN pago p on c.codigo_cliente=p.codigo_cliente 
JOIN empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o on e.codigo_oficina = o.codigo_oficina
WHERE p.codigo_cliente is null;		
                              
--  5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas 
--  y la ciudad donde está su oficina.

SELECT c.codigo_cliente, c.nombre_cliente, c.codigo_empleado_rep_ventas,  concat(e.nombre,' ', e.apellido1) empleado, o.ciudad 
FROM cliente c  JOIN empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o on e.codigo_oficina = o.codigo_oficina;	

--  6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
SELECT concat(e.nombre,' ', e.apellido1) empleado, e.puesto, o.telefono
FROM empleado e JOIN oficina o on e.codigo_oficina = o.codigo_oficina
WHERE codigo_empleado not in (SELECT codigo_empleado_rep_ventas FROM cliente);

--  7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.
SELECT o.ciudad, COUNT(codigo_empleado) cant_empleados
FROM empleado e JOIN oficina o on e.codigo_oficina = o.codigo_oficina
GROUP BY o.ciudad;