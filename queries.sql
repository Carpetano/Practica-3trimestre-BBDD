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


-- 2. Igual que en el apartado anterior, crea 2 consultas multitablas que se ejecutarán de manera frecuente en la aplicación  (JOIN)


-- Mario | Mostrar todos los datos de los pedidos y el mail de el usuario que los pidió
SELECT Pedidos.*, Usuarios.mail
FROM Pedidos
INNER JOIN Usuarios ON Pedidos.id_pedido = Usuarios.id_pedido;

-- Mario | Mostrar todo sobre los comentarios y el sabor al que se refieren en vez de la id
SELECT Comentarios.*, Helados.sabor
FROM Comentarios
INNER JOIN Helados ON Comentarios.id_helado = Helados.id_helado;


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


-- 4. Imaginaros que vienen dos personas nuevas a vuestra empresa, os ayudarán a mejorar aspectos de la aplicación 
-- ¿Qué vistas le proporcionaríais teniendo en cuenta las funciones que van a desarrollar (define también qué función desarrollarán)? 
-- crea mínimo 2 vistas.

-- 5. Define qué usuarios crearías para que puedan acceder al SGBD y qué permisos tendrán.

-- 6. ¿Has detectado alguna consulta que se realiza constantemente? ¿echas de menos algún índice? por ejemplo, 
-- si se busca siempre información por ciudad sería recomendable crear un índice en el campo ciudad.

-- 7. ¿Qué triggers pensáis que necesita la base de datos?, crea 2 trigger por tabla.

-- 8. ¿Qué procedimientos almacenados podría necesitar la base de datos?, crea 2 procedimientos almacenados.


