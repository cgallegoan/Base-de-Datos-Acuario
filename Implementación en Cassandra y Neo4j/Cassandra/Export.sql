-- Consultas SQL para obtener datos de cada tabla
-- ESPECIES
SELECT * FROM ESPECIE;

-- EJEMPLARES
SELECT * FROM EJEMPLAR;

-- EMPLEADOS
SELECT * FROM EMPLEADO;

-- ENCARGADOS
SELECT e.* FROM EMPLEADO e
WHERE e.Nº_EMPLEADO IN (SELECT en.Nº_EMPLEADO FROM ENCARGADO en);

-- CUIDADORES
SELECT e.* FROM EMPLEADO e
WHERE e.Nº_EMPLEADO IN (SELECT cd.Nº_EMPLEADO FROM CUIDADOR cd);

-- Los cuidadores y los encargados son una especialización parcial disjunta de los empleados totales, esto quiere decir que tendremos que obtener tanto cuidadores, como encargados, como empleados para tener toda la información de la base de datos.

-- ESPACIOS FUNCIONALES
SELECT ef.COD_ESP, e.NOMBRE, e.SITUACION, e.SUPERFICIE, (LISTAGG(f.funcion, ', ') 
WITHIN GROUP(ORDER BY f.funcion)) as FUNCIONES
FROM ESP_FUNCIONAL ef, FUNCION f, ESPACIO e
WHERE Ef.COD_ESP = f.COD_ESPACIO AND e.COD_ESPACIO = ef.COD_ESP
GROUP BY ef.COD_ESP, e.NOMBRE, e.SITUACION, e.SUPERFICIE;

-- Los espacios funcionales cuentan con varias funciones cada uno, por lo que hemos tenido que recurrir a LISTAGG para agrupar en una sola fila todas las funciones de cada espacio, y así poder subirlo como ‘set’ a Cassandra. 

-- PECERAS
SELECT p.COD_PEC, p.CAPACIDAD, p.NUM_ANIM, e.NOMBRE, e.SUPERFICIE, e.SITUACION
FROM PECERA p, ESPACIO e
WHERE e.COD_ESPACIO = p.COD_PEC;

-- Los espacios funcionales y las peceras son una especialización total disjunta de la tabla ESPACIO, esto quiere decir que tendremos que nos sirve con obtener solo estas 2 tablas para tener toda la información de la base de datos.

-- TARIFAS
SELECT * FROM TARIFA;

-- Tablas complejas (Queries)
-- ESPECIES_POR_NOMBRE
SELECT 1 as agrupa, nombre_cientifico, cod_especie, lugar_origen, clase, alimentacion, nº_ejemplares
FROM especie
ORDER BY nombre_cientifico ASC;

-- PECERA_POR_ESPECIE
SELECT cod_especie, nombre_cientifico, nombre, situacion, superficie
FROM especie, pecera, espacio
WHERE especie.cod_pec = pecera.cod_pec and espacio.cod_espacio = pecera.cod_pec
ORDER BY nombre_cientifico ASC;

-- EJEMPLAR_POR_ESPECIE
SELECT ej.cod_especie, ej.nombre, cod_ejemplar, importado, fecha_inc, peso
FROM ejemplar ej, especie e
WHERE ej.cod_especie = e.cod_especie
ORDER BY ej.nombre ASC;

-- CUIDADOR_POR_ESPECIE
SELECT e.cod_especie, emp.nombre, emp.anyo_exp, emp.sueldo FROM cuidador c, especie e, cuidado cu, empleado emp
WHERE c.Nº_EMPLEADO = cu.nº_cuid and e.cod_especie = cu.cod_especie 
and emp.nº_empleado = c.nº_empleado
ORDER BY emp.nombre ASC, emp.anyo_exp ASC;

-- ENCARGADO_POR_NOMBRE
SELECT 1 as agrupa, e.nombre, e.nº_empleado, e.anyo_exp, e.NIF, e.sueldo
FROM encargado en, empleado e
WHERE en.nº_empleado = e.nº_empleado
ORDER BY e.nombre DESC;

-- ESP_FUNC_POR_ENCARGADO
SELECT emp.nº_empleado, emp.nombre as nombre_encargado, e.nombre as nombre_espacio, e.superficie, e.situacion, LISTAGG(f.funcion, ', ') 
WITHIN GROUP(ORDER BY f.funcion) as funciones
FROM empleado emp, espacio e, funcion f, encargo en
WHERE emp.nº_empleado = en.nº_empleado and en.cod_espacio = e.cod_espacio and e.cod_espacio = f.cod_espacio
GROUP BY emp.nº_empleado, e.nombre, e.superficie, e.situacion, emp.nombre
ORDER BY e.superficie DESC, e.nombre ASC;

-- EMPLEADO_POR_NOMBRE
SELECT 1 as agrupa, e.nombre, e.nº_empleado, e.nº_emp_JEFE, e.anyo_exp, e.NIF, e.sueldo
FROM empleado e
ORDER BY e.nombre ASC;

-- SUBS_POR_EMPLEADO
SELECT nº_emp_jefe,sueldo,nº_empleado
FROM empleado






