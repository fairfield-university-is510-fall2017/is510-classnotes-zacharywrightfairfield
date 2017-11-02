/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 02			*/
/*																				*/
/*  The Queen Ann Curiosity Shop [QACS] Database Queries						*/
/*																				*/
/*	These are the MySQL code solutions											*/
/*																				*/
/********************************************************************************/

/*****   QACS CREATE TABLE statements   *****************************************/

/*       See the file:	 DBP-e14-MySQL-QACS-Create-Tables.sql					*/

/*****   QACS INSERT statements   ***********************************************/

/*       See the files:	 DBC-e14-MySQL-QACS-Insert-Data.sql						*/

/*****   Question A   ***********************************************************/

/*****   CUSTOMER DATA  *********************************************************/

SELECT * FROM CUSTOMER;

/*****   ITEM DATA   ************************************************************/

SELECT * FROM ITEM;

/*****   SALE DATA   ************************************************************/

SELECT * FROM SALE;

/*****   SALE_ITEM   ************************************************************/

SELECT * FROM SALE_ITEM;


/*****   Question B   ***********************************************************/

SELECT		LastName, FirstName, Phone
FROM		CUSTOMER;

/*****   Question C   ***********************************************************/

SELECT		LastName, FirstName, Phone
FROM		CUSTOMER
WHERE		FirstName = 'John';

/*****   Question D   ***********************************************************/

SELECT		LastName, FirstName, Phone, SaleDate, Total
FROM		CUSTOMER, SALE
WHERE		CUSTOMER.CustomerID = SALE.CustomerID 
  AND Total > 100;

/*****   Question E   ***********************************************************/

SELECT		LastName, FirstName, Phone
FROM		CUSTOMER
WHERE		FirstName LIKE 'D%';

/*****   Question F   ***********************************************************/

SELECT		LastName, FirstName, Phone
FROM		CUSTOMER
WHERE		LastName LIKE '%ne%';

/*****   Question G   ***********************************************************/

SELECT		LastName, FirstName, Phone
FROM		CUSTOMER
WHERE		Phone LIKE '%56_';


/*****   Question H   ***********************************************************/

SELECT		MAX (Total) as MaximumTotalSales,
			MIN (Total) as MinimumTotalSales
FROM		SALE;

/*****   Question I   ***********************************************************/

SELECT		AVG (Total) as AverageTotalSales
FROM		SALE;

/*****   Question J   ***********************************************************/

SELECT		COUNT(customerid) AS NumberOfCustomers
FROM		CUSTOMER;

/*****   Question K   ***********************************************************/

SELECT		LastName, FirstName
FROM		CUSTOMER
GROUP BY	LastName, FirstName;


/*****   Question L   ***********************************************************/

SELECT		LastName, FirstName, COUNT(*) AS NumberOfCustomers
FROM		CUSTOMER
GROUP BY	LastName, FirstName;


/*****   Question M   ***********************************************************/

SELECT		LastName, FirstName, Phone
FROM		CUSTOMER
WHERE		CustomerID IN 
			(SELECT CustomerID
			 FROM SALE
			 WHERE Total > 100)
ORDER BY	LastName, FirstName DESC;

/*****   Question N   ***********************************************************/

SELECT  	LastName, FirstName, Phone
FROM		CUSTOMER, SALE
WHERE		Total  > 100
	AND		CUSTOMER.CustomerID = SALE.CustomerID
ORDER BY LastName, FirstName DESC;

/*       For each CUSTOMER only once:                                         */

SELECT		DISTINCT LastName, FirstName, Phone
FROM		CUSTOMER, SALE
WHERE		Total  > 100
	AND		CUSTOMER.CustomerID = SALE.CustomerID
ORDER BY LastName, FirstName DESC;

/*****   Question O   ***********************************************************/

SELECT  	LastName, FirstName, Phone
FROM		CUSTOMER JOIN SALE
	ON		CUSTOMER.CustomerID = SALE.CustomerID
WHERE		Total  > 100
ORDER BY LastName, FirstName DESC;
	

/*       For each CUSTOMER only once:                                         */

SELECT		DISTINCT LastName, FirstName, Phone
FROM		CUSTOMER JOIN SALE
	ON		CUSTOMER.CustomerID = SALE.CustomerID
WHERE		Total  > 100
ORDER BY LastName, FirstName DESC;

/*****   Question P   ***********************************************************/

SELECT		LastName, FirstName, Phone
FROM		CUSTOMER
WHERE		CustomerID IN 
			(SELECT 	CustomerID
			 FROM 		SALE
			 WHERE		SaleID IN
						(SELECT		SaleID
						 FROM		SALE_ITEM
						 WHERE		ItemID IN
									(SELECT		ItemID
									 FROM		ITEM
									 WHERE		ItemDescription = 'Desk Lamp')))
ORDER BY LastName, FirstName DESC;

						 						 
/*****   Question Q   ***********************************************************/

SELECT		LastName, FirstName, Phone
FROM		CUSTOMER C,
			SALE S,
			SALE_ITEM SI,
			ITEM I
WHERE		C.CustomerID = S.CustomerID
	AND		S.SaleID = SI.SaleID
	AND		SI.ItemID = I.ItemID
	AND		ItemDescription = 'Desk Lamp'
ORDER BY LastName, FirstName DESC;

						 
/*****   Question R   ***********************************************************/

SELECT		LastName, FirstName, Phone
FROM		CUSTOMER C JOIN SALE S
	ON		C.CustomerID = S.CustomerID
			JOIN	SALE_ITEM SI
				ON	S.SaleID = SI.SaleID
					JOIN	ITEM I
						ON	SI.ItemID = I.ItemID
WHERE		ItemDescription = 'Desk Lamp'
ORDER BY LastName, FirstName DESC;

/*****   Question S   ***********************************************************/

SELECT		LastName, FirstName, Phone
FROM		CUSTOMER C JOIN
			SALE S
ON		C.CustomerID = S.CustomerID
	WHERE		SaleID IN
						(SELECT		SaleID
						 FROM		SALE_ITEM
						 WHERE		ItemID IN
									(SELECT		ItemID
									 FROM		ITEM
									 WHERE		ItemDescription = 'Desk Lamp'))
ORDER BY LastName, FirstName DESC ;


/*****   Question T   ***********************************************************/

SELECT		LastName, FirstName, Phone
FROM		CUSTOMER C JOIN SALE S ON C.CustomerID = S.CustomerID
		JOIN SALE_ITEM SI ON S.SaleID = SI.SaleID
WHERE		ItemID IN
				(SELECT		ItemID
				 FROM		ITEM I
				 WHERE		ItemDescription = 'Desk Lamp')
ORDER BY LastName, FirstName DESC;

/*****   Question U  ***********************************************************/

SELECT		LastName, FirstName, Phone, ItemDescription
FROM		CUSTOMER C LEFT JOIN (SALE S
				JOIN	SALE_ITEM SI
				ON	S.SaleID = SI.SaleID
					JOIN	ITEM I
						ON	SI.ItemID = I.ItemID
		AND I.ItemDescription = 'Desk Lamp')
	ON C.CustomerID = S.CustomerID
ORDER BY ItemDescription, LastName, FirstName DESC;


/********************************************************************************/
