-- stored procedures
DELIMITER //
CREATE PROCEDURE sp_agregar_producto_stock(
in p_nombre CHAR(40),
in p_descripcion VARCHAR(100),
in p_precio DECIMAL(7,2),
in p_id_proveedores INT,
in p_id_categoria INT, 
in p_activo BIT,
in s_cantidad INT)
BEGIN
	DECLARE p_id_producto INT;
    SET p_id_producto = f_id_ultimo_producto();
	-- insertar el producto
    INSERT INTO productos (nombre,descripcion,precio,id_proveedores,id_categoria,activo) VALUES (p_nombre,p_descripcion,p_precio,p_id_proveedores,p_id_categoria,p_activo);
    
    -- insertar el stock
    INSERT INTO stock (cantidad,id_proveedores,id_producto) VALUES (s_cantidad,p_id_proveedores,p_id_producto + 1);
END //
DELIMITER ;

-- CALL sp_agregar_producto_stock("coca cola","bebisa gaseosa",2000.00,3,8,1,40);


DELIMITER //
CREATE PROCEDURE sp_Registrar_Detalle_Venta(
IN p_id_producto INT,
IN p_cantidad INT,
IN p_id_venta INT
)
BEGIN
	DECLARE v_precio DECIMAL(7, 2);
    DECLARE v_stock INT;

	-- Obtener el precio actualizado del producto
	SELECT precio INTO v_precio
	FROM productos
	WHERE id_producto = p_id_producto;

	-- Obtener stock actualizado del producto
    SELECT cantidad INTO v_stock
    FROM stock
    WHERE id_producto = p_id_producto;

	-- Descontar el stock del producto
    IF v_stock > p_cantidad THEN
		UPDATE stock
		SET cantidad = cantidad - p_cantidad
		WHERE id_producto = p_id_producto;
        	-- Crear la factura del  detalle_venta
	INSERT INTO detalle_venta (id_producto, cantidad, precio_unitario, id_venta)
	VALUES (p_id_producto , p_cantidad, v_precio , p_id_venta);
		SELECT 'Detalle de Venta registrado exitosamente.' AS mensaje;
    ELSE
		SELECT 'No hay stock suficiente' AS mensaje;
    END IF;
END //
DELIMITER ;

-- CALL sp_Registrar_Detalle_Venta(79, 50 ,50);

