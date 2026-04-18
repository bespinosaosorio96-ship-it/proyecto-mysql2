use GaseosasValle;

-- resumen ventas sede
create view vista_resumen_pedidos_sede as 
select 
	s.nombre_sede,
	count(p.id_pedido) as 'Cantidad Pedidos',
	sum(p.total_con_iva) as 'Total ventas iva'
from sedes s 
left join pedidos p on s.id_sede = p.id_sede
group by s.nombre_sede;


-- productos poco inventario
create view vista_productos_poco_stock as
select nombre, stock_actual, stock_minimo 
from productos
where stock_actual <= stock_minimo;

-- clientes activos

create view vista_clientes_activos as 
select distinct c.id_cliente,c.nombre_completo
from clientes c 
inner join pedidos p on c.id_cliente = p.id_cliente;