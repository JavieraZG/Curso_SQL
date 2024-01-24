/* 
EVALUACIÓN MÓDULO 3
CORRECIÓN RESPUESTAS MALAS   BY: Javiera Zavala

*/

-- 5. Contabiliza la frecuencia de aparición de cada ciudad en la tabla 'address'. 
-- ¿Cuál es el valor más alto entre las frecuencias obtenidas?  RESP: 2

SELECT
	COUNT(*)
FROM
	address
GROUP BY
	city_id
ORDER BY COUNT(*) DESC;


 
-- 6. ¿Cuántas películas tiene una duración de 85 min?
-- Hint_1: Usa DISTINCT, GROUP BY y HAVING.
-- Hint_2: Utiliza DISTINC(length) como categoria.,   RESP: 17

SELECT
	DISTINCT(length),
	COUNT(*) AS total_peliculas
FROM
	film
WHERE
	length = 85
GROUP BY
	DISTINCT(length);
	
-- 7. Consulta cuáles son los costos de inventario (replacement cost) promedio para cada tipo de tarifa (rental_rate) 
-- y clasificación (rating). Usa solo las clasificaciones R o G. ¿Cuál combinación tiene el mayor el costo de inv promedio?
-- Hint:  Usa DISTINCT para usar rental_rate como una categoría.	 RESP: 0.99-G

SELECT
	DISTINCT(rental_rate, rating),
	ROUND(AVG(replacement_cost),2) AS v_inv_promedio
FROM
	film
GROUP BY
	DISTINCT(rental_rate, rating)
ORDER BY
	v_inv_promedio DESC;



--------------------------------FIN------------------------------------------
	