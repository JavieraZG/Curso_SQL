/*SQL Nivel Inicial | NivelUP Chile 
Módulo 8: Desafio final 
base de datos: northwind
Nombre: Javiera Zavala
*/



-- Exploracion inicial de las tabla. 
-- Hint: si la tabla tiene 2 nombres debes escribirla con un guión bajo

SELECT *
FROM customers;


SELECT *
FROM products;


SELECT *
FROM orders;


SELECT *
FROM order_details;


SELECT *
FROM employees;


SELECT 
	DISTINCT(categoryname)
FROM categories;



-- Uso apopiado de sintaxis
-- Obtener todos los productos de la categoría 'Beverages'.

SELECT 
	DISTINCT(categoryname),
	categoryid
FROM 
	categories
ORDER BY 
	categoryid ASC;

/* BEVERAGES categoryid= 1 */

SELECT 
	*
FROM
	products
WHERE categoryid = '1';


-- Uso apropiado de búsquedas en texto
-- Consulta el id y nombre de los productos que tengan 'rr' en alguna parte de su nombre

SELECT
	productid,
	productname
FROM
	products
WHERE
	productname LIKE '%rr%';

	
-- Uso apropiado de JOIN simple
-- Consulta con JOIN: Obtener el order_id, la fecha de orden y cliente (companyname) que realizó cada pedido.
-- Debes hacer INNER JOIN entre orders y customers 
-- hint: recuerds especificar la tabla cuando hayan columnas comunes a ambas

SELECT
	o.orderid AS order_id,
	o.orderdate AS fecha_de_orden,
	c.companyname AS clientes
FROM
	orders o
INNER JOIN
	customers c ON o.customerid = c.customerid;
	
-- Uso apropiado de JOINs
-- Explora cuáles son los clientes que nunca han realizado una compra
	
SELECT
	c.companyname AS clientes,
	c.customerid,
	o.orderid AS order_id
FROM 
	customers c
LEFT JOIN
	orders o ON c.customerid = o.customerid
WHERE o.orderid IS NULL;


	
-- Uso apropiado de creación de columnas
-- Obtener la informacion básica de los productos (productid, productname y unitprice ) 
-- con una columna extra que indique si el precio es 'alto' (> $50) o 'bajo' (<= $50).

SELECT 
	productid,
	productname,
	unitprice AS precio_unidad,
	CASE
		WHEN unitprice > 50 THEN 'alto'
		WHEN unitprice <= 50 THEN 'bajo'
		ELSE 'Null'
	END AS nivel_precio
FROM
	products
ORDER BY
	precio_unidad ASC;


-- Manejo de filtro y datos tipo fecha

-- Calcular los días trascurridos entre orderdate y shippeddate:
-- Crea un query con orderid, orderdate, shippeddate y la duracion del pedido
-- ordena el resultado por duracion descenciente
-- Hay ordenes que nunca fueron despachadas por lo tanto debes excluirlas de tu resultado
-- Hint la resta directa entre columnas de fecha perimite obtener los dias entre ellas


SELECT
	orderid,
	orderdate,
	shippeddate,
	AGE(shippeddate,orderdate) AS tiempo_despacho
FROM
	orders
WHERE shippeddate IS NOT NULL
ORDER BY tiempo_despacho DESC;
	
	
-- Uso apropiado de filtro en columnas agregadas y alias
-- Necesitas conocer cuáles categorías han vendido al menos 3000 unidades.
-- Consulta la categoryid, categoryname, y el total de unidades que se han vendido.
-- Filtra tu resultado final por para obtener solo las categorias que han vendido más de 3000
-- Usa alias para escirbir tu consulta

SELECT
	c.categoryid AS category_id,
	c.categoryname AS category_name,
	SUM (od.quantity) AS total_units_sold
FROM
	categories c
JOIN
	products p ON c.categoryid = p.categoryid
JOIN
	order_details od ON p.productid = od.productid
GROUP BY
	c.categoryid, c.categoryname
HAVING
	SUM(od.quantity)>= 3000
ORDER BY
	total_units_sold  ASC;




-- Uso aporpiado de agregación y operadores aritméticos
-- En la tabla order_details esta la información de los productos asociados a cada orden, 
-- el precio, el descuento y la cantidad de unidades
-- Organiza la información para calcular cuanto dinero esta asociado a cada orden	


SELECT 
    orderid,
	quantity,
	unitprice,
	discount,
   	ROUND(CAST(SUM(quantity*(unitprice - discount)) AS FLOAT)) AS total_order_cost
FROM 
    order_details
GROUP BY 
    orderid,
	quantity,
	unitprice,
	discount;


-- Uso apropiado de UNION y de manejo de Texto
-- Obten un listado con los nombres (clientes y de trabajadores) y su region 

SELECT
	companyname AS nombre_completo,
	region
FROM
	customers

UNION

SELECT
	firstname || ' ' || lastname AS nombre_completo,
	region
FROM 
	employees;

	
-- Uso apropiado de filtros de Fecha y Agregación
-- Evalúa la performance para cada trabajador según cantidad de ordenes procesadas 
-- durante el último trimestre del año 96 


SELECT
	e.firstname || ' ' || e.lastname AS Nombre_empleado,
	o.employeeid AS id_empleado, 
	COUNT(o.orderid) AS qty_ordenes
FROM
	orders o 
LEFT JOIN
	employees e ON o.employeeid = e.employeeid
WHERE
	EXTRACT(YEAR FROM orderdate)=1996
	AND EXTRACT(QUARTER FROM orderdate)=4
GROUP BY
	e.firstname,
	e.lastname,
	o.employeeid
ORDER BY
	qty_ordenes DESC;


/*	
	
Uso aprepiado de Subconsultas y/o CTEs
	
-- #######################################################################################
	
   A cotinuación hay dos bloques de ejercicios
   Lee ambos bloques y escoje uno para desarrollar
	
--########################################################################################
*/
	
-- ----------------------------------------------------------------------------------------		
-- ------------------------------------ BLOQUE # 1 ---------------------------------------
-- ----------------------------------------------------------------------------------------	
	
-- Crea una tabla con el nombre cliente (customerid) y la fecha de la ultima compra
-- Hint: Solo necestias la tabla orders

SELECT
	customerid,
	MAX(orderdate) AS ultima_compra
FROM
    orders
GROUP BY
    customerid;

	
-- Obten cutomer_id, order_date y unitprice.
-- Ordena el resultado por customer y por unitprice descendiente
-- Hint: necestias las combinar las tablas orders y order_details

	
-- Recicla en query anterior para obenter el primer registro de cada cliente
-- es decir el de mayor unit price.


	
	
-- Necesitas crear una tabla con la fecha de la ultima compra
-- y la fecha de la compra de mayor monto


	
	
-- ----------------------------------------------------------------------------------------		
-- ------------------------------------ BLOQUE # 2 ---------------------------------------
-- ----------------------------------------------------------------------------------------	


-- Para cada cliente obten la cantidad total de ordenes que ha realizado
	
SELECT
	c.companyname,	
	o.customerid,
	count(o.orderid) AS qty_ordenes
FROM
	orders o
LEFT JOIN
	customers c ON o.customerid = c.customerid
GROUP BY 
	c.companyname,
	o.customerid;

	
--  Para cada cliente suma cuanto dinero ha gastado

SELECT
    o.customerid,
    ROUND(CAST(SUM(od.quantity*(od.unitprice - od.discount)) AS FLOAT)) AS total_gastado
FROM
    orders o
JOIN
    order_details od ON o.orderid = od.orderid
GROUP BY
    o.customerid
ORDER BY
	total_gastado DESC;

-- Crea un query con el customerid y el valor promedio que gasta cada cliente (total_dinero/# ordenes)
-- Crea una columna extra que clasfique el tipo de gasto como alto, medio o bajo segun si el gasto
-- promedio es alo menos 100, más de 50 y menor a 100 o bajo 50


WITH Gastos AS (
    SELECT
        o.customerid,
        COUNT(o.orderid) AS qty_ordenes,
        ROUND(CAST(SUM(od.quantity*(od.unitprice - od.discount)) AS FLOAT)) AS total_gastado
    FROM
        orders o
    LEFT JOIN
        order_details od ON o.orderid = od.orderid
    GROUP BY
        o.customerid
	)
	
SELECT
	Gastos.customerid,
    Gastos.total_gastado,
	Gastos.qty_ordenes,
    ROUND(CAST(Gastos.total_gastado/ Gastos.qty_ordenes AS FLOAT)) AS valor_promedio_gasto,
    CASE
        WHEN Gastos.total_gastado/ Gastos.qty_ordenes >= 100 THEN 'alto'
        WHEN Gastos.total_gastado / Gastos.qty_ordenes > 50 AND 
		Gastos.total_gastado / Gastos.qty_ordenes < 100 THEN 'medio'
        ELSE 'bajo'
    END AS tipo_gasto
FROM
    Gastos
GROUP BY
	Gastos.customerid,
    Gastos.total_gastado,
	Gastos.qty_ordenes
ORDER BY
    Gastos.total_gastado DESC;
	
	
