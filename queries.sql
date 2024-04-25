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


-- JAVIER | Mostrar comentarios de los helados ordenados por su id.

SELECT comentario , id_helado
FROM comentarios
ORDER BY id_helado;

-- JAVIER | Mostrar mail,id pedido ordenados por su mail.
SELECT id_pedido , mail
FROM usuarios
ORDER BY mail;


-- ANGEL | SABORES PREFERIDOS POR LOS CLIENTES
SELECT sabor
FROM helados
ORDER BY valoracion DESC
LIMIT 3;
        
-- ANGEL | ¿CUAL ES LA INFORMACION DEL PEDIDO MÁS RECIENTE?
SELECT *
FROM pedidos
ORDER BY id_pedido DESC
LIMIT 1;

-- 2. Igual que en el apartado anterior, crea 2 consultas multitablas que se ejecutarán de manera frecuente en la aplicación  (JOIN)

-- Mario | Mostrar todos los datos de los pedidos y el mail de el usuario que los pidió
SELECT Pedidos.*, Usuarios.mail
FROM Pedidos
INNER JOIN Usuarios ON Pedidos.id_pedido = Usuarios.id_pedido;

-- Mario | Mostrar todo sobre los comentarios y el sabor al que se refieren en vez de la id
SELECT Comentarios.*, Helados.sabor
FROM Comentarios
INNER JOIN Helados ON Comentarios.id_helado = Helados.id_helado;


-- JAVIER | La consulta devuelve todos los comentarios de cada sabor de helado junto con los detalles del sabor correspondiente.
SELECT
    c.comentario AS Comentarios,
    h.sabor AS Sabor,
    h.precio AS Precio,
    h.valoracion AS Valoracion
FROM
    Comentarios AS c
INNER JOIN
    Helados AS h ON c.id_helado = h.id_helado;

-- JAVIER |-- La consulta devuelve todos los pedidos junto con los detalles del usuario que realizó el pedido correspondiente.
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


-- ANGEL | COMENTARIOS DE LOS CLIENTES RESPECTO A LOS SABORES
SELECT h.sabor, c.comentario
FROM helados h
INNER JOIN comentarios c ON h.id_helado = c.id_comentario;
        
-- ANGEL | CONOCER LA INFORMACION DE LOS CLIENTES QUE HAN REALIZADO PEDIDOS
SELECT p.id_pedido, u.mail, u.contraseña
FROM pedidos p
INNER JOIN usuarios u ON p.id_pedido = u.id_pedido
ORDER BY p.id_pedido DESC;

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


-- JAVIER |INSERCIONES

-- JAVIER | Insertar un nuevo comentario en la tabla Comentarios:
INSERT INTO Comentarios (id_comentario, comentario, id_helado)
VALUES (4, 'Este helado es mi favorito', 1);

-- JAVIER | Insertar un nuevo pedido en la tabla Pedidos:
INSERT INTO Pedidos (id_pedido, direccion, precio_total, fecha_pedido)
VALUES (4, 'Calle del Sol 123', 15.00, '2023-03-25');


-- JAVIER | MODIFICACIONES

-- JAVIER | Actualizar el precio de un helado en la tabla Helados:
UPDATE Helados
SET precio = 4.50
WHERE id_helado = 2;

-- JAVIER | Actualizar la contraseña de un usuario en la tabla Usuarios:
UPDATE Usuarios
SET contraseña = 'nueva_contraseña'
WHERE mail = 'usuario1@example.com';

-- JAVIER | ELIMINACIONES

-- JAVIER | Eliminar un comentario de la tabla Comentarios:
DELETE FROM Comentarios
WHERE id_comentario = 1;

-- JAVIER | Eliminar un pedido de la tabla Pedidos:
DELETE FROM Pedidos
WHERE id_pedido = 3;


-- ANGEL | INSERCCIONES
	-- PARA AGREGAR USUARIOS NUEVOS
		INSERT INTO Usuarios (mail, contraseña, id_pedido) VALUES('wedaulleluso-8198@yopmail.com','u50N9^','4');
            
	-- PARA AGREGAR SABORES NUEVOS
		INSERT INTO Helados (id_helado, sabor, precio, valoracion, alergenos) VALUES('4', 'Chocolate', '5.50', '4.0', 'Lacteos, Nueces');
            
-- ANGEL | MODIFICACION
	-- MODIFICAR LA TABLA USUARIOS PARA AGREGAR LA FECHA DE CUMPLEAÑOS DEL USUARIO
		ALTER TABLE Usuarios ADD fechaCumpleaños DATE;
            
    -- MODIFICAR LA TABLA HELADOS PARA AGREGAR UN PORCENTAJE DE DESCUENTO EN EL PRECIO
		ALTER TABLE Helados ADD descuento DECIMAL (3,2);
    
-- ANGEL | ELIMINACION
	-- ELIMINANDO EL SABOR DE HELADO QUE ES MENOS SOLICITADO
		DELETE FROM Helados WHERE id_helado = (
												SELECT id_helado
												FROM helados
												WHERE valoracion < 1.50
		);
            
	-- ELIMINANDO LA COLUMNA DESCUENTO, YA QUE NO ESTARÁ HABILITADA SIEMPRE
        ALTER TABLE helados DROP COLUMN descuento;

-- 4. Imaginaros que vienen dos personas nuevas a vuestra empresa, os ayudarán a mejorar aspectos de la aplicación 
-- ¿Qué vistas le proporcionaríais teniendo en cuenta las funciones que van a desarrollar (define también qué función desarrollarán)? 
-- crea mínimo 2 vistas.

-- JAVIER | Vista para el Analista de ventas: Esta vista muestra el número de pedidos y el total de ventas para cada sabor de helado.
CREATE VIEW VentasHelados AS
SELECT h.sabor, COUNT(p.id_pedido) AS NumeroPedidos, SUM(p.precio_total) AS TotalVentas
FROM Helados h
LEFT JOIN Pedidos p ON h.id_helado = p.id_helado
GROUP BY h.sabor;

-- JAVIER | Vista para el Administrador de Comentarios y Valoraciones: Esta vista muestra todos los comentarios y valoraciones de los helados, junto con el sabor de helado correspondiente.
CREATE VIEW ComentariosValoraciones AS
SELECT c.id_comentario, c.comentario, c.id_helado, h.sabor, h.valoracion
FROM Comentarios c
INNER JOIN Helados h ON c.id_helado = h.id_helado;


-- ANGEL | ENCARGADA DE MOSTRAR LA INFORMACION DE LOS HELADOS QUE PEOR VALORACION TIENEN
		CREATE VIEW heladosMenosRequeridos AS 
				SELECT * FROM HELADOS WHERE valoracion < 1.50;
    
-- ANGEL | ENCARGADA DE MOSTRAR LA DIRECCION A LA CUAL DEBERÁ DE SER ENTREGADA EL PEDIDO MAS RECIENTE
		CREATE VIEW direccionPedidoReciente AS
				SELECT id_pedido, direccion
                FROM pedidos
                ORDER BY id_pedido DESC 
                LIMIT 1

-- 5. Define qué usuarios crearías para que puedan acceder al SGBD y qué permisos tendrán.

-- JAVIER | Administrador del SGBD:
– CREAR USUARIO PARA EL ADMIN Y PERMISOS DE TODO
CREATE USER admin@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO admin@'localhost';

-- JAVIER | Analista de datos:
– CREAR USUARIO ANALISTA DE DATOS Y VISTAS , SOLO TIENE PERMISOS DE SELECCIONAR Y VER VISTAS
CREATE USER analyst@'localhost' IDENTIFIED BY 'password';
GRANT SELECT ON iceAndChill.* TO analyst@'localhost'

    
-- ANGEL | CREAR USUARIO PARA EL REPARTIDOR
		CREATE USER rep01 IDENTIFIED BY 'repartidor1';
        GRANT ALL PRIVILEGES ON pedidos TO 'repartidor1'@'localhost';
        
-- ANGEL | CREAR USUARIO PARA EL HELADERO
		CREATE USER hld01 IDENTIFIED BY 'heladero1';
        GRANT ALL PRIVILEGES ON helados TO 'heladero1'@'localhost';
        GRANT ALL PRIVILEGES ON usuarios TO 'heladero1'@'localhost';


-- 6. ¿Has detectado alguna consulta que se realiza constantemente? ¿echas de menos algún índice? por ejemplo, 
-- si se busca siempre información por ciudad sería recomendable crear un índice en el campo ciudad.

-- JAVIER | CREAR INDICE PARA LAS VALORACIONES DE LOS HELADOS
CREATE INDEX idx_valoracion ON Helados (valoracion);

-- JAVIER | CREAR INDICE PARA LAS FECHAS DE PEDIDOS
CREATE INDEX idx_fecha_pedido ON Pedidos (fecha_pedido);

-- ANGEL | CREAR INDICE PARA LOS SABORES DE HELADO
		CREATE INDEX indx_helados ON Helados(sabor);
        
-- ANGEL | CREAR INDICE PARA LOS PEDIDOS QUE SE TIENEN QUE ENVIAR
		CREATE INDEX indx_pedidos ON Pedidos(id_pedido);


-- 7. ¿Qué triggers pensáis que necesita la base de datos?, crea 2 trigger por tabla.

-- JAVIER | TRIGGER PARA NUEVO PEDIDO 
DELIMITER //
CREATE TRIGGER nuevo_pedido
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
  UPDATE Usuarios SET id_pedido = NEW.id_pedido WHERE mail = NEW.mail;
END;//
DELIMITER;


-- JAVIER | TRIGGER PARA ACTUALIZAR PRECIO TOTAL
DELIMITER //
CREATE TRIGGER precioTotal_act
AFTER UPDATE ON Helados
FOR EACH ROW
BEGIN
  UPDATE Pedidos SET precio_total = precio_total + (NEW.precio - OLD.precio) WHERE id_helado = NEW.id_helado;
END;//
DELIMITER;

-- ANGEL | ELIMINAR HELADOS CON MENOS DE 2 DE VALORACION POR CADA ACTUALIZACION DE LA TABLA HELADOS
		DELIMITER //
		CREATE TRIGGER eliminarHelados
        BEFORE UPDATE ON helados
        FOR EACH ROW
        BEGIN
			IF NEW.valoracion < 2 THEN
				DELETE FROM helados;
			END IF;
        END; //
		
-- ANGEL | INSERTAR COMENTARIOS POR CADA PEDIDO REALIZADO
		DELIMITER //
		CREATE TRIGGER comentarioPedido
        BEFORE INSERT ON pedido
        FOR EACH ROW
        BEGIN
			INSERT INTO Comentario (id_comentario, comentario, id_helado) VALUES (NEW.id_comentario, 'texto comentario ...', NEW.id_helado);
        END; //


-- 8. ¿Qué procedimientos almacenados podría necesitar la base de datos?, crea 2 procedimientos almacenados.

-- JAVIER | Procedimiento almacenado para agregar un nuevo helado a la tabla Helados:
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

-- JAVIER | Procedimiento almacenado para obtener todos los pedidos realizados por un usuario específico:
DELIMITER //
CREATE PROCEDURE pedidos_Usuarios(
  IN userEmail VARCHAR(50)
)
BEGIN
  SELECT * FROM Pedidos WHERE mail = userEmail;
END; //
DELIMITER;


-- ANGEL | PROCEDIMIENTO CREADO PARA ENCONTRAR LOS PEDIDOS MAS CERCANOS:
		DELIMITER //
			CREATE PROCEDURE mostrarPedidosEnUbicacion()
            BEGIN
				SELECT *
                FROM pedidos
                WHERE direccion LIKE ('*Lugar en donde se encuentra nuestra heladeria*');
            END; //
        
-- ANGEL | PROCEDIMIENTO PARA MOSTRAR LOS USUARIOS CON MAS PEDIDOS
		DELIMITER //
				CREATE PROCEDURE mostrarUsuariosConMasPedidos()
				BEGIN
					SELECT u.mail, p.id_pedido
					FROM usuarios u
					INNER JOIN pedidos p ON u.id_pedido = p.id_pedido
                    GROUP BY u.id_pedido
                    HAVING COUNT(u.id_pedido) > 1;
				END; //
