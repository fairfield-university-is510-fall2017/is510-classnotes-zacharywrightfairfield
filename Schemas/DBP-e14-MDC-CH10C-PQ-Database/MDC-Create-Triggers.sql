# V.1
DELIMITER //

CREATE PROCEDURE AssignNewInvoice
			(IN varInvoiceNumber		Int,
			 IN newCustomerID	        Int)

BEGIN

	# INVOICE changes are not allowed - ROLLBACK transaction.
	ROLLBACK;
	SELECT 'Customer assigned to INVOICE changes are not allowed.'
		AS ReassignEmployeeDepartment;

END
//
DELIMITER ;

CALL AssignNewInvoice (2015001, 100);   

# V.2
DELIMITER //
CREATE PROCEDURE DeleteInvoice
	(IN		varInvoiceNumber		Int)
spicwt:BEGIN

	DECLARE	varRowCount			  Int;

	# Check to see if the INVOICE has more than one INVOICE_ITEM.

	SELECT	COUNT(*) INTO varRowCount
	FROM	INVOICE_ITEM
	WHERE	 InvoiceNumber = varInvoiceNumber;

	# IF varRowCount > 1 THEN do NOT delete the invoice.
	IF (varRowCount > 1)
		THEN
		SELECT 'The INVOICE has more than one INVOICE_ITEM.'
			AS	DeleteInvoiceResultsDeleteDenied;
		ROLLBACK;
        LEAVE spicwt;
	END IF;

	# IF varRowCount = 1 THEN DELETE the invoice.
	# Start transaction - Rollback everything if unable to complete it.

	# DELETE the INVOICE_ITEM.
	DELETE FROM INVOICE_ITEM
	WHERE	InvoiceNumber = varInvoiceNumber;

	# DELETE the INVOICE.
	DELETE FROM INVOICE
	WHERE	InvoiceNumber = varInvoiceNumber;

	# Commit the Transaction
	COMMIT;

	# The transaction is completed. Print message
	SELECT 'The INVOICE is deleted.'
		AS DeleteInvoiceResultsDeleteOccured;

END spicwt;
//
DELIMITER ;


/* To test this trigger, use:                                                   */

#   (1)	To generate an error message

    CALL DeleteInvoice (2015008);

#   (2)	To delete an invoice with only one invoice_item

    CALL DeleteInvoice (2015009);

    SELECT * FROM INVOICE;
    
    # V.3
    
    DELIMITER //

CREATE PROCEDURE CreateNewInvoice
	(IN		varNewCustomerID		INT,
	 IN		varNewDateIn			Date,
	 IN		varNewServiceID			INT)

BEGIN 
	DECLARE	varInvoiceNumber        INT;

	# Start transaction - Rollback everything if unable to complete it.
	START TRANSACTION;

	# Get the next invoice number
	SELECT max(InvoiceNumber)+1 INTO varInvoiceNumber
	FROM INVOICE;

	# INSERT the new INVOICE data.

	INSERT INTO INVOICE (InvoiceNumber, CustomerID, DateIn) VALUES(
		varInvoiceNumber, varNewCustomerID, VarNewDateIn);

	# INSERT the new INVOICE_ITEM

	INSERT INTO INVOICE_ITEM (InvoiceNumber, ItemNumber, ServiceID, Quantity) VALUES (
		varInvoiceNumber, 1, varNewServiceID, 1);
		# Commit the Transaction
		COMMIT;

	# The transaction is completed. Print message
	SELECT 'The new INVOICE is created.'
		AS CreateNewInvoiceResults;

END;
//
DELIMITER ;

/*  To test this procedure, use:                                          */

 CALL CreateNewInvoice
   (100, '2015-10-04', 10);

SELECT * FROM INVOICE;

