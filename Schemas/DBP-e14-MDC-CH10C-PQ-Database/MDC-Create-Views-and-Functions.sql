# L
CREATE VIEW OrderSummaryView AS
	SELECT 	I.InvoiceNumber, I.DateIn, I.DateOut,
				II.ItemNumber, II.ServiceID, II.ExtendedPrice
	FROM 		INVOICE AS I, INVOICE_ITEM AS II
	WHERE		I.InvoiceNumber = II.InvoiceNumber;

# To test this, run the following command:
SELECT * FROM OrderSummaryView;

# M
CREATE VIEW CustomerOrderSummaryView AS
	SELECT 	I.InvoiceNumber, C.FirstName, C.LastName, C.Phone,
				I.DateIn, I.DateOut, I.Subtotal,
				II.ItemNumber, II.ServiceID, II.ExtendedPrice
	FROM 		CUSTOMER AS C, INVOICE AS I, INVOICE_ITEM AS II
	WHERE		C.CustomerID = I.CustomerID
		AND		I.InvoiceNumber = II.InvoiceNumber;
# To test this, run the following command:
SELECT * FROM CustomerOrderSummaryView;

# N
CREATE VIEW CustomerOrderHistoryView AS
	SELECT 	I.InvoiceNumber, C.FirstName, C.LastName, C.Phone,
				I.DateIn, I.DateOut, I.Subtotal,
				II.ExtendedPrice,
				SUM(II.ExtendedPrice) AS TotalExtendedPrice,
				AVG(II.ExtendedPrice) AS AverageExtendedPrice
	FROM 		CUSTOMER AS C, INVOICE AS I, INVOICE_ITEM AS II
	WHERE		C.CustomerID = I.CustomerID
		AND		I.InvoiceNumber = II.InvoiceNumber
        GROUP BY	C.FirstName, C.LastName, I.InvoiceNumber;
				

	#GROUP BY	C.LastName, C.FirstName, I.InvoiceNumber;
#
drop view customerorderhistoryview;
	
# To test this, run the following command
SELECT *
FROM		CustomerOrderHistoryView
order by Lastname, firstname, InvoiceNumber;

# O
CREATE VIEW CustomerOrderCheckView AS
	SELECT 	CH.LastName, CH.FirstName,
				CH.InvoiceNumber, CH.Subtotal, CH.ExtendedPrice
	FROM 		CustomerOrderHistoryView AS CH
	WHERE		CH.Subtotal <> CH.ExtendedPrice;

# To test this, run the following command
SELECT		* 
FROM		CustomerOrderCheckView
ORDER BY	LastName, FirstName, InvoiceNumber;

# P - prose

# Q
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

select LastNameFirst('Robert','Frost');

# R
CREATE VIEW CustOrderSummaryView  AS
	SELECT 	LastNameFirst(FirstName, LastName) AS CustomerName,
				  InvoiceNumber, DateIn, DateOut, Total
	FROM 		Customer AS C, Invoice AS I
	WHERE		C.CustomerID = I.CustomerID;

SELECT * FROM CustOrderSummaryView;

# S
DELIMITER //

CREATE FUNCTION FirstNameFirst
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
	SET varFullName = CONCAT(varFirstName, ' ', varLastName);
	-- Return the concatenated name
	RETURN varFullName;

END
//

DELIMITER ;

select FirstNameFirst('Robert','Frost');

# T 
CREATE VIEW CustomerDataView  AS
	SELECT 	FirstNameFirst(FirstName, LastName) AS CustomerName,
				  Phone, Email
	FROM 		Customer;

SELECT * FROM CustomerDataView;
