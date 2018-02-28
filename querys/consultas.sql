--QUERYS

---------------------------------------------------------------------------------
--1. Porcentajes de préstamos completados y préstamos no completados
--   segmentados por genero y año
---------------------------------------------------------------------------------

SELECT ROUND(Q.NUMERO * 50/Q.TOTAL,3)||'%' PROMEDIO, 
Q.GENERO, 
Q.COMPLETADO,
Q.AÑO ,
Q.TOTAL, NUMERO

FROM 
	(SELECT COUNT(LN.IS_COMPLETE)                                 NUMERO,
		    DECODE(IS_COMPLETE, '1','COMPLETADO','NO COMPLETADO') COMPLETADO ,
			CU.GENDER   										  GENERO,
		    TO_CHAR(LN.CREATED_DATE, 'YYYY')                      "AÑO",
		   (
		    SELECT COUNT(LN1.IS_COMPLETE)                         TOTAL 
			FROM   LOANS.LOAN LN1
			INNER  JOIN  LOANS.CUSTOMER CU1
			ON     CU1.ID = LN1.CUSTOMER_ID
			WHERE 1=1
			AND TO_CHAR(LN1.CREATED_DATE, 'YYYY')= TO_CHAR(LN.CREATED_DATE, 'YYYY')

		) TOTAL 
		FROM LOANS.LOAN LN
		INNER JOIN  LOANS.CUSTOMER CU
		ON CU.ID= LN.CUSTOMER_ID

		GROUP BY GENDER,IS_COMPLETE,TO_CHAR(LN.CREATED_DATE, 'YYYY')
		ORDER BY TO_CHAR(LN.CREATED_DATE, 'YYYY')

) Q

/*
--Resultado

PROMEDIO	GENERO		COMPLETADO		AÑO		NUMERO
10%	    		Female	NO COMPLETADO	2016	33
14.242%			Male	NO COMPLETADO	2016	47
11.515%			Male	COMPLETADO	    2016	38
14.242%			Female	COMPLETADO		2016	47
11.724%			Female	COMPLETADO		2017	102
10.575%			Female	NO COMPLETADO	2017	92
13.908%			Male	COMPLETADO		2017	121
13.793%			Male	NO COMPLETADO	2017	120
*/

---------------------------------------------------------------------------------
--2. El préstamo más alto que se haya dado segmentado por mes junto con el
--   promedio que se prestó durante el año 2017
---------------------------------------------------------------------------------

SELECT      Q.MES,
			(SELECT  L.ID LOAN
			  FROM LOANS.LOAN L
			  WHERE L.AMOUNT= Q.AMOUNT
			) LOAN,
			Q.AMOUNT,
			Q.AVERAGE_AMOUNT

FROM 
	(   SELECT  TO_CHAR(TO_DATE(TO_CHAR(TO_CHAR(LOAN.CREATED_DATE, 'MM')),'MM'),
	    'MONTH','NLS_DATE_LANGUAGE = SPANISH') MES,

		MAX(LOAN.AMOUNT) AMOUNT,

		ROUND(AVG(AMOUNT),2 )AVERAGE_AMOUNT
		FROM LOANS.LOAN
		WHERE  TO_CHAR(LOAN.CREATED_DATE, 'YYYY')= 2017
		GROUP BY TO_CHAR(TO_DATE(TO_CHAR(TO_CHAR(LOAN.CREATED_DATE, 'MM')),'MM'),
		'MONTH','NLS_DATE_LANGUAGE = SPANISH'),
		
		TO_CHAR(LOAN.CREATED_DATE, 'MM'),
		TO_CHAR(LOAN.CREATED_DATE, 'YYYY')

		ORDER BY  TO_CHAR(LOAN.CREATED_DATE, 'MM'),
		TO_CHAR(LOAN.CREATED_DATE, 'YYYY') 

	)Q
	
/*	
--Resultado	
MES			LOAN	    AMOUNT	    AVERAGE_AMOUNT
ENERO     	495			997922.97	470816.06
FEBRERO   	450			949094.59	524137.51
MARZO     	377			984409.11	441701.59
ABRIL     	102			993027		512517.05
MAYO      	507			995235.84	580349.38
JUNIO     	113			946430.97	478705.87
JULIO     	478			980800.09	523147.89
AGOSTO    	176			996049		503401.18
SEPTIEMBRE	203			958800.58	463438.24
OCTUBRE   	43			745040.78	672875.92
*/

---------------------------------------------------------------------------------
--3.Los nombres, edad, y número de préstamo de aquellos clientes que hayan
--pagado más de la cantidad que se les haya prestado inicialmente.
---------------------------------------------------------------------------------
SELECT
 
   LN1.ID NUMERO_PRESTAMO,
   CU1.FIRST_NAME
    || ' '
    || CU1.LAST_NAME NOMBRE,
   TO_CHAR(SYSDATE,'YYYY')- TO_CHAR( CU1.DATE_OF_BIRTH, 'YYYY') EDAD,
   LN1.AMOUNT PRESTAMO_CANTIDAD,
   PM.PAGO    PAGO_CANTIDAD
  
FROM LOANS.CUSTOMER CU1
    
    INNER JOIN LOANS.LOAN LN1  ON CU1.ID = LN1.CUSTOMER_ID
	
    INNER JOIN  (SELECT  SUM(PM1.AMOUNT)  PAGO,
                         MAX(PM1.LOAN_ID) LOAN
                 FROM LOANS.PAYMENT PM1
                 GROUP BY PM1.LOAN_ID
                ) PM           ON PM.LOAN = LN1.ID
    
    
WHERE LN1.AMOUNT >PM. PAGO;


/*
--Este resultado es el top 12, ejecuta el query para descubrir completamente el resultado
	
NUMERO_PRESTAMO	NOMBRE			    	EDAD	PRESTAMO_CANTIDAD	PAGO_CANTIDAD
56				Jock Spiers	        	31				409414.32	15463.16
253				Boycey Nears	    	48				118140.33	104420.91
316				Saunders O'Moylan		36				38906.54	16065.86
280				Berne De Blasiis		32				818412.89	1916.55
560				Megen Dockrell	    	42				60849.58	44500.32
409				Megen Dockrell	    	42				445965.86	10265.16
311				Megen Dockrell	    	42				937221.33	71905.62
518				Beauregard Caudelier	32				741043.76	20612.24
498				Doralynne Cuckson		34				357872.14	72432.64
347				Doralynne Cuckson		34				131823.88	500.9
471				Martica Heliot	    	49				376704.34	2650.21
102				Emelyne Slowgrave		39				993027	    77274.75
*/			





---------------------------------------------------------------------------------
--4.Los números de préstamos cuyos pagos tengan un payment_number duplicado.
---------------------------------------------------------------------------------

SELECT  LN.ID                    NUMERO_PRESTAMO,  
        COUNT(PY.PAYMENT_NUMBER) OCURRENCIAS,
        PAYMENT_NUMBER           NUMERO_REPETIDO 
FROM    LOANS.LOAN LN
INNER   JOIN LOANS.PAYMENT PY
ON PY.LOAN_ID = LN.ID
GROUP BY LN.ID, PAYMENT_NUMBER
HAVING COUNT(PAYMENT_NUMBER)>1
;

/*
--Resultado
NUMERO_PRESTAMO	OCURRENCIAS	NUMERO_REPETIDO
476					3				4
340					2				1
462					3				2
372					2				2
505					2				4
498					2				1
389					2				2
130					2				1
302					2				1
591					2				2
501					2				2
511					2				2
218					2				2
319					2				2
282					2				1
564					2				2
253					2				2
*/

---------------------------------------------------------------------------------
--5.La cantidad de préstamos de cada mes, agrupados por tipo. 
---------------------------------------------------------------------------------
SELECT
Q.*, 
"'AUTO'"+ "'MORTGAGE'"+ "'REVOLVING'"+ "'INSTALLMENTS'" TOTAL
FROM 
	(SELECT * FROM ( SELECT * FROM ( SELECT TO_CHAR(LN.CREATED_DATE, 'YYYYMM') FECHA,
										   LT.TYPE                             TIPO
									 FROM  LOANS.LOAN LN
									 INNER JOIN LOANS.LOAN_TYPE LT
									 ON LT.ID = LN.TYPE_ID
									) 
					)
	PIVOT 
		(
		   COUNT(TIPO)
		   FOR TIPO IN ('AUTO','MORTGAGE','REVOLVING','INSTALLMENTS')
		   
		)

	) Q
	
/*	
--Resultado
FECHA	'AUTO'	'MORTGAGE'	'REVOLVING'	'INSTALLMENTS'	TOTAL
201610	16			15			15				20		 66
201611	9			12			10				13		 44
201612	13			14			13				15		 55
201701	15			11			9				24		 59
201702	8			7			7				8		 30
201703	13			11			9				17		 50
201704	15			11			13				15		 54
201705	9			11			12				16		 48
201706	13			16			9				14		 52
201707	13			7			24				9		 53
201708	9			11			10				9		 39
201709	12			8			17				10		 47
201710	1			0			2				0		 3
*/
	
---------------------------------------------------------------------------------
--6.Obtener un reporte de aquellos pagos cuyo payment_number no fue asignado
--  correctamente (los números de los pagos deben comenzar en 1 y ser
--  consecutivos) 
---------------------------------------------------------------------------------




SELECT  IDACTUAL NUMERO_PAGO 

FROM (
        SELECT * FROM (
						SELECT (SELECT MIN(ID) DATO FROM LOANS.PAYMENT WHERE LOAN_ID= P.MINIMOLOAN) IDMENOR,
						       (SELECT MIN(PAYMENT_NUMBER) DATO FROM LOANS.PAYMENT WHERE LOAN_ID= P.MINIMOLOAN) PAGOMENOR,
						 
  					    P.*

						FROM (SELECT  ID IDACTUAL, MIN (PAYMENT_NUMBER) MINIMOPAY, MIN (LOAN_ID) MINIMOLOAN FROM LOANS.PAYMENT
						      GROUP BY ID, PAYMENT_NUMBER
						      ORDER BY ID
							  ) P

						WHERE MINIMOPAY>1


                      )

         WHERE  IDACTUAL=IDMENOR
    )
/*
--Este resultado contiene el top 10,ejecuta el query para ver el resultado completo
NUMERO_PAGO
4
13
17
24
25
26
28
30
32
*/

---------------------------------------------------------------------------------
--7. Obtener un reporte de aquellos préstamos que incorrectamente han sido
--   marcados como completados o no completos. Así como la cantidad sobrante o
--   faltante según sea el caso.
---------------------------------------------------------------------------------

SELECT 	Q.NUMERO_PRESTAMO,
		Q.PRESTAMO_CANTIDAD,
		Q.PAGO_CANTIDAD,
		DECODE(Q.IS_COMPLETE, 1,'ABIERTO', 'CERRADO') STATUS,
		Q.DIFERENCIA,

		CASE
			WHEN VALIDACION=1
				 THEN 'SOBRA '|| TO_CHAR(DIFERENCIA * -1)
			WHEN VALIDACION=0 
				 THEN 'FALTA '|| TO_CHAR(DIFERENCIA )
		END BANDERA  

FROM 

   (

		SELECT     LN1.ID     			NUMERO_PRESTAMO,
		           LN1.AMOUNT 			PRESTAMO_CANTIDAD,
		           PM.PAGO    			PAGO_CANTIDAD,
		           LN1.IS_COMPLETE,
		           LN1.AMOUNT - PM.PAGO  DIFERENCIA,
		   
				   CASE WHEN LN1.AMOUNT - PM.PAGO <0 
						     THEN 1--'SE PAGO COMPLETAMENTE'
					    WHEN LN1.AMOUNT - PM.PAGO >=0
						    THEN 0--'AUN FATA POR PAGAR'
					END VALIDACION
					
		FROM LOANS.LOAN  LN1
		INNER JOIN     (SELECT  SUM(PM1.AMOUNT)   PAGO,
								 MAX(PM1.LOAN_ID) LOAN
						 FROM LOANS.PAYMENT PM1
						 GROUP BY PM1.LOAN_ID
						) PM   ON PM.LOAN = LN1.ID
						
    )Q
WHERE
Q.VALIDACION <> Q.IS_COMPLETE



/*
El resultado incluye el top 10, si deseas ver el resultado completo ejecuta la consulta

NUMERO_PRESTAMO		PRESTAMO_CANTIDAD	PAGO_CANTIDAD	STATUS		DIFERENCIA	BANDERA
218						2047.89			100373.14		CERRADO		-98325.25	SOBRA 98325.25
229						44427.69		104127.67		CERRADO		-59699.98	SOBRA 59699.98
442						11605.89		60711.4			CERRADO		-49105.51	SOBRA 49105.51
240						23987.01		49620.58		CERRADO		-25633.57	SOBRA 25633.57
592						52297.28		72101.12		CERRADO		-19803.84	SOBRA 19803.84
505						86619.53		101803.81		CERRADO		-15184.28	SOBRA 15184.28
507						995235.84		11272.42		ABIERTO		983963.42	FALTA 983963.42
375						977389.73		2168.8			ABIERTO		975220.93	FALTA 975220.93
291						958646.88		6232.35			ABIERTO		952414.53	FALTA 952414.53
*/












---------------------------------------------------------------------------------
--8. Generar un procedure que corrija la información obtenida en los puntos
--   anteriores 
---------------------------------------------------------------------------------








--B) PARA EL INSISO B NO ENCONTRE NECESIDAD DE CREAR UN STORED PROCEDURE
--   YA QUE PUEDO APOYARME DE LA INSTRUCCION MERGE Y EN OTROS LENGUAJES
--   SQL DEL UPDATE 
MERGE INTO loans.loan2   b
USING (
   
			   
			   SELECT 	Q.NUMERO_PRESTAMO,
					Q.PRESTAMO_CANTIDAD,
					Q.PAGO_CANTIDAD,
					DECODE(Q.IS_COMPLETE, 0,'ABIERTO', 'CERRADO') STATUS,
					Q.DIFERENCIA,

					CASE
						WHEN VALIDACION=1
							 THEN 'SOBRA '|| TO_CHAR(DIFERENCIA * -1)
						WHEN VALIDACION=0 
							 THEN 'FALTA '|| TO_CHAR(DIFERENCIA )
					END BANDERA ,
					CASE
						WHEN VALIDACION=1
							 THEN 1
						WHEN VALIDACION=0 
							 THEN 0
					END BANDERA2, IS_COMPLETE 

			FROM 

			   (

					SELECT     LN1.ID     			NUMERO_PRESTAMO,
							   LN1.AMOUNT 			PRESTAMO_CANTIDAD,
							   PM.PAGO    			PAGO_CANTIDAD,
							   LN1.IS_COMPLETE,
							   LN1.AMOUNT - PM.PAGO  DIFERENCIA,
					   
							   CASE WHEN LN1.AMOUNT - PM.PAGO <0 
										 THEN 1--'SE PAGO COMPLETAMENTE'
									WHEN LN1.AMOUNT - PM.PAGO >=0
										THEN 0--'AUN FATA POR PAGAR'
								END VALIDACION
								
					FROM LOANS.LOAN  LN1
					INNER JOIN     (SELECT  SUM(PM1.AMOUNT)   PAGO,
											 MAX(PM1.LOAN_ID) LOAN
									 FROM LOANS.PAYMENT PM1
									 GROUP BY PM1.LOAN_ID
									) PM   ON PM.LOAN = LN1.ID
									
				)Q
			WHERE
			Q.VALIDACION <> Q.IS_COMPLETE
			   
   
   ) e
ON (b.ID = e.NUMERO_PRESTAMO)
WHEN MATCHED THEN
  UPDATE SET b.IS_COMPLETE = e.bandera2;
 