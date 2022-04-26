/* CONSULTAS SQL PARA EXPORTAR LOS DATOS E INTRODUCIRLOS EN NEO4J */

/* NODO ESPECIE */
SELECT COD_ESPECIE, NOMBRE_CIENTIFICO, LUGAR_ORIGEN, TAMAÑO_GEN AS GENERAL_SIZE, CLASE, ALIMENTACION, Nº_EJEMPLARES AS N_EJEMPLARES
FROM ESPECIE;

/* NODO EJEMPLAR */
SELECT * FROM EJEMPLAR;

/* NODO EMPLEADO */
SELECT Nº_EMPLEADO AS N_EMPLEADO, NOMBRE, NIF, SUELDO, ANYO_EXP
FROM EMPLEADO;

/* CUIDADORES (Empleados) */
SELECT Nº_EMPLEADO AS N_EMPLEADO
FROM CUIDADOR;

/* ENCARGADOS (Empleados) */
SELECT Nº_EMPLEADO AS N_EMPLEADO
FROM ENCARGADO;

/* NODO ESPACIO */
SELECT * FROM ESPACIO;

/* ESPACIOS FUNCIONALES (Espacios) */
SELECT ef.COD_ESP, LISTAGG(f.funcion, ', ') WITHIN GROUP(ORDER BY f.funcion) as FUNCIONES
FROM ESP_FUNCIONAL ef, FUNCION f
WHERE Ef.COD_ESP = f.COD_ESPACIO
GROUP BY ef.COD_ESP;

/* PECERAS (Espacios) */
SELECT * FROM PECERA;

/* NODO TARIFA */
SELECT * FROM TARIFA;

/* CREACIÓN DE LAS RELACIONES (Las relaciones de la base de datos van a ser: VIVE_EN, PERTENECE, CUIDA_DE, ES_JEFE_DE, SE_ENCARGA_DE) */

/* RELACIÓN PERTENECE */
SELECT COD_ESPECIE, COD_EJEMPLAR
FROM EJEMPLAR;

/* RELACIÓN ES_JEFE_DE */
SELECT Nº_EMPLEADO AS N_EMPLEADO, Nº_EMP_JEFE AS N_EMP_JEFE, FECHA
FROM EMPLEADO;

/* RELACIÓN CUIDA_DE */
SELECT Nº_CUID AS N_CUID, COD_ESPECIE
FROM CUIDADO;

/* RELACIÓN SE_ENCARGA_DE */
SELECT Nº_EMPLEADO AS N_EMPLEADO, COD_ESPACIO
FROM ENCARGO;

/* RELACIÓN VIVE_EN */
SELECT COD_ESPECIE, COD_PEC
FROM ESPECIE;

