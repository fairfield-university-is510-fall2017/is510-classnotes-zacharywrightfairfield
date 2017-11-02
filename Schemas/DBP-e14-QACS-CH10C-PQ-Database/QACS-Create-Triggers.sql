use qacs;
# G-1
DELIMITER //
CREATE PROCEDURE AssignNewSale
			(IN varOldSaleID			Int,
			 IN varOldSaleItemID        Int,
			 IN varNewSaleID			Int)

BEGIN
	# INVOICE changes are not allowed - ROLLBACK transaction.
	ROLLBACK;
	SELECT 'Sales Items assigned to SALE changes are not allowed.'
		AS ReassignNewSale;

END
//
DELIMITER ;

# test

CALL AssignNewSale (1, 2, 2);  

 # G-2
 DELIMITER //
CREATE PROCEDURE DeleteSale
	(IN		varSaleID		Int,
	 IN		varSaleItemID	Int)
spicwt:BEGIN
	DECLARE	varRowCount			  Int;
	# Check to see if the SALE has more than one SALE_ITEM.

	SELECT	COUNT(*) INTO varRowCount
	FROM	SALE_ITEM
	WHERE	 SaleID = varSaleID;

	# IF varRowCount > 1 THEN do NOT delete the SALE.
	IF (varRowCount > 1)
		THEN
		SELECT 'The SALE has more than one Sale_ITEM.'
			AS	DeleteSaleResultsDeleteDenied;
		ROLLBACK;
        LEAVE spicwt;
	END IF;

	# IF varRowCount = 1 THEN DELETE the sale.
	# Start transaction - Rollback everything if unable to complete it.

	# DELETE the SALE_ITEM.
	DELETE FROM SALE_ITEM
	WHERE	SaleID = varSaleID
	  AND   SaleItemID = varSaleItemID;

	# DELETE the SALE.
	DELETE FROM SALE
	WHERE	SaleID = varSaleID;

	# Commit the Transaction
	COMMIT;
	# The transaction is completed. Print message
	SELECT 'The SALE is deleted.'
		AS DeleteSaleResultsDeleteOccured;

END spicwt;
//
DELIMITER ;

# test
#   (1)	To generate an error message

    CALL DeleteSale(1,2);

#   (2)	To delete a department

    CALL DeleteSale (2,1);

# check
    SELECT * FROM SALE;
    select * from sale_item;

# G-3
DELIMITER //

CREATE PROCEDURE CreateNewSale
	(IN		varNewCustomerID			INT,
	 IN		varNewEmployeeID			INT,
	 IN		varNewSaleDate				Char(35),
	 IN		varNewItemID				INT,
	 IN		varNewItemPrice				Decimal(9,2)
	)

BEGIN 
	DECLARE	varSaleID        INT;

	# Start transaction - Rollback everything if unable to complete it.
	START TRANSACTION;

	# INSERT the new SALE data.

	INSERT INTO SALE (CustomerID, EmployeeID, SaleDate) VALUES(
		varNewCustomerID, varNewEmployeeID, varNewSaleDate);

   # Get new SaleID surrogate key value.
    SET varSaleID = LAST_INSERT_ID();

	# INSERT the new SALE_ITEM

	INSERT INTO SALE_ITEM (SaleID, SaleItemID, ItemID, ItemPrice) VALUES (
		varSaleID, 1, varNewItemID, varNewItemPrice);
		# Commit the Transaction
		COMMIT;

	# The transaction is completed. Print message
	SELECT 'The new SALE is created.'
		AS CreateNewShipmentResults;

END;
//
DELIMITER ;

# Test this use:

CALL CreateNewSale(1, 1, '2015-06-10', 1, 500);

SELECT * FROM SALE;


 