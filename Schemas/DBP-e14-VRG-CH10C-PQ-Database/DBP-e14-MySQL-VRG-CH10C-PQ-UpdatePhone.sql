/********************************************************************************/
/*											                                 	*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C     		*/
/*																				*/
/*	The VRG-CH10C-PQ Database - Stored Procedure UpdatePhone       			    */
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions	for 10C.36.H	                */
/*																				*/
/********************************************************************************/

DELIMITER //

CREATE PROCEDURE UpdatePhone
	(IN CustomerLastName	  Char(25),
	 IN CustomerFirstName	 Char(25),
	 IN priorAreaCode		   Char(3),
	 IN priorPhoneNumber		Char(8),
	 IN newAreaCode			 	Char(3),
	 IN newPhoneNumber			Char(8))

updateproc: BEGIN

	DECLARE  recCount		    Int;
	DECLARE  readCustomerID		Int;

	/* Check to see if the customer is in the database */

	SELECT COUNT(*) INTO recCount
		FROM 	 CUSTOMER AS C
		WHERE 	C.LastName = CustomerLastName
			AND	 C.FirstName = CustomerFirstName
		  AND 	C.AreaCode = priorAreaCode
	  	AND 	C.PhoneNumber = priorPhoneNumber;

	IF (recCount = 0)
		THEN
			
			SELECT 'Customer does not exist.'
				AS UpdatePhoneErrorMessage;
                ROLLBACK;
                LEAVE updateproc;
		END IF;

	/* Customer exists, so update phone number */

	SELECT CustomerID INTO readCustomerID
		FROM 		CUSTOMER AS C
		WHERE 		C.LastName = CustomerLastName
			AND		C.FirstName = CustomerFirstName
		   AND 	C.AreaCode = priorAreaCode
	  	   AND 	C.PhoneNumber = priorPhoneNumber;

	UPDATE CUSTOMER
		SET AreaCode = newAreaCode
		WHERE CustomerID = readCustomerID;

	UPDATE CUSTOMER
		SET PhoneNumber = newPhoneNumber
		WHERE CustomerID = readCustomerID;

	SELECT 'Customer phone number updated'
		AS UpdatePhoneResults;

END updateproc;
//

Delimiter ;

# Test data --> 

  CALL UpdatePhone ('Twilight', 'Tiffany', '360', '765-5566', '206', '876-1122');

# this next line will generate an error message, customer does not exist
 CALL UpdatePhone ('Joockson', 'Samuel', '460', '865-5566', '306', '976-1122');

 SELECT  CustomerID, LastName, FirstName, AreaCode, PhoneNumber
  FROM    CUSTOMER;
 























