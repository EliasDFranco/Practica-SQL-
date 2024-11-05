CREATE SCHEMA libreria;

CREATE TABLE libreria.autor (
    id_autor INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_autor)
) ENGINE = InnoDB;

CREATE TABLE libreria.libros (
    id_libros INT NOT NULL,
    título VARCHAR(50) NOT NULL,
    editorial VARCHAR(50) NOT NULL,
    area VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_libros)
) ENGINE = InnoDB;

CREATE TABLE libreria.estudiante (
    id_lector INT NOT NULL,
    ci VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dirección VARCHAR(100) NOT NULL,
    carrera VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    PRIMARY KEY (id_lector)
) ENGINE = InnoDB;

CREATE TABLE libreria.prestamo (
    id_lector INT NOT NULL,
    id_libros INT NOT NULL,
    id_fechaprestamo DATE NOT NULL,
    fecha_devolución DATE NOT NULL,
    devuelto BOOLEAN NOT NULL,
    PRIMARY KEY (id_lector, id_libros, id_fechaprestamo),
    FOREIGN KEY (id_lector) REFERENCES libreria.estudiante(id_lector),
    FOREIGN KEY (id_libros) REFERENCES libreria.libros(id_libros)
) ENGINE = InnoDB;

CREATE TABLE libreria.libroAutor (
    id_autor INT NOT NULL,
    id_libros INT NOT NULL,
    PRIMARY KEY (id_libros, id_autor),
    FOREIGN KEY (id_autor) REFERENCES libreria.autor(id_autor),
    FOREIGN KEY (id_libros) REFERENCES libreria.libros(id_libros)
) ENGINE = InnoDB;

INSERT INTO libreria.libros (id_libros, título, editorial, area) VALUES
    (1, 'One Piece', 'SHUESHIA', 'Manga'),
    (2, 'El Trueno entre las hojas', 'SERVILIBRO EDICIONES', 'Literatura'),
    (3, 'El Principito', 'Reynal & Hitchock', 'Literatura Infantil');

INSERT INTO libreria.autor (id_autor, nombre, nacionalidad) VALUES
    (1, 'Eiichiro Oda', 'Japonesa'),
    (2, 'Augusto Roa Bastos', 'Paraguaya'),
    (3, 'Antoine de Saint-Exupéry', 'Francesa');

INSERT INTO libreria.estudiante (id_lector, ci, nombre, apellido, dirección, carrera, edad) VALUES
    (1, '6167356', 'Elias', 'Franco', 'San Salvador c/ Colombia', 'Ingeniería Informática', 20),
    (2, '5768997', 'Tyler', 'Durden', 'San Salvador c/ Perú', 'Medicina', 21),
    (3, '3456772', 'Edgar', 'Gutiérrez', 'San Salvador c/ Paraguay', 'Ingeniería Comercial', 23);

INSERT INTO libreria.libroAutor (id_autor, id_libros) VALUES
    (1, 1),
    (2, 2),
    (3, 3);

INSERT INTO libreria.prestamo (id_lector, id_libros, id_fechaprestamo, fecha_devolución, devuelto) VALUES
    (1, 1, '2024-11-02', '2024-11-10', TRUE),
    (2, 2, '2024-11-03', '2024-11-11', TRUE),
    (3, 3, '2024-11-04', '2024-11-12', TRUE);

-- Listar los datos de los autores
select * from libreria.autor;

-- Listar nombre y edad de los estudiantes
select nombre, edad from libreria.estudiante;

-- ¿Qué estudiantes pertenecen a la carrera de Informática?
select nombre from libreria.estudiante where carrera = 'Ingeniería Informática';

-- Listar los nombres de los estudiantes cuyo apellido comience con la letra G
select nombre from libreria.estudiante where apellido like 'G%';

-- Quiénes son los autores del libro “Visual Studio Net”, listar solamente los nombres.
select nombre from libreria.autor where id_autor in (
    select id_autor from libreria.libroAutor where id_libros in (
        select id_libros from libreria.libros where título = 'Visual Studio Net'));

-- ¿Qué autores son de nacionalidad USA o Francia?
select * from libreria.autor where nacionalidad in ('USA', 'Francesa');

-- ¿Qué libros No Son del Área de Internet?
select * from libreria.libros where area <> 'Internet';

-- ¿Qué libros se prestó el Lector “Raul Valdez Alanes”?
select * from libreria.libros where id_libros in (
    select id_libros from libreria.prestamo where id_lector in (
        select id_lector from libreria.estudiante where nombre = 'Raul Valdez Alanes'));

-- Listar el nombre del estudiante de menor edad
select nombre from libreria.estudiante where edad = (select min(edad) from libreria.estudiante);

-- Listar los nombres de los estudiantes que se prestaron Libros de Base de Datos
select * from libreria.estudiante where id_lector in (
    select id_lector from libreria.prestamo where id_libros in (
        select id_libros from libreria.libros where area = 'Base de Datos'));

-- Listar los libros de editorial AlfayOmega
select * from libreria.libros where editorial = 'AlfayOmega';

-- Listar los libros que pertenecen al autor Mario Benedetti
select * from libreria.libros where id_libros in (
    select id_libros from libreria.libroAutor where id_autor in (
        select id_autor from libreria.autor where nombre = 'Mario Benedetti'));

-- Listar los títulos de los libros que debían devolverse el 10/04/07
select * from libreria.libros where id_libros in (
    select id_libros from libreria.prestamo where fecha_devolución = '2007-04-10' and devuelto = FALSE);

-- Hallar la suma de las edades de los estudiantes
select sum(edad) as 'La suma de las edades es:' from libreria.estudiante;

-- Listar los datos de los estudiantes cuya edad es mayor al promedio
select * from libreria.estudiante where edad > (select avg(edad) from libreria.estudiante);
