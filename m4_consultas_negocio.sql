--Consulta 1 Resumen ejecutivo mensual Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes.
--Calculá el total como cantidad * precio_unitario. Usá alias descriptivos en español y agrupá por mes con EXTRACT(MONTH FROM fecha_venta).


Select 
month(fecha) as 'Mes',
sum(cantidad * precio_unitario) as 'Total Facturado',
COUNT(id_venta) as 'Cantidad de pedidos',
sum(cantidad * precio_unitario) / COUNT(id_venta) as 'Ticket promedio'
from ventas
GROUP BY MONTH(fecha)
Order by MONTH(fecha)

--Consulta 2 — Ranking de productos Top 5 de id_producto por total facturado, mostrando las unidades vendidas 
--(SUM(cantidad)) y el total generado. Usá GROUP BY id_producto, ORDER BY y limitá el resultado a 5.

Select TOP 5
id_producto as 'Id producto', -- Acá metería un join para traer el nombre del articulo, pero no me quiero adelantar.
sum(cantidad * precio_unitario) as 'Total Facturado',
SUM(cantidad) as 'Unidades vendidas'
from ventas
Group by id_producto
Order by sum(cantidad * precio_unitario) DESC

--Consulta 3 — Clientes recurrentes id_cliente que hayan realizado más de un pedido, mostrando la cantidad de pedidos y el total gastado. 
--Usá GROUP BY id_cliente y HAVING COUNT(*) > 1.

Select
id_cliente as 'Cliente', -- Acá tambien hace falta otro join para traer el nombre
count(id_venta) as 'Cant pedidos',
sum(cantidad * precio_unitario) as 'Total Gastado'
from ventas
group by id_cliente
HAVING COUNT(*) > 1

--Consulta 4 — Meses por encima/por debajo del promedio Total facturado por mes,
--con una columna adicional que etiquete con CASE WHEN si ese mes quedó 'Por encima' o 'Por debajo' del promedio mensual general.
WITH ventas_mensuales AS (
    SELECT
        MONTH(fecha) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha)
)
SELECT
    mes,
    total_facturado AS 'Total Facturado',
    CASE
        WHEN total_facturado > (SELECT AVG(total_facturado) FROM ventas_mensuales)
            THEN 'Por encima'
        ELSE 'Por debajo'
    END AS 'Comparación'
FROM ventas_mensuales
ORDER BY mes;

-- HALLAZGOS

-- 1. La Laptop Pro 15 (id_producto 1) concentra $2.400 de los $6.084 facturados,
--    representando aproximadamente el 40% de la facturación total.

-- 2. El Mouse Inalámbrico (id_producto 2) es el producto con mayor cantidad de
--    unidades vendidas, con 13 unidades, pero representa solo $364 de facturación.

-- 3. Todos los clientes han hecho más de un pedido.

