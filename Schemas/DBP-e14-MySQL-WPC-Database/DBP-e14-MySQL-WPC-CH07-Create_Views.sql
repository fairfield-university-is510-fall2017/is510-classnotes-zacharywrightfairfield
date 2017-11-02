/* 7.65 - 66 Prose */

/* 7.67 */
/******  Create View  *******************************************************/

					
CREATE VIEW EmployeePhoneView AS
	SELECT	LastName AS EmployeeLastName,
			FirstName AS EmployeeFirstName,
			Phone AS EmployeePhone
	FROM	EMPLOYEE;

/******  Query View *********************************************************/

SELECT		*
FROM		EmployeePhoneView
ORDER BY	EmployeeLastName;

/* 7.68 */
CREATE VIEW FinanceEmployeePhoneView AS
	SELECT	LastName AS EmployeeLastName, FirstName AS EmployeeFirstName,
			Phone AS EmployeePhone
	FROM	EMPLOYEE
	WHERE	Department = 'Finance';

/******  Query View ********************************************************/

SELECT		*
FROM		FinanceEmployeePhoneView
ORDER BY	EmployeeLastName;


/* 7.69 */
/******  Create View  *****************************************************/
					
CREATE VIEW CombinedNameEmployeePhoneView AS
	SELECT	CONCAT(RTRIM(FirstName),' ',RTRIM(LastName)) AS EmployeeName,
			Phone AS EmployeePhone
	FROM	EMPLOYEE;

/******  Query View *******************************************************/

SELECT		*
FROM		CombinedNameEmployeePhoneView
ORDER BY	EmployeeName;

/* 7.70 */
/******  Create View  *****************************************************/

CREATE VIEW EmployeeProjectAssignmentView AS
	SELECT	LastName AS EmployeeLastName,
			FirstName AS EmployeeFirstName,
			Phone AS EmployeePhone,
			P.Name AS ProjectName
	FROM	EMPLOYEE AS E, ASSIGNMENT AS A, PROJECT AS P
	WHERE	E.EmployeeNumber = A.EmployeeNumber
		AND A.ProjectID = P.ProjectID;

/******  Query View ********************************************************/

SELECT		*
FROM		EmployeeProjectAssignmentView
ORDER BY	EmployeeLastName, EmployeeFirstName;

/* 7.71 */
/******  Create View  *****************************************************/

CREATE VIEW DepartmentEmployeeProjectAssignmentView AS
	SELECT	LastName AS EmployeeLastName, FirstName AS EmployeeFirstName,
			E.Phone AS EmployeePhone,
D.DepartmentName, D.Phone AS DepartmentPhone,
			P.Name AS ProjectName
	FROM	EMPLOYEE AS E, ASSIGNMENT AS A, PROJECT AS P, DEPARTMENT AS D
	WHERE	E.EmployeeNumber = A.EmployeeNumber
		AND A.ProjectID = P.ProjectID
		AND	P.Department = D.DepartmentName;

/******  Query View *******************************************************/

SELECT		*
FROM		DepartmentEmployeeProjectAssignmentView
ORDER BY	EmployeeLastName, EmployeeFirstName;

/* 7.72 */
/******  Create View  ****************************************************/

CREATE VIEW	ProjectHoursToDateView AS
	SELECT		P.ProjectID, 	P.Name AS ProjectName,
				MaxHours AS ProjectMaxHours,
				SUM(HoursWorked) AS ProjectHoursWorkedToDate
	FROM		PROJECT AS P, ASSIGNMENT AS A
	WHERE		P.ProjectID = A.ProjectID
	GROUP BY	P.ProjectID, Name, MaxHours;

/******  Query View ******************************************************/

SELECT		*
FROM		ProjectHoursToDateView
ORDER BY	ProjectID;

/* 7.73 - 83 prose */
