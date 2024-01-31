/*
EVALUACIÓN 4
CORRECCION RESPUESTAS ERRÓNEAS
Nombre: Javiera Zavala
*/

-- Pregunta 1
-- ¿Qué string obtendrias al aplicar la siguiente función?
-- SUBSTRING ('sql nivel inicial', 7, 13)

-- RESPUESTA: 'VEL INI'


--Pregunta 3
-- Marca los enunciados correctos respecto al string 'para la vida'

-- RESPUESTA: 
-- SUBSTRING(''para la vida', 9, 4) => 'vida'
-- LEFT(''para la vida', 4) => 'para'
-- RIGHT(''para la vida', 4) => 'vida'
-- SUBSTRING(''para la vida', 9) => 'vida'

--Pregunta 8
/*Crea direcciones de email para los clientes
Requisitos

Usa los 3 primeros caractéres del first_name, luego el símbolo punto', luego la inicial del apellido, luego símbolo punto, luego el resto de caractéres del apellido  
y finalmente concatena el string '@xmail.com'

¿Cuál es el correo del cliente correpondiente al customer_id = 453?
*/

-- RESPUESTA: "cal.m.artel@xmail.com"

SELECT
	customer_id,
	first_name,
	last_name,
	LEFT(first_name,3) || '.' || LEFT (last_name,1) ||'.'|| SUBSTRING(last_name,2) || '@xmail.com'
FROM
	CUSTOMER
WHERE
	customer_id = 453;



--------------------------------- FIN ----------------------------------------

