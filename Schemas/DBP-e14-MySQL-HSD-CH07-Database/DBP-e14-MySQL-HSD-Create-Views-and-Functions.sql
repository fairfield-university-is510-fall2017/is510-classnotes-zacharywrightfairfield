/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 07 Case		*/
/*																				*/
/*	Heather Sweeny Designs [HSD] Database Create Views and Functions			*/
/*																				*/
/*	These are the MySQL 5.6 code solutions										*/
/*																				*/
/********************************************************************************/

/*****   Case Question R   ******************************************************/
# use hsd;

CREATE VIEW InvoiceSummaryView AS
	SELECT	I.InvoiceNumber, I.InvoiceDate,
			LI.LineNumber, LI.ProductNumber,
			P.ProductDescription, LI.UnitPrice
	FROM	INVOICE I JOIN LINE_ITEM LI
		ON	I.InvoiceNumber = LI.InvoiceNumber 
			JOIN PRODUCT P
				ON	LI.ProductNumber = P. ProductNumber;


SELECT		*
FROM		InvoiceSummaryView
ORDER BY	InvoiceNumber, LineNumber;



/*****   Case Question S   ******************************************************/
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


SELECT		LastNameFirst(FirstName, LastName) AS CustomerName, 
			Phone, EmailAddress
FROM		CUSTOMER
ORDER BY	CustomerName;

/*****   Case Question T   ******************************************************/

CREATE VIEW CustomerInvoiceSummaryView AS
	SELECT	I.InvoiceNumber, I.InvoiceDate,
			LastNameFirst (FirstName, LastName) AS CustomerName, 
			C.EmailAddress,
			I.Total
			FROM	INVOICE I JOIN CUSTOMER C
		ON	I.CustomerID = C.CustomerID;


SELECT		*
FROM		CustomerInvoiceSummaryView
ORDER BY	InvoiceNumber;







