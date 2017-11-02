/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 07			*/
/*																				*/
/*  Morgan Importing [MI_CH07] Database Project Questions						*/
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions									*/
/*																				*/
/********************************************************************************/

/*****   Project Question  7.M   ************************************************/
/******  Create View  ***********************************************************/

CREATE VIEW PurchaseSummaryView AS
	SELECT 	I.ItemID, I.PurchaseDate, I.ItemDescription, I.PriceUSD
	FROM 	ITEM I;

/******  Query View *************************************************************/

SELECT * FROM PurchaseSummaryView;

/*****   Project Question  7.N   ************************************************/
/******  Create Function  *******************************************************/
DELIMITER //
CREATE FUNCTION StoreContactAndPhone
-- These are the input parameters
		(
		 varStoreContact		Char(50),
		 varContactPhone		Char(16)
		)
RETURNS Varchar(100) DETERMINISTIC
BEGIN 
	-- This is the variable that will hold the value to be returned
	-- SQL statements to concatenate the names in the proper order
	RETURN CONCAT(varStoreContact, ': ', varContactPhone);
	-- Return the concatenated name
	END
//
DELIMITER ;

/*****  Test Function  *********************************************************/

SELECT		StoreName, City, Country, EmailAddress,
			StoreContactAndPhone(Contact, Phone) AS ContactData 
FROM		STORE
ORDER BY	StoreName;


/*****   Project Question  7.O   ************************************************/
/*****   Create View  ***********************************************************/

CREATE VIEW StorePurchaseHistoryView AS
	SELECT 	S.StoreName, S.Phone, S.Contact,
			I.ItemID, I.PurchaseDate, I.ItemDescription, I.PriceUSD
	FROM 	STORE S, ITEM I
	WHERE	S.StoreID = I.StoreID;

/*****  Query View **************************************************************/
	
SELECT		* 
FROM		StorePurchaseHistoryView
ORDER BY	StoreName;


/*****   Project Question  7.P   ************************************************/
/*****   Create View  ***********************************************************/

CREATE VIEW StoreContactPurchHistoryView AS
	SELECT 	S.StoreName, StoreContactAndPhone(Contact, Phone) AS ContactData,
			I.ItemID, I.PurchaseDate, I.ItemDescription, I.PriceUSD
	FROM 	STORE S, ITEM I
	WHERE	S.StoreID = I.StoreID;

/*****  Query View **************************************************************/
	
SELECT		* 
FROM		StoreContactPurchHistoryView
ORDER BY	StoreName;

/*****   Project Question  7.Q   ************************************************/
/******  Create View  ***********************************************************/

CREATE VIEW StoreHistoryView AS
	SELECT 		SPH.StoreName, SUM(PriceUSD) AS TotalPurchases
	FROM 		StorePurchaseHistoryView SPH
	GROUP BY	SPH.StoreName;

/******  Query View *************************************************************/

SELECT		* 
FROM		StoreHistoryView
ORDER BY	StoreName;

/*****   Project Question  7.R   ************************************************/
/******  Create View  ***********************************************************/

CREATE VIEW MajorSourcesView AS
	SELECT 		StoreName, TotalPurchases
	FROM 		StoreHistoryView
	WHERE		TotalPurchases > 100000
	GROUP BY	StoreName, TotalPurchases;

/******  Query View *************************************************************/
	
SELECT * FROM MajorSourcesView;

/********************************************************************************/

