# 🚀 Introducción

Para esta semana van a tener 2 prácticas bastante interesantes y de aplicación práctica directa. Esta semana trabajaremos con bases de datos relacionales de tipo SQL.

## 📚 Parte 1

[Curso PostgreSQL de freeCodeCamp](https://www.freecodecamp.org/learn/relational-database/learn-relational-databases-by-building-a-database-of-video-game-characters/build-a-database-of-video-game-characters)

En esta actividad van a tener que desarrollar 165 ejercicios de ir poniendo un comando tras otro para practicar y entender el funcionamiento a bajo nivel de este tipo de base de datos. Estos ejercicios te permitirán familiarizarte con la sintaxis de SQL y entender cómo se estructuran las consultas desde lo más básico hasta lo más avanzado.

> [!IMPORTANT]
> Nota: Las bases de datos de tipo MySQL y PostgreSQL se parecen mucho pero no son iguales

## 🎬 Parte 2

[Curso guiado de Midudev sobre SQL](https://www.youtube.com/watch?v=96s2i-H7e0w&ab_channel=midulive)

En este otro apartado, van a tener que trabajar a la par con Midudev para entender y comprender cada concepto hacer de las bases de datos.

## 📋 Entregables

Deben de crear un FORK de este repositorio para desarrollar la práctica.

- 📸 Parte 1 -> Crear una carpeta llamada "parte1" y dentro introducir la captura de pantalla donde se vea reflejado que han realizado el 100% de los ejercicios (los 165 propuestos).

- 💻 Parte 2 -> Crear una carpeta llamada "parte2" e introducir el código fuente y apuntes que hayan tomado en extensión .sql durante el vídeo.

## Recursos

- [Chuletilla de comando SQL](./docs/SQL-cheat-sheet.pdf): Una chuletilla bien redactada donde tienen todos los comandos típicos de SQL separados por el tipo de consulta.

## 🛠️ Software recomendado

- [MySQL Workbench](https://dev.mysql.com/downloads/workbench/): Un software muy grande para manejo de bases de datos que no pasa de moda.
- [DBeaver](https://dbeaver.io/download/): Personalmente es mi mayor recomendación, es un software más ligero y que va más rápido. Tiene muchos tipos de conexiones y en general es fácil de usar.
- [phpMyAdmin](https://www.phpmyadmin.net/downloads/): Software de gestión de bases de datos tipo MySQL / MariaDB. Pueden levantar este software mediante un [contenedor docker](https://hub.docker.com/_/phpmyadmin) lo cual lo hace bastante modular.


## 🧠 Curiosidades

- [Databases in depth - freeCodeCamp](https://www.youtube.com/watch?v=pPqazMTzNOM&t=2358s&ab_channel=freeCodeCamp.org): Si quieren seguir investigando sobre cómo funcionan las bases de datos relacionales y no relacionales. Recomiendo encarecidamente ver este tutorial en donde explican más a bajo nivel cómo funcionan y cómo trabajan.

## 🔗 Tipos de relaciones en bases de datos

En las bases de datos relacionales, la forma en que las tablas se conectan entre sí es fundamental para el diseño. Estas conexiones se conocen como relaciones:

### 👤⬅➡👤 Relación uno a uno (1:1)

Cada registro en la tabla A se relaciona con exactamente un registro en la tabla B y viceversa.

**Ejemplo:** Un empleado tiene exactamente un número de seguro social, y cada número está asignado a un único empleado.

```sql
CREATE TABLE empleados (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    fecha_contratacion DATE
);

CREATE TABLE detalles_empleado (
    id INT PRIMARY KEY,
    empleado_id INT UNIQUE,
    numero_seguro_social VARCHAR(20),
    direccion VARCHAR(200),
    FOREIGN KEY (empleado_id) REFERENCES empleados(id)
);
```
> [!IMPORTANT]
> Nota: Es una buena práctica introducir en singular de "empleados" a "empleado" para entender que la relación es de uno a uno. Se sobrentiende de manera natural que "detalles" no necesariamente está serializada sino que incrementa el número de columnas del modelo anterior.

### 👤⬅➡👥 Relación uno a muchos (1:N)

Un registro en la tabla A puede estar relacionado con varios registros en la tabla B, pero cada registro en B está relacionado con solo uno en A.

**Ejemplo:** Un cliente puede realizar muchos pedidos, pero cada pedido pertenece a un único cliente.

```sql
CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    cliente_id INT,
    fecha_pedido DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);
```
> [!IMPORTANT]
> Nota: Para seguir las mismas reglas se podrían llamar a la tabla "pedidos" como "cliente_pedidos" para relacionar el singular de cliente con el plural de "pedido" que es "pedidos".

### 👥⬅➡👥 Relación muchos a muchos (N:M)

Múltiples registros en la tabla A pueden relacionarse con múltiples registros en la tabla B.

**Ejemplo:** Un estudiante puede inscribirse en varios cursos, y cada curso puede tener varios estudiantes.

```sql
CREATE TABLE estudiantes (
    id INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE cursos (
    id INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE inscripciones (
    estudiante_id INT,
    curso_id INT,
    fecha_inscripcion DATE,
    PRIMARY KEY (estudiante_id, curso_id),
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);
```
> [!IMPORTANT]
> Nota: Por mantener un criterio. También se puede llamar a la tabla de "inscripciones" -> "estudiantes_cursos" utilizando el plural para automáticamente entender que relaciona varios estudiantes con varios cursos.

### 🌲 Relación recursiva o auto-referencial

Una tabla se relaciona consigo misma.

**Ejemplo:** Empleados y sus supervisores, donde ambos son registros en la misma tabla.

```sql
CREATE TABLE empleados (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    supervisor_id INT,
    FOREIGN KEY (supervisor_id) REFERENCES empleados(id)
);
```

### ☝️ Consideraciones importantes

- Las relaciones se implementan mediante claves primarias (PK) y claves foráneas (FK).
- En una relación N:M, siempre se necesita una tabla intermedia (tabla de unión).
- El diseño adecuado de las relaciones evita la redundancia de datos y mantiene la integridad referencial.
- Las restricciones (CONSTRAINTS) de clave foránea (ON DELETE, ON UPDATE) ayudan a mantener la consistencia cuando los datos cambian.

## 💡 Buenas prácticas

- 🔄 Es una buena práctica preguntar donde tienen la copia de seguridad de la base de datos y la periodicidad con la que se generan las copias de seguridad. Idealmente, deberían realizarse copias diarias y guardarse en ubicaciones diferentes para prevenir pérdidas catastróficas.

- 🔍 También es una buena práctica generar índices en columnas en tablas con muchos registros para mejorar las búsquedas y optimizar las consultas pesadas. Un buen índice puede reducir el tiempo de consulta de horas a segundos.

- 📊 Al igual que el apartado anterior, cuando una columna tenemos la sospecha de que puede ser muy pesada por ella sola es una buena idea normalizar dicha columna en una nueva tabla si es posible. Esto reduce la redundancia y mejora la integridad de los datos.

- 🔀 Otra buena práctica es tener una base de datos orientada al desarrollo y otra orientada a producción. De esta forma cualquier cambio que se realice en la lógica de negocio de nuestro software será probado en la base de datos en desarrollo para posteriormente realizar los cambios necesarios en producción sin la posibilidad de romper la integridad de los datos.

## 🧾​ Recursos adicionales

- [SQL Cheat Sheet de W3Schools](https://www.w3schools.com/sql/sql_ref_mysql.asp)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Comando interesantes de Awesome Cheatsheets](https://github.com/LeCoupa/awesome-cheatsheets/blob/master/databases/mysql.sh)