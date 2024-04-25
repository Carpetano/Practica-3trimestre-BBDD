

DROP DATABASE IF EXISTS iceAndChill;
CREATE DATABASE iceAndChill;
USE iceAndChill;

CREATE TABLE Comentarios (
    id_comentario INT(6) PRIMARY KEY,
    comentario VARCHAR(255),
    id_helado TINYINT
);

CREATE TABLE Pedidos (
    id_pedido INT(6) PRIMARY KEY,
    direccion VARCHAR(50),
    precio_total DECIMAL(7,2),
    fecha_pedido DATE
);

CREATE TABLE Helados (
    id_helado TINYINT PRIMARY KEY,
    sabor VARCHAR(20),
    precio DECIMAL(4,2),
    valoracion DECIMAL(3,2),
    alergenos VARCHAR(127)
);

CREATE TABLE Usuarios (
    mail VARCHAR(50) PRIMARY KEY,
    contraseña VARCHAR(50),
    id_pedido INT(6)
);

-- Add foreign key constraint after Helados table is created
ALTER TABLE Comentarios
ADD CONSTRAINT fk_helado_comentario
FOREIGN KEY (id_helado) REFERENCES Helados(id_helado);

-- Inserts para la tabla Helados
INSERT INTO Helados (id_helado, sabor, precio, valoracion, alergenos) VALUES
(1, 'Vainilla', 3.50, 4.5, 'Leche, huevos'),
(2, 'Chocolate', 4.00, 4.2, 'Leche, soja'),
(3, 'Fresa', 3.80, 4.0, 'Leche, frutas');

-- Inserts para la tabla Pedidos
INSERT INTO Pedidos (id_pedido, direccion, precio_total, fecha_pedido) VALUES
(1, 'Calle Principal 123', 15.50, '2024-04-20'),
(2, 'Avenida Central 456', 12.00, '2024-04-21'),
(3, 'Plaza Mayor 789', 10.80, '2024-04-22');

-- Inserts para la tabla Usuarios
INSERT INTO Usuarios (mail, contraseña, id_pedido) VALUES
('usuario1@example.com', 'contraseña123', 1),
('usuario2@example.com', 'segura456', 2),
('usuario3@example.com', 'clave789', 3);

-- Inserts para la tabla Usuarios
INSERT INTO Comentarios (id_comentario, comentario, id_helado) VALUES
(1, 'Muy Cremoso', 1),
(2, 'No es un sabor tipico muy dulce de chocolate, es bastante agradable', 3),
(3, 'Siempre lo pido con extra de almendras, me encanta', 2)

