
--Reporte1
DELIMITER //

CREATE PROCEDURE reporte1()
BEGIN
    SELECT E.cedula_emp, E.nombre_emp, E.apellido_emp, CA.nombre_cargo, SUM(TIMESTAMPDIFF(HOUR, ES.hora_entrada, ES.hora_salida)) AS Horas_Trabajadas
    FROM EMPLEADO E
    JOIN CONTRATO_EMPLEADO CE ON E.cedula_emp = CE.fk_emp
    JOIN ENTRADA_SALIDA ES ON CE.id_contrato = ES.fk_contrato
    JOIN C_C CC ON CC.cont_fk = CE.id_contrato
    JOIN CARGO CA ON CA.id_cargo = CC.fk_cargo
    GROUP BY E.cedula_emp
    ORDER BY Horas_Trabajadas DESC;
END//

DELIMITER;

--Reporte2
DELIMITER //

CREATE PROCEDURE reporte2()
BEGIN
    SELECT 
        P.id_producto, 
        P.imagen_p,
        P.nombre_p, 
        SUM(DF.cantidad_prod) AS Cantidad
    FROM 
        PRODUCTO P
    JOIN 
        INVENTARIO I ON P.id_producto = I.producto_fk
    JOIN 
        HIST_PRECIO_VENTA PV ON I.id_inventario = PV.fk_inv
    JOIN 
        DETALLE_FACTURA DF ON I.id_inventario = DF.fk_inventario
    GROUP BY 
        P.id_producto, P.nombre_p, P.imagen_p
    ORDER BY 
        Cantidad DESC;
END//

DELIMITER;

--Reporte3
DELIMITER //

CREATE PROCEDURE reporte3(IN mes INT, IN ano INT)
BEGIN
    SELECT 
        E.cedula_emp, 
        E.nombre_emp, 
        E.apellido_emp, 
        SUM(TIMESTAMPDIFF(HOUR, ES.hora_entrada, ES.hora_salida)) AS Horas_Trabajadas
    FROM EMPLEADO E
    JOIN contrato_empleado CE ON E.cedula_emp = CE.fk_emp
    JOIN ENTRADA_SALIDA ES ON CE.id_contrato = ES.fk_contrato
    WHERE 
        YEAR(ES.hora_entrada) = ano AND MONTH(ES.hora_entrada) = mes
    GROUP BY 
        E.cedula_emp
    ORDER BY 
        Horas_Trabajadas DESC;
END//

DELIMITER;

--Reporte4
DELIMITER //

CREATE PROCEDURE reporte4(IN categoriaNombre VARCHAR(50))
BEGIN
    SELECT 
        P.id_producto, 
        P.imagen_p,
        P.nombre_p, 
        C.nombre_categoria, 
        I.cantidad_disp AS Cantidad_Disponible
    FROM 
        PRODUCTO P
    JOIN 
        CATEGORIA C ON P.fk_categoria = C.id_categoria
    JOIN 
        INVENTARIO I ON P.id_producto = I.producto_fk
    WHERE 
        C.nombre_categoria = categoriaNombre
    ORDER BY 
        Cantidad_Disponible DESC;
END //

DELIMITER ;

--Reporte5
DELIMITER //

CREATE PROCEDURE reporte5()
BEGIN
    SELECT 
        E.cedula_emp, 
        E.nombre_emp, 
        E.apellido_emp, 
        COUNT(DF.cantidad_prod) AS cantidad_vendida
    FROM 
        EMPLEADO E
    JOIN 
        contrato_empleado CE ON E.cedula_emp = CE.fk_emp
    JOIN 
        C_C CC ON CE.id_contrato = CC.cont_fk
    JOIN 
        CARGO C ON CC.fk_cargo = C.id_cargo
    JOIN  
        FACTURA F ON E.cedula_emp = F.fk_empleado
    JOIN
        DETALLE_FACTURA DF ON F.id_factura = DF.fk_factura
        GROUP BY
        E.cedula_emp, 
        E.nombre_emp, 
        E.apellido_emp
    ORDER BY 
        cantidad_vendida DESC;
END//

DELIMITER;

--Reporte6
DELIMITER //

CREATE PROCEDURE reporte6()
BEGIN
    SELECT
        P.id_producto, 
        P.imagen_p,
        P.nombre_p, 
        C.nombre_categoria,
        SUM(DF.cantidad_prod) AS Cantidad
    FROM 
        PRODUCTO P
    JOIN 
        CATEGORIA C ON P.fk_categoria = C.id_categoria
    JOIN 
        INVENTARIO I ON P.id_producto = I.producto_fk
    JOIN 
        HIST_PRECIO_VENTA PV ON I.id_inventario = PV.fk_inv
    JOIN 
        DETALLE_FACTURA DF ON I.id_inventario = DF.fk_inventario
    GROUP BY 
        C.nombre_categoria
    ORDER BY 
        Cantidad ASC;
END//

DELIMITER;

--Reporte7
DELIMITER //

CREATE PROCEDURE reporte7(IN ano INT)
BEGIN
    SELECT 
        YEAR(f.fecha_emision) AS Año_Venta, 
        MONTH(f.fecha_emision) AS Mes_Venta, 
        c.nombre_categoria,
        SUM(F.total) AS Total_Ventas
    FROM 
        categoria as c
    JOIN
    producto p on c.id_categoria = p.fk_categoria
    JOIN
    inventario i on p.id_producto = i.producto_fk
    JOIN
    detalle_factura df on i.id_inventario = df.fk_inventario
    JOIN
    factura f on df.fk_factura = f.id_factura
    WHERE 
        YEAR(f.fecha_emision) = ano
    GROUP BY 
        Año_Venta, Mes_Venta, C.nombre_categoria
    ORDER BY 
        Año_Venta, Mes_Venta, Total_Ventas DESC;
END//

DELIMITER ;

--Reporte8

DELIMITER //

CREATE PROCEDURE reporte8(
    IN anio INT,
    IN taza_impuestos DECIMAL(10,2) 
)
BEGIN
    DECLARE contador_mes INT DEFAULT 1;
    DECLARE Ventas_totales DECIMAL(10,2);
    DECLARE Gastos_Totales DECIMAL(10,2);
    DECLARE Ganancia_neta DECIMAL(10,2);
    DECLARE impuestos DECIMAL(10,2);
    DECLARE start_date DATE;
    DECLARE end_date DATE;
    
    CREATE TEMPORARY TABLE IF NOT EXISTS DataMes (
        Mes VARCHAR(20),
        Ventas_Totales DECIMAL(10,2),
        Gastos_Totales DECIMAL(10,2),
        Ganancia_neta DECIMAL(10,2),
        impuestos DECIMAL(10,2)
    );

    WHILE contador_mes <= 12 DO
        -- Calculate start_date and end_date for each month
        SET start_date = STR_TO_DATE(CONCAT(anio, '-', contador_mes, '-01'), '%Y-%m-%d');
        SET end_date = LAST_DAY(start_date);
        
        SELECT IFNULL(SUM(total), 0) INTO Ventas_Totales
        FROM FACTURA
        WHERE YEAR(fecha_emision) = anio AND MONTH(fecha_emision) = contador_mes;

        SELECT IFNULL(SUM(sueldo), 0) INTO Gastos_Totales
        FROM C_C
        WHERE YEAR(fecha_inicio) = anio AND MONTH(fecha_inicio) = contador_mes;

        SET Ganancia_neta = Ventas_Totales - Gastos_Totales;
        SET impuestos = ROUND(Ganancia_neta * (taza_impuestos / 100), 2);

        INSERT INTO DataMes (Mes, Ventas_Totales, Gastos_Totales, Ganancia_neta, impuestos)
        VALUES (DATE_FORMAT(start_date, '%M %Y'), Ventas_Totales, Gastos_Totales, Ganancia_neta, impuestos);

        SET contador_mes = contador_mes + 1;
    END WHILE;

    SELECT * FROM DataMes;
    DROP TEMPORARY TABLE IF EXISTS DataMes;
END //

DELIMITER ;


--generar facturas
DELIMITER //

CREATE PROCEDURE InsertDetalleFactura()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE factura_count INT DEFAULT 0;
    DECLARE fk_inventario INT;
    DECLARE factura_id INT;
    DECLARE date_emision DATE;
    DECLARE total FLOAT;
    DECLARE cantidad INT;
    DECLARE pu FLOAT;

    SET date_emision = '2021-01-01';

    WHILE counter < 1195 DO
    INSERT INTO FACTURA (fecha_emision,total,cliente_fk,fk_empleado)
    VALUES (date_emision,0,(SELECT cedula_cli FROM CLIENTE ORDER BY RAND() LIMIT 1),(SELECT cedula_emp EMP FROM EMPLEADO ORDER BY RAND() LIMIT 1));

        SET factura_id = LAST_INSERT_ID();
        SET factura_count = 0;
        SET total = 0;
        WHILE factura_count < 4 DO

            SET cantidad = FLOOR(1 + RAND() * 10);
            SET fk_inventario = FLOOR(1 + RAND() * 66);
            SET pu = (SELECT valor_pv FROM hist_precio_venta WHERE fk_inv = fk_inventario AND fecha_fin_pv IS NULL);
            SET total = total + pu*cantidad;

            INSERT INTO DETALLE_FACTURA (cantidad_prod, precio_unitario, descuento, fk_factura, fk_inventario)
            SELECT 
                 cantidad as cantidad_prod, 
                pu as precio_unitario,
                0 as descuento,
                factura_id as fk_factura,
                fk_inventario as fk_inventario;
                
            SET factura_count = factura_count + 1;
            
        END WHILE;

        UPDATE FACTURA SET total = total  WHERE id_factura = factura_id; 
        SET total = 0;
        SET date_emision = DATE_ADD(date_emision, INTERVAL 1 DAY);
        SET counter = counter + 1;

    END WHILE;
END//

DELIMITER;
