/*
SQL Nivel Inicial - NivelUp Chile
Ejemplos y ejercicios Módulo 6
Nombre: Javiera Zavala
*/



-- #######
-- BETWEEN
-- #######

-- Necesitas conocer los montos pagados para los payment_id que estan entre
-- 17600 y 17620. Usa operadores lógicos

SELECT
	payment_id,
	amount
FROM
	payment
WHERE
	payment_id >=17600
	AND
	payment_id <=17620;


-- Necesitas conocer los montos pagados para los payment_id que estan entre
-- 17600 y 17620. Usa BETWEEN

SELECT
	payment_id,
	amount
FROM
	payment
WHERE
	payment_id BETWEEN 17600 AND 17620;
  
-- Puedes excluir los payment ID entre 17600 y 17620 usando NOT BETWEEN  {{ES EXCLUSIVO, excluye los limites}}

SELECT
	payment_id,
	amount
FROM
	payment
WHERE
	payment_id NOT BETWEEN 17600 AND 17620
GROUP BY payment_id;
  
 

-- Puedes usar BETWEEN para filtrar un rango de fechas.
-- Explora la rental_date de la tabla rental para ver cuáles son es el rango de fechas

SELECT
	MAX (rental_date),
	MIN (rental_date)
FROM
	rental;

-- Obten los rental_id y rental_date del día 05 de Julio del 2005.
-- Ordena el resultado según rental_date DESC
-- '2005-07-05'
-- '2005-07-06'
-- 

SELECT
	rental_date
FROM
	rental
WHERE
	rental_date >'2005-07-05' AND rental_date < '2005-07-06'
ORDER BY
	rental_date DESC;


-- Usa between para obtener el mismo resultado del query anterior


SELECT
	rental_date
FROM
	rental
WHERE
	rental_date BETWEEN '2005-07-05' AND '2005-07-06';


-- ########
-- CURRENT_DATE
-- ########

-- Explora la tabla payment


SELECT
	payment_date
FROM PAYMENT;

-- Usa CURRENT_DATE para agregar 

SELECT
	payment_date,
	CURRENT_DATE
FROM PAYMENT;


-- ########
-- DATE_PART 
-- EXTRACT
-- ########


-- Crea una columna con el año en el que se relizaron los pagos de la tabla payment.

SELECT
	payment_date,
	EXTRACT (YEAR FROM payment_date),
	DATE_PART('YEAR', payment_Date)
FROM PAYMENT;

-- Usa DISTINCT para averiguar cuantos años diferentes hay en esa columna

SELECT
	DISTINCT(EXTRACT (YEAR FROM payment_date))
FROM PAYMENT;


-- Consulta la fecha y el trimestre en el que se realizaron los pagos.
-- Usa payment_date de la tabla payment.

SELECT
	payment_date,
	DATE_PART ('QUARTER', payment_date) AS Trimestre
FROM PAYMENT;

-- Ejercicio


-- Crea un query para obtener payment_date  y el mes en que realizó el pago.

SELECT
	DISTINCT(DATE_PART ('MONTH', payment_date))
FROM PAYMENT;


-- Ejercios
-- ¿Cuánto dinero fue recaudado en cada mes?

SELECT
	DISTINCT(DATE_PART ('MONTH', payment_date)),
	SUM(amount)
FROM PAYMENT
GROUP BY 
	DISTINCT(DATE_PART ('MONTH', payment_date));


select 
extract(month from payment_date) as mes, 
sum(amount) as total 
from payment 
group by mes
	
/*
Quieres evaluar la performace del staff entonces necesitas saber cuántos 
pagos recibió  cada miembro del equipo por mes.
Consulta el mes, staff_id y la cantidad de pagos procesados 
Ordena la información por mes.

*/


SELECT
	DISTINCT (DATE_PART ('MONTH', payment_date)) AS Mes,
	staff_id,
	count(payment_id)
FROM payment
GROUP BY
	DISTINCT (DATE_PART ('MONTH', payment_date)),
	staff_id
ORDER BY
	Mes;
	
-- Añade una columna con el nombre del miembro del staff en el query anterior

SELECT
	DISTINCT (DATE_PART ('MONTH', payment_date)) AS Mes,
	payment.staff_id,
	CONCAT(first_name, ' ' , last_name),
	COUNT (*)
FROM payment
JOIN staff
	ON staff.staff_id = payment.staff_id	
GROUP BY
	DISTINCT (DATE_PART ('MONTH', payment_date)),
	payment.staff_id,
	CONCAT(first_name, ' ' , last_name)
ORDER BY
	Mes;


-- ######
-- AGE
-- ######

-- Usa AGE()  para calcular cuanto tiempo ha pasado entre una fecha y ahora.
-- Ahora es relativo al momento en que se realiza el query.

SELECT AGE(payment_date)
FROM	payment;

-- AGE entre dos fechas
-- Calcula el tiempo que trascurre entre que la renta (rental_date) 
-- y la revolución (return_id) para cada cada rental_id

SELECT
	rental_date,
	return_date,
	AGE(return_date,rental_date) AS dias_prestamo
FROM	rental;

-- Orderna el query anterior en orden descendiente

SELECT
	rental_date,
	return_date,
	AGE(return_date,rental_date) AS dias_prestamo
FROM	rental
ORDER BY dias_prestamo DESC;

-- Elimina los valores nulos

SELECT
	rental_date,
	return_date,
	AGE(return_date,rental_date) AS dias_prestamo
FROM	rental
WHERE return_date IS NOT NULL
ORDER BY dias_prestamo DESC;


-- ##########
-- DATE_PART
-- DATEDIFF
-- ##########



-- Hay sospechas de que algunos clientes tardan mucho en pagar o simplemente no pagan

-- Revisemos primero el rental_date y el payment_date 
-- Realiza un LEFT JOIN entre la tabla rental (L) y la tabla payment_date

SELECT
	rental_date,
	payment_date
FROM	
	payment
LEFT JOIN rental
	ON payment.rental_id = rental.rental_id;

	
	
-- Consulta si la columna payment_id tiene valores nulos
	
SELECT
	rental_date,
	payment_date,
	AGE(payment_date, rental_date)
FROM	
	rental
LEFT JOIN payment
	ON payment.rental_id = rental.rental_id
WHERE
	payment_date IS NULL;


-- Añade una columna para calcular el tiempo entre la renta y el pago. Usa AGE()
-- y filtra para obtener solo las rentas que si fueron pagadas

SELECT
	rental_date,
	payment_date,
	AGE(payment_date, rental_date)
FROM	
	rental
LEFT JOIN payment
	ON payment.rental_id = rental.rental_id
WHERE
	payment_date IS NOT NULL;


-- Crea una columna para obtener los meses totales entre la renta y el pago


SELECT
	rental_date,
	payment_date,
	AGE(payment_date, rental_date),
	DATE_PART('YEAR',age(payment_date, rental_date)) * 12 +
	DATE_PART('MONTH',age(payment_date, rental_date)) AS meses_transcurridos
FROM	
	rental
LEFT JOIN payment
	ON payment.rental_id = rental.rental_id
WHERE
	payment_date IS NOT NULL;




	
/* DATEDIFF es una formula exclusiva de sql server 

SELECT 
    rental_date,
    payment_date,
    DATEDIFF(DAY, rental_date, payment_date) AS dias_transcurridos
FROM 
    rental 
LEFT JOIN 
    payment ON rental.rental_id = payment.rental_id
WHERE 
    payment_date IS NOT NULL;

*/

-- ##
-- ##



-- TO CHAR()

SELECT 
    rental_date,
    TO_CHAR(rental_date, 'DD-Mon-YYYY') AS fecha_formateada
FROM 
    rental
LIMIT 5; 

/* in SQL server 

SELECT 
    rental_date,
    FORMAT(rental_date, 'dd-MMM-yy') AS fecha_formateada
FROM 
    rental
TOP 5; 


*/


