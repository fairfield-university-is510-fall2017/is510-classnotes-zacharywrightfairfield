/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (14th Edition) CH07		*/
/*																				*/
/*	The Queen Anne Curiousity Shop Database Create Tables						*/
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions									*/
/*																				*/
/********************************************************************************/


/*****   Question 7.L   *********************************************************/
/*****   Create View  ***********************************************************/

CREATE VIEW	SaleSummaryView AS
	SELECT		S.SaleID, S. SaleDate, SI.SaleItemID, SI.ItemID, 
				ItemDescription, I.ItemPrice 
	FROM 		SALE S JOIN SALE_ITEM SI
					ON S.SaleID = SI.SaleID
				JOIN ITEM I
					ON SI.ItemID = I.ItemID;

/*****  Query View **************************************************************/

SELECT		*
FROM		SaleSummaryView
ORDER BY	SaleID, SaleItemID;

/*****   Question 7.M   *********************************************************/
/******  Create Function  *******************************************************/
DELIMITER //
CREATE FUNCTION LastNameFirst
-- These are the input parameters
		(
		 varFirstName		Char(25),
		 varLastName		Char(25)
		)
RETURNS Varchar(60) DETERMINISTIC
BEGIN 
	-- This is the variable that will hold the value to be returned
	DECLARE	varFullName	Varchar(60);
	-- SQL statements to concatenate the names in the proper order
	SET varFullName = CONCAT(varLastName, ', ', varFirstName);
	-- Return the concatenated name
	RETURN varFullName;

END
//
DELIMITER ;

/******  Test Function  *********************************************************/

SELECT		LastNameFirst(FirstName, LastName) AS CustomerName, 
			Phone, Email
FROM		CUSTOMER
ORDER BY	CustomerName;

/*****   Question 7.N   *********************************************************/
/*****   Create View  ***********************************************************/
# drop view customersalesummaryview; 

CREATE VIEW	CustomerSaleSummaryView AS
	SELECT		S.SaleID, S. SaleDate, 
				C.LastName, C.FirstName,
				SI.SaleItemID, SI.ItemID, 
				ItemDescription, I.ItemPrice 
	FROM 		CUSTOMER C JOIN SALE S
		ON		C.CustomerID = S.CustomerID
				JOIN	SALE_ITEM SI
					ON	S.SaleID = SI.SaleID
						JOIN	ITEM I
						ON		SI.ItemID = I.ItemID;

/*****  Query View **************************************************************/

SELECT		*
FROM		CustomerSaleSummaryView
ORDER BY	SaleID, SaleItemID;


/*****   Question 7.O   *********************************************************/
/*****   Create View  ***********************************************************/
drop view custlastnamefirstsaleview;

CREATE VIEW	CustLastNameFirstSaleView AS
	SELECT		S.SaleID, S. SaleDate, 
				LastNameFirst (C.FirstName, C.LastName) AS CustomerName,
				SI.SaleItemID, SI.ItemID, 
				ItemDescription, I.ItemPrice 
	FROM 		CUSTOMER C JOIN SALE S
		ON		C.CustomerID = S.CustomerID
				JOIN	SALE_ITEM SI
					ON	S.SaleID = SI.SaleID
						JOIN	ITEM I
						ON		SI.ItemID = I.ItemID;

/*****  Query View **************************************************************/

SELECT		*
FROM		CustLastNameFirstSaleView 
ORDER BY	SaleID, SaleItemID;


/*****   Question 7.P   *********************************************************/
/*****   Create View  ***********************************************************/

CREATE VIEW	CustomerSaleHistoryView AS
	SELECT		S.SaleID, S.SaleDate, 
				C.LastName, C.FirstName,
				SUM(I.ItemPrice) AS SumItemPrice,
				AVG(I.ItemPrice) AS AvgItemPrice
	FROM 		CUSTOMER C JOIN SALE S
		ON		C.CustomerID = S.CustomerID
				JOIN	SALE_ITEM SI
					ON	S.SaleID = SI.SaleID
						JOIN	ITEM I
						ON		SI.ItemID = I.ItemID
	GROUP BY	S.SaleID, C.LastName,C.FirstName, S.SaleDate;

/*****  Query View **************************************************************/

SELECT		*
FROM		CustomerSaleHistoryView
ORDER BY	SaleID;


/*****   Question 7.Q   *********************************************************/
/*****   Create View  ***********************************************************/

CREATE VIEW	CustomerSaleCheckView AS
	SELECT		CSHV.SaleID, CSHV.SaleDate, 
				LastName, FirstName,
				SumItemPrice,
				S.SubTotal
	FROM		CustomerSaleHistoryView CSHV JOIN SALE S
		ON		CSHV.SaleID = S.SaleID
	WHERE		SumItemPrice <> S.Subtotal;

/*****  Query View **************************************************************/
	
SELECT		*
FROM		CustomerSaleCheckView
ORDER BY	SaleID;

/**********************************************************************************/
# 7.R is prose