	USE datos;
SELECT *
FROM empleados;
SELECT *
FROM ventas;
SELECT *
FROM productos;
Select venta, fecha
from ventas;

Use Datos;
SELECT 
    venta, fecha, venta * .16 AS venta_IVA
FROM ventas
where ID_local = 2;

select *
from ventas 
where venta > 1000;
SELECT *
FROM ventas 
where venta >=1000;
select *
from ventas 
where ID_local != 2;

Select *
from ventas 
where ID_local = 2 or clave_producto = "pzz";	
Select *
from ventas 
where ID_local =2 or ID_local = 4;
Select *
from ventas 
where Not ID_local and not clave_producto;

select *
from ventas
where clave_producto= "clz" or clave_producto= "pzz" or clave_producto = "qsd";
select *
from ventas
where clave_producto in ("clz", "pzz", "qsd");

select *
from ventas
where ID_local in (1,2,3); and clave_producto in ("clz", "pzz");

SELECT 
    *
FROM
    ventas
WHERE
    venta BETWEEN 500 AND 1000;
    
select *
from ventas 
where clave_producto like "%z";

select *
from empleados 
where nombre like "a%";

select *
from empleados 
where apellido regexp "ez|iz";

Select *
from empleados 
Order BY nombre desc;

select *
from empleados
where apellido like "%ez"
order by apellido desc;

select *
from empleados;

select *
from ventas
limit 10;

USE db_practicas;
select *
from ventas;

select ID_zona, venta, ID_cliente 
from ventas;

select venta as venta_junio 
from ventas;

select venta *16 as Iva_ventas
from ventas;

select *
from ventas 
where ID_zona = 2;

select *
from ventas 
where venta >200000;

select ID_producto, ID_cliente
from ventas 
where ID_Cliente = 7;

select *
from ventas
where venta >1000000;

select *
from ventas 
where venta >- 1500000 and ID_zona = 2;

select*
from ventas 
where venta >-999.999 or ID_Vendedor = 13;  

select *
from ventas 
where not ID_Cliente =10;

Select *
from ventas 
where ID_Zona in (1,2,3,4);

Select *
from ventas
where ID_Cliente in (6,7,8,9);

Select *
from ventas 
where not ID_Vendedor not in (15,21,35);

Select *
from vendedor 
where apellido regexp "ez";

select nombre, apellido
from vendedor
where apellido regexp "ez";

select *
from vendedor 
where apellido regexp "$ez" or apellido regexp "^sa";

USE db_practicas 
select *
from clientes
where telefono in null;

select *
from vendedor
order by nombre desc;
Select v.ventas_id, v.fecha,l.direccion,v.clave_producto, v.venta, e.nombre,e.apellido
from ventas v
join local l
	on v.ID_local=l.ID_local 
JOIN empleados e
	ON v.venta_empleado=e.ID_empleado;
    
Select e.ID_empleado, e.Nombre,e.Apellido, e.Edad,p.nombre as gerente, p.Apellido as apellido_gerente
from empleados e
left join empleados p
	on e.ID_Gerente=p.ID_empleado;
    


select *
from ventas v
right join empleados e
	ON v.venta_empleado=e.ID_empleado;

select *
from ventas v
join local l 
	using(ID_local);
    
select *
from productos
cross join ingredientes i;

select producto 
from productos 
union 
select ingredientes	
from ingredientes;

UPDATE ingredientes

set ingredientes= "Pïna",clave_ingrediente="pin"
where ingredientes_id=5;
insert into producto (producto)
values ("producto1"), ("producto2");


select *
from producto;

Select *
from ventas;

Select
	max(venta)
from ventas;

select 
	max(venta), 
    venta_empleado,
    fecha
    from ventas;
    SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
    
    select
		COUNT(fecha) as conteo_ventas
        from ventas
select
SUM (venta) as total_ventas, 
fecha
from ventas;

Select 
	sum(venta),
	ID_local
FROM ventas 
group by ID_local;

select 
	sum (venta),
    venta_empleado
FROM ventas 
GROUP BY venta_empleado;

SELECT id_local, clave_producto, SUM (venta) as venta_total
from ventas
GROUP BY id_local
having venta_total > 1500; 

select 
	c.nombre, 
    max(Venta) As Venta_maxima
from ventas v
join clientes c 
	on v.ID_Cliente = c.ID_Cliente
where Fecha_venta between "2018-01-01" and "2018-12-31"
group by c.nombre
order by venta_maxima desc;

USE db_practicas;

SELECT *
FROM ventas;

SELECT
	YEAR(str_to_date(v.`Fecha venta`, "%d-%b-%Y")) AS Fecha_venta,
    p.Producto,
    z.Zona,
    c.Nombre AS Nombre_cliente,
    MAX(v.Venta) AS Compra_maxima
FROM ventas v
JOIN clientes c
	USING(ID_cliente)
JOIN producto p
	USING(ID_producto)
JOIN zona z
	USING(ID_Zona)
GROUP BY (Fecha_venta)
HAVING Fecha_venta = 2018;


SELECT
	YEAR(str_to_date(Fecha_pago, "%d-%m-%y")) AS Fecha_pago,
    MIN(Pago) AS Pago_minimo
FROM Pagos
GROUP BY (Fecha_pago)
HAVING Fecha_pago = 2018;

SELECT
	MONTH(str_to_date(v.`Fecha venta`, "%d-%b-%Y")) AS Fecha_venta,
    p.Producto,
    z.Zona,
    c.Nombre AS Nombre_cliente,
    COUNT(v.Venta) AS Nº_ventas
FROM ventas v
JOIN clientes c
	USING(ID_cliente)
JOIN producto p
	USING(ID_producto)
JOIN zona z
	USING(ID_Zona)
GROUP BY Fecha_venta WITH ROLLUP
HAVING Fecha_venta BETWEEN 6 AND 1;

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SELECT @@sql_mode;

SELECT * 
FROM empleados
WHERE edad > 25;

SELECT AVG (edad)
FROM empleados as edad_promedio 
where edad > edad_promedio;

SELECT AVG (edad) 
FROM empleados 
HAVING edad > edad_promedio;

SELECT *
FROM empleados 
where edad >
	(SELECT 
			AVG(edad)
	FROM empleados);
    
SELECT COUNT(distinct ID_empleado)
FROM empleados; 

SELECT COUNT(distinct venta_empleado)
FROM ventas;
	
    SELECT *
    FROM empleados 
    WHERE ID_empleado IN( 
		SELECT DISTINCT venta_empleado
        from ventas);
        
SELECT * 
FROM empleados e
LEFT JOIN ventas v
	ON v.venta_empleado= e.ID_empleado
    WHERE v.ventas_id IS NULL;
    
SELECT venta
FROM ventas
WHERE ID_local =2;

SELECT MAX(venta)
FROM ventas
WHERE ID_local= 2;

SELECT *
FROM ventas 
WHERE venta > (
	SELECT MAX(venta)
    FROM ventas 
    WHERE ID_local= 2);
    
SELECT *
FROM ventas 
WHERE venta > ALL(
SELECT venta
FROM ventas
WHERE ID_local= 2);

SELECT *
FROM ventas
WHERE venta < ALL(
	SELECT venta
    FROM ventas
    WHERE ID_local=4);

SELECT venta
FROM ventas
WHERE ID_local=2;

SELECT *
FROM ventas 
WHERE venta > ANY(
SELECT venta
FROM ventas
WHERE ID_local=2);

SELECT 
	ventas_id,
    venta,
    (select AVG (venta) FROM ventas) as promedio_venta
	venta - (SELECT promedio_venta)
    FROM ventas; 
    
SELECT *
FROM (
	select
		venta, ventas_id
			(SELECT  AVG (venta) FROM ventas) as pormedioventa 
            venta - (SELECT promedioventa)
            FROM ventas as promedio; 

-- VISTAS--

USE datos;

CREATE VIEW venta_empleados as venta_empleados
select
	l.letra_zona,
    l.telefono,
    v.venta,
    v.venta_empleado,venta_empleados
    e.nombre 
From local l
	Left join ventas v
	on l.ID_Local =v.ID_local
    Left join empleados e
    on venta_empleado = e.ID_empleado
    where venta > 1000;
    
Select *
from venta_empleados;

-- ALMACENAMIENTO DESDE WORKBNCH--

USE	datos;

DELIMITER $$
CREATE procedure sp_pizza()
begin
	Select *
    from ventas
    where clave_producto = "pzz";
    end $$
    DELIMITER ; 
    
DELIMITER %%
CREATE PROCEDURE sp.venta_calzone ()
BEGIN
SELECT *
FROM venntas
Where clave_porducto = "clz"; 
END
DELIMITER %%;

-- PARÁMETROS--

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_venta_producto`(producto VARCHAR(3))
BEGIN
SELECT *
FROM ventas 
WHERE clave_producto = producto; 
END;

CALL sp_venta_local(1,0), 
 
 SET @param_local =1;
 SET @suma_ventas =0; 

 
 Call sp_proceso_mejora ();
 
 SELECT 
 venta_empleado,
 AVG(venta)
 FROM ventas 
 GROUP BY venta_empleado; 
 
 SELECT 
	ID_empleado, 
    Nommbre, 
    fn_mejora_empleado (ID_empleado) 
    FROM empleados;
    
    --Eventos TRIGGER--
    
    DDELIMITER $$
    
    CREATE TRIGGER pago_after_insert
		AFTER INSERT ON pago_orden
        FOR EACH ROW  
        
BEGIN 
	UPDATE orden
    SET balance= balance + NEW.cantidad
    WHERE orden =NEW.orden; 
    END$$

DELIMITER ;

DELIMITER $$
    
    CREATE TRIGGER pago_after_insert
		AFTER INSERT ON pago_orden
        FOR EACH ROW  
        
BEGIN 
	UPDATE orden
    SET balance= balance + NEW.cantidad
    WHERE orden =NEW.orden; 
    END$$

DELIMITER ;

SELECT *
FROM pago_orden;

INSERT INTO pago_orden 
VALUES (default, curdate(), 499,6792,1000);

SELECT *
FROM pago_orden;

-- eventos trigger--

DELIMITER $$
    
    CREATE TRIGGER pago_after_insert
		AFTER INSERT ON pago_orden
        FOR EACH ROW  
        
BEGIN 
	UPDATE orden
    SET balance= balance + NEW.cantidad
    WHERE orden =NEW.orden; 
    END$$

DELIMITER ;

SELECT *
FROM pago_orden;

INSERT INTO pago_orden 
VALUES (default, curdate(), 499,6792,1000);

SELECT *
FROM pago_orden;

-- TRRIFDELIMITER $$
    
   DROP TRIGGER IF exists pago_after_insert; 
   CREATE TRIGGER pago_after_insert
		AFTER INSERT ON pago_orden
        FOR EACH ROW  
        
BEGIN 
	UPDATE orden
    SET balance= balance + NEW.cantidad
    WHERE orden =NEW.orden; 
    INSERT INTO auditoria_pagos
values(new.ID_pago,new.orden,new.fecha,new.cantidad, "insert", curdate());

    END$$

DELIMITER ;

CREATE PROCEDURE insertar_pago(IN p_ID_pago INT, IN p_orden INT, IN p_fecha DATE, IN p_cantidad DECIMAL(10,2))
BEGIN
    -- Actualizar el balance en la tabla 'orden'
    UPDATE orden
    SET balance = balance + p_cantidad
    WHERE orden = p_orden;

    -- Insertar registro en la tabla 'auditoria_pagos'
    INSERT INTO auditoria_pagos (ID_pago, orden, fecha, cantidad, accion, fecha_registro)
    VALUES (p_ID_pago, p_orden, p_fecha, p_cantidad, 'insert', CURDATE());
END$$
DELIMITER ;









    

 
 
 
 
 
 
 













 
	

