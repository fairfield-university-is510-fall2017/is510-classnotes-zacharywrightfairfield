/* 7.103 */
CREATE VIEW 	ComputerView AS
	SELECT 	SerialNumber, concat(RTRIM(Make), ': ', RTRIM(Model)) AS ComputerType
	FROM 		COMPUTER;

# To test the view, use
SELECT * FROM ComputerView;

/* 7.104 */
CREATE VIEW 	ComputerMakeView AS
	SELECT 	Make, AVG(ProcessorSpeed) AS AverageProcessorSpeed
	FROM 		COMPUTER
	GROUP BY 	Make;

# To test the view, use
SELECT * FROM ComputerMakeView;

/* 7.105 */
CREATE VIEW ComputerUserView AS
	SELECT	C.SerialNumber, Make, Model,
			ProcessorType, ProcessorSpeed, MainMemory, DiskSize,
			EmployeeNumber, DateAssigned, DateReassigned
	FROM 	COMPUTER AS C, COMPUTER_ASSIGNMENT AS CA
	WHERE 	C.SerialNumber = CA.SerialNumber;

# To test the view, use
SELECT * FROM ComputerUserView;

/* 7.06 */

CREATE VIEW EmployeeComputerAssignmentView AS
	SELECT 	CV.SerialNumber, CV.ComputerType,
				concat(RTRIM(FirstName), ' ', RTRIM(LastName)) AS EmployeeName
	FROM 		ComputerView AS CV, COMPUTER_ASSIGNMENT AS CA, EMPLOYEE AS E
	WHERE		CV.SerialNumber = CA.SerialNumber
		AND		CA.EmployeeNumber = E.EmployeeNumber
		AND		CA.DateReassigned IS NULL;

# To test the view, use
SELECT * FROM EmployeeComputerAssignmentView;

/* 7.107 */
DELIMITER //
CREATE FUNCTION ComputerMakeAndModel
-- These are the input parameters
		(
		 varMake		Char(12),
		 varModel		Char(24)
		)
RETURNS Varchar(40) DETERMINISTIC
BEGIN 
	-- This is the variable that will hold the value to be returned
	DECLARE	varFullName	Varchar(60);
	-- SQL statements to concatenate the names in the proper order
	SET varFullName = CONCAT(RTRIM(varMake), ': ', RTRIM(varModel));
	-- Return the concatenated name
	RETURN varFullName;

END
//
DELIMITER ;

# Test
SELECT 		SerialNumber, ComputerMakeAndModel(Make, Model) AS ComputerType
FROM 		COMPUTER;

/* 7.108 */
CREATE VIEW ComputerMakeAndModelView AS
	SELECT	SerialNumber, ComputerMakeAndModel(Make, Model) AS ComputerType
	FROM 	COMPUTER;
				
/******  Query View *************************************************************/

SELECT		*
FROM		ComputerMakeAndModelView;

# 7.109 - 110  Prose
