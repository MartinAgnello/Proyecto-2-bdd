CREATE DATABASE banco;

USE banco;

#------------------------------------------------------
# CREACION DE LAS TABLAS PARA LAS ENTIDADES

CREATE TABLE ciudad (
    cod_postal SMALLINT UNSIGNED NOT NULL,
    nombre VARCHAR(20) NOT NULL,

    CONSTRAINT pk_ciudad /*Se puede escribir algo distinto algo del CONSTRAINT?*/
    PRIMARY KEY (cod_postal)

) ENGINE=InnoDB;



CREATE TABLE sucursal (
    nro_suc SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    direccion VARCHAR(20) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    horario VARCHAR(20) NOT NULL,
    cod_postal SMALLINT UNSIGNED NOT NULL,

    CONSTRAINT pk_sucursal
    PRIMARY KEY (nro_suc),

    CONSTRAINT fk_sucursal
    FOREIGN KEY (cod_postal) REFERENCES ciudad (cod_postal)

) ENGINE=InnoDB;



CREATE TABLE empleado (
    legajo SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    apellido VARCHAR(20) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    tipo_doc VARCHAR(20) NOT NULL,
    nro_doc INT UNSIGNED NOT NULL,
    direccion VARCHAR(20) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    cargo VARCHAR(20) NOT NULL,
    password VARCHAR(32) NOT NULL, /*se debe almacenar de forma segura con la funcion hash MD5*/
    nro_suc SMALLINT UNSIGNED NOT NULL,

    CONSTRAINT pk_empleado
    PRIMARY KEY (legajo),

    CONSTRAINT fk_empleado
    FOREIGN KEY (nro_suc) REFERENCES sucursal (nro_suc)

) ENGINE=InnoDB;

CREATE TABLE cliente (
    nro_cliente SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    apellido VARCHAR(20) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    tipo_doc VARCHAR(20) NOT NULL,
    nro_doc INT UNSIGNED NOT NULL,
    direccion VARCHAR(20) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    fecha_nac DATE NOT NULL, /*no especifica como se escribe*/

    CONSTRAINT pk_cliente
    PRIMARY KEY (nro_cliente)

) ENGINE=InnoDB;

CREATE TABLE plazo_fijo (
    nro_plazo INT UNSIGNED NOT NULL AUTO_INCREMENT,
    capital DECIMAL(16,2) UNSIGNED NOT NULL,
    fecha_inicio DATE NOT NULL, /*no especifica como se escribe*/
    fecha_fin DATE NOT NULL, /*no especifica como se escribe*/
    tasa_interes DECIMAL(4,2) UNSIGNED NOT NULL,
    interes DECIMAL(16,2) UNSIGNED NOT NULL, /* interes es un atributo derivado*/
    nro_suc SMALLINT UNSIGNED NOT NULL,

    CONSTRAINT pk_plazo_fijo
    PRIMARY KEY (nro_plazo),

    CONSTRAINT fk_plazo_fijo
    FOREIGN KEY (nro_suc) REFERENCES sucursal (nro_suc)

) ENGINE=InnoDB;


CREATE TABLE tasa_plazo_fijo (
    periodo MEDIUMINT UNSIGNED NOT NULL,
    monto_inf DECIMAL(16,2) UNSIGNED NOT NULL,
    monto_sup DECIMAL(16,2) UNSIGNED NOT NULL,
    tasa DECIMAL(4,2) UNSIGNED NOT NULL, /*preguntar*/

    CONSTRAINT pk_tasa_plazo_fijo
    PRIMARY KEY (periodo, monto_inf, monto_sup)

) ENGINE=InnoDB;


CREATE TABLE plazo_cliente (
    nro_plazo INT UNSIGNED NOT NULL,
    nro_cliente SMALLINT UNSIGNED NOT NULL,

    CONSTRAINT pk_plazo_cliente /*preguntar si se pueden poner dos CONSTRAINT*/
    PRIMARY KEY (nro_plazo, nro_cliente),

    CONSTRAINT fk_plazo_cliente
    FOREIGN KEY (nro_plazo) REFERENCES plazo_fijo (nro_plazo),
    FOREIGN KEY (nro_cliente) REFERENCES cliente (nro_cliente)

) ENGINE=InnoDB;


CREATE TABLE prestamo (
    nro_prestamo INT UNSIGNED NOT NULL AUTO_INCREMENT,
    fecha DATE NOT NULL,
    cant_meses TINYINT UNSIGNED NOT NULL,
    monto DECIMAL(10,2) UNSIGNED NOT NULL,
    tasa_interes DECIMAL(4,2) UNSIGNED NOT NULL,
    interes DECIMAL(9,2) UNSIGNED NOT NULL,
    valor_cuota DECIMAL(9,2) UNSIGNED NOT NULL,
    legajo SMALLINT UNSIGNED NOT NULL,
    nro_cliente SMALLINT UNSIGNED NOT NULL,

    CONSTRAINT pk_prestamo
    PRIMARY KEY (nro_prestamo),

    CONSTRAINT fk_prestamo
    FOREIGN KEY (legajo) REFERENCES empleado (legajo),
    FOREIGN KEY (nro_cliente) REFERENCES cliente (nro_cliente)

) ENGINE=InnoDB;


CREATE TABLE pago (
    nro_prestamo INT UNSIGNED NOT NULL,
    nro_pago TINYINT UNSIGNED NOT NULL,
    fecha_venc DATE NOT NULL,
    fecha_pago DATE,

    CONSTRAINT pk_pago
    PRIMARY KEY (nro_prestamo, nro_pago),

    CONSTRAINT fk_pago
    FOREIGN KEY (nro_prestamo) REFERENCES prestamo (nro_prestamo)

) ENGINE=InnoDB;


CREATE TABLE tasa_prestamo (
    periodo MEDIUMINT UNSIGNED NOT NULL,
    monto_inf DECIMAL(10,2) UNSIGNED NOT NULL,
    monto_sup DECIMAL(10,2) UNSIGNED NOT NULL,
    tasa DECIMAL(4,2) UNSIGNED NOT NULL,

    CONSTRAINT pk_prestamo
    PRIMARY KEY (monto_inf, monto_sup, periodo)

) ENGINE=InnoDB;


CREATE TABLE caja_ahorro (
    nro_ca INT UNSIGNED NOT NULL AUTO_INCREMENT,
    CBU BIGINT UNSIGNED NOT NULL,
    saldo DECIMAL(16,2) UNSIGNED NOT NULL,

    CONSTRAINT pk_caja_ahorro
    PRIMARY KEY (nro_ca)

) ENGINE=InnoDB;


CREATE TABLE cliente_ca (
    nro_cliente SMALLINT UNSIGNED NOT NULL,
    nro_ca INT UNSIGNED NOT NULL,

    CONSTRAINT pk_cliente_ca
    PRIMARY KEY (nro_ca, nro_cliente),

    CONSTRAINT fk_cliente_ca
    FOREIGN KEY (nro_cliente) REFERENCES cliente (nro_cliente),
    FOREIGN KEY (nro_ca) REFERENCES caja_ahorro (nro_ca)

) ENGINE=InnoDB;


CREATE TABLE tarjeta (
    nro_tarjeta BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    PIN VARCHAR(32) NOT NULL, /*utilizar hash md5*/
    CVT VARCHAR(32) NOT NULL, /*utilizar hash md5*/
    fecha_venc DATE NOT NULL,
    nro_cliente SMALLINT UNSIGNED NOT NULL,
    nro_ca INT UNSIGNED NOT NULL,

    CONSTRAINT pk_tarjeta
    PRIMARY KEY (nro_tarjeta),

    CONSTRAINT fk_tarjeta
    FOREIGN KEY (nro_cliente, nro_ca) REFERENCES cliente_ca (nro_cliente, nro_ca)

) ENGINE=InnoDB;


CREATE TABLE caja (
    cod_caja MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,

    CONSTRAINT pk_caja
    PRIMARY KEY (cod_caja)

) ENGINE=InnoDB;


CREATE TABLE ventanilla (
    cod_caja MEDIUMINT UNSIGNED NOT NULL,
    nro_suc SMALLINT UNSIGNED NOT NULL,

    CONSTRAINT pk_ventanilla
    PRIMARY KEY (cod_caja),

    CONSTRAINT fk_ventanilla
    FOREIGN KEY (cod_caja) REFERENCES caja (cod_caja), /* esta bien?*/
    FOREIGN KEY (nro_suc) REFERENCES sucursal (nro_suc)

) ENGINE=InnoDB;


CREATE TABLE atm (
    cod_caja MEDIUMINT UNSIGNED NOT NULL,
    cod_postal SMALLINT UNSIGNED NOT NULL,
    direccion VARCHAR(20) NOT NULL,

    CONSTRAINT pk_atm
    PRIMARY KEY (cod_caja),

    CONSTRAINT fk_atm
    FOREIGN KEY (cod_caja) REFERENCES caja (cod_caja),
    FOREIGN KEY (cod_postal) REFERENCES ciudad (cod_postal)

) ENGINE=InnoDB;


CREATE TABLE transaccion (
    nro_trans INT UNSIGNED NOT NULL AUTO_INCREMENT,
    fecha DATE NOT NULL,
    hora  TIME NOT NULL, /* PREGUNTAR*/
    monto DECIMAL(16,2) UNSIGNED NOT NULL,

    CONSTRAINT pk_transaccion
    PRIMARY KEY (nro_trans)

) ENGINE=InnoDB;


CREATE TABLE debito (
    nro_trans INT UNSIGNED NOT NULL,
    descripcion TINYTEXT,
    nro_cliente SMALLINT UNSIGNED NOT NULL,
    nro_ca INT UNSIGNED NOT NULL,

    CONSTRAINT pk_debito
    PRIMARY KEY (nro_trans),

    CONSTRAINT fk_debito
    FOREIGN KEY (nro_trans) REFERENCES transaccion (nro_trans),
    FOREIGN KEY (nro_cliente, nro_ca) REFERENCES cliente_ca (nro_cliente, nro_ca)

) ENGINE=InnoDB;


CREATE TABLE transaccion_por_caja (
    nro_trans INT UNSIGNED NOT NULL,
    cod_caja MEDIUMINT UNSIGNED NOT NULL,

    CONSTRAINT pk_transaccion_por_caja
    PRIMARY KEY (nro_trans),

    CONSTRAINT fk_transaccion_por_caja
    FOREIGN KEY (nro_trans) REFERENCES transaccion (nro_trans),
    FOREIGN KEY (cod_caja) REFERENCES caja (cod_caja)

) ENGINE=InnoDB;


CREATE TABLE deposito (
    nro_trans INT UNSIGNED NOT NULL,
    nro_ca INT UNSIGNED NOT NULL,

    CONSTRAINT pk_deposito
    PRIMARY KEY (nro_trans),

    CONSTRAINT fk_deposito
    FOREIGN KEY (nro_trans) REFERENCES transaccion_por_caja (nro_trans),
    FOREIGN KEY (nro_ca) REFERENCES caja_ahorro (nro_ca)

) ENGINE=InnoDB;


CREATE TABLE extraccion (
    nro_trans INT UNSIGNED NOT NULL,
    nro_cliente SMALLINT UNSIGNED NOT NULL,
    nro_ca INT UNSIGNED NOT NULL,

    CONSTRAINT pk_extraccion
    PRIMARY KEY (nro_trans),

    CONSTRAINT fk_extraccion
    FOREIGN KEY (nro_cliente, nro_ca) REFERENCES cliente_ca (nro_cliente, nro_ca),
    FOREIGN KEY (nro_trans) REFERENCES transaccion_por_caja (nro_trans)

) ENGINE=InnoDB;


CREATE TABLE transferencia (
    nro_trans INT UNSIGNED NOT NULL,
    nro_cliente SMALLINT UNSIGNED NOT NULL,
    origen INT UNSIGNED NOT NULL,
    destino INT UNSIGNED NOT NULL,

    CONSTRAINT pk_transferencia
    PRIMARY KEY (nro_trans),

    CONSTRAINT fk_transferencia
    FOREIGN KEY (nro_trans) REFERENCES transaccion_por_caja (nro_trans),
    FOREIGN KEY (nro_cliente, origen) REFERENCES cliente_ca (nro_cliente, nro_ca),
    FOREIGN KEY (destino) REFERENCES caja_ahorro (nro_ca)

) ENGINE=InnoDB;


#-------------------------------------------------------------------------
# Creación de usuarios y otorgamiento de privilegios


    CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'admin';

    GRANT ALL PRIVILEGES ON banco.* TO 'admin'@'localhost' WITH GRANT OPTION;


    CREATE USER IF NOT EXISTS 'empleado'@'%' IDENTIFIED BY 'empleado';

    -- Privilegios sólo de consulta (SELECT) sobre las tablas Empleado, Sucursal, Tasa Plazo Fijo y Tasa Prestamo
    GRANT SELECT ON banco.empleado TO 'empleado'@'%';
    GRANT SELECT ON banco.sucursal TO 'empleado'@'%';
    GRANT SELECT ON banco.tasa_plazo_fijo TO 'empleado'@'%';
    GRANT SELECT ON banco.tasa_prestamo TO 'empleado'@'%';

    -- Privilegios de consulta (SELECT) e inserción (INSERT) sobre las tablas Préstamo, Plazo Fijo, Plazo Cliente, Caja Ahorro y Tarjeta
    GRANT SELECT, INSERT ON banco.prestamo TO 'empleado'@'%';
    GRANT SELECT, INSERT ON banco.plazo_fijo TO 'empleado'@'%';
    GRANT SELECT, INSERT ON banco.plazo_cliente TO 'empleado'@'%';
    GRANT SELECT, INSERT ON banco.caja_ahorro TO 'empleado'@'%';
    GRANT SELECT, INSERT ON banco.tarjeta TO 'empleado'@'%';

    -- Privilegios de consulta (SELECT), inserción (INSERT) y modificación (UPDATE) sobre las tablas Cliente CA, Cliente y Pago
    GRANT SELECT, INSERT, UPDATE ON banco.cliente_ca TO 'empleado'@'%';
    GRANT SELECT, INSERT, UPDATE ON banco.cliente TO 'empleado'@'%';
    GRANT SELECT, INSERT, UPDATE ON banco.pago TO 'empleado'@'%';


    -- Eliminamos el usuario vacio
    DROP USER IF EXISTS ''@'localhost';



    CREATE USER IF NOT EXISTS 'atm'@'%' IDENTIFIED BY 'atm';

    GRANT SELECT ON banco.caja_ahorro TO 'atm'@'%';
    GRANT INSERT ON banco.transaccion TO 'atm'@'%'; /*PREGUNTAR*/

	
	CREATE VIEW trans_cajas_ahorro AS
	SELECT
		ca.nro_ca,
		ca.saldo,
		transa.nro_trans,
		transa.fecha,
		transa.hora,
		/* Columna tipo usando CASE */
		CASE
			WHEN transf.nro_trans IS NOT NULL THEN 'Transferencia'
			WHEN deposito.nro_ca IS NOT NULL THEN 'Depósito'
			WHEN debito.nro_trans IS NOT NULL THEN 'Débito'
			WHEN extraccion.nro_cliente IS NOT NULL THEN 'Extracción'
			ELSE 'NULL'
		END AS tipo,
		transa.monto,
		cj.cod_caja,
		cl.nro_cliente,
		cl.tipo_doc,
		cl.nro_doc,
		cl.nombre,
		cl.apellido,
		transf.destino


	FROM transferencia AS transf
	LEFT JOIN transaccion_por_caja ON transf.nro_trans = transaccion_por_caja.nro_trans
	LEFT JOIN transaccion AS transa ON transa.nro_trans = transaccion_por_caja.nro_trans
	/* Unimos transferencia con transacción */

	LEFT JOIN cliente_ca ON transf.nro_cliente = cliente_ca.nro_cliente
	LEFT JOIN cliente AS cl ON cliente_ca.nro_cliente = cl.nro_cliente
	/* Unimos transferencia con cliente */

	LEFT JOIN caja_ahorro AS ca ON ca.nro_ca = transf.destino
	/* Unimos caja ahorro y transferencia */

	LEFT JOIN caja AS cj ON transaccion_por_caja.cod_caja = cj.cod_caja
	/* Unimos cod de caja con transacción */

	LEFT JOIN deposito ON deposito.nro_ca = ca.nro_ca
	LEFT JOIN debito ON debito.nro_trans = transa.nro_trans
	LEFT JOIN extraccion ON extraccion.nro_cliente = cliente_ca.nro_cliente;


	/*Unimos los tipos*/
	
	/*falta cod_caja y ver como relacionar el tipo */
	
	/*
	Utilizaremos left join xq hay nulos en algunas tablas. Preguntar si hacemos bien utilizando 
	todos LEFT JOIN 
	*/
	
	/*datoides*/
	
	
INSERT INTO ciudad (cod_postal, nombre) VALUES
(1000, 'Ciudad A'),
(2000, 'Ciudad B'),
(3000, 'Ciudad C');


INSERT INTO sucursal (nombre, direccion, telefono, horario, cod_postal) VALUES
('Sucursal 1', 'Dirección 1', '123456789', '9-18', 1000),
('Sucursal 2', 'Dirección 2', '987654321', '10-17', 2000);

-- Inserción de datos en la tabla empleado
INSERT INTO empleado (apellido, nombre, tipo_doc, nro_doc, direccion, telefono, cargo, password, nro_suc) VALUES
('Gómez', 'Juan', 'DNI', 12345678, 'Calle 1', '123456789', 'Gerente', MD5('password123'), 1),
('Pérez', 'Ana', 'DNI', 87654321, 'Calle 2', '987654321', 'Cajero', MD5('password123'), 2);

-- Inserción de datos en la tabla cliente
INSERT INTO cliente (apellido, nombre, tipo_doc, nro_doc, direccion, telefono, fecha_nac) VALUES
('Lopez', 'Maria', 'DNI', 11223344, 'Calle 3', '123456789', '1985-06-15'),
('Martínez', 'Carlos', 'DNI', 55667788, 'Calle 4', '987654321', '1990-12-30');

-- Inserción de datos en la tabla plazo_fijo
INSERT INTO plazo_fijo (capital, fecha_inicio, fecha_fin, tasa_interes, interes, nro_suc) VALUES
(10000.00, '2024-01-01', '2024-12-31', 5.00, 500.00, 1),
(20000.00, '2024-01-01', '2025-01-01', 4.50, 900.00, 2);

-- Inserción de datos en la tabla tasa_plazo_fijo
INSERT INTO tasa_plazo_fijo (periodo, monto_inf, monto_sup, tasa) VALUES
(12, 0.00, 10000.00, 5.00),
(24, 10000.01, 20000.00, 4.50);

-- Inserción de datos en la tabla plazo_cliente
INSERT INTO plazo_cliente (nro_plazo, nro_cliente) VALUES
(1, 1),
(2, 2);

-- Inserción de datos en la tabla prestamo
INSERT INTO prestamo (fecha, cant_meses, monto, tasa_interes, interes, valor_cuota, legajo, nro_cliente) VALUES
('2024-06-01', 12, 5000.00, 6.00, 300.00, 450.00, 1, 1),
('2024-07-01', 24, 10000.00, 5.50, 1100.00, 525.00, 2, 2);

-- Inserción de datos en la tabla pago
INSERT INTO pago (nro_prestamo, nro_pago, fecha_venc, fecha_pago) VALUES
(1, 1, '2024-07-01', '2024-07-01'),
(1, 2, '2024-08-01', NULL),
(2, 1, '2024-08-01', '2024-08-01');

-- Inserción de datos en la tabla tasa_prestamo
INSERT INTO tasa_prestamo (periodo, monto_inf, monto_sup, tasa) VALUES
(12, 0.00, 5000.00, 6.00),
(24, 5000.01, 10000.00, 5.50);

-- Inserción de datos en la tabla caja_ahorro
INSERT INTO caja_ahorro (CBU, saldo) VALUES
(1234567890123456, 1000.00),
(6543210987654321, 2000.00);

-- Inserción de datos en la tabla cliente_ca
INSERT INTO cliente_ca (nro_cliente, nro_ca) VALUES
(1, 1),
(2, 2);

-- Inserción de datos en la tabla tarjeta
INSERT INTO tarjeta (PIN, CVT, fecha_venc, nro_cliente, nro_ca) VALUES
(MD5('1234'), MD5('abcd'), '2025-12-31', 1, 1),
(MD5('5678'), MD5('efgh'), '2026-12-31', 2, 2);

-- Inserción de datos en la tabla caja
INSERT INTO caja (cod_caja) VALUES
(1),
(2);

-- Inserción de datos en la tabla ventanilla
INSERT INTO ventanilla (cod_caja, nro_suc) VALUES
(1, 1),
(2, 2);

-- Inserción de datos en la tabla atm
INSERT INTO atm (cod_caja, cod_postal, direccion) VALUES
(1, 1000, 'Dirección ATM 1'),
(2, 2000, 'Dirección ATM 2');

-- Inserción de datos en la tabla transaccion
INSERT INTO transaccion (fecha, hora, monto) VALUES
('2024-09-01', '10:00:00', 100.00),
('2024-09-02', '11:00:00', 200.00);

-- Inserción de datos en la tabla debito
INSERT INTO debito (nro_trans, descripcion, nro_cliente, nro_ca) VALUES
(1, 'Compra en tienda', 1, 1),
(2, 'Compra en línea', 2, 2);

-- Inserción de datos en la tabla transaccion_por_caja
INSERT INTO transaccion_por_caja (nro_trans, cod_caja) VALUES
(1, 1),
(2, 2);

-- Inserción de datos en la tabla deposito
INSERT INTO deposito (nro_trans, nro_ca) VALUES
(1, 1);

-- Inserción de datos en la tabla extraccion
INSERT INTO extraccion (nro_trans, nro_cliente, nro_ca) VALUES
(2, 2, 2);

-- Inserción de datos en la tabla transferencia
INSERT INTO transferencia (nro_trans, nro_cliente, origen, destino) VALUES
(1, 1, 1, 2);



















