use GaseosasValle;



delimiter $$
create function fn_calcular_total_con_iva(p_id_pedido int)
returns decimal(10,2)
deterministic
begin
	declare v_total_final decimal(10,2);
select sum(subtotal) * 1.19 into v_total_final
from detalle_pedido
where id_pedido=p_id_pedido;

return ifnull(v_total_final, 0);
end $$
delimiter ;
	
DELIMITER $$
create function fn_validar_stock(p_id_producto int, p_cantidad int)
returns varchar(50)
deterministic
begin
	declare v_stock_actual int;
	declare mensaje varchar(50);
	
	select stock_actual into v_stock_actual
	from productos
	where id_producto = p_id_producto;
	
	if v_stock_actual >= p_cantidad then 
		set mensaje ='Stock disponoble';
	else
		set mensaje = 'Stock insuficiente';
	end if;
	return mensaje;
end $$

delimiter ;
