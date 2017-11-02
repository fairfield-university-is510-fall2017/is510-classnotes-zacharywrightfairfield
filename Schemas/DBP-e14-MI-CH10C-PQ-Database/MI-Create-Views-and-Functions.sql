/******************************************************************************/
/*									                                           	*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C  			*/
/*										                                        */
/*	The Morgan Importing (MI-CH10B) Database - Views and Functions              */
/*							                                                    */
/*	These are the MySQL 5.6 SQL code solutions								    */
/*								                                                */
/******************************************************************************/

/******** 10C - MI- A *********************************************************/
DELIMITER //
CREATE FUNCTION LastNameFirst
-- These are the input parameters
		(
		 varFirstName 			Char(25),
		 varLastName  			Char(25)
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

/******** 10C - MI- B *********************************************************/

CREATE OR REPLACE VIEW PurchasingAgentSummaryView AS
	SELECT 	LastNameFirst(FirstName, LastName) AS PurchasingAgentName,
         			I.ItemDescription, I.PurchaseDate, S.StoreName, S.City, S.Country 
    	FROM 		EMPLOYEE E, ITEM I, STORE S
	WHERE	E.EmployeeID = I.PurchasingAgentID
    AND S.StoreID = I.StoreID;

/******** 10C - MI- C *********************************************************/

DELIMITER //
CREATE FUNCTION FirstNameFirst
-- These are the input parameters
		(
		 varFirstName 			Char(25),
		 varLastName  			Char(25)
		)
RETURNS Varchar(60) DETERMINISTIC
BEGIN 
	-- This is the variable that will hold the value to be returned
	DECLARE	varFullName	Varchar(60);
	-- SQL statements to concatenate the names in the proper order
	SET varFullName = CONCAT(varFirstName, ' ', varLastName);
	-- Return the concatenated name
	RETURN varFullName;

END
//
DELIMITER ;

/******** 10C - MI- D *********************************************************/

CREATE OR REPLACE VIEW ReceivingAgentSummaryView AS
	SELECT 	FirstNameFirst(E.FirstName, E.LastName) AS ReceivingAgentName,
         			SR.ReceiptNumber, S.ShipmentID, SH.ShipperName, S.EstimatedArrivalDate,
              TO_CHAR(SR.ReceiptDateTime, 'DD-MON-YY') AS ReceiptDate,
              TO_CHAR(SR.ReceiptDateTime, 'HH:MI AM') AS ReceiptTime
    	FROM 		EMPLOYEE E, SHIPMENT_RECEIPT SR, SHIPMENT S, SHIPPER SH
     WHERE 		E.EmployeeID = S.PurchasingAgentID
       AND		SR.ShipmentID = S.ShipmentID
       AND    S.ShipperID = SH.ShipperID;

