-- Fuente: https://josejuansanchez.org/bd/ejercicios-consultas-sql/index.html#modelo-entidadrelaci%C3%B3n-2

-- 1.1 Tienda de informática
-- Cargar la base de datos de 1.1 Tienda de informática-base de datos

USE tienda;

--  1.1.3 Consultas sobre una tabla

--  1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre FROM producto;

--  2. Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio FROM producto;

--  3. Lista todas las columnas de la tabla producto.
SELECT * FROM producto;

--  4. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
--  hoy 13/07 1 euro 1.01 euro
SELECT nombre, precio as 'Precio en euros', precio*1.01 as 'Precio en USD' FROM producto;

--  5. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.
SELECT nombre as 'Nombre de producto', precio*0.99 as 'Euros', precio as 'Dolares' FROM producto;

--  6. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.

SELECT UPPER(nombre) AS nombre, precio FROM producto;

--  7. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.
SELECT lower(nombre) AS nombre, precio FROM producto;

--  8. Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
SELECT * FROM fabricante;
SELECT nombre, CONCAT(UPPER(LEFT(nombre, 2)), LOWER(SUBSTRING(nombre, 3))) AS nombre2 FROM  fabricante;

--  9. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT nombre, round(precio, 0) as precio from producto;

--  10. Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
SELECT nombre, round(precio, 0)  as precio from producto;

--  11. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT f.codigo FROM fabricante f JOIN producto p ON p.codigo_fabricante = f.codigo;

--  12. Lista el código de los fabricantes que tienen productos en la tabla producto, eliminando los códigos que aparecen repetidos.
SELECT DISTINCT(f.codigo) FROM fabricante f JOIN producto p ON p.codigo_fabricante = f.codigo;

--  13. Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre FROM fabricante
ORDER BY nombre asc;

--  14. Lista los nombres de los fabricantes ordenados de forma descendente.
SELECT nombre FROM fabricante
ORDER BY nombre desc;

--  15. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT nombre, precio FROM producto
ORDER BY nombre asc, precio desc;

--  16. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM fabricante
LIMIT 5;

--  17. Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.
SELECT * FROM fabricante
WHERE codigo >= 4
LIMIT 2;

SELECT * FROM fabricante
WHERE codigo in (4,5);

SELECT * FROM fabricante LIMIT 2 OFFSET 3;

--  18. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre, precio FROM producto
ORDER BY precio asc
LIMIT 1;

--  19. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre, precio FROM producto
ORDER BY precio DESC
LIMIT 1;

--  20. Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.
SELECT codigo, nombre FROM fabricante
WHERE codigo = 2;

--  21. Lista el nombre de los productos que tienen un precio menor o igual a 120€.
SELECT nombre from producto 
WHERE precio <= 120;

--  22. Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
SELECT nombre from producto 
WHERE precio >= 400;

--  23. Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.
SELECT nombre from producto 
WHERE precio <= 400;

--  24. Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.
SELECT nombre, precio FROM producto
WHERE precio BETWEEN 80 AND 300;

--  25. Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.
SELECT nombre, precio FROM producto
WHERE precio BETWEEN 60 AND 200;

--  26. Lista todos los productos que tengan un precio mayor que 200€ y que el código de fabricante sea igual a 6.
SELECT nombre, precio FROM producto
WHERE precio BETWEEN 80 AND 300;

--  27. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.
SELECT nombre FROM producto
WHERE codigo_fabricante=1 or codigo_fabricante=3 or codigo_fabricante=5;

--  28. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT nombre FROM producto
WHERE codigo_fabricante IN (1, 3 , 5);

--  29. Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). Cree un alias para la columna que contiene el precio que se llame céntimos.
SELECT nombre, precio*100 as 'precio en céntimos'
FROM producto;

--  30. Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
SELECT nombre FROM fabricante
WHERE nombre LIKE 'S%';

--  31. Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
SELECT nombre FROM fabricante
WHERE nombre LIKE '%e';

--  32. Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
SELECT nombre FROM fabricante
WHERE nombre LIKE '%w%';

--  33. Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
SELECT nombre FROM fabricante
WHERE CHARACTER_LENGTH(nombre)=4;

--  34. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
SELECT nombre FROM producto
WHERE nombre LIKE '%Portátil%';

--  35. Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.
SELECT nombre FROM producto
WHERE nombre LIKE '%Monitor%' AND precio < 215;

--  36. Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. 
--  Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).
SELECT nombre, precio FROM producto
WHERE precio >= 180
ORDER BY precio DESC, nombre ASC;


--  1.1.4 Consultas multitabla (Composición interna)
--  Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.


--  1. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
SELECT p.nombre as Producto, p.precio as Precio, f.nombre as Fabricante FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante;
SELECT * FROM producto;


--  2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
--  Ordene el resultado por el nombre del fabricante, por orden alfabético.
SELECT p.nombre as Producto, p.precio as Precio, f.nombre as Fabricante FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
ORDER BY f.nombre ASC;

--  3. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
SELECT p.codigo as Codigo_Producto, p.nombre as Producto_Nombre, f.codigo as Codigo_Fabricante, f.nombre as Fabricante_Nombre FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante;

--  4. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT p.nombre as Producto, p.precio as Precio, f.nombre as Fabricante FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
ORDER BY p.precio ASC
LIMIT 1;

--  5. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
SELECT p.nombre as Producto, p.precio as Precio, f.nombre as Fabricante FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
ORDER BY p.precio DESC
LIMIT 1;

--  6. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT p.nombre as Producto FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE f.nombre = 'Lenovo';

--  7. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
SELECT p.nombre as Producto FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE f.nombre = 'Crucial' and p.precio > 200;

--  8. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Sin utilizar el operador IN.
SELECT p.nombre as Producto FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE f.nombre = 'Asus' or f.nombre = 'Hewlett-Packardy Seagate';

--  9. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.
SELECT p.nombre as Producto FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE f.nombre IN ('Asus' ,'Hewlett-Packardy Seagate');

--  10. Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.
SELECT p.nombre as Producto, p.precio as Precio FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE f.nombre LIKE '%e';

--  11. Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
SELECT p.nombre as Producto, p.precio as Precio, f.nombre FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE f.nombre IN (SELECT nombre FROM fabricante WHERE nombre LIKE '%w%');

--  12. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. 
--  Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT p.nombre as Producto, p.precio as Precio, f.nombre as Fabricante FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre ASC;


--  13. Devuelve un listado con el código y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.
SELECT p.codigo_fabricante as Codigo_Fabricante, f.nombre as Fabricante FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante;

--  1.1.5 Consultas multitabla (Composición externa)
--  Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.


--  1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. 
-- El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
SELECT p.nombre as Producto, f.nombre as Fabricante FROM producto p 
RIGHT JOIN fabricante f ON f.codigo = p.codigo_fabricante;

--  2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.

SELECT p.nombre as Producto, f.nombre as Fabricante FROM producto p 
RIGHT JOIN fabricante f ON f.codigo = p.codigo_fabricante WHERE p.nombre is Null;


--  3. ¿Pueden existir productos que no estén relacionados con un fabricante? Justifique su respuesta.



--  1.1.6 Consultas resumen

--  1. Calcula el número total de productos que hay en la tabla productos.
SELECT count(nombre) as total_productos FROM producto;

--  2. Calcula el número total de fabricantes que hay en la tabla fabricante.
SELECT count(nombre) as total_fabricantes FROM fabricante;

--  3. Calcula el número de valores distintos de código de fabricante aparecen en la tabla productos.
SELECT count(DISTINCT(codigo_fabricante)) as distinto_codigo from producto;

--  4. Calcula la media del precio de todos los productos.
SELECT round(AVG(precio),2) as valor_medio FROM producto;

--  5. Calcula el precio más barato de todos los productos.
SELECT MIN(precio) 'precio más barato' FROM producto;

--  6. Calcula el precio más caro de todos los productos.
SELECT MAX(precio) 'precio más caro' FROM producto;

--  7. Lista el nombre y el precio del producto más barato.
SELECT nombre, precio FROM producto
WHERE precio = (SELECT MIN(precio)  as precio FROM producto);

--  8. Lista el nombre y el precio del producto más caro.
SELECT nombre, precio FROM producto
WHERE precio = (SELECT MAX(precio)  as precio FROM producto);

--  9. Calcula la suma de los precios de todos los productos.
SELECT sum(precio) 'total precio' FROM producto;

--  10. Calcula el número de productos que tiene el fabricante Asus.
SELECT count(p.nombre) FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE f.nombre = 'Asus';

--  11. Calcula la media del precio de todos los productos del fabricante Asus.
SELECT AVG(p.precio) FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE f.nombre = 'Asus';

--  12. Calcula el precio más barato de todos los productos del fabricante Asus.
SELECT MIN(p.precio) FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE f.nombre = 'Asus';

--  13. Calcula el precio más caro de todos los productos del fabricante Asus.
SELECT MAX(p.precio) FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE f.nombre = 'Asus';

--  14. Calcula la suma de todos los productos del fabricante Asus.
SELECT SUM(p.precio) FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE f.nombre = 'Asus';

--  15. Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene el fabricante Crucial.
SELECT MAX(p.precio) 'precio máximo', MIN(p.precio) 'precio mínimo', AVG(p.precio) 'precio medio', COUNT(p.precio) 'número total' FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE f.nombre = 'Crucial';

--  16. Muestra el número total de productos que tiene cada uno de los fabricantes. 
--  El listado también debe incluir los fabricantes que no tienen ningún producto. 
--  El resultado mostrará dos columnas, una con el nombre del fabricante y otra con el número de productos que tiene. 
--  Ordene el resultado descendentemente por el número de productos.

SELECT  f.nombre as Fabricante, count(p.codigo_fabricante) as Totales FROM producto p 
RIGHT JOIN fabricante f ON f.codigo = p.codigo_fabricante
GROUP BY p.codigo_fabricante
ORDER BY Totales DESC;

--  17. Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes. 
--  El resultado mostrará el nombre del fabricante junto con los datos que se solicitan.
SELECT f.nombre as Fabricante, MAX(p.precio) precio_máximo, MIN(p.precio) precio_mínimo, AVG(p.precio) precio_medio FROM producto p 
JOIN fabricante f ON f.codigo = p.codigo_fabricante
GROUP BY f.nombre;

--  18. Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen 
--  un precio medio superior a 200€. No es necesario mostrar el nombre del fabricante, con el código del fabricante es suficiente.
SELECT AVG(precio) precio_medio, 
		   codigo_fabricante,  
		   MAX(precio) precio_máximo ,
		   MIN(precio) precio_mínimo,
		   COUNT(precio) Total
	from producto
	GROUP BY codigo_fabricante;

SELECT codigo_fabricante, precio_medio, precio_máximo, precio_mínimo, Total
FROM (SELECT AVG(precio) precio_medio, 
		   codigo_fabricante,  
		   MAX(precio) precio_máximo ,
		   MIN(precio) precio_mínimo,
		   COUNT(precio) Total
	from producto 
	GROUP BY codigo_fabricante) as a
WHERE precio_medio>200;

--  19. Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio medio y el número total de productos 
--  de los fabricantes que tienen un precio medio superior a 200€. Es necesario mostrar el nombre del fabricante.

SELECT Fabricante, codigo_fabricante, precio_medio, precio_máximo, precio_mínimo, Total
FROM (SELECT f.nombre as Fabricante,
	    AVG(p.precio) precio_medio, 
		codigo_fabricante,  
		MAX(p.precio) precio_máximo ,
		MIN(p.precio) precio_mínimo,
		COUNT(p.precio) Total
	from producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
	GROUP BY codigo_fabricante) as a
WHERE precio_medio>200;

--  20. Calcula el número de productos que tienen un precio mayor o igual a 180€.
SELECT count(precio) as total FROM producto
WHERE precio >= 180;

--  21. Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a 180€.
SELECT codigo_fabricante, count(precio) as total FROM producto
WHERE precio >= 180
GROUP BY codigo_fabricante;

--  22. Lista el precio medio los productos de cada fabricante, mostrando solamente el código del fabricante.
SELECT codigo_fabricante, AVG(precio) precio_medio FROM producto
GROUP BY codigo_fabricante;

--  23. Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre del fabricante.
SELECT  f.nombre as Fabricante, AVG(p.precio) precio_medio 
FROM producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
GROUP BY codigo_fabricante;

--  24. Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€.

SELECT Fabricante, precio_medio
FROM (SELECT f.nombre as Fabricante,
	    AVG(p.precio) precio_medio
	from producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
	GROUP BY codigo_fabricante) as a
WHERE precio_medio>150;

--  25. Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.

SELECT Fabricante,  Total
FROM (SELECT f.nombre as Fabricante,
		COUNT(p.precio) Total
	from producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
	GROUP BY codigo_fabricante) as a
WHERE Total>=2;

--  26. Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €. 
--  No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condición.

SELECT f.nombre as Fabricante,	COUNT(p.precio) Total
from producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE p.precio >= 220
GROUP BY p.codigo_fabricante; 

--  27. Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €. 
--  El listado debe mostrar el nombre de todos los fabricantes, es decir, si hay algún fabricante que no tiene productos con un precio superior 
--  o igual a 220€ deberá aparecer en el listado con un valor igual a 0 en el número de productos.

SELECT f.nombre as Fabricante, SUM(p.Total) Nro_productos
FROM 
	(SELECT codigo_fabricante, precio, 
		CASE
			WHEN precio >= 220 then 1 
			ELSE 0
		END as Total   
		FROM producto) p
JOIN fabricante f ON f.codigo = p.codigo_fabricante
GROUP BY p.codigo_fabricante
ORDER BY Nro_productos DESC ; 

--  28.Devuelve un listado con los nombres de los fabricantes donde la suma del precio de todos sus productos es superior a 1000 €.
SELECT f.nombre as Fabricante,	SUM(p.precio) Total
from producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE SUM(p.precio) >= 1000
GROUP BY p.codigo_fabricante; 

SELECT Fabricante, Total 
FROM
	(SELECT f.nombre as Fabricante,	SUM(p.precio) Total
	from producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
	GROUP BY p.codigo_fabricante) as a
WHERE Total >= 1000;

--  29.Devuelve un listado con el nombre del producto más caro que tiene cada fabricante. 
--  El resultado debe tener tres columnas: nombre del producto, precio y nombre del fabricante. 
--  El resultado tiene que estar ordenado alfabéticamente de menor a mayor por el nombre del fabricante.

SELECT p.nombre as Nombre_Producto, f.nombre as Fabricante, p.precio as Precio
FROM producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE p.precio in (SELECT MAX(precio)  as precio FROM producto
				GROUP BY codigo_fabricante)
ORDER BY Fabricante ASC;

--  1.1.7Subconsultas (En la cláusula WHERE)
--  1.1.7.1 Con operadores básicos de comparación

--  1.Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT nombre as Nombre_Producto
FROM producto
WHERE codigo_fabricante = (SELECT codigo FROM fabricante
						WHERE nombre = 'Lenovo');

--  2.Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. 
--  (Sin utilizarINNER JOIN).

SELECT * FROM producto
WHERE precio =
	(SELECT max(precio) as max_precio FROM producto
	WHERE codigo_fabricante = (SELECT codigo FROM fabricante
							WHERE nombre = 'Lenovo'));
                            
--  3.Lista el nombre del producto más caro del fabricante Lenovo.
SELECT nombre FROM producto 
WHERE precio = (SELECT max(p.precio) precio_maximo
				FROM producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
				WHERE f.nombre ='Lenovo')
    and codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre ='Lenovo');
                            
--  4.Lista el nombre del producto más barato del fabricante Hewlett-Packard.
SELECT nombre FROM producto 
WHERE precio = (SELECT min(p.precio) precio_maximo
				FROM producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
				WHERE f.nombre ='Hewlett-Packard')
    and codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre ='Hewlett-Packard');

--  5.Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.
SELECT * FROM producto
WHERE precio >=
	(SELECT max(precio) as max_precio FROM producto
	WHERE codigo_fabricante = (SELECT codigo FROM fabricante
							WHERE nombre = 'Lenovo'));

--  6.Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT * FROM producto 
WHERE precio >= (SELECT AVG(p.precio) precio_medio
				FROM producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
				WHERE f.nombre ='Asus')
    and codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre ='Asus');

SELECT * FROM producto  WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre ='Asus');

--  1.1.7.2 Subconsultas con ALL y ANY 
--  8.Devuelve el producto más caro que existe en la tablaproducto sin hacer uso de MAX, ORDER BY ni LIMIT.
SELECT * FROM producto 
WHERE precio >= ALL ( SELECT precio FROM producto);

--  9.Devuelve el producto más barato que existe en la tablaproductosin hacer uso de MIN,ORDER BY ni LIMIT.
SELECT * FROM producto 
WHERE precio <= ALL ( SELECT precio FROM producto);

--  10.Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).
SELECT f.nombre as Fabricante
FROM producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante;

SELECT nombre as Fabricante FROM fabricante 
WHERE codigo = ANY(SELECT DISTINCT(codigo_fabricante) from producto);

--  11.Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).
SELECT nombre as Fabricante FROM fabricante 
WHERE codigo != all (SELECT DISTINCT(codigo_fabricante) from producto);

--  1.1.7.3 Subconsultas con IN y NOT IN
--  12.Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre as Fabricante FROM fabricante 
WHERE codigo in (SELECT DISTINCT(codigo_fabricante) from producto);

--  13.Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre as Fabricante FROM fabricante 
WHERE codigo not in (SELECT DISTINCT(codigo_fabricante) from producto);

--  1.1.7.4 Subconsultas con EXISTS y NOT EXISTS
--  14.Devuelve los nombres de los fabricantes que tienen productos asociados. (UtilizandoEXISTS o NOT EXISTS).

SELECT nombre FROM fabricante
WHERE EXISTS  
	(SELECT nombre FROM fabricante 
	WHERE codigo in (SELECT DISTINCT(codigo_fabricante) from producto));

--  15.Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).
SELECT nombre FROM fabricante
WHERE NOT EXISTS  
	(SELECT nombre FROM fabricante 
	WHERE codigo in (SELECT DISTINCT(codigo_fabricante) from producto));

--  1.1.7.5 Subconsultas correlacionadas

--  16.Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.
SELECT precio, p.nombre Producto, f.nombre Fabricante
FROM producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE precio IN (SELECT MAX(precio) as precio_maximo FROM producto GROUP BY codigo_fabricante)
GROUP BY codigo_fabricante;


--  17.Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de todos los productos de su mismo fabricante.
SELECT precio, p.nombre Producto, f.nombre Fabricante
FROM producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE precio IN (SELECT AVG(precio) as precio_medio FROM producto GROUP BY codigo_fabricante)
GROUP BY codigo_fabricante;

--  18.Lista el nombre del producto más caro del fabricante Lenovo.
SELECT nombre FROM producto 
WHERE precio = (SELECT max(p.precio) precio_maximo
				FROM producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
				WHERE f.nombre ='Lenovo')
    and codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre ='Lenovo');

--  1.1.8Subconsultas (En la cláusula HAVING) 
--  7.Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo

SELECT count(p.precio) cantidad, codigo_fabricante
FROM producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
GROUP BY codigo_fabricante
ORDER BY cantidad DESC;

SELECT count(p.precio) cantidad,  f.nombre Fabricante
FROM producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
GROUP BY codigo_fabricante
HAVING cantidad = (SELECT count(p.precio) cantidad
				FROM producto p JOIN fabricante f ON f.codigo = p.codigo_fabricante
				WHERE f.nombre ='Lenovo');


