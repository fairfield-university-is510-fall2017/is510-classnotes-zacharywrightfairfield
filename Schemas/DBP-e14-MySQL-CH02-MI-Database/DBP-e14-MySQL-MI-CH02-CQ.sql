/******************************************************************************/
/*				                                                        	*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 02  			*/
/*										                                        */
/*	The Morgan Importing (MI-CH02) Database - Case Questions 				*/
/*							                                                  */
/*	These are the MySQL 5.6 code solutions							            */
/*								                                               */
/******************************************************************************/

/* A */

SELECT *
FROM ITEM;

SELECT *
FROM SHIPMENT;

SELECT *
FROM SHIPMENT_ITEM;

/* B */

SELECT ShipmentID, ShipperName, ShipperInvoiceNumber
FROM SHIPMENT;

/* C */

SELECT ShipmentID, ShipperName, ShipperInvoiceNumber
FROM SHIPMENT
WHERE InsuredValue>10000;

/* D */

SELECT ShipmentID, ShipperName, ShipperInvoiceNumber
FROM SHIPMENT
WHERE ShipperName Like 'AB%';

/* E */

SELECT ShipmentID, ShipperName, ShipperInvoiceNumber, ArrivalDate
FROM SHIPMENT
WHERE MONTH(DepartureDate) = 12; 

/* F */

SELECT ShipmentID, ShipperName, ShipperInvoiceNumber, ArrivalDate
FROM SHIPMENT
WHERE DAY(DepartureDate) = 10; 


/* G */

SELECT MAX(InsuredValue) AS MaxInsuredValue, MIN(InsuredValue) AS MinInsuredValue
FROM SHIPMENT;

/* H */

SELECT AVG(InsuredValue) AS AvgInsuredValue
FROM SHIPMENT;

/* I */

SELECT COUNT(*) AS NumberOfShipments
FROM SHIPMENT;

/* J */

SELECT ItemID, Description, Store, LocalCurrencyAmount*ExchangeRate AS USCurrencyAmount
FROM ITEM;

/* K */

SELECT City, Store
FROM ITEM
GROUP BY City, Store;

/* L */

SELECT City, Store, COUNT(*) AS City_Store_Combination_Count
FROM ITEM
GROUP BY City, Store;

/* M */

SELECT ShipperName, ShipmentID, DepartureDate
FROM SHIPMENT
WHERE ShipmentID IN
			(SELECT	ShipmentID
			 FROM 	SHIPMENT_ITEM
			 WHERE	Value >= 1000)
ORDER BY ShipperName, DepartureDate DESC;

/* N */

/* First query attampt contains duplicates ... */

SELECT ShipperName, SHIPMENT.ShipmentID, DepartureDate
FROM SHIPMENT, SHIPMENT_ITEM
WHERE SHIPMENT.ShipmentID = SHIPMENT_ITEM.ShipmentID
             	 AND 	(Value >= 1000)
ORDER BY ShipperName, DepartureDate DESC;

/* ... final version eliminates duplicates */
	

SELECT DISTINCT ShipperName, SHIPMENT.ShipmentID, DepartureDate
FROM SHIPMENT, SHIPMENT_ITEM
WHERE SHIPMENT.ShipmentID = SHIPMENT_ITEM.ShipmentID
	AND 	Value >= 1000
ORDER BY ShipperName, DepartureDate DESC;

/* O */

SELECT ShipperName, ShipmentID, DepartureDate
FROM SHIPMENT
WHERE ShipmentID IN
			(SELECT 	ShipmentID
			 FROM 	SHIPMENT_ITEM
			 WHERE 	ItemID IN
						(SELECT 	ItemID
						 FROM 		ITEM
						 WHERE		City = 'Singapore'))
ORDER BY ShipperName, DepartureDate DESC;

/* P */

SELECT DISTINCT ShipperName, SHIPMENT.ShipmentID, DepartureDate
FROM SHIPMENT, SHIPMENT_ITEM, ITEM
WHERE SHIPMENT.ShipmentID=SHIPMENT_ITEM.ShipmentID And SHIPMENT_ITEM.ItemID=ITEM.ItemID And City='Singapore'
ORDER BY ShipperName, DepartureDate DESC;

/* Q */

SELECT DISTINCT SHIPMENT.ShipperName, SHIPMENT_ITEM.ShipmentID, SHIPMENT.DepartureDate
FROM ITEM JOIN (SHIPMENT JOIN SHIPMENT_ITEM ON SHIPMENT.ShipmentID = SHIPMENT_ITEM.ShipmentID) ON ITEM.ItemID = SHIPMENT_ITEM.ItemID
WHERE ITEM.City ='Singapore'
ORDER BY ShipperName, DepartureDate DESC;

/* R */

SELECT ShipperName, SHIPMENT.ShipmentID, DepartureDate, Value
FROM SHIPMENT, SHIPMENT_ITEM
WHERE SHIPMENT.ShipmentID = SHIPMENT_ITEM.ShipmentID
	AND 	ItemID IN
			(SELECT 	ItemID
			 FROM 		ITEM
			 WHERE 	City = 'Singapore')
ORDER BY ShipperName, DepartureDate DESC;

/* S */

SELECT ShipperName, SHIPMENT.ShipmentID, DepartureDate, Value
FROM SHIPMENT LEFT JOIN (ITEM JOIN SHIPMENT_ITEM ON ITEM.ItemID 		= SHIPMENT_ITEM.ItemID AND ITEM.City ='Singapore') 
	ON SHIPMENT.ShipmentID = SHIPMENT_ITEM.ShipmentID
ORDER BY Value, ShipperName, DepartureDate DESC;


