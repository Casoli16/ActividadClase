CREATE DATABASE IF NOT EXISTS dbHuellitasPets;

USE dbHuellitasPets;

CREATE TABLE IF NOT EXISTS clientes (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre_cliente VARCHAR(50) NOT NULL,
  apellido_cliente VARCHAR(50) NOT NULL,
  dui_cliente VARCHAR(10) UNIQUE,
  correo_cliente VARCHAR(100) UNIQUE,
  telefono_cliente VARCHAR(9) UNIQUE,
  nacimiento_cliente DATE,
  direccion_cliente VARCHAR(250) NOT NULL,
  clave_cliente VARCHAR(200),
  estado_cliente ENUM ('Activo', 'Inactivo'),
  fecha_registro_cliente DATE,
  imagen_cliente VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS permisos (
  id_permiso INT AUTO_INCREMENT PRIMARY KEY,
  nombre_permiso VARCHAR(100),
  agregar_actualizar_usuario BOOL,
  eliminar_usuario BOOL,
  agregar_actualizar_producto BOOL,
  eliminar_producto BOOL,
  borrar_comentario BOOL,
  agregar_actualizar_categoria BOOL,
  borrar_categoria BOOL,
  gestionar_cupon BOOL
);

CREATE TABLE IF NOT EXISTS administradores (
  id_admin INT AUTO_INCREMENT PRIMARY KEY,
  nombre_admin VARCHAR(50) NOT NULL,
  apellido_admin VARCHAR(50) NOT NULL,
  correo_admin VARCHAR(100) UNIQUE,
  alias_admin VARCHAR(50) UNIQUE,
  clave_admin VARCHAR(100),
  fecha_registro_admin DATE,
  imagen_admin VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS asignacionPermisos (
  id_asignacion_permiso INT AUTO_INCREMENT PRIMARY KEY,
  id_permiso INT,
  id_admin INT,
  CONSTRAINT fk_asignacionPermisos_permisos FOREIGN KEY (id_permiso) REFERENCES permisos (id_permiso),
  CONSTRAINT fk_asignacionPermisos_administradores FOREIGN KEY (id_admin) REFERENCES administradores (id_admin)
);

CREATE TABLE IF NOT EXISTS categorias (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nombre_categoria VARCHAR(50) NOT NULL,
  descripcion_categoria VARCHAR(250) NOT NULL,
  imagen_categoria VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS marcas (
  id_marca INT AUTO_INCREMENT PRIMARY KEY,
  nombre_marca VARCHAR(100) NOT NULL,
  imagen_marca VARCHAR(25)
);

CREATE TABLE IF NOT EXISTS productos (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre_producto VARCHAR(50) NOT NULL,
  descripcion_producto VARCHAR(250) NOT NULL,
  precio_producto DECIMAL(5,2) NOT NULL,
  imagen_producto VARCHAR(50),
  estado_producto ENUM('activo', 'inactivo'),
  existencia_producto INT,
  fecha_registro_producto DATE NOT NULL,
  mascotas ENUM('perro', 'gato'),
  id_categoria INT,
  id_marca INT,
  CONSTRAINT fk_Productos_Marca FOREIGN KEY (id_marca) REFERENCES marcas (id_marca),
  CONSTRAINT fk_Productos_categoria FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

CREATE TABLE IF NOT EXISTS pedidos (
  id_pedido INT AUTO_INCREMENT PRIMARY KEY,
  estado_pedido ENUM('pendiente', 'completado', 'cancelado'),
  fecha_registro_pedido DATE NOT NULL,
  direccion_pedido VARCHAR(250) NOT NULL,
  id_cliente INT,
  CONSTRAINT fk_Pedidos_Clientes FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

CREATE TABLE IF NOT EXISTS cuponOferta(
 id_cupon INT AUTO_INCREMENT PRIMARY KEY,
 codigo_cupon VARCHAR(50) UNIQUE,
 porcentaje_cupon FLOAT,
 estado_cupon BOOL,
 fecha_ingreso_cupon DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS cuponesUtilizados(
 id_utilizado INT AUTO_INCREMENT PRIMARY KEY,
 id_cupon INT,
 id_cliente INT,
 CONSTRAINT fk_cupononesUtilizados_idcupon FOREIGN KEY (id_cupon) REFERENCES cuponOferta (id_cupon),	
 CONSTRAINT fk_cupononesUtilizados_idcliente FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

CREATE TABLE IF NOT EXISTS detallesPedidos (
  id_detalle_pedido INT AUTO_INCREMENT PRIMARY KEY,
  cantidad_detalle_pedido INT CHECK(Cantidad_producto >= 0),
  precio__detalle_pedido DECIMAL(5,2) NOT NULL,
  id_producto INT,
  id_pedido INT,
  CONSTRAINT fk_DetallesPedidos_Productos FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
  CONSTRAINT fk_DetallesPedidos_Pedidos FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido)
);

CREATE TABLE IF NOT EXISTS valoraciones (
  id_valoracion INT AUTO_INCREMENT PRIMARY KEY,
  calificacion_valoracion INT,
  comentario_valoracion VARCHAR(250),
  fecha_valoracion DATE NOT NULL,
  estado_valoracion BOOL,
  id_cliente INT,
  CONSTRAINT fk_Valoraciones_clientes FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

SELECT * FROM detallesPedidos;
SELECT * FROM productos;

-- Insersion de datos en tabla de clientes 
INSERT INTO clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, nacimiento_cliente, direccion_cliente, clave_cliente, estado_cliente, fecha_registro_cliente, imagen_cliente)
VALUES
  ('Alice', 'Johnson', '987654321', 'alice.johnson@example.com', '987654321', '1985-05-15', '456 Oak St', 'alice123', 'Activo', '2024-02-20', 'alice_johnson.jpg'),
  ('Bob', 'Smith', '456789012', 'bob.smith@example.com', '456789012', '1992-08-22', '789 Pine St', 'bob456', 'Activo', '2024-02-20', 'bob_smith.jpg'),
  ('Charlie', 'Brown', '123789456', 'charlie.brown@example.com', '123789456', '1980-12-03', '123 Elm St', 'charlie789', 'Inactivo', '2024-02-20', 'charlie_brown.jpg'),
  ('David', 'Miller', '789012345', 'david.miller@example.com', '789012345', '1998-04-10', '234 Maple St', 'davidMiller1', 'Activo', '2024-02-20', 'david_miller.jpg'),
  ('Eva', 'Taylor', '345678901', 'eva.taylor@example.com', '345678901', '1989-07-28', '567 Birch St', 'evaTaylor123', 'Activo', '2024-02-20', 'eva_taylor.jpg');

-- Insersion de datos en tabla de permisos 
INSERT INTO permisos (nombre_permiso, agregar_actualizar_usuario, eliminar_usuario, agregar_actualizar_producto, eliminar_producto, borrar_comentario, agregar_actualizar_categoria, borrar_categoria, gestionar_cupon)
VALUES
  ('Admin', TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE),
  ('Editor', TRUE, FALSE, TRUE, FALSE, TRUE, TRUE, FALSE, TRUE),
  ('Moderador', FALSE, TRUE, FALSE, TRUE, TRUE, FALSE, TRUE, FALSE),
  ('Usuario Básico', FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE),
  ('Supervisor', TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE);

-- Insersion de datos en tabla de administradores
INSERT INTO administradores (nombre_admin, apellido_admin, correo_admin, alias_admin, clave_admin, fecha_registro_admin, imagen_admin)
VALUES
  ('Admin1', 'Superuser', 'admin1@example.com', 'adminSuper1', 'adminpassword1', '2024-02-20', 'admin1.jpg'),
  ('Admin2', 'Poweruser', 'admin2@example.com', 'adminPower2', 'adminpassword2', '2024-02-20', 'admin2.jpg'),
  ('Admin3', 'Masteruser', 'admin3@example.com', 'adminMaster3', 'adminpassword3', '2024-02-20', 'admin3.jpg'),
  ('Admin4', 'Ultimateuser', 'admin4@example.com', 'adminUltimate4', 'adminpassword4', '2024-02-20', 'admin4.jpg'),
  ('Admin5', 'Prouser', 'admin5@example.com', 'adminPro5', 'adminpassword5', '2024-02-20', 'admin5.jpg');

-- Insersion de datos en tabla de asignacionPermisos
INSERT INTO asignacionPermisos (id_permiso, id_admin)
VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5);

-- Insersion de datos en tabla de categorias
INSERT INTO categorias (nombre_categoria, descripcion_categoria, imagen_categoria)
VALUES
  ('Electronics', 'Electronic devices and accessories', 'electronics.jpg'),
  ('Clothing', 'Fashion and apparel', 'clothing.jpg'),
  ('Home and Garden', 'Home decor and gardening', 'home_garden.jpg'),
  ('Toys and Games', 'Toys and games for all ages', 'toys_games.jpg'),
  ('Books', 'Books and literature', 'books.jpg');

-- Insersion de datos en tabla de marcas
INSERT INTO marcas (nombre_marca, imagen_marca)
VALUES
  ('Samsung', 'samsung.jpg'),
  ('Nike', 'nike.jpg'),
  ('Home Essentials', 'home_essentials.jpg'),
  ('ToyJoy', 'toyjoy.jpg'),
  ('BookWorm', 'bookworm.jpg');

-- Insersion de datos en tabla de productos
INSERT INTO productos (nombre_producto, descripcion_producto, precio_producto, imagen_producto, estado_producto, existencia_producto, fecha_registro_producto, mascotas, id_categoria, id_marca)
VALUES
  ('Smartphone X', 'High-end smartphone', 999.99, 'smartphoneX.jpg', 'activo', 100, '2024-02-20', 'perro', 1, 1),
  ('Running Shoes', 'Comfortable running shoes', 79.99, 'runningshoes.jpg', 'activo', 150, '2024-02-20', 'gato', 2, 2),
  ('Home Decor Set', 'Modern home decor set', 249.99, 'homedecorset.jpg', 'activo', 30, '2024-02-20', 'perro', 3, 3),
  ('Board Game Collection', 'Family-friendly board games', 39.99, 'boardgames.jpg', 'activo', 80, '2024-02-20', 'gato', 4, 4),
  ('Bestseller Novels Set', 'Collection of bestselling novels', 129.99, 'bestsellerbooks.jpg', 'activo', 50, '2024-02-20', 'perro', 5, 5);



-- Insersion de datos en tabla de pedidos
INSERT INTO pedidos (estado_pedido, fecha_registro_pedido, direccion_pedido, id_cliente)
VALUES
  ('pendiente', '2024-02-20', '123 Pine St', 1),
  ('completado', '2024-02-20', '789 Elm St', 2),
  ('cancelado', '2024-02-20', '456 Oak St', 3),
  ('pendiente', '2024-02-20', '234 Birch St', 4),
  ('completado', '2024-02-20', '567 Maple St', 5);

-- Insersion de datos en tabla de cuponOferta
INSERT INTO cuponOferta (codigo_cupon, porcentaje_cupon, estado_cupon, fecha_ingreso_cupon)
VALUES
  ('SALE2024', 10.0, TRUE, '2024-02-20'),
  ('HOLIDAY25', 25.0, TRUE, '2024-02-20'),
  ('FREESHIP', 15.0, TRUE, '2024-02-20'),
  ('WELCOME10', 10.0, TRUE, '2024-02-20'),
  ('FLASHSALE', 30.0, TRUE, '2024-02-20');

-- Insersion de datos en tabla de cuponesUtilizados 
INSERT INTO cuponesUtilizados (id_cupon, id_cliente)
VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5);

-- Insersion de datos en tabla de detallesPedidos
INSERT INTO detallesPedidos (cantidad_detalle_pedido, precio__detalle_pedido, id_producto, id_pedido)
VALUES
  (3, 299.99, 1, 1),
  (2, 159.99, 2, 2),
  (1, 249.99, 3, 3),
  (4, 159.99, 4, 4),
  (2, 99.99, 5, 5);
  
-- Insersion de datos en tabla de valoraciones
INSERT INTO valoraciones (calificacion_valoracion, comentario_valoracion, fecha_valoracion, estado_valoracion, id_cliente)
VALUES
  (5, 'Excellent product!', '2024-02-20', TRUE, 1),
  (4, 'Good quality shoes!', '2024-02-20', TRUE, 2),
  (3, 'Nice home decor set.', '2024-02-20', TRUE, 3),
  (5, 'Love the board games!', '2024-02-20', TRUE, 4),
  (4, 'Great collection of books.', '2024-02-20', TRUE, 5);
  
-- FUNCION ---
DELIMITER //

CREATE FUNCTION calcular_precio_total_producto(producto_id INT, cantidad_detalle_pedido INT)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE precio_total DECIMAL(10,2);
    DECLARE total DECIMAL(10,2);

    SELECT precio_producto INTO precio_total
    FROM productos
    WHERE id_producto = producto_id;

    SET total = precio_total * cantidad_detalle_pedido;

    RETURN total;
END //

DELIMITER ;

SELECT * FROM productos
SELECT calcular_precio_total_producto(2, 5);	

-- TRIGGER PARA ACTUALIZAR EXISTENCIAS DE PRODUCTO SI SE HACE UN PEDIDO --
DELIMITER //

CREATE TRIGGER actualizar_existencias AFTER INSERT ON detallesPedidos
FOR EACH ROW
BEGIN 
	UPDATE productos
	SET existencia_producto = existencia_producto - NEW.cantidad_producto
	WHERE id_producto = NEW.id_producto;
END

//
DELIMITER;


CREATE PROCEDURE AgregarCupon(codigo VARCHAR(100), porcentaje INT, estado BOOL)
BEGIN
    -- Declaramos la variable que contendrá el día de ingreso del cupón
    DECLARE fechaActual DATE;
    SET fechaActual = CURDATE();
    
    INSERT INTO cuponOferta(codigo_cupon, porcentaje_cupon, estado_cupon, fecha_ingreso_cupon) VALUES (codigo, porcentaje, estado, fechaActual);

END //

DELIMITER ;

CALL AgregarCupon ('TREBOR', 30, 1);



/*SELECT * FROM valoraciones, detallespedidos, pedidos, productos, subcategorias, administradores, Permisos, clientes;*/
