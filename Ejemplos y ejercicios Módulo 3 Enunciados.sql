/*
SQL Nivel Inicial | NivelUp Chile
Módulo 3
Nombre:
*/

-- Ejemplos

-- ¿Cuáles son todas posibles tarifas de renta rental_rate?
SELECT 
	DISTINCT(rental_rate)
FROM 
	film;
	
-- Ejercicio 1: ¿Cuáles son los calificación de las películas
--    			según su contenido (rating)?

SELECT 
	DISTINCT(rating)
FROM 
	film;

-- Ejemplos

-- Obten el título (title), tarifa (rental_rate), y tarifa (rental_rate) con un alias

SELECT
	title,
	rental_rate,
	rental_rate AS tarifa_renta
FROM
	film;
	
-- ¿Cuál sería el rating_rate si subieras los precios en un 15% ?

SELECT
	title,
	rental_rate,
	rental_rate * 1.15,
	rental_rate * 1.15 AS nueva_tarifa_renta
FROM
	film;

-- Ejercicio 2: Escoge un alias apropiado para las siguientes
-- columnas (title,length, rating,rental_rate)

SELECT
	title AS Nombre,
	length AS duración,
	rating AS clasificación, 
	rental_rate AS tarifa
FROM
	film;


-- Ejemplos Funciones de agregación

-- ¿Cuántas películas hay en total?

SELECT
	COUNT (*) AS TOTAL_PELICULAS
FROM
	film;

-- Ejercicio 3: ¿Cuál el el valor de todos los pagos
-- 				que hay registrados?

SELECT
	SUM(amount) AS Pago_totales
FROM
	payment;

	
-- Ejemplos
-- ¿Cuál es el valor mínimo y máximo de replacement_cost?


	
-- ¿Cuál es la duración promedio de una película?

SELECT
	MAX(replacement_cost) AS max_valor_inv,
	MIN(replacement_cost) AS min_valor_inv
FROM
	film;

-- Manejo de decimales
-- ¿Cuál es la duración promedio de una película?

SELECT
	ROUND( AVG(length), 1) AS duración_promedio
FROM
	film;

-- Ejemplos GROUP BY
-- ¿Cuántos dinero gasta cada cliente?

SELECT
	customer_id,
	SUM(amount)
FROM
	payment
GROUP BY
	customer_id
ORDER BY
	SUM(amount);

-- ¿Cuántos pagos ha realizado cada clientes?
-- Ordena los resultados para ver los clientes
-- con mas pagos primero

SELECT
	customer_id,
	COUNT(amount)
FROM
	payment
GROUP BY
	customer_id
ORDER BY
	COUNT (amount) DESC;	

-- Usar mas de una fun. agg. 

--  ¿Cuántos pagos ha realizado cada clientes
--y cuánto ha gastado en total?

SELECT
	customer_id,
	SUM(amount),
	COUNT(amount)
FROM
	payment
GROUP BY
	customer_id
ORDER BY
	COUNT(amount) DESC;


-- Uso de alias para el query anterior
	
SELECT
	customer_id,
	SUM(amount) AS total_pagos,
	COUNT(amount) AS QTY_pagos
FROM
	payment
GROUP BY
	customer_id
ORDER BY
	COUNT(amount) DESC;

	
-- Agregar más de una categoría
-- ¿Cuánto gasta cada cliente con cada miembro del staff?

SELECT
	customer_id,
	staff_id,
	SUM(amount)
FROM
	payment
GROUP BY
	customer_id,
	staff_id
ORDER BY
	customer_id;

-- Ordena según más de una columna

SELECT
	customer_id,
	staff_id,
	SUM(amount) AS total
FROM
	payment
GROUP BY
	customer_id,
	staff_id
ORDER BY
	customer_id, total;
	
	
-- Ejercicios!
/*
Ejercicio 4: Hay 2 miembros del staff. La empresa quiere darle
			un bono al que haya realizado mas pagos 
			(en cantidad no en dinero total)

			¿Qué miermbro gana el bono?
*/	

SELECT
	staff_id,
	COUNT(amount)
FROM
	payment
GROUP BY
	staff_id
ORDER BY
	COUNT(amount) DESC;
	

/*
Ejercicio 5: El equipo de finanzas quiede determinar el
			valor de inventario promedio para cada clasificación
			(rating) de películas

		¿Qué rating tiene el mayor valor de inventario promedio?

*/

SELECT
	rating,
	ROUND(AVG(replacement_cost),1)
FROM
	film
GROUP BY
	rating
ORDER BY
	ROUND(AVG(replacement_cost),1) DESC;


/*
Ejercicio 6: Queremos premiar a  nuestros mejores 5 clientes 
			con un cupon de descuentos¿Cuáles son los top 5 clientes que han
			gastado más dinero en renta de dvd?
*/

SELECT
	customer_id,
	SUM(amount)
FROM
	payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;

-- Ejemplo ¿Qué clientes han gastado más de 100 dólares?

SELECT
	customer_id,
	SUM(amount)
FROM
	payment
GROUP BY customer_id
HAVING SUM(amount)>100;

-- ¿Cuál tienda tiene más de 300 clientes?

SELECT
	store_id,
	COUNT(customer_id)
FROM
	customer
GROUP BY store_id
HAVING COUNT(customer_id)>300;


/* Ejercicios

Ejercicios 7: Daremos la clasificación de Premium a los
clientes tengas al menos de 40 transacciones de compra.
Obten los customer_id para estos clientes.

*/

SELECT
	customer_id,
	COUNT(payment_id)
FROM
	payment
GROUP BY customer_id
HAVING COUNT(payment_id) >=40;


/*

Ejercicios 8: ¿Qué clientes (customer_id) han gastado
			a lo menos 100 dolares en transaciones 
			con el miembro del staff de id número 2?
*/

SELECT
	customer_id,
	staff_id,
	SUM(amount)
FROM
	payment
WHERE
	staff_id = 2
GROUP BY 
	customer_id,
	staff_id
HAVING 
	SUM(amount) >=100
ORDER BY 
	SUM(amount) DESC;
	
	
--- *FIN*
