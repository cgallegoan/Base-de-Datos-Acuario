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





