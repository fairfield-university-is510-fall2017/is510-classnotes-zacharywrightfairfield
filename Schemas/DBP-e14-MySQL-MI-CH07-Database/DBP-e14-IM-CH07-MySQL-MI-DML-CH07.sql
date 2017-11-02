/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 07			*/
/*																				*/
/*  Morgan Importing [MI_CH07] Database Project Questions						*/
/*																				*/
/*	These are the MySQL 5.6 code solutions										*/
/*																				*/
/********************************************************************************/



/*****   Project Question  7.H   ************************************************/

/*       See the file:	 DBP-e14-MySQL-MI-CH07-Create-Tables.sql				*/

/*****   Project Question  7.J   ************************************************/

/*       See the file:	 DBP-e14-MySQL-MI-CH07-Insert-Data.sql					*/

/*****   EMPLOYEE DATA  *********************************************************/

SELECT * FROM EMPLOYEE;

/*****   STORE DATA  ************************************************************/

SELECT * FROM STORE;

/*****   SHIPPER DATA  **********************************************************/

SELECT * FROM SHIPPER;

/*****   ITEM DATA  *************************************************************/

SELECT * FROM ITEM;

/*****   SHIPMENT DATA  *********************************************************/

SELECT * FROM SHIPMENT;

/*****   SHIPMENT_ITEM DATA  ****************************************************/

SELECT * FROM SHIPMENT_ITEM;

/*****   SHIPMENT_RECEIPT DATA  *************************************************/

SELECT * FROM SHIPMENT_RECEIPT;

/*****   Project Question  7.K   ************************************************/

SELECT * FROM STORE;

UPDATE STORE
	SET		City = 'NYC'
	WHERE	City = 'New York City';

SELECT * FROM STORE;

/*****   Project Question  7.L  ************************************************/
/*																				*/
/*  Note that we have set ON DELETE CASADE between SHIPMENT and					*/
/*	SHIPMENT_ITEM.  Therefore, if we DELETE a record in SHIPMENT,				*/
/*	all associated records in SHIPMENT_ITEM will also be deleted.				*/
/*	This means we just use a simple	DELETE statement on SHIPMENT.				*/
/*	Note for MySQL we provide the "surrogate" keys of 570 and 575 				*/
/*	The correct command is:														*/
/*																				*/
/*	DELETE 	FROM SHIPMENT														*/
/*	WHERE	ShipmentID = 106;													*/
/*																				*/
/*	To test this, run the following set of commands:							*/
/*																				*/
/********************************************************************************/


INSERT INTO ITEM VALUES(570, 1000, 103, '2015-09-06', 'Large bureau', 'Furniture', 9500);
INSERT INTO ITEM VALUES(575, 1100, 103, '2015-09-07', 'Brass lamps', 'Lamps', 1200);
INSERT INTO SHIPMENT VALUES(null, 2, 103, 511700, 'Singapore', 'Portland', '2015-09-15', NULL, NULL);
INSERT INTO SHIPMENT_ITEM VALUES(106, 1, 570, 10000);
INSERT INTO SHIPMENT_ITEM VALUES(106, 2, 575, 1500);

SELECT * FROM SHIPMENT_ITEM;

DELETE 	FROM SHIPMENT
WHERE	ShipmentID = 106;

SELECT * FROM SHIPMENT_ITEM;

/********************************************************************************/
