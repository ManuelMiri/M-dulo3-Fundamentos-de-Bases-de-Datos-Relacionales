-- Crea la base de datos Alke Wallet
CREATE DATABASE  `alke Wallet`;


START TRANSACTION; -- Iniciar la transaccion

-- Crear la tabla Usuario
CREATE TABLE IF NOT EXISTS Usuario (
    user_id INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo_electronico VARCHAR(100),
    contrasena VARCHAR(50),
    saldo DECIMAL(10, 2)
);

-- Crear la tabla Transaccion
CREATE TABLE IF NOT EXISTS Transaccion (
    transaction_id INT PRIMARY KEY,
    envia_user_id INT,
    recibe_user_id INT,
    importe DECIMAL(10, 2),
    transaction_date DATE,
    FOREIGN KEY (envia_user_id) REFERENCES Usuario(user_id),
    FOREIGN KEY (recibe_user_id) REFERENCES Usuario(user_id)
);

-- Crear la tabla Moneda
CREATE TABLE IF NOT EXISTS Moneda (
    divisa_id INT PRIMARY KEY,
    divisa_nombre VARCHAR(50),
    divisa_simbolo VARCHAR(5)
);

-- Agregar relacion entre Transaccion y Moneda
ALTER TABLE  Transaccion
ADD COLUMN divisa_id INT,
ADD FOREIGN KEY (divisa_id) REFERENCES Moneda(divisa_id);

-- Agregar las tres monedas a la tabla Moneda
INSERT INTO Moneda (divisa_id, divisa_nombre, divisa_simbolo) VALUES
(2, 'Dólar', '$'),
(3, 'Euro', '€'),
(4, 'Peso Chileno', 'Cl$');

-- Agregar tres usuarios a la tabla Usuario
INSERT INTO Usuario (user_id, nombre, correo_electronico, contrasena, saldo) VALUES
(2, 'Felipe', 'Felipe@example.com', '123456', 1000.00),
(3, 'Pablo', 'Pablo@example.com', '654123', 2000.00),
(4, 'Jose', 'Jose@example.com', '789456', 1500.00);

-- Agregar una transaccion
INSERT INTO Transaccion (transaction_id, envia_user_id, recibe_user_id, importe, transaction_date, divisa_id) VALUES 
(10, 2, 3, 500.00, '2024-03-27', 3);

-- Actualizar los saldos de los usuarios involucrados en la transaccion
UPDATE Usuario SET saldo = saldo - 500.00 WHERE user_id = 2;
UPDATE Usuario SET saldo = saldo + 500.00 WHERE user_id = 3;



select * from transaccion

COMMIT; -- Confirma la transaccion


-- Consulta para obtener el nombre de la moneda elegida por un usuario  especifico
SELECT M.divisa_nombre
FROM Usuario U
JOIN Transaccion T ON U.user_id = T.envia_user_id
JOIN Moneda M ON T.divisa_id = M.divisa_id
WHERE U.user_id = '2';

-- Consulta para obtener todas las transacciones realizadas por un usuario especifico
SELECT *
FROM Transaccion
WHERE envia_user_id = '2' OR recibe_user_id = '2';

-- Consulta para obtener todas las transacciones registradas
SELECT *
FROM Transaccion;


-- Sentencia DML para modificar el campo correo electronico de un usuario especifico
UPDATE Usuario
SET correo_electronico = 'Manuel@gmail.com'
WHERE user_id = '3';

-- Sentencia para eliminar los datos de una transaccion ( fila completa):
DELETE FROM Transaccion
WHERE transaction_id = '10';


