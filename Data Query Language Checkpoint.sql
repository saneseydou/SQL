CREATE TABLE PRODUCT_TYPES(
PRODUCT_TYPES_ID int,
PRODUCT_TYPES_NAME VARCHAR(100) PRIMARY KEY,

);

CREATE TABLE PRODUCTS(
PRODUCT_ID int PRIMARY KEY,
PRODUCT_NAME VARCHAR(100) NOT NULL,
PRODUCT_TYPE_NAME VARCHAR(100) 
FOREIGN KEY (PRODUCT_TYPE_NAME) REFERENCES PRODUCT_TYPES(PRODUCT_TYPES_NAME),
PRODUCT_PRICE INT not null,
);


CREATE TABLE CUSTOMERS(
CUSTOMER_ID int PRIMARY KEY, 
CUSTOMER_NAME varchar(100) not null,
EMAIL varchar(200) not null,
PHONE varchar(250) not null,
);

CREATE TABLE ORDERS(
ORDER_ID INT PRIMARY KEY,
CUSTOMER_ID int 
FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID),
ORDER_DATE DATE
);

CREATE TABLE ORDER_DETAILS(
ORDER_DETAILS_ID int,
ORDER_ID int 
FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID),
PRODUCT_ID INT
FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS(PRODUCT_ID),
QUANTITY int
);

/* CREATING THE ROWS OF PRODUCT_TYPES TABLE -------------------------------------*/ 

INSERT INTO PRODUCT_TYPES VALUES ( 1, 'Widget');
INSERT INTO PRODUCT_TYPES VALUES (2, 'Gadget');
INSERT INTO PRODUCT_TYPES VALUES (3, 'Doohickey');

/* CREATING THE ROWS OF PRODUCTS TABLE -------------------------------------*/ 

INSERT INTO PRODUCTS VALUES (1, 'Widget A', 'Widget', 10.00);
INSERT INTO PRODUCTS VALUES (2, 'Widget B', 'Widget', 15.00); 
INSERT INTO PRODUCTS VALUES (3, 'Gadget X', 'Gadget', 20.00);
INSERT INTO PRODUCTS VALUES (4, 'Gadget Y', 'Gadget', 25.00);
INSERT INTO PRODUCTS VALUES (5, 'Doohickey Z', 'Doohickey', 30.00);

/* CREATING THE ROWS OF CUSTOMERS TABLE -------------------------------------*/ 


INSERT INTO CUSTOMERS VALUES (1, 'John Smith', 'john@example.com', '123-456-7890');
INSERT INTO CUSTOMERS VALUES (2, 'Jane Doe', 'jane.doe@example.com', '987-654-3210');
INSERT INTO CUSTOMERS VALUES ( 3, 'Alice Brown', 'alice.brown@example.com', '456-789-0123');


/* CREATING THE ROWS OF ORDERS TABLE -------------------------------------*/ 

INSERT INTO ORDERS VALUES (101, 1, '2024-05-01');
INSERT INTO ORDERS VALUES (102, 2, '2024-05-02');
INSERT INTO ORDERS VALUES (103, 3, '2024-05-01');


/* CREATING THE ROWS OF ORDER_DETAILS TABLE -------------------------------------*/ 

INSERT INTO ORDER_DETAILS VALUES (1, 101, 1, 2)
INSERT INTO ORDER_DETAILS VALUES (2, 101, 3, 1)
INSERT INTO ORDER_DETAILS VALUES (3, 102, 2, 3)
INSERT INTO ORDER_DETAILS VALUES (4, 102, 4, 2)
INSERT INTO ORDER_DETAILS VALUES (5, 103, 5, 1);


/*1   -----Retrieve all products.                          */
SELECT * FROM PRODUCTS;

/* 2 -----    Retrieve all customers.-----------------------*/

SELECT * FROM CUSTOMERS;

/* 3 ---------------- Retrieve all orders.				*/

SELECT * FROM ORDERS 


/*4 ----------Retrieve all order details.----------------*/

SELECT * FROM ORDER_DETAILS;


/*5 -----Retrieve all product types.---------------------*/

SELECT * FROM PRODUCT_TYPES;


/*  6----------Retrieve the names of the products that have been ordered by at least one customer, */ 
/*    -------along with the total quantity of each product ordered.                                */

SELECT PRODUCT_NAME, QUANTITY
FROM PRODUCTS
	JOIN ORDER_DETAILS
		ON PRODUCTS.PRODUCT_ID = ORDER_DETAILS.PRODUCT_ID
		GROUP BY 
		PRODUCT_NAME,
		QUANTITY
		HAVING COUNT(ORDER_DETAILS.PRODUCT_ID)>= 1;

GO

/* 7 ---Retrieve the names of the customers who have placed an order on every day of the week, */
/* ---along with the total number of orders placed by each customer.--------------------------*/


SELECT CUSTOMER_NAME,
		COUNT(ORDER_DETAILS.PRODUCT_ID) as TOTAL_NUMBER_OF_ORDER
		FROM CUSTOMERS
		JOIN ORDERS
		ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID
		JOIN ORDER_DETAILS 
		ON ORDERS.ORDER_ID = ORDER_DETAILS.ORDER_ID
		GROUP BY 
				CUSTOMER_NAME
			HAVING
					COUNT(DISTINCT ORDERS.ORDER_DATE)=7 ;

GO

/* 8-----  Retrieve the names of the customers who have placed the most orders, along with --------*/
/* -----   the total number of orders placed by each customer.  ---------------------------------*/


WITH COMMON_TABLE_EXPRESSION AS (
		SELECT CUSTOMER_NAME,
           COUNT(ORDER_DETAILS.QUANTITY) AS TOTAL_QUANTITY_OF_ORDER
		FROM CUSTOMERS
			JOIN ORDERS 
			ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID
			JOIN ORDER_DETAILS 
			ON ORDERS.ORDER_ID = ORDER_DETAILS.ORDER_ID
			GROUP BY CUSTOMER_NAME
			)
SELECT	CUSTOMER_NAME,
		TOTAL_QUANTITY_OF_ORDER
FROM COMMON_TABLE_EXPRESSION
WHERE TOTAL_QUANTITY_OF_ORDER = (SELECT MAX(TOTAL_QUANTITY_OF_ORDER) FROM COMMON_TABLE_EXPRESSION);
			
GO					

/* 9 -----Retrieve the names of the products that have been ordered the most, -------------------*/
/* -----along with the total quantity of each product ordered.-------------------*/



	WITH CTE as(
			SELECT PRODUCT_NAME, 
			COUNT(ORDER_DETAILS.QUANTITY) as total_quantity_what_is_ordered
			FROM PRODUCTS
			JOIN ORDER_DETAILS
			ON PRODUCTS.PRODUCT_ID = ORDER_DETAILS.PRODUCT_ID
			GROUP BY PRODUCT_NAME
			)
	SELECT PRODUCT_NAME, total_quantity_what_is_ordered
	FROM CTE
	WHERE total_quantity_what_is_ordered = (select MAX(total_quantity_what_is_ordered) FROM CTE);


/* 10----- Retrieve the names of customers who have placed an order for at least one widget.  --------------*/


SELECT CUSTOMER_NAME
		FROM CUSTOMERS
		JOIN ORDERS
		ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID
		JOIN ORDER_DETAILS
		ON ORDERS.ORDER_ID = ORDER_DETAILS.ORDER_ID
		JOIN PRODUCTS
		ON ORDER_DETAILS.PRODUCT_ID = PRODUCTS.PRODUCT_ID
		WHERE (PRODUCT_NAME like '%Widget%')
	GROUP BY CUSTOMER_NAME
		HAVING  COUNT(PRODUCTS.PRODUCT_NAME)>=1;
				
GO

/* 11-----Retrieve the names of the customers who have placed an order for at least one widget and at least one gadget,--*/
/* ----- along with the total cost of the widgets and gadgets ordered by each customer.  -------------------------------*/


SELECT CUSTOMER_NAME, 
		SUM(PRODUCT_PRICE) as TOTAL_COST
		FROM CUSTOMERS
		JOIN ORDERS
		ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID
		JOIN ORDER_DETAILS
		ON ORDERS.ORDER_ID = ORDER_DETAILS.ORDER_ID
		JOIN PRODUCTS
		ON ORDER_DETAILS.PRODUCT_ID = PRODUCTS.PRODUCT_ID
		WHERE (PRODUCT_NAME like '%Widget%') 
		 OR (PRODUCT_NAME like '%gadget%')
		 GROUP BY CUSTOMER_NAME;
GO

/* 12-----Retrieve the names of the customers who have placed an order for at least one gadget, */
/*along with the total cost of the gadgets ordered by each customer. --------------------------*/

SELECT CUSTOMER_NAME,
		SUM(PRODUCT_PRICE) as TOTAL_COST
		FROM CUSTOMERS
		join ORDERS
		ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID
		JOIN ORDER_DETAILS
		ON ORDERS.ORDER_ID = ORDER_DETAILS.ORDER_ID
		JOIN PRODUCTS
		ON ORDER_DETAILS.PRODUCT_ID = PRODUCTS.PRODUCT_ID
		WHERE (PRODUCT_NAME like '%gadget%')
	GROUP BY CUSTOMER_NAME;
GO

/*  13   Retrieve the names of the customers who have placed an order for at least one doohickey, */
/*   along with the total cost of the doohickeys ordered by each customer. */

SELECT CUSTOMER_NAME,
		SUM(PRODUCT_PRICE) as TOTAL_Cost
		FROM CUSTOMERS
		join ORDERS
		ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID
		JOIN ORDER_DETAILS
		ON ORDERS.ORDER_ID = ORDER_DETAILS.ORDER_ID
		JOIN PRODUCTS
		ON ORDER_DETAILS.PRODUCT_ID = PRODUCTS.PRODUCT_ID
		WHERE (PRODUCT_NAME like '%doohickey%')
	GROUP BY CUSTOMER_NAME;
GO
	
/* 14-----  Retrieve the names of the customers who have placed an order every day of the week, */
/*-----along with the total number of orders placed by each customer.-----------------------*/


/*-------------------même question que la 7--------------*/



/*  15 --- ------ Retrieve the total number of widgets and gadgets ordered by each customer, --------*/
/*----------------along with total cost of the orders. -----------------------------------------*/


	SELECT	PRODUCT_NAME, 
			SUM(QUANTITY) AS TOTAL_NUMB
			FROM PRODUCTS
			JOIN ORDER_DETAILS
		 ON PRODUCTS.PRODUCT_ID = ORDER_DETAILS.PRODUCT_ID
		 WHERE PRODUCT_NAME like '%gadge%' or PRODUCT_NAME like '%widget%'
		 GROUP BY PRODUCT_NAME;


	Go
		 





		


