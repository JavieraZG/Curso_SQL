/*
SQL Nivel Inicial
Ejemplos y ejercicios módulo 2
*/ --Nombre: Javiera Zavala

-- Ejemplo: 

-- Consultar una columnas  de una tabla

SELECT 
	title 
FROM 
	film;

-- Consultar múltiples columnas  de una tabla.

SELECT
	title,
	release_year
FROM
	film;
	
--	Consultar todas las columnas de una tabla

SELECT
	*
FROM
	film;
	
-- Usa LIMIT para obtener 3 filas en el resultado

SELECT
	*
FROM
	film
LIMIT 3;


--Usar OFF SET

SELECT
	*
FROM
	film
LIMIT 3 OFFSET 2;


-- Consulta la tabla rental ordenada según rental date
-- ¿Qué fechas quedaron arriba?
-- Javiera: del más antiguo al más nuevo. 

SELECT
	*
FROM
	rental
ORDER BY
	rental_date;
	
----------------------------------------------------------	ASC o DESC

SELECT
	*
FROM
	rental
ORDER BY
	rental_date DESC;
	
	
-- Ejercicios		
	
-- Ejercicio 1 ¿Qué duración tienen las películas más largas
-- 				(length) de table film?

SELECT
	title,
	length
FROM
	film
ORDER BY
	length DESC;
	

-- Ejercicio 2  ¿Cuál es el precio de renta (rental_rate) 
--               mayor en la table film?

SELECT
	title,
	rental_rate
FROM
	film
ORDER BY
	rental_rate DESC;


-- Ejercicio 3 ¿Hay algún cliente que su nombre (first_name) comience
--             con la letra Z?

SELECT
	first_name
FROM
	customer
ORDER BY
	first_name  DESC;


-- Ejercicio 4 ¿Qué mes se realizó el primer arriendo de dvd (table rental)?  MAYO

SELECT
	rental_date
FROM
	rental
ORDER BY
	rental_date  ASC;



-- Ejemplo clase. Consulta con una condición
-- Consulta las películas con un rental_duration mayor a 5

SELECT
	title,
	rental_duration
FROM
	film
WHERE
	rental_duration > 5;


-- Consulta con múltiples condiciones
-- Películas con rental_duration mayor a 4 y el language_id  igual a 1

SELECT
	*
FROM
	film
WHERE
	rental_duration > 4
	AND
	language_id = 1;

-- Operadores Lógicos
-- Películas con rental_duration mayor a 4 
-- y menor a 7 y que el clasificación (rating) no sea restringido para menores 

SELECT
	*
FROM
	film
WHERE
	(rental_duration > 4 AND rental_duration < 7)
	AND
	rating <> 'R';   --cuando el dato es de tipo VARCHAR (texto) se agrega entre comillas o apóstrofe. 


-- Ejercicios

-- Ejercicio 5: ¿Qué país tiene in id de 22?

SELECT
	*
FROM
	country
WHERE
	country_id = 22; 

-- Ejercicio 6: Obten las nombre y valor de inventario (replacement_cost)
-- de las películas que tengan un valor de inventario mayor o igual a 20.

SELECT
	title,
	replacement_cost
FROM
	film
WHERE
	replacement_cost >= 20; 

-- Ejercicio 7: Obten las nombre y valor (replacement_cost) 
-- de las peliculas que tengas un valor mayor o igual a 20 
-- y menos o igual a 25

SELECT
	title,
	replacement_cost
FROM
	film
WHERE
	(replacement_cost >= 20) AND (replacement_cost <= 25);
	
/*
Ejercicio 8: Obten las títulos y valores (replacement_cost) de las peliculas 
que tengas un valor mayor o igual a 20 y menos o igual a 25. 
Ordena los resultados de manera que los valores mayores aparezcan primero 
y limita tu resultado a solo 4 filas.
*/

SELECT
	title,
	replacement_cost
FROM
	film
WHERE
	(replacement_cost >= 20) AND (replacement_cost <= 25)
ORDER BY
	replacement_cost DESC
LIMIT 4;


-- Ejemplos

-- Obten los nombres de las categorias  que tienen 
-- category_id 1, 14 o 16

SELECT
	*
FROM
	category
WHERE
	category_id = 1 OR
	category_id = 14 OR
	category_id = 16;
	
-- Uso de IN para ejemplo anterior

SELECT
	*
FROM
	category
WHERE
	category_id IN (1,14,16);

-- Obten los nombres de las categorías que no son populares

SELECT
	*
FROM
	category
WHERE
	category_id NOT IN (1,14,16);


-- Consulta las direcciones de la tabla address

SELECT
	*
FROM
	address;

-- Consulta las direcciones de la tabla address
-- excluyendo las que tienen valor nulo en la columna address2

SELECT
	*
FROM
	address
WHERE
	address2 IS NOT NULL;



