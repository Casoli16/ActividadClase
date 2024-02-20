USE db_guiaPractica;

SHOW TABLES;

SELECT * FROM cliente;
SELECT * FROM pedido;
SELECT * FROM producto;
SELECT * FROM detalle_pedido;


-- Right Join (Para ver los clientes que han hecho pedidos)--
SELECT cliente.nombre_cliente, pedido.id_pedido
FROM cliente
RIGHT JOIN pedido
ON cliente.id_cliente=pedido.id_cliente

-- Between (Selecciona todos los pedidos que han sido realizados entre dos fechas )--
SELECT * FROM pedido 
WHERE fecha_registro BETWEEN '2024-01-01' AND '2024-03-09'

-- Order by (Selecciona a todos los clientes y ordénalos según su fecha de nacimiento de forma descendente)--
SELECT * FROM cliente ORDER BY fecha_registro DESC;

-- SUBCONSULTA(Selecciona los productos que se encuentran dentro de un pedido)--
SELECT * FROM producto WHERE id_producto IN
(SELECT detalle_pedido.id_producto FROM detalle_pedido WHERE id_pedido = 18)

-- MAX(Selecciona el producto con el mayor precio)--
SELECT MAX(precio_producto) FROM producto;

-- AVG(Selecciona el promedio de precios de los productos ingresados.)--
SELECT AVG(precio_producto) FROM producto;

-- COUNT(Haz una consulta que te permita ver la información de cuantos pedidos se encuentran en estado: Pendiente, Finalizado, Entregado, Anulado.)--
SELECT COUNT(id_pedido) FROM pedido WHERE estado_pedido = 'Anulado'

-- LIKE(Selecciona todos los clientes que su nombre empiece por la letra D)--
SELECT * FROM cliente WHERE nombre_cliente LIKE 'D%';

-- RIGHT JOIN(Plantear una consulta donde se calculen la cantidad de --
-- órdenes agrupadas por cliente, filtradas por fecha y se ordenen los registros de mayor a menor.)--
SELECT cliente.nombre_cliente, pedido.fecha_registro
FROM cliente
RIGHT JOIN pedido
ON cliente.id_cliente=pedido.id_cliente WHERE cliente.id_cliente = 2 ORDER BY pedido.fecha_registro DESC

-- SUM, GROUP BY, ORDER BY AND LIMIT (Haz una consulta que muestre los 3 productos más vendidos)--
SELECT id_producto, SUM(cantidad_producto) AS total_vendido
FROM detalle_pedido
GROUP BY id_producto
ORDER BY total_vendido DESC
LIMIT 3;

-- (Haz una consulta que muestre al cliente que más pedidos ha realizado y cuantos pedidos ha realizado.)--
SELECT pedido.id_cliente, cliente.nombre_cliente,  COUNT(pedido.id_cliente) AS cantidad_pedidos
FROM cliente
RIGHT JOIN pedido
ON cliente.id_cliente=pedido.id_cliente 
GROUP BY id_cliente 
ORDER BY id_cliente 
LIMIT 1;

-- Haz una consulta que muestre la información de la tabla, cliente, pedido, detalle pedido, producto. Utiliza la sentencia inner JOIN.  
-- La información debe verse de la siguiente forma: --
SELECT pedido.id_pedido, cliente.id_cliente, cliente.nombre_cliente, pedido.direccion_pedido, 
pedido.estado_pedido, pedido.fecha_registro, detalle_pedido.id_detalle, producto.nombre_producto, 
detalle_pedido.cantidad_producto, detalle_pedido.precio_producto
FROM cliente
INNER JOIN pedido
ON cliente.id_cliente=pedido.id_cliente
INNER JOIN detalle_pedido
ON pedido.id_pedido=detalle_pedido.id_pedido
INNER JOIN producto
ON producto.id_producto=detalle_pedido.id_producto

