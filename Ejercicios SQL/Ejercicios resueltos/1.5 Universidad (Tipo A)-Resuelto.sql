-- Fuente: https://josejuansanchez.org/bd/ejercicios-consultas-sql/index.html#modelo-entidadrelaci%C3%B3n-2

-- 1.5 Universidad (Tipo A)
-- Cargar la base de datos de 1.5 Universidad (Tipo A)-base de datos

USE universidad;

--  1.5.4 Consultas sobre una tabla
--  1. Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos. 
--  El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.
SELECT apellido1, apellido2, nombre 
from persona WHERE tipo = 'alumno'
ORDER BY apellido1, apellido2, nombre;

--  2. Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
SELECT * from persona 
WHERE tipo = 'alumno' and telefono is null;

--  3. Devuelve el listado de los alumnos que nacieron en 1999.
SELECT * FROM persona 
WHERE tipo = 'alumno' and year(fecha_nacimiento)=1999;

--  4. Devuelve el listado de profesores que no han dado de alta su número de teléfono en la base de datos y además su nif termina en K.
SELECT * FROM persona 
WHERE tipo = 'profesor' and telefono is null and nif LIKE '%K';


--  5. Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.
SELECT * FROM asignatura WHERE cuatrimestre = 1;

--  1.5.5 Consultas multitabla (Composición interna)
--  1. Devuelve un listado con los datos de todas las alumnas que se han matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).
SELECT * FROM persona p join 
(SELECT mat.id_alumno FROM alumno_se_matricula_asignatura as mat 
JOIN (SELECT id FROM asignatura WHERE id_grado = 
			(SELECT id FROM grado WHERE nombre = 'Grado en Ingeniería Informática (Plan 2015)')) a 
            on mat.id_asignatura = a.id) b on p.id = b.id_alumno
WHERE sexo = 'M';
--  2. Devuelve un listado con todas las asignaturas ofertadas en el Grado en Ingeniería Informática (Plan 2015).
SELECT nombre FROM asignatura WHERE id_grado = (SELECT id FROM grado WHERE nombre = 'Grado en Ingeniería Informática (Plan 2015)');

--  3. Devuelve un listado de los profesores junto con el nombre del departamento al que están vinculados. 
--  El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del departamento. 
--  El resultado estará ordenado alfabéticamente de menor a mayor por los apellidos y el nombre.

SELECT  p.apellido1, p.apellido2, p.nombre, d.nombre as departamento  FROM persona p 
JOIN profesor pr on p.id = pr.id_profesor
JOIN departamento d on pr.id_departamento = d.id
WHERE tipo = 'profesor'
ORDER BY p.apellido1, p.apellido2, p.nombre;

--  4. Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno con nif 26902806M.

SELECT a.nombre, ce.anyo_inicio, ce.anyo_fin FROM alumno_se_matricula_asignatura mat
JOIN  curso_escolar ce on mat.id_curso_escolar = ce.id
JOIN asignatura a on mat.id_asignatura = a.id
WHERE mat.id_alumno = (SELECT id FROM persona WHERE nif = '26902806M');

SELECT * FROM alumno_se_matricula_asignatura;

--  5. Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura 
--  en el Grado en Ingeniería Informática (Plan 2015).
SELECT d.nombre FROM departamento d
join profesor p on d.id = p.id_departamento
WHERE p.id_profesor in (SELECT DISTINCT id_profesor FROM asignatura a  
						JOIN grado g on a.id_grado = g.id
						WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)');
                        
--  6. Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.

SELECT * FROM persona 
WHERE id in (SELECT id_alumno FROM alumno_se_matricula_asignatura mat
		JOIN  curso_escolar ce on mat.id_curso_escolar = ce.id
		WHERE ce.anyo_inicio = 2018 and ce.anyo_fin = 2019)
        AND tipo = 'alumno';

--  1.5.6 Consultas multitabla (Composición externa)
--  Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

--  1. Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados. 
--  El listado también debe mostrar aquellos profesores que no tienen ningún departamento asociado. 
--  El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor. 
--  El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.

SELECT d.nombre, p.apellido1, p.apellido2, p.nombre from persona p
join profesor pr on p.id = pr.id_profesor
LEFT JOIN departamento d on pr.id_departamento = d.id
ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;

--  2. Devuelve un listado con los profesores que no están asociados a un departamento.
SELECT d.nombre, p.apellido1, p.apellido2, p.nombre from persona p
join profesor pr on p.id = pr.id_profesor
LEFT JOIN departamento d on pr.id_departamento = d.id
WHERE d.id is null;

--  3. Devuelve un listado con los departamentos que no tienen profesores asociados.
SELECT * FROM departamento d
LEFT JOIN profesor pr on d.id = pr.id_departamento
WHERE pr.id_departamento is null;


--  4. Devuelve un listado con los profesores que no imparten ninguna asignatura.

SELECT p.id_profesor, pe.apellido1, pe.apellido2, pe.nombre FROM profesor p
LEFT JOIN  asignatura a on p.id_profesor = a.id_profesor
JOIN persona pe on p.id_profesor = pe.id
WHERE a.id_profesor is null;

--  5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.
SELECT * FROM asignatura WHERE id_profesor is null;

--  6. Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar. 
--  El resultado debe mostrar el nombre del departamento y el nombre de la asignatura que no se haya impartido nunca.

--  Revisar!

SELECT * FROM departamento d 
join profesor p on d.id = p.id_departamento
JOIN asignatura a on p.id_profesor = a.id_profesor
WHERE p.id_profesor not in (SELECT DISTINCT id_profesor FROM asignatura a 
							JOIN  alumno_se_matricula_asignatura mat on a.id = mat.id_asignatura
							JOIN curso_escolar ce on  mat.id_curso_escolar = ce.id);
SELECT * FROM asignatura;

SELECT * FROM departamento d 
join profesor p on d.id = p.id_departamento
WHERE p.id_profesor not in (SELECT DISTINCT id_profesor FROM asignatura a 
							JOIN  alumno_se_matricula_asignatura mat on a.id = mat.id_asignatura
							JOIN curso_escolar ce on  mat.id_curso_escolar = ce.id);

--  1.5.7 Consultas resumen
--  1. Devuelve el número total de alumnas que hay.
SELECT count(*) FROM persona
WHERE sexo = 'M' and tipo = 'alumno';

--  2. Calcula cuántos alumnos nacieron en 1999.
SELECT count(*) FROM persona
WHERE year(fecha_nacimiento) = 1999 and tipo = 'alumno';

--  3. Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, 
--  una con el nombre del departamento y otra con el número de profesores que hay en ese departamento. 
--  El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar 
--  ordenado de mayor a menor por el número de profesores.
SELECT d.id, count(id_profesor) as total_profesores FROM departamento d 
JOIN profesor p on d.id = p.id_departamento
GROUP BY d.id
ORDER BY total_profesores DESC;

--  4. Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. 
--  Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. 
--  Estos departamentos también tienen que aparecer en el listado.
SELECT d.id, count(id_profesor) as total_profesores FROM departamento d 
LEFT JOIN profesor p on d.id = p.id_departamento
GROUP BY d.id
ORDER BY total_profesores DESC;

--  5. Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. 
--  Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas. Estos grados también tienen que aparecer en el listado. 
--  El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.

SELECT g.nombre as grados_existentes, count(a.nombre) as Nro_asignaturas FROM grado g 
LEFT JOIN asignatura a on g.id = a.id_grado
GROUP BY grados_existentes
ORDER BY Nro_asignaturas DESC;

--  6. Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, 
--  de los grados que tengan más de 40 asignaturas asociadas.
SELECT g.nombre as grados_existentes, count(a.nombre) as Nro_asignaturas FROM grado g 
LEFT JOIN asignatura a on g.id = a.id_grado
GROUP BY grados_existentes
HAVING Nro_asignaturas > 40
ORDER BY Nro_asignaturas DESC;

--  7. Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos que hay para cada tipo de asignatura. 
--  El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que hay de ese tipo. 
--  Ordene el resultado de mayor a menor por el número total de crédidos.

SELECT g.nombre as grado, a.tipo as tipo_asignatura, sum(creditos) as creditos  FROM asignatura a 
JOIN grado g on a.id_grado = g.id
GROUP BY grado, tipo_asignatura;

--  8. Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. 
--  El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.

SELECT anyo_inicio, COUNT(id_alumno) FROM alumno_se_matricula_asignatura mat 
join curso_escolar ce on mat.id_curso_escolar = ce.id
GROUP BY anyo_inicio;

--  9. Devuelve un listado con el número de asignaturas que imparte cada profesor. 
--  El listado debe tener en cuenta aquellos profesores que no imparten ninguna asignatura. 
-- El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. 
-- El resultado estará ordenado de mayor a menor por el número de asignaturas.

SELECT p.id, p.nombre, p.apellido1, p.apellido2, count(a.id_profesor) as cant_asignaturas
FROM persona p left JOIN  asignatura a on p.id = a.id_profesor
WHERE p.tipo = 'profesor'
GROUP BY p.id
ORDER BY cant_asignaturas DESC;

--  1.5.8 Subconsultas
--  1. Devuelve todos los datos del alumno más joven.
SELECT * FROM persona 
WHERE tipo = 'alumno' and fecha_nacimiento = (SELECT max(fecha_nacimiento) FROM persona WHERE tipo = 'alumno');

--  2. Devuelve un listado con los profesores que no están asociados a un departamento.
SELECT * FROM profesor p 
LEFT JOIN departamento d on p.id_departamento = d.id
WHERE d.id is null;

--  3. Devuelve un listado con los departamentos que no tienen profesores asociados.
SELECT * FROM departamento d
LEFT JOIN profesor p on d.id = p.id_departamento
WHERE p.id_departamento is null;

--  4. Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.

SELECT * FROM asignatura;

SELECT p.id_profesor FROM profesor p 
JOIN departamento d on p.id_departamento = d.id
left JOIN asignatura a on p.id_profesor=a.id_profesor
WHERE a.id_profesor is null;

--  5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.
SELECT * FROM asignatura WHERE id_profesor is null;

--  6. Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.

SELECT * FROM departamento d 
join profesor p on d.id = p.id_departamento
WHERE id_profesor not in (SELECT DISTINCT id_profesor FROM asignatura a 
							JOIN  alumno_se_matricula_asignatura mat on a.id = mat.id_asignatura
							JOIN curso_escolar ce on  mat.id_curso_escolar = ce.id);