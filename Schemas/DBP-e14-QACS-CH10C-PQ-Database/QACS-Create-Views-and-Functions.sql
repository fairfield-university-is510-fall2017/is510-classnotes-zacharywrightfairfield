# A
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

# test
select LastNameFirst('Robert','Frost');

# B
CREATE VIEW CustomerSaleSummaryView AS
  SELECT 	LastNameFirst(FirstName, LastName) AS CustomerName,
         			SaleID, SaleDate, Total  
   	FROM 	CUSTOMER C, SALE S
	WHERE	C.CustomerID = S.CustomerID;

# Test with:

SELECT * FROM CustomerSaleSummaryView;

# C

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

# test 
select FirstNameFirst('Robert','Frost');

# D
DELIMITER //
CREATE FUNCTION CityStateZIP
    (varCity 	Char(35),
     varState  	Char(35),
     varZip 	Char(10)
     )
  RETURNS      Varchar(100) DETERMINISTIC
  BEGIN
  DECLARE varResult Varchar(100);
  SET varResult= CONCAT(varCity,', ',varState,' ',varZip);
  RETURN varResult;
END
//
DELIMITER ;

# test 
select CityStateZip('Schenectady','New York','12345');

# E
CREATE VIEW CustomerMailingAddressView AS
	SELECT 	FirstNameFirst(FirstName, LastName) AS CustomerName,
         		Address AS  CustomerStreetAddress,
			CityStateZIP(City, State, Zip) AS CustomerCityStateZIP
    	FROM 		CUSTOMER;

# Test with:

SELECT * FROM CustomerMailingAddressView;


