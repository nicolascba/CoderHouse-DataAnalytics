--Consulta 1 — Vista base del proyecto (INNER JOIN)
--Trabajás sobre el esquema que creaste en el Checkpoint del Módulo 3.
--Combiná con INNER JOIN tu tabla de ventas con las tablas descriptivas que hayas modelado (clientes, productos y cualquier otra dimensión de tu caso de negocio)
--para obtener en una sola fila, como mínimo: fecha, identificación del cliente, descripción del producto, cantidad, precio unitario y total de venta.

--Sumá además las columnas descriptivas que existan en tu propio esquema (por ejemplo segmento de cliente, categoría de producto o región, si las modelaste).
--No es necesario que estén todas: la consulta se evalúa sobre las tablas que vos diseñaste, no sobre una lista fija.

--Si tu esquema no tiene ninguna dimensión geográfica ni de segmentación, agregala ahora al script del Módulo 3 con dos o tres registros de ejemplo. 
--Esta consulta va a ser la fuente de datos principal en Power BI, así que conviene que tenga al menos una columna para agrupar y una para filtrar.

select * from categorias
select * from ciudades

select * from productos
select * from ventas
select * from clientes

INSERT INTO clientes
VALUES ('Nico Senestrari', 'nsenestrari@gmail.com', 1, GETDATE()) --Acá me inserte en la BD para probar que la consulta 2 funcione jeje

INSERT INTO productos
VALUES('Producto prueba', 9999, 4) --Acá inserte un producto random en la BD para probar que la consulta 3 funcione jeje

Select v.fecha as 'Fecha compra', cli.nombre as 'Cliente', p.nombre_producto as 'Producto', ca.nombre_categoria as 'Categoria',
v.precio_unitario 'Precio', v.cantidad as 'Unidades',
SUM(V.precio_unitario * V.cantidad) as 'Total venta'
From ventas v 
Inner join clientes as cli
ON v.id_cliente = cli.id_cliente
Inner join productos as p
ON v.id_producto = p.id_producto
Inner join categorias as ca
ON p.id_categoria = ca.id_categoria
Group by v.fecha, cli.nombre, p.nombre_producto, v.precio_unitario, v.cantidad , ca.nombre_categoria

--Consulta 2 — Clientes sin ventas (LEFT JOIN) Identificá clientes registrados que aún no han realizado ninguna compra.
--Mostrá su nombre, email y fecha de registro. Usá WHERE ... IS NULL para aislar los casos.
select cli.nombre 'CLIENTE',
cli.email as 'EMAIL',
cli.fecha_registro as 'Fecha Registro'
from clientes as cli
LEFT JOIN ventas as v
ON v.id_cliente = cli.id_cliente
WHERE v.id_venta is null

--Consulta 3 — Productos sin ventas (LEFT JOIN) Identificá productos del catálogo que no tienen ninguna venta registrada.
--Mostrá nombre del producto, categoría y precio. Usá WHERE ... IS NULL.

select p.nombre_producto 'Producto',
c.nombre_categoria 'Categoria',
p.precio 'Precio'
from productos p
LEFT JOIN ventas v
ON p.id_producto = v.id_producto
INNER JOIN categorias c
on p.id_categoria = c.id_categoria
where v.id_venta is null

--Consulta 4 — Consolidado por canal (UNION ALL)

--Importante: la columna canal no se consulta, se crea. No busques ese dato en tus tablas — lo generás vos dentro de cada SELECT como valor literal.
--Ese es el punto de este ejercicio.

--Escribí dos SELECT sobre tus ventas, separados por el criterio que corresponda a tu caso 
--(por ejemplo, ventas de dos períodos, dos sucursales o dos orígenes distintos), y agregá en cada uno una columna de texto fija que identifique el origen.
--Unilos con UNION ALL y cerrá con un GROUP BY para obtener el total por cada origen.

--La estructura es esta:

--SELECT fecha, total, 'Online' AS canal FROM ventas WHERE ... UNION ALL SELECT fecha, total, 'Presencial' AS canal FROM ventas WHERE ...

--Las dos consultas tienen que devolver la misma cantidad de columnas, en el mismo orden
--y con tipos compatibles. Usamos UNION ALL y no UNION porque no queremos que se eliminen filas repetidas: cada venta debe contarse una sola vez,
--aunque coincida con otra en todos sus valores.

SELECT COUNT(id_venta) 'Cantidad de ventas primera semana',
SUM(v.cantidad) 'Cantidades de art vendidas'
from ventas as v
where v.fecha between '2024-03-01' and '2024-03-07'

UNION ALL

SELECT COUNT(id_venta) 'Cantidad de ventas segunda semana',
SUM(v.cantidad) 'Cantidades de art vendidas'
from ventas as v
where v.fecha between '2024-03-08' and '2024-03-14'

--Con esta ultima tuve dudas, lo resolvi usando como ""canal"" un periodo de venta, pero no se si es lo correcto, acá quedo abierto a sugerencias :D