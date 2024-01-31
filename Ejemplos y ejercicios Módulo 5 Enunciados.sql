/*
SQL Nivel Inicial
Módulo 5
Nombre: Javiera Zavala
*/

-- INNER JOIN
-- Realiza un INNER JOIN entre las tablas payment y customer. 

SELECT 
	*
FROM 
	payment
INNER JOIN customer
	ON customer.customer_id = payment.customer_id;
	

-- Realiza un INNER JOIN entre las tablas payment y customer. 
-- Selecciona solamente pas columnas payment_id, customer_id y first_name

SELECT 
	payment_id,
	customer.customer_id,
	first_name
FROM 
	payment
INNER JOIN customer
	ON customer.customer_id = payment.customer_id;
	
	
-- #############################################
-- Uso de alias en tablas
-- #############################################

SELECT 
	payment_id,
	c.customer_id,
	first_name
FROM 
	payment p
INNER JOIN customer c
	ON c.customer_id = p.customer_id;
	

-- FULL OUTER JOIN
-- Realiza un FULL OUTER JOIN entre las tablas payment y customer

SELECT 
	*
FROM 
	payment
FULL OUTER JOIN customer
	ON customer.customer_id = payment.customer_id;

	
	
-- el order de las tablas no afecta el resultado en un FULL OUTER JOIN 	

SELECT 
	*
FROM 
	payment
FULL OUTER JOIN customer
	ON payment.customer_id = customer.customer_id;



-- LEFT JOIN
-- Explorar tabla inventory
SELECT 
	*
FROM 
	inventory;

-- Explora la tabla film

SELECT 
	*
FROM 
	film;	
	
-- Realiza un LEFT JOIN entre las tablas film (LEFT) y la table inventory 
-- Consulta las columnas film.film_id, title, inventory_id y  store_id.

SELECT 
	film.film_id,
	title,
	inventory_id,
	store_id
FROM 
	film
LEFT JOIN inventory
	ON film.film_id = inventory.film_id;
	
-- Usando el query anterior revisa si existen valores nulos
-- en alguna de las columnas de la tabla inventory
	
SELECT 
	film.film_id,
	title,
	inventory_id,
	store_id
FROM 
	film
LEFT JOIN inventory
	ON film.film_id = inventory.film_id
WHERE inventory_id IS NULL;
	

-- Modifica el query anterior para obtener solo las filas que NO tienen
-- valores nulos en alguna de las columnas de la tabla inventory.

SELECT 
	film.film_id,
	title,
	inventory_id,
	store_id
FROM 
	film
LEFT JOIN inventory
	ON film.film_id = inventory.film_id
WHERE inventory_id IS NOT NULL;

	
-- En el query anterior añade un filtro para obtener solo la filas 
-- relativas a la película ‘Academy Dinosaur’ 

SELECT 
	film.film_id,
	title,
	inventory_id,
	store_id
FROM 
	film
LEFT JOIN inventory
	ON film.film_id = inventory.film_id
WHERE inventory_id IS NOT NULL
	AND
	title='Academy Dinosaur';

	
-- Modifica el query anterior para contar las copias que hay en cada 
-- tienda de la película ‘Academy Dinosaur’.

SELECT 
	film.film_id,
	title,
	store_id,
	COUNT(inventory_id)
FROM 
	film
	
LEFT JOIN inventory
	ON film.film_id = inventory.film_id
	
WHERE inventory_id IS NOT NULL
	AND
	title='Academy Dinosaur'
	
GROUP BY
	film.film_id,
	title,
	store_id;

-- RIGHT JOIN 
-- Explora la table language
SELECT
	*
FROM
	language;

-- Explora la todos los idiomas presents en las películas de la table film

SELECT
	DISTINCT (language_id)
FROM
	film;

/*
Ejercicio
Realiza un RIGHT JOIN entre la tabla `film` y  la tabla `language` (R)
Selecciona el nombre (`name`), el título (`title`) y el identificador de idioma (`language_id`).
Ordena el resultado en por name en orden descendiente

*/

SELECT
	name AS idioma,
	language.language_id,
	title
FROM
	film
RIGHT JOIN language
	ON film.language_id = language.language_id
ORDER BY IDIOMA DESC;

-- Añade un filtro al query anterior para obtener las idiomas que no estan asociados a ninguna película

SELECT
	name AS idioma,
	language.language_id,
	title
FROM
	film
RIGHT JOIN language
	ON film.language_id = language.language_id
WHERE
	title IS NULL
ORDER BY idioma DESC;
	
-- Añade un filtro al query anterior para obtener las idiomas 
SELECT
	name AS idioma,
	language.language_id,
	title
FROM
	film
RIGHT JOIN language
	ON film.language_id = language.language_id
WHERE
	title IS NULL
ORDER BY idioma DESC;
	

-- ¿Es los mismo RIGHT JOIN y LEFT JOIN  si cambio el orden de las tablas?
-- RESPUESTA: ES LO MISMO.

SELECT
	name AS idioma,
	language.language_id,
	title
FROM
	film
RIGHT JOIN language
	ON film.language_id = language.language_id
WHERE
	title IS NULL
ORDER BY idioma DESC;


SELECT
	name AS idioma,
	language.language_id,
	title
FROM
	language
LEFT JOIN film
	ON language.language_id = film.language_id
WHERE
	title IS NULL
ORDER BY idioma DESC;


-- MULTIPLES JOINS
-- Un cliente quiere saber en que películas actúa 'Nick Wahlberg'

-- PASO 1 Explora la tabla actor y consulta las columna actor_id, first_name,
-- last_name. Usa un filtro para obtener el actor de interes
SELECT
	actor_id,
	first_name || ' ' || last_name as actor_full_name,
FROM
	actor
WHERE 
	first_name = 'Nick' AND last_name='Wahlberg';

-- Paso 2
-- Realiza un INNER JOIN con la table film_actor para para añadir la info de los film_id asociados a ese actor

SELECT
	first_name || ' ' || last_name as actor_full_name,
	actor.actor_id,
	film_id
FROM
	actor
INNER JOIN  film_actor
	ON actor.actor_id = filmactor.actor_id
WHERE 
	first_name = 'Nick' AND last_name='Wahlberg';

-- Paso 3
-- Ahora solo ncestiamos el titulo de cada pelicula!

SELECT
	first_name || ' ' || last_name as actor_full_name,
	film_actor.film_id,
	title
FROM
	actor
INNER JOIN  film_actor
	ON actor.actor_id = film_actor.actor_id
INNER JOIN film
	ON film_actor.film_id = film.film_id
WHERE 
	first_name = 'Nick' AND last_name='Wahlberg';
	
	
-- 
-- Reescribe el query anterior usando alias para las tablas
	
SELECT
	first_name || ' ' || last_name as actor_full_name,
	fa.film_id,
	title
FROM
	actor a
INNER JOIN  film_actor fa
	ON a.actor_id = fa.actor_id
INNER JOIN film f
	ON fa.film_id = f.film_id
WHERE 
	first_name = 'Nick' AND last_name='Wahlberg';




-- Ejercicio
-- ¿Cómo saber si tenemos peliculas con este actor ('Nick Wahlberg') en nuestro
-- inventario?
-- Agrega otro JOIN pero ahora con la table inventory.

SELECT
	first_name || ' ' || last_name as actor_full_name,
	title,
	inventory_id
FROM
	actor a
INNER JOIN  film_actor fa
	ON a.actor_id = fa.actor_id
INNER JOIN film f
	ON fa.film_id = f.film_id
INNER JOIN inventory I
	ON f.film_id = I.film_id
WHERE 
	first_name = 'Nick' AND last_name='Wahlberg';

	
-- Usa alias para tus tablas

SELECT
	first_name || ' ' || last_name as actor_full_name,
	title,
	inventory_id
FROM
	actor a
INNER JOIN  film_actor fa
	ON a.actor_id = fa.actor_id
INNER JOIN film f
	ON fa.film_id = f.film_id
INNER JOIN inventory I
	ON f.film_id = I.film_id
WHERE 
	first_name = 'Nick' AND last_name='Wahlberg';


-- Uniones
-- Quieres enviar un mail de Feliz navidad tanto clientes como al staff.
-- Realiza una union para obtener los nombres y los corres deseados
-- Obtener nombres y correos electrónicos de clientes

SELECT 	First_name, last_name, email
FROM customer

UNION 

SELECT	First_name, last_name, email
FROM staff;


-- #####################################################################
-- #####################################################################
-- #####################################################################
-- #####################################################################
-- #####################################################################

-- Ejercicios Opcionales
-- ¿Qué ciudades chilenas hay en la base de datos?
-- Realiza un JOIN entre las tablas country y city
-- Selecciona las columnas city y country.
-- Filtra los resultados por pais  = Chile




-- union con agregación

--¿Cuántas películas hay de cada categoría?

-- PASO 1
-- Escribe un query con las category_id y film_id. Para esto debes realizar un JOIN
-- entre film y film_category



-- PASO 2
-- Realiza una agregación para contar las peliculas en cada category_id
-- Ordena el resultado según total de peliculas en orden descendiente


-- Paso 3
-- Averigua el nombre de la categoría que corresponde cada category_id
-- Para esto debes hacer un JOIN con la tabla category








-- Obten nombre y apellido como full_name, el estado (district) y el email
-- de clientes que viven en  California 

-- ¿Qué tablas tienen la información que necesito?
-- ¿Qué atributo relaciona las tablas?
-- ¿Qué tipo de JOIN necesito obtener el resultado deseado?




-- Añade alias a las tablas del quey anterior





