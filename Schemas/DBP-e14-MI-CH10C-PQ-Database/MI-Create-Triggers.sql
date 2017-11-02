

# F.1
DELIMITER //

CREATE PROCEDURE ReassignShipmentItem
	(IN		varOldShipmentID		Int,
	 IN		varShipmentItemID		int,
     IN     varNewShipmentID		int)

proc: BEGIN

	DECLARE	varOldRowCount				Int; # number of child rows for old  SHIPMENT
    DECLARE varNewRowCount				Int; # number of child rows in new SHIPMENT to reassign to
	DECLARE	varCurrentShipmentID		Int; 
    DECLARE varMaxItem					Int; # highest item number in new child set

	# Check to see if the currrent (old) SHIPMENT has more than one SHIPMENT_ITEM.

	SELECT		ShipmentID 
	FROM		SHIPMENT
	WHERE		ShipmentID  = varOldShipmentID
	INTO		varCurrentShipmentID;

	SELECT	 	COUNT(*) INTO varOldRowCount
	FROM		SHIPMENT_ITEM
	WHERE		ShipmentID = varCurrentShipmentID;
    
    # IF varRowCount = 0 THEN error, no child row, ROLLBACK and exit.
	IF (varOldRowCount = 0)
		THEN
		SELECT 'Error: No child shipment_item for shipment. Rollback.'
			AS	NoChildShipmentItem;
		ROLLBACK;
        LEAVE proc; # get out
	END IF;
    # determine how many child rows belong to the proposed new SHIPMENT
    # since we will have to update the new shipment_ID = max id plus 1;
    SELECT	 	COUNT(*) INTO varNewRowCount
	FROM		SHIPMENT_ITEM
	WHERE		ShipmentID = varNewShipmentID;
    IF (varNewRowCount = 0) 
    THEN 
    SELECT 'Error: new parent SHIPMENT does not have any rows, M:M violation.'
		AS ReAssignError;
        ROLLBACK;
	LEAVE proc;
    END IF;
    
    SELECT max(ShipmentItemID) into varMaxItem
    FROM  SHIPMENT_ITEM
    WHERE ShipmentID = varNewShipmentID;

	# IF varRowCount = 1 THEN reasssign the SHIPMENT_ITEM row and delete parent SHIPMENT row.
    # update the itemID to be one higher than current max id (otherwise we will have duplicate PK).
	IF (varOldRowCount = 1)
		THEN
        START TRANSACTION;
		SELECT 'Reassigning last SHIPMENT_ITEM row and deteting old SHIPMENT parent row.'
			AS	ReassignLastChildDeleteOldParent;
		# assign current shipment_item to new parent shipment
		UPDATE SHIPMENT_ITEM
        SET ShipmentID = varNewShipmentID, ShipmentItemID = varMaxItem+1
        WHERE ShipmentID = varOldShipmentID
        AND ShipmentItemID = varShipmentItemID;
        # delete old parent row
        DELETE from SHIPMENT
        WHERE ShipmentID = varOldShipmentID
        LIMIT 1; # just to be safe only delete one parent row
        COMMIT;
        SELECT 'Last SHIPMENT_ITEM row reassigned, old SHIPMENT parent row deleted.'
			AS	ReassignDeleteComplete;
		LEAVE proc;
        
	END IF; # last remaing child

	# IF varRowCount > 1 THEN lust REASSIGN the shipment_item to new parent.
	IF (varOldRowCount > 1)
		THEN
		# Start transaction - Rollback everything if unable to complete it.
		START TRANSACTION;
		SELECT 'Reassigning SHIPMENT_ITEM row to new parent SHIPMENT row.'
			AS	ReassignChild;
            
		# assign current shipment_item to new parent shipment
		UPDATE SHIPMENT_ITEM
        SET ShipmentID = varNewShipmentID, ShipmentItemID = varMaxItem+1
        WHERE ShipmentID = varOldShipmentID
        AND ShipmentItemID = varShipmentItemID;
		# Commit the Transaction
		COMMIT;

	# The transaction is completed. Print message
	SELECT 'The Shipment_item is reassigned to the new SHIPMENT.'
		AS ReassignShipmentItemComplete;

	END IF; # rowcount > 1

END proc;
//
DELIMITER ;


# make new test data
INSERT INTO SHIPMENT VALUES (106, 
		2, 104, 488955,  'Albany', 'Portland', '2015-08-05', '2015-08-09', '2015-09-11');
INSERT INTO SHIPMENT_ITEM VALUES(106, 1, 500, 14000);

INSERT INTO SHIPMENT_ITEM VALUES(106, 2, 505, 15000);

# Test, will change shipment_item row with key 106,1 to 101, 3.
CALL ReAssignShipmentItem (106, 1, 101);
# This will assign last row of SHIPMENT_ITEM 106,2  to 101,4 and delete SHIPMENT 106
CALL ReAssignShipmentItem (106, 2, 101);

# Error, the new shipment does not exist
CALL ReAssignShipmentItem (100, 1, 107);


# F.2
DELIMITER //
CREATE PROCEDURE DeleteShipment
	(IN		varShipmentID		Int,
	 IN		varShipmentItemID	Int)
spicwt:BEGIN

	DECLARE	varRowCount			  Int;

	# Check to see if the SHIPMENT has more than one SHIPMENT_ITEM.

	SELECT	COUNT(*) INTO varRowCount
	FROM	SHIPMENT_ITEM
	WHERE	 ShipmentID = varShipmentID;

	# IF varRowCount > 1 THEN do NOT delete the invoice.
	IF (varRowCount > 1)
		THEN
		SELECT 'The SHIPMENT has more than one SHIPMENT_ITEM.'
			AS	DeleteShipmentResultsDeleteDenied;
		ROLLBACK;
        LEAVE spicwt;
	END IF;

	# IF varRowCount = 1 THEN DELETE the shipment.
	# Start transaction - Rollback everything if unable to complete it.

	# DELETE the SHIPMENT_ITEM.
	DELETE FROM SHIPMENT_ITEM
	WHERE	ShipmentID = varShipmentID
	  AND   ShipmentItemID = varShipmentItemID;

	# DELETE the SHIPMENT.
	DELETE FROM SHIPMENT
	WHERE	ShipmentID = varShipmentID;

	# Commit the Transaction
	COMMIT;

	# The transaction is completed. Print message
	SELECT 'The SHIPMENT is deleted.'
		AS DeleteShipmentResultsDeleteOccured;

END spicwt;
//
DELIMITER ;

# To test this trigger, use:                                                   */

#   (1)	To generate an error message

    CALL DeleteShipment (105, 3);

#   (2)	To delete a SHIPMENT with no child SHIPMENT_ITEM rows

    CALL DeleteShipment (102, 1);

    SELECT * FROM SHIPMENT;
    
    # F.3
    DELIMITER //

CREATE PROCEDURE CreateNewShipment
	(IN		varNewShipperID				INT,
	 IN		varNewPurchasingAgentID		INT,
	 IN		varNewShipperInvoiceNumber	INT,
	 IN		varNewOrigin				Char(35),
	 IN		varNewDestination			Char(35),
	 IN		varNewItemID				INT)

BEGIN 
	DECLARE	varShipmentID        INT;

	# Start transaction - Rollback everything if unable to complete it.
	START TRANSACTION;

	# INSERT the new SHIPMENT data.

	INSERT INTO SHIPMENT (ShipperID, PurchasingAgentID, ShipperInvoiceNumber,
						  Origin, Destination) VALUES(
		varNewShipperID, varNewPurchasingAgentID, varNewShipperInvoiceNumber,
		varNewOrigin, varNewDestination);

   # Get new CustomerID surrogate key value.
    SET varShipmentID = LAST_INSERT_ID();

	# INSERT the new SHIPMENT_ITEM

	INSERT INTO SHIPMENT_ITEM (ShipmentID, ShipmentItemID, ItemID, InsuredValue) VALUES (
		varShipmentID, 1, varNewItemID, 0);
		# Commit the Transaction
		COMMIT;

	# The transaction is completed. Print message
	SELECT 'The new SHIPMENT is created.'
		AS CreateNewShipmentResults;

END;
//
DELIMITER ;

/*  To test this procedure, use:                                          */

 CALL CreateNewShipment
   (1, 103, 1234, 'Peru','Seattle',500);

    
    
    
