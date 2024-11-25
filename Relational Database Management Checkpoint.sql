CREATE TABLE WINE(
Num_W INT PRIMARY KEY,
Category varchar(200),
Year int, 
Degree int
);

CREATE TABLE Producer(
Num_P int primary key,
First_NAME varchar(100) not null, 
Last_NAME varchar(100)not null,
Region VARCHAR(100) not null
);

CREATE TABLE HARVEST(
Num_P int
foreign key (Num_P) references Producer(Num_P),
Num_W int 
foreign key (Num_W) references WINE(Num_W),
QUANTITY int PRIMARY KEY
);
GO


/* WINE TABLE INSERTION -------------------------------*/


INSERT INTO WINE VALUES (1, 'Red', 2019, 13.5)
INSERT INTO WINE VALUES (2, 'White', 2020, 12.0)
INSERT INTO WINE VALUES (3, 'Rose', 2018, 11.5)
INSERT INTO WINE VALUES(4, 'Red', 2021, 14.0)
INSERT INTO WINE VALUES (5, 'Sparkling', 2017, 10.5)
INSERT INTO WINE VALUES(6, 'White', 2019, 12.5)
INSERT INTO WINE VALUES(7, 'Red', 2022, 13.0)
INSERT INTO WINE VALUES(8, 'Rose', 2020, 11.0)
INSERT INTO WINE VALUES(9, 'Red', 2018, 12.0)
INSERT INTO WINE VALUES (10, 'Sparkling', 2019, 10.0)
INSERT INTO WINE VALUES(11, 'White', 2021, 11.5)
INSERT INTO WINE VALUES (12, 'Red', 2022, 15.0)

/* Producer TABLE INSERTION -------------------------------*/

INSERT INTO Producer VALUES (1, 'John', 'Smith', 'Sousse')
INSERT INTO Producer VALUES (2, 'Emma', 'Johnson', 'Tunis')
INSERT INTO Producer VALUES (3, 'Michael', 'Williams', 'Sfax')
INSERT INTO Producer VALUES (4, 'Emily', 'Brown', 'Sousse')
INSERT INTO Producer VALUES (5, 'James', 'Jones', 'Sousse')
INSERT INTO Producer VALUES (6, 'Sarah', 'Davis', 'Tunis')
INSERT INTO Producer VALUES (7, 'David', 'Miller', 'Sfax')
INSERT INTO Producer VALUES (8, 'Olivia', 'Wilson', 'Monastir')
INSERT INTO Producer VALUES (9, 'Daniel', 'Moore', 'Sousse')
INSERT INTO Producer VALUES (10, 'Sophia', 'Taylor', 'Tunis')
INSERT INTO Producer VALUES (11, 'Matthew', 'Anderson', 'Sfax')
INSERT INTO Producer VALUES (12, 'Amelia', 'Thomas', 'Sousse');


/* 4 ---- Retrieve a list of all producers.---------------------------*/

SELECT * FROM Producer;

/* 5 ----Retrieve a sorted list of producers by name.----------------------*/

SELECT First_NAME, Last_NAME
	from Producer;

/* 6 ----Retrieve a list of producers from Sousse.--------------------*/

SELECT * FROM Producer
WHERE Region like '%sousse%';

/* 7 ----Calculate the total quantity of wine produced with the wine number 12.---------*/

SELECT
SUM(QUANTITY) as Total_quantity
 FROM HARVEST
 WHERE Num_W = 12; 

 /* 8 ----Calculate the quantity of wine produced for each category.--------*/

 SELECT Category, Degree,
 SUM(QUANTITY) as total_quantity
 FROM WINE
 Join HARVEST
 ON WINE.Num_W = HARVEST.Num_W
 GROUP BY Category, Degree;

 /* 9 ---Find producers in the Sousse region who have harvested at least one wine in quantities greater than 300 liters---*/
 /* ---------------Display their names and first names, sorted alphabetically.-----------------------------*/

 SELECT First_NAME, Last_NAME 
		FROM Producer
		JOIN HARVEST
		ON Producer.Num_P = HARVEST.Num_P
	WHERE Region like '%sousse%' 
	and QUANTITY > 300
	ORDER BY Last_NAME ASC;

	 /*10 ------ List the wine numbers with a degree greater than 12, produced by producer number 24. -----*/
	 
SELECT WINE.Num_W
	FROM WINE
	JOIN HARVEST
	ON WINE.Num_W = HARVEST.Num_W
	Join Producer
	ON HARVEST.Num_P = Producer.Num_P
	WHERE Degree > 12
	and Producer.Num_P = 24;

	/* 11 --------Find the producer who has produced the highest quantity of wine.-----------------*/

	SELECT TOP (1) Producer.Num_P, MAX(QUANTITY) as MAXIMUM
	FROM Producer
	Join HARVEST
	ON Producer.Num_P = HARVEST.Num_P
	GROUP BY Producer.Num_P
	ORDER BY MAXIMUM DESC;

	/* 12 Find the average degree of wine produced.  */
	 SELECT AVG(Degree)
	 from WINE;

/* 13 Find the oldest wine in the database.  */

SELECT TOP (1) WINE.Year
FROM WINE 
ORDER BY Year ASC;

/* 14 --Retrieve a list of producers along with the total quantity of wine they have produced.  */

SELECT First_NAME, Last_NAME, SUM(QUANTITY) as TOTAL_QUANTITY
FROM Producer 
JOIN HARVEST
ON Producer.Num_P = HARVEST.Num_P
GROUP BY First_NAME, Last_NAME;

/* 15 --Retrieve a list of wines along with their producer details.  */

SELECT *, Category, Year 
	from Producer
	JOIN HARVEST
	ON HARVEST.Num_P = Producer.Num_P
	join WINE 
	ON HARVEST.Num_W = WINE.Num_W;

		

	