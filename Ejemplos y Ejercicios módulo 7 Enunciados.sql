/*
SQL Nivel Inicial | NivelUP Chile 
Módulo 7 
Nombre: Javiera Zavala
*/

-- ############
-- Subquery en WHERE
-- ############

-- Quieres obtener todas las opciones de películas que tengan la duración máxima
-- PASO 1: Consultar la duración máxima

SELECT
	MAX(length)
FROM film;

-- PASO 2: Usar resultado anterior para filtrar las películas
SELECT	
	film_id,
	title
FROM film
WHERE lenght=185);


-- Usando subquery (escalar)
SELECT	
	film_id,
	title
FROM film
WHERE length = (
	SELECT
	MAX(length)
	FROM film
	);


-- Ejercicio
-- ¿Cuántos pagos hay por sobre el promedio?


-- PASO 1 Obtener el promedio
SELECT
	ROUND(AVG(amount),2)
FROM
	payment;

-- PASO 2 Incorporar el pago promedio en query

SELECT
	COUNT(*)
FROM payment
where amount >(SELECT AVG(amount) FROM payment);


-- Obten los datos de la películas de la tabla film solo para la categoría 'Action'

-- PASO 1: Crea un query que entregue los film_id de las películas de accion

SELECT
	film_id
FROM
	film_category
	JOIN category
	ON film_category.category_id=category.category_id
WHERE
	name = 'Action';
   
   
   
SELECT
	film_id
FROM
	film_category
	JOIN category USING category_id
WHERE
	name = 'Action';  
   
-- Paso 2:  Realiza un bosquejo del query principal
SELECT
	*
FROM
	film
WHERE
	film_id IN (--lista de film_id)
ORDER BY 
	film_id;
	
	
-- Paso 3: Reemplaza el subquery en el filtro
	  
SELECT
	*
FROM
	film
WHERE
	film_id IN (
	SELECT
		film_id
	FROM
		film_category
	INNER JOIN category USING (category_id)
WHERE
	name = 'Action'
	)
ORDER BY 
	film_id;
	

-- ############
-- Subquery en SELECT
-- ############

-- Realiza un query con 3 columnas: payment_id, amount y una columna que contenga
-- simplemente el promedio de todos los pagos de la tabla
-- PASO 1:
SELECT ROUND(AVG(amount),2) AS avg_pago
FROM payment;

-- PASO 2
SELECT
	payment_id,
	amount AS monto_pago,
	(SELECT ROUND(AVG(amount),2) AS avg_pago FROM payment) AS pago_promedio
FROM payment;
	

	
-- Ejercicio
-- Consulta el film_id, title, length y la última columna
-- obten la duración promedio de todas las películas

SELECT
	ROUND(AVG(length),2)
FROM film;
	
		
		
		
		
		
		
SELECT 
	film_id,
	title,
	length,
	(SELECT	ROUND(AVG(length),2) FROM film) AS promedio_duracion
FROM
	film;
		
-- ############
-- Subquery en FROM
-- ############	
	
	
-- Ejercicio
-- Obtener promedio del total de pago de todos los clientes

-- PASO 1
-- Obtener el total de pago de todos los clientes
SELECT 
	customer_id,
	SUM(amount) as total_pago
FROM payment
GROUP BY customer_id;


-- PASO 2: Obtener El promedio del total de los pagos

--Paso 2.a Puedo usar el query anterior como una tabla
SELECT *
FROM 	(SELECT customer_id,
			SUM(amount) as total_pago
		FROM payment
		GROUP BY customer_id);


--Paso 2.b calcular el promedio de la columna total pago
SELECT  ROUND(AVG(total_pago),1)
FROM 	(SELECT customer_id,
			SUM(amount) as total_pago
		FROM payment
		GROUP BY customer_id);



-- ########
-- Subquery escalar en HAVING
-- ########


-- ejercicio
-- Obtener los id de clientes de los mejores clientes
-- (clientes con un total de pagos por sobre el promedio)


--PASO 1:  Armar bosquejo de consulta  
SELECT
	customer_id,
	SUM(amount)
FROM
	payment
GROUP BY customer_id;


-- PASO 2: Usar el query con el promedio de la suma de pagos por cliente 
-- como filtro en HAVING

SELECT
	customer_id,
	SUM(amount)
FROM
	payment
GROUP BY customer_id
HAVING SUM(amount) >	(SELECT  ROUND(AVG(total_pago),1)
						FROM 	(SELECT customer_id,
									SUM(amount) as total_pago
								FROM payment
								GROUP BY customer_id));

			
	  
	  

-- ######################
-- ################
-- ###########
-- uso de CTE
-- ###########
-- ################
-- ######################

-- Ejemplo 
-- ¿Cuál fue el pago promedio durante el mes de mayo en películas de categoria = 'Family'?

-- Crea un bosquejo
WITH action_film AS (
				-- cte_query con film_id de accion
				-- join film, film_category y category
				-- filtro family
	)	  
		
SELECT AVG(amount)
FROM -- join con payment, rental, inventory y action_film
WHERE DATE_PART('MONTH',payment_date) = 05;		
-----------------------------------
		
		
WITH action_film AS (
	SELECT
	film_id
	FROM
	film_category f_c
	JOIN category c ON c.category_id=f_c.category_id
	WHERE
	name = 'Family'
	)	
		
SELECT ROUND(AVG(amount),2)
FROM payment p
	JOIN rental r ON p.rental_id = r.rental_id
	JOIN inventory i ON i.inventory_id = r.inventory_id
	JOIN action_film af ON af.film_id = i.film_id
WHERE DATE_PART('MONTH',payment_date) = 05;
		
		
		
		
		

-- Ejercicio guiado
-- Un cliente solicita películas que duren al menos 3 horas y de rating = ’G’
-- Para ayudarlo a escoger, debemos informarle los titulos y las categorias de
-- las películas que estan disponibles en nuestro inventario que cumplen los requisitos.



-- Usaremos este query con los film_id y las categorias.
-- Luego  lo usaremos como una CTE.

SELECT f.film_id, c.name as category
FROM film f
	JOIN film_category fc
	ON fc.film_id = f.film_id
	JOIN category c
	ON c.category_id = fc.category_id


-- Usaremos este query de las películas 
-- que cumplen los requisitos.
-- Luego lo usaremos como query principal

SELECT 
	DISTINCT f.film_id as film_id_3h_g,
	f.title as nombre
FROM inventory i
	JOIN film f
	ON f.film_id = i.film_id
WHERE length > 180 AND rating = 'G';


-- bosquejo
		
WITH cte_category AS (
		--query para las categorias
		)
SELECT 
	DISTINCT f.film_id as film_id_3h_g,
	f.title as nombre,
	--categoria  -- columna desde la CTE
FROM inventory i
	JOIN film f
	ON f.film_id = i.film_id
-- JOIN xx
-- ON xx  -- combinar el query principal con la CTE
WHERE length > 180 AND rating = 'G';



-- Por último...

-- Reemplaza el query de CTE
-- Añade al query principal la columna categoria
-- Combina el query principal con la CTE

WITH cte_category AS (
		SELECT f.film_id, c.name as category
		FROM film f
		JOIN film_category fc  	ON fc.film_id = f.film_id
		JOIN category c  ON c.category_id = fc.category_id
		)
SELECT 
	DISTINCT f.film_id as film_id_3h_g,
	f.title as nombre,
	category
FROM inventory i
	JOIN film f
	ON f.film_id = i.film_id
	JOIN cte_category
	ON cte_category.film_id = f.film_id
WHERE length > 180 AND rating = 'G';


