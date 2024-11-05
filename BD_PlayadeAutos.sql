CREATE DATABASE Playa_de_autos;
USE Playa_de_autos;
CREATE TABLE PROVEEDOR (
    id_proveedor INTEGER PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    ruc VARCHAR(20),
    telefono_proveedor VARCHAR(20)
);

CREATE TABLE MARCA (
    id_marca INTEGER PRIMARY KEY,
    descripcion_marca VARCHAR(30)
);

CREATE TABLE MODELO (
    id_modelo INTEGER PRIMARY KEY,
    i INTEGER PRIMARY KEY,
    mod_descr VARCHAR(30)
);

CREATE TABLE vehiculo (
    veh_cod INTEGER PRIMARY KEY,
    marca_mar_cod INTEGER,
    modelo_mod_cod INTEGER,
    veh_descr VARCHAR(30),
    veh_color VARCHAR(30),
    veh_pre_ven INTEGER,
    FOREIGN KEY (marca_mar_cod) REFERENCES marca(mar_cod),
    FOREIGN KEY (modelo_mod_cod) REFERENCES modelo(mod_cod)
);
CREATE TABLE compra (
    com_cod INTEGER PRIMARY KEY,
    proveedor_prov_cod INTEGER,
    com_descr VARCHAR(30),
    FOREIGN KEY (proveedor_prov_cod) REFERENCES proveedor(prov_cod)
);

CREATE TABLE det_compra (
    vehiculo_veh_cod INTEGER,
    compra_com_cod INTEGER,
    cant INTEGER,
    precio INTEGER,
    PRIMARY KEY (vehiculo_veh_cod, compra_com_cod),
    FOREIGN KEY (vehiculo_veh_cod) REFERENCES vehiculo(veh_cod),
    FOREIGN KEY (compra_com_cod) REFERENCES compra(com_cod)
);

CREATE TABLE vendedor (
    ven_cod INTEGER PRIMARY KEY,
    ven_nom VARCHAR(30),
    ven_ape VARCHAR(30),
    ven_tel VARCHAR(30),
    ven_dir VARCHAR(30)
);

CREATE TABLE venta (
    ven_cod INTEGER PRIMARY KEY,
    vendedor_ven_cod INTEGER,
    ven_descr VARCHAR(30),
    ven_fecha DATE,
    FOREIGN KEY (vendedor_ven_cod) REFERENCES vendedor(ven_cod)
);

CREATE TABLE det_venta (
    vehiculo_veh_cod INTEGER,
    venta_ven_cod INTEGER,
    cant INTEGER,
    precio INTEGER,
    PRIMARY KEY (vehiculo_veh_cod, venta_ven_cod),
    FOREIGN KEY (vehiculo_veh_cod) REFERENCES vehiculo(veh_cod),
    FOREIGN KEY (venta_ven_cod) REFERENCES venta(ven_cod)
);

INSERT INTO proveedor (prov_cod, prov_nom, prov_ruc, prov_tel) VALUES
(1, 'Proveedor MCBENZ1', '12345678', '0981111111'),
(2, 'TOYOTOSHI1', '87654321', '0982222222'),
(3, 'BMW12', '11223344', '0983333333');

INSERT INTO marca (mar_cod, mar_descr) VALUES
(1, 'Mercedes'),
(2, 'TOYOTA'),
(3, 'BMW');

INSERT INTO modelo (mod_cod, mod_descr) VALUES
(1, 'Modelo CLASE C'),
(2, 'HILUX'),
(3, 'SHARK');

INSERT INTO vehiculo (veh_cod, marca_mar_cod, modelo_mod_cod, veh_descr, veh_color, veh_pre_ven) VALUES
(1, 1, 1, 'Vehículo 1', 'Blanco', 15000),
(2, 2, 2, 'Vehículo 2', 'Azul', 20000),
(3, 3, 3, 'Vehículo 3', 'Negro', 25000);

INSERT INTO compra (com_cod, proveedor_prov_cod, com_descr) VALUES
(1, 1, 'Compra 1'),
(2, 2, 'Compra 2'),
(3, 3, 'Compra 3');

INSERT INTO det_compra (vehiculo_veh_cod, compra_com_cod, cant, precio) VALUES
(1, 1, 10, 12000),
(2, 2, 5, 18000),
(3, 3, 8, 22000);

INSERT INTO vendedor (ven_cod, ven_nom, ven_ape, ven_tel, ven_dir) VALUES
(1, 'Samuel', 'Vargas', '0984444444', 'San Salvador casi Colombia'),
(2, 'José', 'Alonzo', '0985555555', 'San Salvador casi Perú'),
(3, 'Manuel', 'Franco', '0986666666', 'San Salvador casi Brasil');

INSERT INTO venta (ven_cod, vendedor_ven_cod, ven_descr, ven_fecha) VALUES
(1, 1, 'Venta 1', '2024-10-01'),
(2, 2, 'Venta 2', '2024-10-02'),
(3, 3, 'Venta 3', '2024-10-03');

INSERT INTO det_venta (vehiculo_veh_cod, venta_ven_cod, cant, precio) VALUES
(1, 1, 2, 15000),
(2, 2, 1, 20000),
(3, 3, 1, 25000);

ALTER TABLE vendedor
ADD COLUMN email VARCHAR(50),
ADD COLUMN fec_nac DATE;

ALTER TABLE proveedor
DROP COLUMN prov_tel;

DELETE FROM modelo
WHERE mod_cod = 2;

UPDATE modelo
SET mod_descr = 'Modelo Actualizado'
WHERE mod_cod = 3;

SELECT * FROM vehiculo
WHERE marca_mar_cod = 1;

SELECT * FROM compra;

SELECT v.veh_cod, v.veh_descr, m.mar_descr AS marca, mo.mod_descr AS modelo, v.veh_color, v.veh_pre_ven
FROM vehiculo v
JOIN marca m ON v.marca_mar_cod = m.mar_cod
JOIN modelo mo ON v.modelo_mod_cod = mo.mod_cod;
