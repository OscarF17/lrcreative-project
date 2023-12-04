DROP DATABASE IF EXISTS LRCreative;

CREATE DATABASE LRCreative;
USE LRCreative;

GRANT ALL PRIVILEGES ON * TO web_user@localhost IDENTIFIED BY 'password';
FLUSH PRIVILEGES;

CREATE TABLE Usuario(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(250),
    email VARCHAR(100),
    password VARCHAR(500)
);

CREATE TABLE Pedido(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_cliente VARCHAR(200),
    correo VARCHAR(200),
    calle1 VARCHAR(200),
    calle2 VARCHAR(200),
    ciudad VARCHAR(200),
    codigo_postal VARCHAR(200),
    telefono VARCHAR(200),
    fecha_pedido DATETIME,
    status VARCHAR(50),
    fecha_cambio_status DATETIME,
    metodo_pago VARCHAR(50)
);

DELIMITER ..
CREATE PROCEDURE crearPedido(
    IN in_nombre VARCHAR(200),
    IN in_correo VARCHAR(200),
    IN in_calle1 VARCHAR(200),
    IN in_calle2 VARCHAR(200),
    IN in_ciudad VARCHAR(200),
    IN in_codigo VARCHAR(200),
    IN in_telefono VARCHAR(200),
    IN in_metodo VARCHAR(50)
)
BEGIN
    INSERT INTO Pedido (nombre_cliente, correo, calle1, calle2, ciudad, codigo_postal, telefono, fecha_pedido, status, fecha_cambio_status, metodo_pago) VALUES
    (in_nombre, in_correo, in_calle1, in_calle2, in_ciudad, in_codigo, in_telefono, NOW(), 'Pendiente', NOW(), in_metodo);
END ..
DELIMITER ;

CREATE TABLE Producto(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(200),
    precio DECIMAL(10,2),
    foto VARCHAR(200),
    descripcion VARCHAR(1000)
);

CREATE TABLE DetallePedido(
    pedido_id INT,
    producto_id INT,
    cantidad INT,
    color VARCHAR(50),
    PRIMARY KEY(pedido_id, producto_id),
    FOREIGN KEY (pedido_id) REFERENCES Pedido(id),
    FOREIGN KEY (producto_id) REFERENCES Producto(id)
);

INSERT INTO Producto (nombre, precio, foto, descripcion) VALUES
('Playeras', 250.00, 'playeras.jpg', 'Cómodas playeras personalizadas con tus diseños favoritos. Disponibles en distintos tamaños y colores'),
('Camisas Polo', 300.00, 'polo.jpg', 'Representa a tu escuela u organización con camisas polo de alta cálidad'),
('Gorras', 150.00, 'gorras.jpg', 'Gorras unitalla ideales para toda clase de eventos, garantizadas a quedarle a todo mundo'),
('Tazas', 100.00, 'tazas.jpg', 'Ideales para regalos, personaliza tazas de distintos colores con diseños y mensajes personalizables'),
('Termos', 200.00, 'termos.jpg', 'Perfectos para regalos y eventos. Personaliza tus termos de distintos colores con el logo de tu organización');

INSERT INTO Usuario (nombre, email, password) VALUES 
('Oscar Flores', 'oscarlflores@hotmail.com', 'pbkdf2:sha256:260000$q9gOWvEsc12VVxIb$cba1b25127eda4c0e4137470ffedab24b355371db0397d4120e6c75d20ddff28'),
('Roberto Leija', 'roberto.leija@udem.edu', 'pbkdf2:sha256:260000$5Q6WZya4Hd0z79GZ$938dfd8cc120494c6f384c63a63a8cdb01d0bd3c04487e2ca178b8742de95fef'),
('Eduardo Flores', 'eduardo.flores@udem.edu0', 'pbkdf2:sha256:260000$KQkoQvXg5oPSvMp4$438ce75f0155bb6ac048b6fc571ce85017289d9550374b72969c6c6953b9b8e7'),
('David Zavala', 'david.zavala@udem.edu', 'pbkdf2:sha256:260000$pkoVJcGYzpZlFkGr$3b9c1c98ef805d7918b1c55229b13f86a8f05249fcff4b3479f83dbcf6d30a5c'),
('Carlos Lozada', 'carlos.lozada@udem.edu', 'pbkdf2:sha256:260000$AtZmuVmA2oDMKL8q$a41bda668c99829af385818e90e40fa3f855004a110352746d0e38ad5acb5961');



/*
INSERT INTO Pedido (fecha_pedido, status, fecha_cambio_status, metodo_pago) VALUES 
('2023-10-15 08:30:00', 'En Proceso', '2023-10-15 09:15:00', 'Master Card'),
('2023-10-16 14:45:00', 'Entregado', '2023-10-17 10:20:00', ' Master Card'),
('2023-10-18 11:00:00', 'En Proceso', '2023-10-18 14:30:00', 'VISA'),
('2023-10-19 09:20:00', 'Entregado', '2023-10-19 12:45:00', 'American Express'),
('2023-10-20 15:10:00', 'En Proceso', '2023-10-20 17:30:00', 'Paypal');

-- Detalles del Pedido 1
INSERT INTO DetallePedido (pedido_id, producto_id, cantidad) VALUES (1, 1, 3); -- 3 Playeras
INSERT INTO DetallePedido (pedido_id, producto_id, cantidad) VALUES (1, 4, 5); -- 5 Tazas

-- Detalles del Pedido 2
INSERT INTO DetallePedido (pedido_id, producto_id, cantidad) VALUES (2, 2, 2); -- 2 Camisas Polo
INSERT INTO DetallePedido (pedido_id, producto_id, cantidad) VALUES (2, 5, 1); -- 1 Termo

-- Detalles del Pedido 3
INSERT INTO DetallePedido (pedido_id, producto_id, cantidad) VALUES (3, 3, 4); -- 4 Gorras
INSERT INTO DetallePedido (pedido_id, producto_id, cantidad) VALUES (3, 1, 2); -- 2 Playeras

-- Detalles del Pedido 4
INSERT INTO DetallePedido (pedido_id, producto_id, cantidad) VALUES (4, 5, 2); -- 2 Termos
INSERT INTO DetallePedido (pedido_id, producto_id, cantidad) VALUES (4, 4, 3); -- 3 Tazas

-- Detalles del Pedido 5
INSERT INTO DetallePedido (pedido_id, producto_id, cantidad) VALUES (5, 1, 1); -- 1 Playera
INSERT INTO DetallePedido (pedido_id, producto_id, cantidad) VALUES (5, 2, 1); -- 1 Camisa Polo
*/
