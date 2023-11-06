DROP DATABASE IF EXISTS LRCreative;

CREATE DATABASE LRCreative;
USE LRCreative;

GRANT ALL PRIVILEGES ON * TO web_user@localhost IDENTIFIED BY 'password';
FLUSH PRIVILEGES;

CREATE TABLE Usuario(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(250),
    email VARCHAR(100),
    password VARCHAR(500),
    admin BOOL DEFAULT False
);

CREATE TABLE Pedido(
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_pedido DATETIME,
    status VARCHAR(50),
    fecha_cambio_status DATETIME,
    metodo_pago VARCHAR(50),
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id)
);

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

INSERT INTO Usuario (nombre, email, password, admin) VALUES 
('Oscar Flores', 'oscarlflores@hotmail.com', 'pbkdf2:sha256:260000$q9gOWvEsc12VVxIb$cba1b25127eda4c0e4137470ffedab24b355371db0397d4120e6c75d20ddff28', True),
('Roberto Leija', 'roberto.leija@udem.edu', 'pbkdf2:sha256:260000$5Q6WZya4Hd0z79GZ$938dfd8cc120494c6f384c63a63a8cdb01d0bd3c04487e2ca178b8742de95fef', True),
('Eduardo Flores', 'eduardo.flores@udem.edu0', 'pbkdf2:sha256:260000$KQkoQvXg5oPSvMp4$438ce75f0155bb6ac048b6fc571ce85017289d9550374b72969c6c6953b9b8e7', False),
('David Zavala', 'david.zavala@udem.edu', 'pbkdf2:sha256:260000$pkoVJcGYzpZlFkGr$3b9c1c98ef805d7918b1c55229b13f86a8f05249fcff4b3479f83dbcf6d30a5c', False),
('Carlos Lozada', 'carlos.lozada@udem.edu', 'pbkdf2:sha256:260000$AtZmuVmA2oDMKL8q$a41bda668c99829af385818e90e40fa3f855004a110352746d0e38ad5acb5961', False);

INSERT INTO Pedido (fecha_pedido, status, fecha_cambio_status, metodo_pago, id_usuario) VALUES 
('2023-10-15 08:30:00', 'En Proceso', '2023-10-15 09:15:00', 'Master Card' ,1),
('2023-10-16 14:45:00', 'Entregado', '2023-10-17 10:20:00', ' Master Card', 2),
('2023-10-18 11:00:00', 'En Proceso', '2023-10-18 14:30:00', 'VISA', 3),
('2023-10-19 09:20:00', 'Entregado', '2023-10-19 12:45:00', 'American Express', 4),
('2023-10-20 15:10:00', 'En Proceso', '2023-10-20 17:30:00', 'Paypal', 5);

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
