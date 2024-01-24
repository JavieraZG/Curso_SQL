/*
SQL Nivel Inicial - NivelUp Chile
Módulo 4
Nombre:
*/

-- Ejemplos

-- LOWER UPPER
-- Crea una columa con el nombre de los clientes escrito con
-- letras mayúsculas y otra con letras minúsculas

SELECT
	first_name,
	LOWER(first_name),
	UPPER(first_name)
FROM
	customer;

-- CONCAT ||

-- Explora las columnas first_name y last_name de la tabla customer

SELECT
	first_name,
	last_name
FROM
	customer;

-- Crea una columna llamada full_name con el nombre y el apellido de los clientes

SELECT
	first_name || last_name AS full_name,
	CONCAT(first_name,last_name) AS full_name2
FROM
	customer;


-- Mejora el query anterior para separar nombre de apellido con un espacio

SELECT
	first_name ||' '|| last_name AS full_name,
	CONCAT(first_name,' ',last_name) AS full_name2
FROM
	customer;


-- LEFT / RIGHT
-- Obten los primeros 3 caracteres del nombre de los clientes

SELECT
	first_name,
	LEFT(first_name,3)
FROM
	customer;

-- Obten los 3 últimos caracteres del nombre de los clientes

SELECT
	first_name,
	RIGHT(first_name,3)
FROM
	customer;


-- SUBSTRING
--**SUBSTRING(string, start_position,length)**
--Genera una nueva columna con la tercera letra del nombre de los clientes 

SELECT
	first_name,
	SUBSTRING(first_name,3,1)
FROM
	customer;

--**SUBSTRING(string, start_position)**
-- Crea una columna con los apellidos de los clientes comenzando desde el 4to caracter

SELECT
	last_name,
	SUBSTRING(last_name,4)
FROM
	customer;

-- Ejercicio:

/*
Genera nuevos correos para los miembros de tu staff siguiendo las siguientes
instrucciones: 
Las tres primeras letras del nombre, luego un guión bajo,
luego la Inicial del apellido,  luego otro guión bajo, 
el apellido desde el tercer caracter, y finalmente ‘@xmail.com’
*/

SELECT
	first_name,
	last_name,
	CONCAT(LEFT(first_name,3),'_',LEFT(last_name,1),'_',SUBSTRING(last_name,3),'@xmail.com')
FROM
	staff;

-- Modifica el query anterior para obtener los correos con letras minúsculas

SELECT
	first_name,
	last_name,
	LOWER(CONCAT(LEFT(first_name,3),'_',LEFT(last_name,1),'_',SUBSTRING(last_name,3),'@xmail.com'))
FROM
	staff;

-- CAST

-- Combierte a texto la columna amount de la table payment y añade 
-- un símbolo peso ($) en frente de la columna

SELECT
	amount,
	CONCAT('$',CAST(amount AS VARCHAR)) AS monto
FROM
	payment;


-- LIKE
	--WILDCARD: '%' ó '_'
	
--  '%' = 0 ó multiples caracteres
--	'_' = 1 caracter
--	'__'= 2 caracteres
	
-- Consulta los clientes que su nombre comienza con la letra 'A'

SELECT
	*
FROM
	customer
WHERE
	first_name LIKE 'A%';
	
-- Consulta los clientes que su nombre terminen con la letra 'a'

SELECT
	*
FROM
	customer
WHERE
	first_name LIKE '%a';

-- Consulta los clientes que su nombre comience con ‘A’ y  termine con la letra ‘a’

SELECT
	*
FROM
	customer
WHERE
	first_name LIKE 'A%a';

-- Consulta los clientes que su nombre comience con ‘A’ y 
-- Apellido con letra ‘C’

SELECT
	first_name,
	last_name
FROM
	customer
WHERE
	first_name LIKE 'A%'
	AND
	last_name LIKE 'C%';

	
-- Consulta los nombres que contengan la secuencia 'nce'

SELECT
	first_name	
FROM
	customer
WHERE
	first_name LIKE '%nce%';
		
-- Consulta los nombres que tengan la secuencia
-- 'ere' desde el segundo caracter en adelante

SELECT
	first_name	
FROM
	customer
WHERE
	first_name LIKE '__ere%';
	
-- Consulta los nombres que tengan la secuencia
-- 'ere' desde el tercer carácter en adelante

SELECT
	first_name	
FROM
	customer
WHERE
	first_name LIKE '___ere%';

-- 
-- Consulta los nombres de todos los clientes 
--que no tengan la secuencia 'ere' desde el tercer carácter en adelante


SELECT
	first_name	
FROM
	customer
WHERE
	first_name NOT LIKE '___ere%';



-- Ejercicios

-- Ejercicio 1 
-- ¿Cuántos actores tienen apellidos que comienzan con la letra 'M'?

SELECT
	last_name	
FROM
	actor
WHERE
	last_name LIKE 'M%';

-- ¿Cuántas películas contienen la palabra Truman 
-- en alguna parte de su título?

SELECT
	title
FROM
	film
WHERE
	title ILIKE '%Truman%';

	
-- Ejemplos
-- CASE general (permite crear nuevas columnas)
-- Sintaxis:
CASE
	WHEN condición_1 THEN resultado_1
	WHEN condición_2 THEN resultado_2
	ELSE otro_resultado
END *AS nombre_columna*


/*
CASE general - una condición
Estás planeando enviar un correo electrónico de agradecimiento
a tus clientes que han brindado su apoyo desde el inicio. 
Para llevar a cabo esto, es necesario clasificar a los clientes
según su orden de adquisición. Asigna la clasificación "Premium"
a los primeros 50 clientes (cuyo ID sea de 1 a 50),
la clasificación "Regular"  a todos los demás
Consulta customer_id, email y tipo_cliente
*/

SELECT
	customer_id,
	CASE
		WHEN (customer_id >=1 AND customer_id <=50)THEN 'Premium'
		ELSE 'Regular'
	END AS tipo_cliente
FROM 
	customer;

/*
CASE general - multiples condiciones

Clasifica las películas por su duración según los siguientes criterios:

Si la duración es menos de 50 min, asigna la etiqueta 'Corta'
Si la duración es mayor a 50 min mas de 50 y igual o menos a 120, asigna la etiqueta'Media'
Si la duración es mayor a 120 min, asigna la etiqueta 'Larga'

*/

SELECT
	title,
	length,
	CASE
		WHEN length > 0  AND length <= 50 THEN 'Short'
		WHEN length > 50 AND length <=120 THEN 'Medium'
		ELSE 'Long'
	END duración
FROM 
	film
ORDER BY title;


-- Mismo ejemplo anterior sin uso de ELSE


SELECT
	title,
	length,
	CASE
		WHEN length > 0  AND length <= 50 THEN 'Short'
		WHEN length > 50 AND length <=120 THEN 'Medium'
		--ELSE 'Long'
	END duración
FROM 
	film
ORDER BY title;



/*
Crea una columna con una versión más descriptiva 
para las clasificaciones (rating)


WHEN 'G' THEN 'General Audiences'
WHEN 'PG' THEN 'Parental Guidance Suggested'
WHEN 'PG-13' THEN 'Parents Strongly Cautioned'
WHEN 'R' THEN 'Restricted'
WHEN 'NC-17' THEN 'Adults Only'
*/

SELECT  title,
		rating,
		CASE rating
			WHEN 'G' THEN 'General Audiences'
			WHEN 'PG' THEN 'Parental Guidance Suggested'
			WHEN 'PG-13' THEN 'Parents Strongly Cautioned'
			WHEN 'R' THEN 'Restricted'
			WHEN 'NC-17' THEN 'Adults Only'
			END descricion_rating
FROM film
ORDER BY title;

/*
Ejercios

Ejercicio 3: 3. Añade las siguientes etiquetas a las tarifas:
0.99 => ‘Oferta’
2.99 => ‘Normal’
4.99 => ‘Estreno’

*/

SELECT  title,
		rental_rate,
		CASE rental_rate
			WHEN 0.99 THEN 'Oferta'
			WHEN 2.99 THEN 'Normal'
			WHEN 4.99 THEN 'Estreno'
		END tipo_tarifas
FROM film;

	
-- CASE Y FUNCIONES AGREGADAS

-- PASO 1
-- Asigna el número uno a las peliculas con rental_rate 0.99.
-- Consulta las columnas rental_rate y la nueva columna.

SELECT  
	rental_rate,
	CASE rental_rate
		WHEN 0.99 THEN 1
		ELSE 0
	END oferta
FROM film;


-- PASO 2: 
-- Elimina la columna rental_rate del query anterior .
-- Aplica la función de agregación SUM() sobre la columna oferta 

SELECT  
	SUM(CASE rental_rate
			WHEN 0.99 THEN 1
			ELSE 0
		END) AS total_oferta
FROM film;

-- PASO 3: Repite la misma agregación SUM() para las otras tarifas
-- para obtener cuántas películas hay de cada una de estas tarifas?


SELECT  
	SUM(CASE rental_rate
			WHEN 0.99 THEN 1
			ELSE 0
		END) AS total_oferta,
	
	SUM(CASE rental_rate
			WHEN 2.99 THEN 1
			ELSE 0
		END) AS total_normal,
	
	SUM(CASE rental_rate
			WHEN 4.99 THEN 1
			ELSE 0
		END) AS total_estreno
FROM film;
	

-- GROUP BY ¿Cuántas películas hay de cada una de estas tarifas?

SELECT  
	DISTINCT(rental_rate),
	COUNT(*)
FROM film
GROUP BY DISTINCT(rental_rate);

/*
CASE
La rentabilidad de las películas depende de el tipo de tarifa
Oferta  15 %
Normal 20%
Estreno 40%
Calcula la ganacia (profit) si rentaras al menos una vez el total del inventario
*/

SELECT  
	SUM(CASE rental_rate
			WHEN 0.99 THEN 0.99 * 1.15
			ELSE 0
		END) AS total_oferta,
	
	SUM(CASE rental_rate
			WHEN 2.99 THEN 2.99 * 1.2
			ELSE 0
		END) AS total_normal,
	
	SUM(CASE rental_rate
			WHEN 4.99 THEN 4.99 * 1.4
			ELSE 0
		END) AS total_estreno
FROM film;

/*
Ejercicio 
Usa CASE para calcular cuántas peliculas hay de las clasificación 
(rating) 'G', 'PG' y 'R'

*/

SELECT  
	SUM(CASE rating
			WHEN 'G' THEN 1
			ELSE 0
		END) AS total_G,
	
	SUM(CASE rating
			WHEN 'PG' THEN 1
			ELSE 0
		END) AS total_PG,
	
	SUM(CASE rating
			WHEN 'R' THEN 1
			ELSE 0
		END) AS total_R
FROM film;


-- CASE y GROUP BY


SELECT  
	rental_rate,
	SUM(CASE rating
			WHEN 'G' THEN 1
			ELSE 0
		END) AS total_G,
	
	SUM(CASE rating
			WHEN 'PG' THEN 1
			ELSE 0
		END) AS total_PG,
	
	SUM(CASE rating
			WHEN 'R' THEN 1
			ELSE 0
		END) AS total_R
FROM film
GROUP BY rental_rate;





