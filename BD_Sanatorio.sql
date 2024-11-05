CREATE DATABASE SANATORIO;

USE SANATORIO;

CREATE TABLE CIUDAD (
    id_ciudad INT AUTO_INCREMENT PRIMARY KEY,
    ciudad_descripcion VARCHAR(50)
);

CREATE TABLE ESPECIALIDAD (
    id_especialidad INT AUTO_INCREMENT PRIMARY KEY,
    esp_descripcion VARCHAR(50)
);

CREATE TABLE PACIENTE (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    telefono VARCHAR(50),
    direccion VARCHAR(50),
    correo_electronico VARCHAR(50),
    id_ciudad INT,
    FOREIGN KEY (id_ciudad) REFERENCES CIUDAD(id_ciudad)
);

CREATE TABLE MEDICO (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    medico_nombre VARCHAR(50),
    medico_apellido VARCHAR(50),
    id_especialidad INT,
    medico_telefono VARCHAR(50),
    medico_correo VARCHAR(50),
    FOREIGN KEY (id_especialidad) REFERENCES ESPECIALIDAD(id_especialidad)
);

CREATE TABLE SALA (
    id_sala INT AUTO_INCREMENT PRIMARY KEY,
    sala_descripcion VARCHAR(50),
    observacion VARCHAR(50)
);

CREATE TABLE CONSULTA (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    id_medico INT,
    fecha_consulta DATE,
    observacion_consulta VARCHAR(50),
    FOREIGN KEY (id_paciente) REFERENCES PACIENTE(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES MEDICO(id_medico)
);

CREATE TABLE INTERNACION (
    id_internacion INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    id_sala INT,
    int_fecha_entrada DATE,
    int_fecha_salida DATE,
    int_observacion VARCHAR(50),
    FOREIGN KEY (id_paciente) REFERENCES PACIENTE(id_paciente),
    FOREIGN KEY (id_sala) REFERENCES SALA(id_sala)
);

USE SANATORIO;

INSERT INTO CIUDAD (ciudad_descripcion) VALUES
('San Lorenzo'),
('Capiata'),
('Luque');

INSERT INTO ESPECIALIDAD (esp_descripcion) VALUES
('Cardiologo'),
('Pediatra'),
('Ginecólogo');

INSERT INTO SALA (id_sala, sala_descripcion, observacion) VALUES
('CIRUGIIA1', 'Cirugía inmediatas', 'Sala para cirugias'),
('TERAPIAINT1', 'Terapia Intensiva', 'Sala para cuidado intensivo'),
('QUIROFANO1', 'Quirófano', 'Sala de cirugía mayor');

INSERT INTO PACIENTE (nombre, apellido, telefono, direccion, correo_electronico, id_ciudad) VALUES
('Elias', 'Franco', '0984545456', 'San Savador c/ colombia', 'eliasdfranco@hotmail.com', 1),
('Yanis', 'Peralta', '0981345675', 'Avenida Médicos del chaco', 'yanisperalta$@gmail.com', 2),
('Marcos', 'Peralta', '0981123456', 'San Salvador c/ Perú', 'marcosperalta$@gmail.com', 3);

INSERT INTO MEDICO (medico_nombre, medico_apellido, id_especialidad, medico_telefono, medico_correo) VALUES
('Kevin', 'Duarte', 1, '0981345643', 'drkevin@gmail.com'),
('Victor', 'Ovelar', 2, '0982235876', 'drvictor@gmail.com'),
('Fátima', 'Gonzalez', 3, '0983525524', 'drafatimagonzalez.com');

INSERT INTO CONSULTA (id_paciente, id_medico,  fecha_consulta, observacion_consulta) VALUES
(1, 1, '2024-10-16 12:00:00', 'Consulta normal'),
(2, 2, '2024-10-16 15:00:00', 'Consulta de pediatría'),
(3, 3, '2024-10-16 18:00:00', 'Consulta ginecológica');

INSERT INTO INTERNACION (id_paciente, id_sala, int_fecha_entrada, int_fecha_salida, int_observacion) VALUES
(1, 1, '2024-10-17', '2024-10-20', 'Internación para una cirugía'),
(2, 2, '2024-10-17', '2024-10-20', 'Internación en terapia intensiva'),
(3, 3, '2024-10-17', '2024-10-20', 'Internación en el quirófano');

ALTER TABLE SALA 
ADD COLUMN fec_nacimiento DATE, 
ADD COLUMN CI VARCHAR(50);

ALTER TABLE SALA 
DROP COLUMN observacion;

DELETE FROM INTERNACION 
WHERE id_internacion = 1;
