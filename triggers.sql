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





