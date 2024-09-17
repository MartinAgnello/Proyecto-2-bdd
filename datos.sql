
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

