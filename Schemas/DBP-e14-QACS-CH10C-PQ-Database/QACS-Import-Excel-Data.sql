# K
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
select GetLastNameCommaSeparated("Frost, Robert");

# L
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
-- SQL statement to determine last name1
SET varFirstName = SUBSTRING(varName, (varIndexValue + 2));
-- Return the first name
RETURN varFirstName;
END
//
DELIMITER ;

# test above function
select getfirstnamecommaseparated("Frost, Robert");

# M
ALTER TABLE payroll_temp
  ADD EmployeeLastName Char(25) NULL;
  
ALTER TABLE payroll_temp
  ADD EmployeeFirstName Char(25) NULL;

# N
UPDATE payroll_temp
  		SET EmployeeLastName = GetLastNameCommaSeparated(EmployeeName);
  
# O
UPDATE payroll_temp
  			SET EmployeeFirstName = GetFirstNameCommaSeparated(EmployeeName);
  
# test N and O
SELECT * FROM payroll_temp;

# drop table payroll_category;

CREATE TABLE PAYROLL_CATEGORY (
		PayrollCategoryID		INT NOT NULL auto_increment,
		CategoryDescription 	VarChar(45) NULL,
		PayRate			VarChar(45) NULL,
		CONSTRAINT PC_PK PRIMARY KEY (PayrollCategoryID));


# Q
INSERT INTO PAYROLL_CATEGORY
		SELECT null, PT.PayrollCategory, PT.PayRate
		FROM (SELECT DISTINCT PayrollCategory, PayRate
		      FROM PAYROLL_TEMP) PT;

select * from payroll_category;

# R
ALTER TABLE PAYROLL_TEMP
		ADD EmployeeID Int NULL;

   UPDATE PAYROLL_TEMP 
 		 SET EmployeeID =
   			(SELECT EmployeeID
   			 FROM EMPLOYEE
   			 WHERE EMPLOYEE.LastName = payroll_temp.employeelastname
             AND EMPLOYEE.FirstName = payroll_temp.EmployeeFirstName);
             
# S
ALTER TABLE PAYROLL_TEMP
		ADD PayrollCategoryID INT NULL;
        
select * from payroll_temp;

   UPDATE PAYROLL_TEMP
  		SET PayrollCategoryID =
			(SELECT PayrollCategoryID
			 FROM PAYROLL_Category PC
			 WHERE PayrollCategory = PC.CategoryDescription);

# T
CREATE TABLE PAYROLL (
		PayrollEntryID	Int NOT NULL auto_increment,
		EmployeeID		Int NOT NULL,
		PayrollCategoryID	Int NOT NULL,
		PayDate		DATE,
		HoursWorkd		Int,
		PaycheckAmount	NUMERIC(9,2),
		CONSTRAINT PAYROLL_PK PRIMARY KEY (PayrollEntryID),
		CONSTRAINT PAYROLL_FK_EMPLOYEE FOREIGN KEY (EmployeeID)
			REFERENCES EMPLOYEE (EmployeeID),
		CONSTRAINT PAYROLL_FK_CATEGORY FOREIGN KEY (PayrollCategoryID) 
REFERENCES PAYROLL_CATEGORY (PayrollCategoryID));

Alter table payroll auto_increment = 20150001;


# U
INSERT INTO PAYROLL
SELECT null, PT.EmployeeID, PT.PayrollCategoryID, 
PT.PayrollPayDate, PT.HoursWorked, PT.PaycheckAmount
    FROM (SELECT DISTINCT EmployeeID, PayrollCategoryID, PayrollPayDate,
          	HoursWorked, PaycheckAmount
        	FROM PAYROLL_TEMP) PT;
        
SELECT * FROM PAYROLL;


     