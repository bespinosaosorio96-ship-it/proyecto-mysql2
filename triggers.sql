use GaseosasValle;

-- actualizar stock

delimiter $$

create trigger tr_actualizar_stock
after insert on detalle_pedido
for each row 
begin
	update productos
	set stock_actual = stock_actual - new.cantidad
	where id_producto = new.id_producto;
end $$

delimiter ;

--  cambiar precios
delimiter $$

create trigger tr_auditor_cambio_precio
after update on productos 
for each row
begin
	if old.precio <> new.precio then
	insert into auditoria_precios(id_producto, precio_anterior, precio_nuevo)
	values (old.id_producto, old.precio, new.precio);
	end if;
end $$
delimiter ;





use gaseosasvalle;

delimiter $$

create function verificar_stock_producto(p_id_producto int, p_cantidad int)
returns varchar(50)
deterministic
begin
    declare v_stock int;
    
    select stock_actual into v_stock 
    from productos 
    where id_producto = p_id_producto;
    
    if v_stock is null then
        return 'producto no encontrado'; -- requisito examen [cite: 5]
    elseif v_stock >= p_cantidad then
        return 'suficiente'; -- requisito examen [cite: 4]
    else
        return 'insuficiente'; -- requisito examen [cite: 5]
    end if;
end $$

delimiter ;




use gaseosasvalle;

delimiter $$

create trigger control_stock_negativo
before insert on detalle_pedido
for each row
begin
    declare v_stock_disponible int;
    
    -- obtenemos el stock del producto que se intenta vender
    select stock_actual into v_stock_disponible 
    from productos 
    where id_producto = new.id_producto;
    
    -- si la cantidad pedida es mayor a la que hay, lanzamos el "spam"
    if new.cantidad > v_stock_disponible then
        signal sqlstate '45000' 
        set message_text = 'stock insuficiente para procesar el pedido'; -- mensaje exacto del examen [cite: 12]
    end if;
end $$

delimiter ;



use gaseosasvalle;

create or replace view vista_productos_bajo_stock as
select 
    p.nombre, 
    p.categoria, 
    p.stock_actual, 
    s.nombre_sede
from productos p
-- nota técnica: en tu db actual no hay relación directa productos-sedes,
-- pero para el examen se requiere el join[cite: 7]. 
-- asegúrate de tener una columna id_sede en productos para que funcione.
join sedes s on p.id_sede = s.id_sede 
where p.stock_actual <= 10;



use gaseosasvalle;

select 
    c.nombre_completo, 
    sum(p.total_con_iva) as total_gastado
from clientes c
join pedidos p on c.id_cliente = p.id_cliente
group by c.id_cliente, c.nombre_completo
having total_gastado > (select avg(total_con_iva) from pedidos) -- filtro promedio [cite: 10]
order by total_gastado desc; -- orden mayor a menor [cite: 11]


-- intenta insertar 1 millón de unidades de un producto
insert into detalle_pedido (id_pedido, id_producto, cantidad, subtotal)
values (1, 1, 1000000, 5000.00);
