-- Fuente: https://josejuansanchez.org/bd/ejercicios-consultas-sql/index.html#modelo-entidadrelaci%C3%B3n-2

-- 1.2 Gestión de empleados
-- Cargar la base de datos de 1.2 Gestión de empleados-base de datos.

USE empleados;


--  1.2.3 Consultas sobre una tabla

--  1.Lista el primer apellido de todos los empleados.
SELECT apellido1 FROM empleado;

--  2.Lista el primer apellido de los empleados eliminando los apellidos que estén repetidos.
SELECT DISTINCT(apellido1) FROM empleado;

--  3.Lista todas las columnas de la tablaempleado.
SELECT * FROM empleado;

--  4.Lista el nombre y los apellidos de todos los empleados.
SELECT nombre, apellido1, apellido2 FROM empleado;

--  5.Lista el código de los departamentos de los empleados que aparecen en la tablaempleado.
SELECT codigo_departamento FROM empleado;
--  6.Lista el código de los departamentos de los empleados que aparecen en la tablaempleado, eliminando los códigos que aparecen repetidos.
SELECT DISTINCT(codigo_departamento) FROM empleado;

--  7.Lista el nombre y apellidos de los empleados en una única columna.
SELECT CONCAT(nombre,' ', apellido1, ' ' ,apellido2) as Nombre_completo FROM empleado;

--  8.Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en mayúscula.
SELECT UPPER(CONCAT(nombre,' ', apellido1, ' ' ,apellido2)) as Nombre_completo FROM empleado;

--  9.Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en minúscula.
SELECT LOWER(CONCAT(nombre,' ', apellido1, ' ' ,apellido2)) as Nombre_completo FROM empleado;

--  10.Lista el código de los empleados junto al nif, pero el nif deberá aparecer en dos columnas, una mostrará únicamente los dígitos del nif 
--  y la otra la letra.
SELECT codigo, nif, REGEXP_SUBSTR(nif,"[0-9]+") as nif_num ,
CASE
    WHEN STRCMP(REGEXP_SUBSTR(nif,"[A-Z]+", 1), REGEXP_SUBSTR(nif,"[A-Z]+", CHARACTER_LENGTH(nif))) = 0 THEN REGEXP_SUBSTR(nif,"[A-Z]+", 1)
    ELSE CONCAT(REGEXP_SUBSTR(nif,"[A-Z]+", 1),REGEXP_SUBSTR(nif,"[A-Z]+", CHARACTER_LENGTH(nif)))
END as nif_letters
FROM empleado
ORDER BY codigo ASC;

SELECT codigo, nif, REGEXP_SUBSTR(nif,"[^0-9]+") as nif_letters FROM empleado;
SELECT codigo, nif, REGEXP_SUBSTR(nif,"[A-Z]*") as nif_letters, REGEXP_SUBSTR(nif,"[A-Z]+") as nif_letters2 FROM empleado;

SELECT nif,left(nif,8),right(nif,1)
FROM empleado;

--  11.Lista el nombre de cada departamento y el valor del presupuesto actual del que dispone. 
--  Para calcular este dato tendrá que restar al valor del presupuesto inicial (columnapresupuesto) los gastos que se han generado (columnagastos). 
-- Tenga en cuenta que en algunos casos pueden existir valores negativos. Utilice un alias apropiado para la nueva columna columna que está calculando.

SELECT * FROM departamento;

SELECT nombre, (presupuesto-gastos) as presupuesto_actual FROM departamento;

--  12.Lista el nombre de los departamentos y el valor del presupuesto actual ordenado de forma ascendente.
SELECT nombre, (presupuesto-gastos) as presupuesto_actual 
FROM departamento
ORDER BY presupuesto_actual asc ;

--  13.Lista el nombre de todos los departamentos ordenados de forma ascendente.
SELECT nombre FROM departamento
ORDER BY nombre asc ;

--  14.Lista el nombre de todos los departamentos ordenados de forma desscendente.
SELECT nombre FROM departamento
ORDER BY nombre DESC ;

--  15.Lista los apellidos y el nombre de todos los empleados, ordenados de forma alfabética tendiendo en cuenta en primer lugar sus apellidos y luego su nombre.


--  16.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.
SELECT nombre, presupuesto  FROM departamento
ORDER BY presupuesto DESC 
LIMIT 3;

--  17.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen menor presupuesto.
SELECT nombre, presupuesto  FROM departamento
ORDER BY presupuesto ASC 
LIMIT 3;

--  18.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen mayor gasto.
SELECT nombre, gastos FROM departamento
ORDER BY gastos DESC
LIMIT 3;

--  19.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen menor gasto.
SELECT nombre, gastos FROM departamento
ORDER BY gastos ASC
LIMIT 3;

--  20.Devuelve una lista con 5 filas a partir de la tercera fila de la tablaempleado. La tercera fila se debe incluir en la respuesta. 
-- La respuesta debe incluir todas las columnas de la tablaempleado.

SELECT * FROM empleado LIMIT 5 OFFSET 2;

--  21.Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto mayor o igual a 150000 euros.
SELECT nombre, presupuesto  FROM departamento
WHERE presupuesto >= 150000;

--  22.Devuelve una lista con el nombre de los departamentos y el gasto, de aquellos que tienen menos de 5000 euros de gastos.
SELECT nombre, gastos  FROM departamento
WHERE gastos <= 5000;

--  23.Devuelve una lista con el nombre de los departamentos y el presupesto, de aquellos que tienen un presupuesto entre 100000 y 200000 euros. 
--  Sin utilizar el operadorBETWEEN.
SELECT nombre, presupuesto  FROM departamento
WHERE presupuesto >= 100000 AND presupuesto <= 200000;

--  24.Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operadorBETWEEN.
SELECT nombre, presupuesto  FROM departamento
WHERE presupuesto <= 100000 or presupuesto >= 200000;

--  25.Devuelve una lista con el nombre de los departamentos que tienen un presupuesto entre 100000 y 200000 euros. Utilizando el operadorBETWEEN.
SELECT nombre, presupuesto  FROM departamento
WHERE presupuesto BETWEEN 100000 AND 200000;

--  26.Devuelve una lista con el nombre de los departamentos quenotienen un presupuesto entre 100000 y 200000 euros. Utilizando el operadorBETWEEN.
SELECT nombre, presupuesto  FROM departamento
WHERE presupuesto NOT BETWEEN 100000 AND 200000;

--  27.Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de quellos departamentos donde 
--  los gastos sean mayores que el presupuesto del que disponen.
SELECT nombre, presupuesto, gastos  FROM departamento
WHERE gastos > presupuesto;

--  28.Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos 
--  donde los gastos sean menores que el presupuesto del que disponen.
SELECT nombre, presupuesto, gastos  FROM departamento
WHERE gastos < presupuesto;

--  29.Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos 
--  donde los gastos sean iguales al presupuesto del que disponen.
SELECT nombre, presupuesto, gastos  FROM departamento
WHERE gastos = presupuesto;

--  30.Lista todos los datos de los empleados cuyo segundo apellido sea NULL.
SELECT * FROM empleado
WHERE apellido2 IS NULL;

--  31.Lista todos los datos de los empleados cuyo segundo apellido no sea NULL.
SELECT * FROM empleado
WHERE apellido2 not LIKE ':alpha:';

--  32.Lista todos los datos de los empleados cuyo segundo apellido sea López.
SELECT * FROM empleado
WHERE apellido2 = 'López';

--  33.Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. Sin utilizar el operadorIN.
SELECT * FROM empleado
WHERE apellido2 = 'Díaz' or apellido2 ='Moreno';

--  34.Lista todos los datos de los empleados cuyo segundo apellido seaDíazoMoreno. Utilizando el operadorIN.
SELECT * FROM empleado
WHERE apellido2 in ('Díaz' ,'Moreno');

--  35.Lista los nombres, apellidos y nif de los empleados que trabajan en el departamento3.
SELECT nif, nombre, apellido1, apellido2 FROM empleado 
WHERE codigo_departamento =3;

--  36.Lista los nombres, apellidos y nif de los empleados que trabajan en los departamentos2,4o5.
SELECT nif, nombre, apellido1, apellido2 FROM empleado 
WHERE codigo_departamento in (2, 4, 5);

--  1.2.4Consultas multitabla (Composición interna)
--  Resuelva todas las consultas utilizando la sintaxis deSQL1ySQL2.

--  1.Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.

SELECT e.codigo as Codigo_Empleado, 
	  CONCAT(e.nombre,' ', e.apellido1, ' ' ,e.apellido2) as Nombre_Empleado, 
      d.nombre as Departamento 
FROM empleado e join  departamento d on d.codigo = e.codigo_departamento
ORDER BY Codigo_Empleado;

--  2.Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. 
--  Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) y en segundo lugar por los apellidos y el nombre de los empleados.
SELECT e.codigo as Codigo_Empleado, 
	  CONCAT(e.nombre,' ', e.apellido1, ' ' ,e.apellido2) as Nombre_Empleado, 
      d.nombre as Departamento 
FROM empleado e join  departamento d on d.codigo = e.codigo_departamento
ORDER BY Departamento ASC, Nombre_Empleado ASC;

--  3.Devuelve un listado con el código y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.

SELECT DISTINCT d.codigo, d.nombre as Departamento
FROM empleado e join  departamento d on d.codigo = e.codigo_departamento;

--  4.Devuelve un listado con el código, el nombre del departamento y el valor del presupuesto actual del que dispone, 
--  solamente de aquellos departamentos que tienen empleados. El valor del presupuesto actual lo puede calcular restando al valor del presupuesto inicial (columnapresupuesto) el valor de los gastos que ha generado (columnagastos).

SELECT DISTINCT d.codigo, d.nombre as Departamento,  (presupuesto-gastos) as presupuesto_actual 
FROM empleado e join  departamento d on d.codigo = e.codigo_departamento;

--  5.Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif38382980M.
SELECT  d.nombre as Departamento
FROM empleado e join  departamento d on d.codigo = e.codigo_departamento
WHERE e.nif = '38382980M';

--  6.Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.
SELECT  d.nombre as Departamento
FROM empleado e join  departamento d on d.codigo = e.codigo_departamento
WHERE CONCAT(e.nombre,' ', e.apellido1, ' ' ,e.apellido2) = 'Pepe Ruiz Santana';

--  7.Devuelve un listado con los datos de los empleados que trabajan en el departamento deI+D. Ordena el resultado alfabéticamente.
SELECT  e.codigo as Codigo_Empleado, 
		nif,
		CONCAT(e.nombre,' ', e.apellido1, ' ' ,e.apellido2) as Nombre_Empleado
FROM empleado e join  departamento d on d.codigo = e.codigo_departamento
WHERE d.nombre = 'I+D';

--  8.Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas,Contabilidado I+D. 
--  Ordena el resultado alfabéticamente.
SELECT  e.codigo as Codigo_Empleado, 
		nif,
		CONCAT(e.nombre,' ', e.apellido1, ' ' ,e.apellido2) as Nombre_Empleado
FROM empleado e join  departamento d on d.codigo = e.codigo_departamento
WHERE d.nombre IN ('Sistemas', 'Contabilidad', 'I+D');

--  9.Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre 100000 y 200000 euros.
SELECT  e.codigo as Codigo_Empleado, 
		nif,
		CONCAT(e.nombre,' ', e.apellido1, ' ' ,e.apellido2) as Nombre_Empleado
FROM empleado e join  departamento d on d.codigo = e.codigo_departamento
WHERE d.presupuesto  NOT BETWEEN 100000 AND 200000;

--  10.Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido seaNULL. Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos.
SELECT  d.nombre as Departamento
FROM empleado e join  departamento d on d.codigo = e.codigo_departamento
WHERE e.apellido2 is null;

--  1.2.5Consultas multitabla (Composición externa)
--  Resuelva todas las consultas utilizando las cláusulasLEFT JOINyRIGHT JOIN.

--  1.Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. 
--  Este listado también debe incluir los empleados que no tienen ningún departamento asociado.
SELECT e.codigo , CONCAT(e.nombre,' ', e.apellido1, ' ' ,e.apellido2) as Nombre_Empleado, d.nombre as Departamento
FROM empleado e LEFT JOIN  departamento d on d.codigo = e.codigo_departamento;

--  2.Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.
SELECT e.codigo , CONCAT(e.nombre,' ', e.apellido1, ' ' ,e.apellido2) as Nombre_Empleado, d.nombre as Departamento
FROM empleado e LEFT JOIN  departamento d on d.codigo = e.codigo_departamento
WHERE d.nombre is NULL;

--  3.Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.
SELECT e.codigo , CONCAT(e.nombre,' ', e.apellido1, ' ' ,e.apellido2) as Nombre_Empleado, d.nombre as Departamento
FROM empleado e RIGHT JOIN  departamento d on d.codigo = e.codigo_departamento
WHERE CONCAT(e.nombre,' ', e.apellido1, ' ' ,e.apellido2) is NULL;

--  4.Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. 
--  El listado debe incluir los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. 
--  Ordene el listado alfabéticamente por el nombre del departamento.
SELECT e.codigo , CONCAT(e.nombre,' ', e.apellido1, ' ' ,e.apellido2) as Nombre_Empleado, d.nombre as Departamento
FROM empleado e LEFT JOIN  departamento d on d.codigo = e.codigo_departamento
UNION
SELECT e.codigo , CONCAT(e.nombre,' ', e.apellido1, ' ' ,e.apellido2) as Nombre_Empleado, d.nombre as Departamento
FROM empleado e RIGHT JOIN  departamento d on d.codigo = e.codigo_departamento
ORDER BY Departamento;

--  5.Devuelve un listado con los empleados que no tienen ningún departamentoasociado y los departamentos que no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.
SELECT e.codigo , CONCAT(e.nombre,' ', e.apellido1, ' ' ,e.apellido2) as Nombre_Empleado, d.nombre as Departamento
FROM empleado e LEFT JOIN  departamento d on d.codigo = e.codigo_departamento
WHERE d.nombre is NULL
UNION
SELECT e.codigo , CONCAT(e.nombre,' ', e.apellido1, ' ' ,e.apellido2) as Nombre_Empleado, d.nombre as Departamento
FROM empleado e RIGHT JOIN  departamento d on d.codigo = e.codigo_departamento
WHERE CONCAT(e.nombre,' ', e.apellido1, ' ' ,e.apellido2) is NULL;

--  1.2.6Consultas resumen
--  1.Calcula la suma del presupuesto de todos los departamentos.
SELECT sum(presupuesto) as presupuesto_total FROM departamento;

--  2.Calcula la media del presupuesto de todos los departamentos.
SELECT AVG(presupuesto) as presupuesto_total FROM departamento;

--  3.Calcula el valor mínimo del presupuesto de todos los departamentos.
SELECT MIN(presupuesto) as presupuesto_total FROM departamento;

--  4.Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con menor presupuesto.
SELECT nombre, presupuesto FROM departamento
WHERE presupuesto = (SELECT MIN(presupuesto) as presupuesto_total FROM departamento);

--  5.Calcula el valor máximo del presupuesto de todos los departamentos.
SELECT MAX(presupuesto) as presupuesto_total FROM departamento;

--  6.Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con mayor presupuesto.
SELECT nombre, presupuesto FROM departamento
WHERE presupuesto = (SELECT MAX(presupuesto) as presupuesto_total FROM departamento);

--  7.Calcula el número total de empleados que hay en la tabla empleado.
SELECT count(nombre) as total_empleados FROM empleado;

--  8.Calcula el número de empleados queno tienenNULLen su segundo apellido.
SELECT count(nombre) as total_empleados FROM empleado
WHERE apellido2 is null;

--  9.Calcula el número de empleados que hay en cada departamento. 
--  Tienes que devolver dos columnas, una con el nombre del departamento y otra con el número de empleados que tiene asignados.
SELECT d.nombre, count(e.nombre) as total_empleados
FROM empleado e JOIN  departamento d on d.codigo = e.codigo_departamento
GROUP BY e.codigo_departamento;

--  10.Calcula el nombre de los departamentos que tienen más de 2 empleados. 
--  El resultado debe tener dos columnas, una con el nombre del departamento y otra con el número de empleados que tiene asignados.
SELECT Departamento, total_empleados FROM
	(SELECT d.nombre as Departamento, count(e.nombre) as total_empleados
	FROM empleado e JOIN  departamento d on d.codigo = e.codigo_departamento
	GROUP BY e.codigo_departamento) as s
WHERE total_empleados=2;

--  11.Calcula el número de empleados que trabajan en cada uno de los departamentos. 
--  El resultado de esta consulta también tiene que incluir aquellos departamentos que no tienen ningún empleado asociado.
SELECT d.nombre, count(e.nombre) as total_empleados
FROM empleado e RIGHT JOIN  departamento d on d.codigo = e.codigo_departamento
GROUP BY e.codigo_departamento;


--  12.Calcula el número de empleados que trabajan en cada unos de los departamentos que tienen un presupuesto mayor a 200000 euros.
SELECT d.nombre, count(e.nombre) as total_empleados
FROM empleado e JOIN  departamento d on d.codigo = e.codigo_departamento
WHERE D.presupuesto>200000
GROUP BY e.codigo_departamento;

--  1.2.7Subconsultas
--  1.2.7.1 Con operadores básicos de comparación
--  1.Devuelve un listado con todos los empleados que tiene el departamento deSistemas. (Sin utilizarINNER JOIN).

SELECT * FROM empleado
WHERE codigo_departamento = (SELECT codigo FROM departamento 
							WHERE nombre='Sistemas');

--  2.Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada.
SELECT nombre, presupuesto from departamento 
WHERE presupuesto = (SELECT MAX(presupuesto) FROM departamento);

--  3.Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada.
SELECT nombre, presupuesto from departamento 
WHERE presupuesto = (SELECT MIN(presupuesto) FROM departamento);

--  1.2.7.2 Subconsultas conALLyANY
--  4.Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada. Sin hacer uso de MAX,ORDER BY ni LIMIT.
SELECT nombre, presupuesto from departamento 
WHERE presupuesto  >= ALL (SELECT presupuesto FROM departamento);

--  5.Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada. Sin hacer uso deMIN,ORDER BYniLIMIT.

SELECT nombre, presupuesto from departamento 
WHERE presupuesto <= ALL (SELECT presupuesto FROM departamento);

--  6.Devuelve los nombres de los departamentos que tienen empleados asociados. (UtilizandoALLoANY).

SELECT nombre as Departamento FROM departamento 
WHERE codigo = ANY(SELECT DISTINCT(codigo_departamento) from empleado);

--  7.Devuelve los nombres de los departamentos que no tienen empleados asociados. (UtilizandoALLoANY).
SELECT nombre as Departamento FROM departamento 
WHERE codigo != ALL(SELECT codigo_departamento from empleado);

--  1.2.7.3Subconsultas conINyNOT IN
--  8.Devuelve los nombres de los departamentos que tienen empleados asociados. (UtilizandoINoNOT IN).
SELECT nombre as Departamento FROM departamento 
WHERE codigo in (SELECT DISTINCT(codigo_departamento) from empleado);

--  9.Devuelve los nombres de los departamentos que no tienen empleados asociados. (UtilizandoINoNOT IN).
SELECT nombre as Departamento FROM departamento 
WHERE codigo not in (SELECT codigo_departamento from empleado);

--  
--  1.2.7.4 Subconsultas conEXISTSyNOT EXISTS
--  10.Devuelve los nombres de los departamentos que tienen empleados asociados. (UtilizandoEXISTSoNOT EXISTS).

SELECT nombre as Departamento FROM departamento d
WHERE EXISTS (SELECT codigo_departamento FROM empleado e 
			  where d.codigo = e.codigo_departamento);

--  11.Devuelve los nombres de los departamentos que tienen empleados asociados. (UtilizandoEXISTSoNOT EXISTS).
SELECT nombre as Departamento FROM departamento d
WHERE NOT EXISTS (SELECT codigo_departamento FROM empleado e 
				  where d.codigo = e.codigo_departamento);