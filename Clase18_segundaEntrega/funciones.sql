				--     FUNCIONES
                
DELIMITER //
CREATE FUNCTION f_venta_mas_alta() RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
	DECLARE venta DECIMAL(10,2);
    SELECT max(total_gastado) INTO venta FROM comercio.pagos;
    RETURN venta;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION f_ventas_por_empleado(id int) RETURNS int DETERMINISTIC
BEGIN
	DECLARE cantidad_ventas int;
    SELECT COUNT(*) into cantidad_ventas FROM v_ventas_empleado where id_empleado = id;
    RETURN cantidad_ventas;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION f_id_ultimo_producto() RETURNS INT DETERMINISTIC
BEGIN
	DECLARE p_id_producto INT;
	SELECT id_producto INTO p_id_producto FROM comercio.productos ORDER BY ID_PRODUCTO DESC LIMIT 1;
    RETURN p_id_producto;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION f_id_ultimo_pago() RETURNS INT DETERMINISTIC
BEGIN
	DECLARE p_id_pago INT;
	SELECT id_pago INTO p_id_pago FROM comercio.pagos ORDER BY id_pago DESC LIMIT 1;
    RETURN p_id_pago;
END //
DELIMITER ;