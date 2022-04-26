-- Primero creamos el KEYSPACE ACUARIO, con todas las tablas. Debido a que solo hay un centro de datos, la estrategia de replicación será simple ('SimpleStrategy'), con un factor de replicación recomendado de 3. 
CREATE KEYSPACE acuario WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '3'};

-- Ahora se crean las tablas simples con información por clases
-- ESPECIE
CREATE TABLE especie (
	cod_especie TEXT PRIMARY KEY,
	nombre_cientifico TEXT,
	lugar_origen TEXT,
	tamanyo_gen FLOAT,
	clase TEXT,
	alimentación TEXT,
	n_ejemplares INT,
	cod_pec TEXT);
-- PECERA
CREATE TABLE pecera (
	cod_pec TEXT PRIMARY KEY,
	num_anim INT,
	capacidad FLOAT,
	nombre TEXT,
	situación TEXT,
	superficie INT);

-- EJEMPLAR
CREATE TABLE ejemplar (
	cod_especie TEXT,
	cod_ejemplar TEXT,
	nombre TEXT,
	importado INT,
	fecha_inc DATE,
	peso FLOAT,
	PRIMARY KEY (cod_especie, cod_ejemplar));

-- CUIDADOR
CREATE TABLE cuidador (
	n_empleado TEXT PRIMARY KEY,
	nombre TEXT,
	anyo_xp INT,
	NIF TEXT,
	sueldo FLOAT,
	n_emp_jefe TEXT,
	fecha_relacion DATE);

-- ENCARGADO
CREATE TABLE encargado (
	n_empleado TEXT PRIMARY KEY,
	nombre TEXT,
	anyo_xp INT,
	NIF TEXT,
	sueldo FLOAT,
	n_emp_jefe TEXT,
	fecha_relacion DATE);

-- ESPACIO FUNCIONAL
CREATE TABLE esp_funcional (
	cod_esp TEXT PRIMARY KEY,
	nombre TEXT,
	situación TEXT,
	superficie INT,
	funcion SET<TEXT>);

-- TARIFA
CREATE TABLE tarifa (
	tipo TEXT,
	day TEXT,
	precio FLOAT,
	PRIMARY KEY (tipo, day);

-- EMPLEADO
CREATE TABLE empleado (
	n_empleado TEXT PRIMARY KEY,
	nombre TEXT,
	anyo_xp INT,
	NIF TEXT,
	sueldo FLOAT,
	n_emp_jefe TEXT,
	fecha_relacion DATE);

-- Ahora se crean las tablas complejas correspondientes a las queries del diagrama chebotko, del apartado 1.3. Diagrama Chebotko - Queries de la Memoria

-- Mostrar las especies ordenadas por nombre científico
CREATE TABLE especies_por_nombre (
    agrupa INT,
    nombre_cientifico TEXT,
    cod_esp TEXT,
    alimentacion TEXT,
    clase TEXT,
    lugar_origen TEXT,
    n_ejemplares INT,
    PRIMARY KEY (agrupa, nombre_cientifico, cod_esp)
) WITH CLUSTERING ORDER BY (nombre_cientifico ASC, cod_esp ASC)

-- Mostrar su correspondiente pecera (situación, superficie, nº de animales, capacidad
CREATE TABLE pecera_por_especie (
    cod_especie TEXT,
    nombre_cientifico TEXT,
    nombre TEXT,
    situacion TEXT,
    superficie INT,
    PRIMARY KEY (cod_especie, nombre_cientifico, nombre)
) WITH CLUSTERING ORDER BY (nombre_cientifico ASC, nombre ASC)

-- De aquellas grandes, mostrar sus ejemplares (importado, fecha de incorporación, peso) ordenados por nombre
CREATE TABLE ejemplar_por_especie (
    cod_especie TEXT,
    nombre_ejemplar TEXT,
    cod_ejemplar TEXT,
    fecha_inc DATE,
    importado INT,
    peso FLOAT,
    PRIMARY KEY (cod_especie, nombre_ejemplar, cod_ejemplar)
) WITH CLUSTERING ORDER BY (nombre_ejemplar ASC, cod_ejemplar ASC)

-- Mostrar sus cuidadores (años de exp., sueldo) ordenados por nombre
CREATE TABLE cuidador_por_especie (
    cod_especie TEXT,
    nombre_cuidador TEXT,
    anyo_xp INT,
    sueldo FLOAT,
    PRIMARY KEY (cod_especie, nombre_cuidador, anyo_xp)
) WITH CLUSTERING ORDER BY (nombre_cuidador ASC, anyo_xp ASC)

--Mostrar los encargados ordenados por nombre de forma descendiente
CREATE TABLE encargado_por_nombre (
    agrupa INT,
    nombre_encargado TEXT,
    n_empleado TEXT,
    anyo_xp INT,
    nif TEXT,
    sueldo FLOAT,
    PRIMARY KEY (agrupa, nombre_encargado, n_empleado)
) WITH CLUSTERING ORDER BY (nombre_encargado DESC, n_empleado ASC)

-- Mostrar los espacios funcionales (nombre, situación, superficie, funciones) de los que se encarga dicho encargado ordenados por superficie/nombre
CREATE TABLE esp_func_por_encargado (
    n_empleado text,
    nombre_encargado text,
    superficie int,
    nombre_espacio text,
    funcion set<text>,
    situacion text,
    PRIMARY KEY (n_empleado, nombre_encargado, superficie, nombre_espacio)
) WITH CLUSTERING ORDER BY (nombre_encargado ASC, superficie DESC, nombre_espacio ASC)

-- Mostrar los empleados ordenados por nombre
CREATE TABLE empleado_por_nombre (
    agrupa INT,
    nombre TEXT,
    n_empleado TEXT,
    anyo_xp INT,
    n_emp_jefe TEXT,
    nif TEXT,
    sueldo FLOAT,
    PRIMARY KEY (agrupa, nombre, n_empleado)
) WITH CLUSTERING ORDER BY (nombre ASC, n_empleado ASC)

-- Mostrar sus subordinados de primer nivel, ordenados por sueldo
CREATE TABLE subs_por_empleado (
    n_emp_jefe TEXT, sueldo FLOAT,
    n_empleado TEXT,
    anyo_exp INT,
    nif TEXT,
    PRIMARY KEY (n_emp_jefe, sueldo, n_empleado)
) WITH CLUSTERING ORDER BY (sueldo DESC, n_empleado ASC)
