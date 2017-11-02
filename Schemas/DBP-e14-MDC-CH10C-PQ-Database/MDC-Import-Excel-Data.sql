#   Z
DELIMITER //
CREATE FUNCTION GetLastNameCommaSeparated
-- These are the input parameters
(
varName VARCHAR(25)
)
RETURNS VARCHAR(25) DETERMINISTIC
BEGIN
-- This is the variable that will hold the value to be returned
DECLARE varLastName VARCHAR(25);
-- This is the variable that will hold the position of the comma
DECLARE varIndexValue INT;
-- SQL statement to find the comma separator
SET varIndexValue = LOCATE(',', varName);
-- SQL statement to determine last name
SET varLastName = SUBSTRING(varName, 1, (varIndexValue - 1));
-- Return the last name
RETURN varLastName;
END
//
DELIMITER ;

# test above function
select getlastnamecommaseparated("Wilson, Marcia");


# AA
DELIMITER //
CREATE FUNCTION GetFirstNameCommaSeparated
-- These are the input parameters
(
varName VARCHAR(50)
)
RETURNS VARCHAR(25) DETERMINISTIC
BEGIN
-- This is the variable that will hold the value to be returned
DECLARE varFirstName VARCHAR(25);
-- This is the variable that will hold the position of the comma
DECLARE varIndexValue INT;
-- SQL statement to find the comma separator
SET varIndexValue = LOCATE(',', varName);
-- SQL statement to determine last name
SET varFirstName = SUBSTRING(varName, (varIndexValue + 2));
-- Return the first name
RETURN varFirstName;
END
//
DELIMITER ;

# test above function
select getfirstnamecommaseparated("Wilson, Marcia");

# AB
ALTER TABLE EMPLOYEE_TEMP
  ADD EmployeeLastName Char(25) NULL;
  
ALTER TABLE EMPLOYEE_TEMP
  ADD EmployeeFirstName Char(25) NULL;

# AC
UPDATE EMPLOYEE_TEMP
  		SET EmployeeLastName = GetLastNameCommaSeparated(EmployeeName);
  
SELECT * FROM EMPLOYEE_TEMP;

# AD
UPDATE EMPLOYEE_TEMP
  			SET EmployeeFirstName = GetFirstNameCommaSeparated(EmployeeName);
  
SELECT * FROM EMPLOYEE_TEMP;

# AE
CREATE TABLE EMPLOYEE (
			EmployeeID		INT NOT NULL AUTO_INCREMENT,
			EmployeeLastName	Char(25) NOT NULL,
			EmployeeFirstName	Char(25) NOT NULL,
			PayrollCategory 	VarChar(45) NULL,
			EmailAddress		VarChar(100) NULL,
			Phone			Char(12) NULL,
			CONSTRAINT EMPLOYEE_PK PRIMARY KEY (EmployeeID));

# AF
INSERT INTO EMPLOYEE
	SELECT null, ET.EmployeeLastName, ET.EmployeeFirstName, ET.PayrollCategory,ET.EmailAddress, ET.Phone
	FROM (SELECT DISTINCT EmployeeLastName, EmployeeFirstName, PayrollCategory, EmailAddress, Phone
			FROM EMPLOYEE_TEMP) ET;
            
select * from EMPLOYEE;

# AG
ALTER TABLE EMPLOYEE_TEMP
		ADD EmployeeID Int NULL;

UPDATE EMPLOYEE_TEMP
 	 	SET EmployeeID =
   		(SELECT EmployeeID
    		FROM EMPLOYEE E
    		WHERE E.EmployeeLastName = EMPLOYEE_TEMP.EmployeeLastName
     			AND E.EmployeeFirstName = EMPLOYEE_TEMP.EmployeeFirstName);

select * from employee_temp;

# AH
CREATE TABLE INVOICE_EMPLOYEE_INT (
		InvoiceNumber		Int NOT NULL,
		EmployeeID		Int NOT NULL,
		CONSTRAINT I_E_INT_PK PRIMARY KEY (InvoiceNumber, EmployeeID),
		CONSTRAINT I_E_INVOICE_FK FOREIGN KEY (InvoiceNumber)
			REFERENCES INVOICE (InvoiceNumber),
		CONSTRAINT I_E_EMPLOYEE_FK FOREIGN KEY (EmployeeID)
	REFERENCES EMPLOYEE (EmployeeID));

# AI
INSERT INTO INVOICE_EMPLOYEE_INT
		SELECT InvoiceNumber, EmployeeID
		FROM EMPLOYEE_TEMP;
        
select * from INVOICE_EMPLOYEE_INT;





