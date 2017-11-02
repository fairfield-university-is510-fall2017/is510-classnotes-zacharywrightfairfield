/* 7.41 */
CREATE TABLE DEPARTMENT(
		DepartmentName	Char(35)		NOT NULL,
		BudgetCode		Char(30)		NOT NULL,
		OfficeNumber		Char(15)		NOT NULL,
		Phone				Char(12)		NOT NULL,
		CONSTRAINT		DEPARTMENT_PK 	PRIMARY KEY(DepartmentName)
		);

/* 7.42 */
CREATE TABLE EMPLOYEE(
		EmployeeNumber	Int				NOT NULL AUTO_INCREMENT,
		FirstName			Char(25)		NOT NULL,
		LastName			Char(25)		NOT NULL,
		Department		Char(35)		NOT NULL DEFAULT 'Human Resources',
		Phone				Char(12)		NULL,
		Email				VarChar(100) 	NOT NULL UNIQUE,
		CONSTRAINT		EMPLOYEE_PK 	PRIMARY KEY(EmployeeNumber),
		CONSTRAINT		EMP_DEPART_FK	FOREIGN KEY(Department)
								REFERENCES	DEPARTMENT(DepartmentName)
									ON UPDATE CASCADE
		);

ALTER TABLE EMPLOYEE AUTO_INCREMENT=1;

/* 7.43 */
CREATE TABLE PROJECT(
		ProjectID			Int				NOT NULL AUTO_INCREMENT,
		Name				Char(50)		NOT NULL,
		Department		Char(35)		NOT NULL,
		MaxHours			Numeric(8,2)	NOT NULL DEFAULT 100,
		StartDate			DateTime		NULL,
		EndDate			DateTime		NULL,
		CONSTRAINT 		PROJECT_PK	PRIMARY KEY(ProjectID),
		CONSTRAINT		PROJ_DEPART_FK	FOREIGN KEY(Department)
								REFERENCES	DEPARTMENT(DepartmentName)
									ON UPDATE CASCADE
		);

ALTER TABLE PROJECT AUTO_INCREMENT=1000; /* insert ProjectID data 1000 , 1100, 1200 manually */

/* 7.44 */

CREATE TABLE ASSIGNMENT (
		ProjectID			Int				NOT NULL,
		EmployeeNumber	Int 			NOT NULL,
		HoursWorked		Numeric(6,2)	NULL,
		CONSTRAINT 		ASSIGNMENT_PK 	PRIMARY KEY(ProjectID, EmployeeNumber),
		CONSTRAINT 		ASSIGN_PROJ_FK	FOREIGN KEY(ProjectID)
								REFERENCES 	PROJECT(ProjectID)
								ON DELETE CASCADE,
		CONSTRAINT 		ASSIGN_EMP_FK	FOREIGN KEY(EmployeeNumber)
								REFERENCES	EMPLOYEE(EmployeeNumber)
								ON DELETE NO ACTION
		);

/* 7.45  do not run */
/* check constraint is not enforced by MySQL and gnerates a syntax warning flag */
/*
ALTER TABLE PROJECT
	ADD CONSTRAINT		DateValuesCheck	CHECK (StartDate < EndDate);
  */  
  
  /* 7.46 DO NOT RUN */
  /* ALTER TABLE SQL Statement                                        */
/* 
ALTER TABLE ASSIGNMENT
	ADD CONSTRAINT			ASSIGNENT_AK1		UNIQUE(EmployeeNumber);

 */ 
  
/* 7.47 */
ALTER  TABLE EMPLOYEE
	ADD		AreaCode			Char(3)	NULL;
    
/* 7.48 */
ALTER  TABLE EMPLOYEE
	DROP COLUMN AreaCode;

/* 7.49 */
ALTER  TABLE EMPLOYEE
	ADD		CONSTRAINT			EMPLOYEE_AK2	UNIQUE(Phone);
    
/* 7.50 */
DROP index  EMPLOYEE_AK2 on employee;

/* 

/* 7.51 see WPC-Insert-DEPARTMENT-Data.sql */
/* 7.52 see WPC-Insert-EMPLOYEE-Data.sql */
/* 7.53 see WPC-Insert-PROJECT-Data.sql */
/* 7.54 see WPC-Insert-ASSIGNMENT-Data.sql */
/* 7.55 prose */
/* 7.56 DO NOT RUN */
/*
INSERT INTO EMPLOYEE (Department, Email, FirstName, LastName)
	SELECT Department, Email, FirstName, LastName
	FROM NEW_EMPLOYEE;
*/
/* 7.57 thru 7.62 is in WPC-Update-Data.sql  */







