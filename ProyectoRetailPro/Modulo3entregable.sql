create database modulo3entregable
use modulo3entregable

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

-- Creacion de tablas, en orden de primero auxiliares desp maestra:

create table categorias (
id_categoria INT IDENTITY(1,1) PRIMARY KEY,
nombre_categoria VARCHAR(25) NOT NULL,
descripcion VARCHAR(150)
)

create table ciudades(
id_ciudad INT IDENTITY(1,1) PRIMARY KEY,
nombre_ciudad VARCHAR(30) not null,
)

create table clientes (
id_cliente INT IDENTITY (1,1) PRIMARY KEY,
nombre VARCHAR(25) not null,
email VARCHAR(50),
id_ciudad INT FOREIGN KEY REFERENCES ciudades(id_ciudad),
fecha_registro DATE not null,

)

create table productos(
id_producto INT IDENTITY(1,1) PRIMARY KEY,
nombre_producto VARCHAR(30) not null,
precio DECIMAL(10,2) not null,
id_categoria INT FOREIGN KEY REFERENCES categorias(id_categoria)
)

create table ventas(
id_venta INT IDENTITY(1,1) PRIMARY KEY,
id_cliente INT FOREIGN KEY REFERENCES clientes(id_cliente),
id_producto INT FOREIGN KEY REFERENCES productos(id_producto),
cantidad INT not null,
precio_unitario DECIMAL(10,2) not null,
fecha DATE NOT NULL,
)

--INSERCIONES DE REGISTROS EN TABLAS
INSERT INTO categorias VALUES ('Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias VALUES ('Accesorios', 'Periféricos y complementos');
INSERT INTO categorias VALUES ('Audio', 'Auriculares y parlantes');
INSERT INTO categorias VALUES ('Almacenamiento', 'Discos y memorias');

INSERT INTO ciudades VALUES ('Córdoba')
INSERT INTO ciudades VALUES ('Rosario')
INSERT INTO ciudades VALUES ('Mendoza')
INSERT INTO ciudades VALUES ('CABA')

INSERT INTO clientes VALUES ('María López',   'maria@mail.com',   1, '2024-01-05');
INSERT INTO clientes VALUES ('Carlos Ruiz',   'carlos@mail.com',  1,      '2024-01-10');
INSERT INTO clientes VALUES ('Ana Gómez',     'ana@mail.com',     2,      '2024-02-01');
INSERT INTO clientes VALUES ('Pedro Sanz',    'pedro@mail.com',   3,      '2024-02-15');
INSERT INTO clientes VALUES ('Laura Torres',  'laura@mail.com',   2,      '2024-03-01');

INSERT INTO productos VALUES ('Laptop Pro 15',      1200.00,  1);
INSERT INTO productos VALUES ('Mouse Inalámbrico',      28.00,  2);
INSERT INTO productos VALUES ('Monitor 4K 27"',       450.00, 1);
INSERT INTO productos VALUES ('Auriculares BT Pro',   120.00,  3);
INSERT INTO productos VALUES ('SSD Externo 1TB',       130.00,  4);
INSERT INTO productos VALUES ('Teclado Mecánico',      95.00,  2);

INSERT INTO ventas VALUES (  1, 1, 2, 1200.00, '2024-03-05');
INSERT INTO ventas VALUES (  2, 2, 5,   28.00, '2024-03-06');
INSERT INTO ventas VALUES ( 3, 3, 1,  450.00, '2024-03-07');
INSERT INTO ventas VALUES (  1, 4, 2,  120.00, '2024-03-08');
INSERT INTO ventas VALUES (  4, 5, 3,  130.00, '2024-03-10');
INSERT INTO ventas VALUES (  2, 6, 4,   95.00, '2024-03-11');
INSERT INTO ventas VALUES (  5, 1, 1, 1200.00, '2024-03-12');
INSERT INTO ventas VALUES (  3, 2, 8,   28.00, '2024-03-13');
INSERT INTO ventas VALUES (  4, 4, 1,  120.00, '2024-03-14');
INSERT INTO ventas VALUES ( 5, 3, 2,  450.00, '2024-03-15');

-- Confirmá que cada tabla se cargó correctamente
SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;



select * from ventas