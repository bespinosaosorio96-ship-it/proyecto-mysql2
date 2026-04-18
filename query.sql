use GaseosasValle;

-- 1. productos con stock por debajo del mínimo
select nombre, stock_actual, stock_minimo
from productos
where stock_actual <= stock_minimo;

-- 2. pedidos entre dos fechas (between)
select id_pedido, fecha_pedido, total_con_iva
from pedidos
where fecha_pedido between '2024-01-01' and '2026-12-31';

-- 3. productos más vendidos (join + group by)
select p.nombre, sum(dp.cantidad) as total_vendido
from detalle_pedido dp
join productos p on dp.id_producto = p.id_producto
group by p.nombre
order by total_vendido desc;

-- 4. clientes y su cantidad de pedidos
select c.nombre_completo, count(p.id_pedido) as num_pedidos
from clientes c
left join pedidos p on c.id_cliente = p.id_cliente
group by c.nombre_completo;

-- 5. buscar clientes por nombre parcial (like)
select * from clientes
where nombre_completo like '%tienda%';

-- 6. productos por categorías específicas (in)
select nombre, categoria, precio
from productos
where categoria in ('cola', 'cítrica');

-- 7. el cliente con más pedidos (subconsulta)
select nombre_completo 
from clientes 
where id_cliente = (
    select id_cliente 
    from pedidos 
    group by id_cliente 
    order by count(*) desc 
    limit 1
);

-- 8. ventas totales por sede
select s.nombre_sede, sum(p.total_con_iva) as ventas_totales
from sedes s
join pedidos p on s.id_sede = p.id_sede
group by s.nombre_sede;



