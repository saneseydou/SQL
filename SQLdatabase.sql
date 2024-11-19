
/*3-----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Display in descending order of seniority the male employees whose net salary (salary + commission) is greater than or equal to 8000. -----------------------*/
/* The resulting table should include the following columns: Employee Number, First Name and Last Name (using LPAD or RPAD for formatting), Age, and Seniority.*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/



SELECT 
		EMPLOYEE_NUMBER, 
		FIRST_NAME, 
		LAST_NAME, 
		DATEDIFF(year, BIRTH_DATE, GETDATE()) as AGE, 
		HIRE_DATE
FROM EMPLOYEES
WHERE SALARY + ISNULL(COMMISSION, 0) >= 8000
ORDER BY HIRE_DATE ASC;



/*4 ----------------------------------------------------------------------------------------------------------------------------------------------------------- */
/* Display products that meet the following criteria: (C1) quantity is packaged in bottle(s), (C2) the third character in the product name is 't' or 'T', (C3)*/
/* supplied by suppliers 1, 2, or 3, (C4) unit price ranges between 70 and 200, and (C5) units ordered are specified (not null). The resulting table should  */
/* include the following columns: product number, product name, supplier number, units ordered, and unit price.												*/
/*---------------------------------------------------------------------------------------------------------------------------------------------------------*/

SELECT 
		PRODUCT_REF, 
		PRODUCT_NAME, 
		SUPPLIER_NUMBER, 
		UNITS_ON_ORDER, 
		UNIT_PRICE
FROM PRODUCTS
WHERE 
	(QUANTITY LIKE '%bottle%')
	AND
	(PRODUCT_NAME LIKE '__t%' OR PRODUCT_NAME LIKE '__T%')
	AND
	(SUPPLIER_NUMBER LIKE '1' OR SUPPLIER_NUMBER LIKE '2' OR SUPPLIER_NUMBER LIKE '3')
	AND
	(UNIT_PRICE BETWEEN 70 and 200) 
	AND
	UNITS_ON_ORDER	<> NULL;
GO

/*5 ------------------------------------------------------------------------------------------------------------------------ */
/* Display customers who reside in the same region as supplier 1, meaning they share the same country, city, and the last three digits */
/* of the postal code. The query should utilize a single subquery. The resulting table should include all columns from the customer table. */                                */
/*-----------------------------------------------------------------------------------------------------------------------------------------*/

SELECT *  FROM CUSTOMERS
WHERE COUNTRY= (select COUNTRY from SUPPLIERS
									WHERE SUPPLIER_NUMBER=1)
	AND
	CITY= (select CITY from SUPPLIERS
									WHERE SUPPLIER_NUMBER=1)
	AND
	RIGHT(POSTAL_CODE, 3)= (select RIGHT(POSTAL_CODE, 3)
									from SUPPLIERS
									WHERE SUPPLIER_NUMBER=1);
GO
									
/* 6--------------------------------------------------------------------------------------------------------------------------------------------------- */
/*	For each order number between 10998 and 11003, do the following:																					*/
/*	-Display the new discount rate, which should be 0% if the total order amount before discount (unit price * quantity) is between 0 and 2000,			*/
/*	5% if between 2001 and 10000, 10% if between 10001 and 40000, 15% if between 40001 and 80000, and 20% otherwise.									*/
/*	Display the message "apply old discount rate" if the order number is between 10000 and 10999, and "apply new discount rate" otherwise.				*/
/*	The resulting table should display the columns: order number, new discount rate, and discount rate application note.								*/
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/


SELECT * , 
		CASE
			WHEN QUANTITY*UNIT_PRICE BETWEEN 0 and 2000 then 0 
			WHEN QUANTITY*UNIT_PRICE BETWEEN 2001 and 10000 then 0.05
			WHEN QUANTITY*UNIT_PRICE BETWEEN 10001 AND 40000 THEN 0.1
			WHEN QUANTITY*UNIT_PRICE BETWEEN 40001 AND 80000 THEN 0.15
			END as NEW_DISCOUNT 
FROM ORDER_DETAILS
where ORDER_NUMBER between 10998 AND 11003;
GO


SELECT *, 
		CASE 
		WHEN ORDER_NUMBER BETWEEN 10000 AND 10999 then 'OLD_DISCOUNT'
		ELSE 'NEW_DISCOUNT' 
		END AS DISCOUNT 
		FROM ORDER_DETAILS;
GO

/*7 ----------------------------------------------------------------------------------------------------------------------------------------------------- */
/*	Display suppliers of beverage products. The resulting table should display the columns: supplier number, company, address, and phone number.		*/
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/

SELECT SUPPLIERS.SUPPLIER_NUMBER, SUPPLIERS.COMPANY, SUPPLIERS.ADDRESS, SUPPLIERS.PHONE  
		FROM SUPPLIERS
						JOIN PRODUCTS ON SUPPLIERS.SUPPLIER_NUMBER = PRODUCTS.SUPPLIER_NUMBER
		WHERE PRODUCTS.CATEGORY_CODE = '1';
GO

/*8 -----------------------------------------------------------------------------------------------------------------------------------------------------*/
/*Display customers from Berlin who have ordered at most 1 (0 or 1) dessert product. The resulting table should display the column: customer code.     */
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/

SELECT CUSTOMERS.CUSTOMER_CODE, CUSTOMERS.CITY
		FROM CUSTOMERS
			JOIN ORDERS ON CUSTOMERS.CUSTOMER_CODE = ORDERS.CUSTOMER_CODE
			JOIN ORDER_DETAILS ON ORDERS.ORDER_NUMBER = ORDER_DETAILS.ORDER_NUMBER
			JOIN PRODUCTS ON PRODUCTS.PRODUCT_REF = ORDER_DETAILS.PRODUCT_REF
		WHERE CUSTOMERS.CITY = 'Berlin' 
			AND ORDER_DETAILS.QUANTITY <= 1
			AND PRODUCTS.CATEGORY_CODE = 3 ; 

GO



/*09------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Display customers who reside in France and the total amount of orders they placed every Monday in April 1998 --------------------------------------*/
/* (considering customers who haven't placed any orders yet). The resulting table should display the columns: customer number,--------------------------*/
/* company name, phone number, total amount, and country.-----------------------------------------------------------------------------------------*/  
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/

SELECT 
    CUSTOMERS.CUSTOMER_CODE, 
    CUSTOMERS.COMPANY, 
    CUSTOMERS.PHONE, 
    (ORDER_DETAILS.QUANTITY * ORDER_DETAILS.UNIT_PRICE) AS TOTAL_AMOUNT,
	CUSTOMERS.COUNTRY
		FROM 
			CUSTOMERS

		JOIN ORDERS ON CUSTOMERS.CUSTOMER_CODE = ORDERS.CUSTOMER_CODE
		JOIN ORDER_DETAILS ON ORDERS.ORDER_NUMBER = ORDER_DETAILS.ORDER_NUMBER
		JOIN PRODUCTS ON ORDER_DETAILS.PRODUCT_REF = PRODUCTS.PRODUCT_REF
		WHERE 
				DATENAME(WEEKDAY, ORDERS.ORDER_DATE) = 'Monday'
				AND ORDERS.ORDER_DATE BETWEEN '1998-04-01' AND '1998-04-30'
				AND CUSTOMERS.COUNTRY LIKE '%FRANCE%';
GO


/*--------------------------------------------------------------------------------------------------------------------------*/
/*Display customers who have ordered all products. The resulting table should display the columns:  -----------------------*/
/*customer code, company name, and telephone number.----------------------------------------------------------------------*/	
/*-----------------------------------------------------------------------------------------------------------------------*/






