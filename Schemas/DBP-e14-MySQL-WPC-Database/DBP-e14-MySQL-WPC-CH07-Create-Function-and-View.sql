/* 7.84 */
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

/******  Test Function  *********************************************************/

SELECT	LastNameFirst(E.FirstName, E.LastName) AS EmployeeName,
	E.Department, D.OfficeNumber,
	D.Phone AS DepartmentPhone,
	E.Phone AS EmployeePhone
FROM	EMPLOYEE AS E JOIN DEPARTMENT AS D
	ON	E.Department = D.DepartmentName;

/* 7.85 */
CREATE VIEW EmployeeDepartmentDataView AS
	SELECT	LastNameFirst(E.FirstName, E.LastName) AS EmployeeName,
		E.Department, D.OfficeNumber,
		D.Phone AS DepartmentPhone,
		E.Phone AS EmployeePhone
	FROM	EMPLOYEE AS E JOIN DEPARTMENT AS D
		ON	E.Department = D.DepartmentName;
				
/******  Query View *************************************************************/

SELECT		*
FROM		EmployeeDepartmentDataView
ORDER BY	EmployeeName;

/* 7.86 - 7.100 prose, but note MySQL does not support INSTEAD OF triggers,
or ROLLBACKS in triggers, in most cases procedures can be used instead. */
