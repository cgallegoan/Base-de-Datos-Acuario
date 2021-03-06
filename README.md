# Base de datos parque-acuario
Diseño de una base de datos sobre un parque acuario para la asignatura de Bases De Datos (BDA) de la carrera. Trabajo realizado junto con Daniel Oliver Belando y Daniel Romero Alvarado.

Para la creación de la base de datos se ha realizado: 
- Diseño conceptual (DISEÑO CONCEPTUAL.pdf)
- Diseño lógico (DISEÑO LOGICO.pdf)
- Implementación en ORACLE SQL (esquema relacional)
- Creación de datos a través de python (datos inventados). Coordinadamente a través de deepnote
- Informes a través de BIRT eclipse
- Diferentes procedimientos, Funciones y disparadores en ORACLE para hacer la base de datos realista
- Posterior implementación en Cassandra y Neo4j (Trabajo asignatura de Gestión de Bases de Datos (GDA)

### Resumen de la base de datos
Nuestra base de datos está orientada al parque-acuario H2OLANDA (es un nombre inventado por nosotros). En este parque existen diversos espacios, que tienen un código que los identifican, un nombre único, una situación en el parque [abierto, cerrado, en mantenimiento, en construcción] y una superficie. De los espacios, unos son peceras, con su respectiva información: número de animales que contienen y capacidad (en litros), y otros tienen diferentes funciones ['Restaurante','Punto de información','Expositor','Seguridad','Atención al cliente','Almacén','Centro médico'].

La información sobre los animales que ocupan el acuario se hace por especies. De cada una se conoce necesariamente, además del código que la identifica, el nombre científico (no se repite), el lugar de origen, la alimentación que deben seguir,  la clase animal a la que pertenece (entendemos por clase la categoría de la taxonomía situada entre el filo y el orden. Ejemplo: –Mamífero–), el número de ejemplares que hay, y en qué pecera del parque está alojada cada especie (todos los ejemplares de una especie están en la misma).

De las especies consideradas ‘grandes’, hay una cantidad reducida de ejemplares, y se mantiene información individualizada de cada uno. Se identifican dentro de su especie por un número, tienen un nombre (no repetido), se señala si es importado o ha nacido en la pecera además de su fecha de incorporación y el peso.

De las personas que trabajan en el parque se guarda el código del empleado, que será el identificador y, necesariamente, el nombre, NIF (que es único) y sueldo. El personal está organizado según una estructura jerárquica, la base de datos se ha creado de forma que la estructura jerárquica tiene forma de árbol, es decir no hay empleados que sean jefes de alguien superior a ellos (no hay ciclos jerárquicos)de manera que cada uno de los empleados es subordinado de otro empleado (su jefe) y sólo de uno. Se debe guardar la información sobre esta jerarquía, junto con la fecha en la que se asignó el jefe a cada uno. Lógicamente, una persona no puede ser subordinada y jefe de la misma persona. Todos los empleados tienen jefe (excepto el jefe superior que no tiene jefe). Entre el personal, de los que tienen como cargo ‘cuidador’ se debe guardar la información sobre qué especie o especies cuida cada uno. También se ha guardado información sobre los empleados que tienen cargo ‘encargado’, concretamente qué espacios funcionales tienen asignados.

Otra información que se debe almacenar es la tarifa de precios de visita al parque. Esta tarifa incluirá el precio según el tipo [jubilado, adulto o niño] y el día [festivo o laborable].
