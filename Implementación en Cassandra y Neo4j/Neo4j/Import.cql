-- NODO ESPECIE

LOAD CSV WITH HEADERS FROM 'file:///ESPECIE_Cypher.csv'
AS line FIELDTERMINATOR ';'
CREATE (n:Species {cod_especie: line.COD_ESPECIE, nombre_cientifico: line.NOMBRE_CIENTIFICO, lugar_origen: line.LUGAR_ORIGEN, 
general_size: toFloat(line.GENERAL_SIZE), class: line.CLASE, alimentacion: line.ALIMENTACION, n_ejemplares: toInteger(line.N_EJEMPLARES)})

-- NODO EJEMPLAR
LOAD CSV WITH HEADERS
FROM 'file:///SPECIMEN.csv'
AS line
CREATE (n:Specimen {cod_spec: line.COD_EJEMPLAR, cod_especie: line.COD_ESPECIE, name: line.NOMBRE, fecha_inc: line.FECHA_INC, 
imported: toBoolean(line.IMPORTADO), weight: toInteger(line.PESO)})

--NODO EMPLEADO
LOAD CSV WITH HEADERS
FROM 'file:///Employee.csv'
AS line
CREATE (n:Employee {cod_em: line.N_EMPLEADO, name: line.NOMBRE, NIF: line.NIF, anyo_exp: toInteger(line.ANYO_EXP), sueldo: toFloat(line.SUELDO)})

-- CUIDADORES (Empleados)
LOAD CSV WITH HEADERS
FROM 'file:///Cuidador.csv'
AS line
MATCH (n:Employee {cod_em: line.N_EMPLEADO})
SET n:Taker

-- ENCARGADOS (Empleados)
LOAD CSV WITH HEADERS
FROM 'file:///Encargado.csv'
AS line
MATCH (n:Employee {cod_em: line.N_EMPLEADO})
SET n:Manager

-- NODO ESPACIO
LOAD CSV WITH HEADERS FROM 'file:///ESPACIO_Cypher.csv'
AS line
CREATE (n:Space {cod_espacio: line.COD_ESPACIO, name: line.NOMBRE, superficie: toInteger(line.SUPERFICIE), status: line.SITUACION})

-- ESPACIOS FUNCIONALES (Espacios)
LOAD CSV WITH HEADERS FROM 'file:///Esp_funcional_Cypher.csv'
AS line
FIELDTERMINATOR ';'
MATCH (n:Space {cod_espacio: line.COD_ESP})
SET n:Facility
SET n.funciones = SPLIT(line.FUNCIONES, ',')

-- PECERAS (Espacios)
LOAD CSV WITH HEADERS
FROM 'file:///PECERA_Cypher.csv'
AS line 
MATCH (n:Space {cod_espacio: line.COD_PEC})
SET n:FishTank
SET n.capacidad = toInteger(line.CAPACIDAD)
SET n.num_animales = toInteger(line.NUM_ANIM)

-- NODO TARIFA
LOAD CSV WITH HEADERS 
FROM 'file:///TARIFA.csv' 
AS line FIELDTERMINATOR ';' 
CREATE (n:Tarifa {type: line.TIPO, day: line.DÍA, price: toFloat(line.PRECIO)})

-- CREACIÓN DE LAS RELACIONES 
-- RELACIÓN PERTENECE
LOAD CSV WITH HEADERS
FROM 'file:///BELONGS.csv'
AS line
MATCH (ej:Specimen {cod_spec: line.COD_EJEMPLAR, cod_especie: line.COD_ESPECIE}), (sp:Species {cod_especie: line.COD_ESPECIE})
CREATE (ej) - [:PERTENECE] -> (sp)

-- RELACIÓN ES_JEFE_DE
LOAD CSV WITH HEADERS
FROM 'file:///IS_BOSS.csv'
AS line
MATCH (b:Employee {cod_em: line.N_EMP_JEFE}), (s:Employee {cod_em: line.N_EMPLEADO})
CREATE (b) - [:ES_JEFE_DE {fecha: line.FECHA}] -> (s)

-- RELACIÓN CUIDA_DE
LOAD CSV WITH HEADERS
FROM 'file:///CUIDADO.csv'
AS line
MATCH (cd:Taker {cod_em: line.N_CUID}), (sp:Species {cod_especie: line.COD_ESPECIE})
CREATE (cd) - [:CUIDA_DE] -> (sp)

-- RELACIÓN SE_ENCARGA_DE
LOAD CSV WITH HEADERS
FROM 'file:///ENCARGO.csv'
AS line
MATCH (mg:Manager {cod_em: line.N_EMPLEADO}), (sp:Facility {cod_espacio: line.COD_ESPACIO})
CREATE (mg) - [:SE_ENCARGA_DE] -> (sp)

-- RELACIÓN VIVE_EN
LOAD CSV WITH HEADERS
FROM 'file:///VIVE_EN.csv'
AS line
MATCH (sp:Species {cod_especie: line.COD_ESPECIE}), (p:FishTank {cod_espacio: line.COD_PEC})
CREATE (sp) - [:VIVE_EN] -> (p)
