-- Queries de la BBDD

-- 1. Crea 2 consultas monotabla que se ejecuten regularmente en la aplicación. 
-- Por ejemplo, si al conectarnos la app nos muestra las ofertas de los productos “SELECT ofertas FROM productos;”


-- Mario | Mostrar helados con valoracion de mas de 4 
SELECT * 
FROM Helados
WHERE valoracion > 4;

-- Mario | Mostrar helados que no contengan huevo
SELECT * 
FROM Helados
WHERE LOWER(alergenos) NOT LIKE '%huevos%';

JAVIER | -Mostrar comentarios de los helados ordenados por su id.

SELECT comentario , id_helado
FROM comentarios
ORDER BY id_helado;

JAVIER | Mostrar mail,id pedido ordenados por su mail.
SELECT id_pedido , mail
FROM usuarios
ORDER BY mail;



-- 2. Igual que en el apartado anterior, crea 2 consultas multitablas que se ejecutarán de manera frecuente en la aplicación  (JOIN)


-- Mario | Mostrar todos los datos de los pedidos y el mail de el usuario que los pidió
SELECT Pedidos.*, Usuarios.mail
FROM Pedidos
INNER JOIN Usuarios ON Pedidos.id_pedido = Usuarios.id_pedido;

-- Mario | Mostrar todo sobre los comentarios y el sabor al que se refieren en vez de la id
SELECT Comentarios.*, Helados.sabor
FROM Comentarios
INNER JOIN Helados ON Comentarios.id_helado = Helados.id_helado;

JAVIER |-- La consulta devuelve todos los comentarios de cada sabor de helado junto con los detalles del sabor correspondiente.
SELECT
    c.comentario AS Comentarios,
    h.sabor AS Sabor,
    h.precio AS Precio,
    h.valoracion AS Valoracion
FROM
    Comentarios AS c
INNER JOIN
    Helados AS h ON c.id_helado = h.id_helado;
    
    
JAVIER |-- La consulta devuelve todos los pedidos junto con los detalles del usuario que realizó el pedido correspondiente.
SELECT
    p.id_pedido AS idPedido,
    p.direccion AS direccion,
    p.precio_total AS PrecioTotal,
    p.fecha_pedido AS fechaPedido,
    u.mail AS mail
FROM
    Pedidos AS p
INNER JOIN
    Usuarios AS u ON p.id_pedido = u.id_pedido;




-- 3. Crea 2 inserciones, 2 modificaciones y 2 eliminaciones frecuentes que se llevarán a cabo en la aplicación. 


-- Mario | Insertar un comentario
INSERT INTO Comentarios (id_comentario, comentario, id_helado) 
VALUES (4, 'Delicioso helado de vainilla con trozos de chocolate', 1);

-- Mario | Insertar un pedido nuevo
INSERT INTO Pedidos (id_pedido, direccion, precio_total, fecha_pedido) 
VALUES (4, 'Calle de la Alegría 789', 18.00, '2024-04-24');

-- Mario | Actualizar el precio del helado 3
UPDATE Helados
SET precio = 3.90
WHERE id_helado = 3;

-- Mario | Cambiar la direccion de el pedido 3
UPDATE Pedidos
SET direccion = 'Calle de la Alegría 890'
WHERE id_pedido = 3;

-- Mario | Borrar el comentario con id 2
DELETE FROM Comentarios
WHERE id_comentario = 2;

-- Mario | Borrar el pedido con id 2
DELETE FROM Pedidos
WHERE id_pedido = 2;


 JAVIER|INSERCIONES

JAVIER|—Insertar un nuevo comentario en la tabla Comentarios:
INSERT INTO Comentarios (id_comentario, comentario, id_helado)
VALUES (4, 'Este helado es mi favorito', 1);


JAVIER|—Insertar un nuevo pedido en la tabla Pedidos:

INSERT INTO Pedidos (id_pedido, direccion, precio_total, fecha_pedido)
VALUES (4, 'Calle del Sol 123', 15.00, '2023-03-25');



JAVIER|Modificaciones:

JAVIER|-Actualizar el precio de un helado en la tabla Helados:

UPDATE Helados
SET precio = 4.50
WHERE id_helado = 2;


JAVIER|-Actualizar la contraseña de un usuario en la tabla Usuarios:

UPDATE Usuarios
SET contraseña = 'nueva_contraseña'
WHERE mail = 'usuario1@example.com';


JAVIER|Eliminaciones:

JAVIER|-Eliminar un comentario de la tabla Comentarios:

DELETE FROM Comentarios
WHERE id_comentario = 1;

JAVIER|-Eliminar un pedido de la tabla Pedidos:

DELETE FROM Pedidos
WHERE id_pedido = 3;


-- 4. Imaginaros que vienen dos personas nuevas a vuestra empresa, os ayudarán a mejorar aspectos de la aplicación 
-- ¿Qué vistas le proporcionaríais teniendo en cuenta las funciones que van a desarrollar (define también qué función desarrollarán)? 
-- crea mínimo 2 vistas.

JAVIER|-Vista para el Analista de ventas: Esta vista muestra el número de pedidos y el total de ventas para cada sabor de helado.


CREATE VIEW VentasHelados AS
SELECT h.sabor, COUNT(p.id_pedido) AS NumeroPedidos, SUM(p.precio_total) AS TotalVentas
FROM Helados h
LEFT JOIN Pedidos p ON h.id_helado = p.id_helado
GROUP BY h.sabor;


JAVIER|-Vista para el Administrador de Comentarios y Valoraciones: Esta vista muestra todos los comentarios y valoraciones de los helados, junto con el sabor de helado correspondiente.

CREATE VIEW ComentariosValoraciones AS
SELECT c.id_comentario, c.comentario, c.id_helado, h.sabor, h.valoracion
FROM Comentarios c
INNER JOIN Helados h ON c.id_helado = h.id_helado;


-- 5. Define qué usuarios crearías para que puedan acceder al SGBD y qué permisos tendrán.

JAVIER|
  -Administrador del SGBD:
– CREAR USUARIO PARA EL ADMIN Y PERMISOS DE TODO
CREATE USER admin@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO admin@'localhost';



JAVIER|
  -Analista de datos:
– CREAR USUARIO ANALISTA DE DATOS Y VISTAS , SOLO TIENE PERMISOS DE SELECCIONAR Y VER VISTAS
CREATE USER analyst@'localhost' IDENTIFIED BY 'password';
GRANT SELECT ON iceAndChill.* TO analyst@'localhost'


-- 6. ¿Has detectado alguna consulta que se realiza constantemente? ¿echas de menos algún índice? por ejemplo, 
-- si se busca siempre información por ciudad sería recomendable crear un índice en el campo ciudad.

JAVIER|– CREAR INDICE PARA LAS VALORACIONES DE LOS HELADOS
CREATE INDEX idx_valoracion ON Helados (valoracion);

JAVIER|–CREAR INDICE PARA LAS FECHAS DE PEDIDOS
CREATE INDEX idx_fecha_pedido ON Pedidos (fecha_pedido);




-- 7. ¿Qué triggers pensáis que necesita la base de datos?, crea 2 trigger por tabla.


JAVIER|– TRIGGER PARA NUEVO PEDIDO 
DELIMITER //
CREATE TRIGGER nuevo_pedido
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
  UPDATE Usuarios SET id_pedido = NEW.id_pedido WHERE mail = NEW.mail;
END;//
DELIMITER;


JAVIER|– TRIGGER PARA ACTUALIZAR PRECIO TOTAL
DELIMITER //
CREATE TRIGGER precioTotal_act
AFTER UPDATE ON Helados
FOR EACH ROW
BEGIN
  UPDATE Pedidos SET precio_total = precio_total + (NEW.precio - OLD.precio) WHERE id_helado = NEW.id_helado;
END;//
DELIMITER;


-- 8. ¿Qué procedimientos almacenados podría necesitar la base de datos?, crea 2 procedimientos almacenados.

JAVIER|–Procedimiento almacenado para agregar un nuevo helado a la tabla Helados:

DELIMITER //
CREATE PROCEDURE helado_nuevo(
  IN sabor VARCHAR(20),
  IN precio DECIMAL(4,2),
  IN valoracion DECIMAL(3,2),
  IN alergenos VARCHAR(127)
)
BEGIN
  INSERT INTO Helados (sabor, precio, valoracion, alergenos) VALUES (sabor, precio, valoracion, alergenos);
END; //
DELIMITER;



JAVIER|Procedimiento almacenado para obtener todos los pedidos realizados por un usuario específico:

DELIMITER //
CREATE PROCEDURE pedidos_Usuarios(
  IN userEmail VARCHAR(50)
)
BEGIN
  SELECT * FROM Pedidos WHERE mail = userEmail;
END; //
DELIMITER;

