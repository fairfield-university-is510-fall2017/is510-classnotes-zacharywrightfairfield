/****************************************************************************/
/*										                        	        */
/*	Kroenke and Auer - Database Processing (14th Edition) Ch 10C		 	*/
/*											                                */
/*	Wedgewood Pacific Corporation [WPC] Create Tables	      	   			*/
/*															                */
/*	These are the MySQL 5.6 SQL code solutions								*/
/*****************************************************************************/
/* 10C.30 */
CREATE  TABLE DEPARTMENT(
	DepartmentName	Char(35)		 NOT NULL,
	BudgetCode		  Char(30)	 	 NOT NULL,
	OfficeNumber	  Char(15)		 NOT NULL,
	Phone			      Char(12)		 NOT NULL,
	CONSTRAINT 		  DEPARTMENT_PK 	PRIMARY KEY(DepartmentName)
	);

CREATE  TABLE EMPLOYEE(
	EmployeeNumber	Int 			    NOT NULL auto_increment,
	FirstName		    Char(25) 		  NOT NULL,
	LastName        Char(25) 		  NOT NULL,
	Department		  Char(35)		  NOT NULL,
	Phone			      Char(12)		  NULL,
	Email 			    VarChar(100)	NOT NULL UNIQUE,
	CONSTRAINT 		  EMPLOYEE_PK 	PRIMARY KEY(EmployeeNumber),
	CONSTRAINT 		  EMP_DEPART_FK FOREIGN KEY(Department)
						          REFERENCES DEPARTMENT(DepartmentName)
	);


/******************************************************************************/
/*											                                    */
/*	Kroenke and Auer - Database Processing (14th Edition) 			   			*/
/*											                                    */
/*	Wedgewood Pacific Corporation Insert Data						            */
/*											                                    */
/*	These are the MySQL 5.6 code solutions							     		*/
/*	10C.31										                                    */
/******************************************************************************/

/*****   DEPARTMENT DATA   ****************************************************/

INSERT INTO DEPARTMENT VALUES('Administration', 'BC-100-10', 'BLDG01-300', '360-285-8100');
INSERT INTO DEPARTMENT VALUES('Legal', 'BC-200-10', 'BLDG01-200', '360-285-8200');
INSERT INTO DEPARTMENT VALUES('Accounting', 'BC-300-10', 'BLDG01-100', '360-285-8300');
INSERT INTO DEPARTMENT VALUES('Finance', 'BC-400-10', 'BLDG01-140', '360-285-8400');
INSERT INTO DEPARTMENT VALUES('Human Resources', 'BC-500-10', 'BLDG01-180', '360-285-8500');
INSERT INTO DEPARTMENT VALUES('Production', 'BC-600-10', 'BLDG02-100', '360-287-8600');
INSERT INTO DEPARTMENT VALUES('Marketing', 'BC-700-10', 'BLDG02-200', '360-287-8700');
INSERT INTO DEPARTMENT VALUES('InfoSystems', 'BC-800-10', 'BLDG02-270', '360-287-8800');

select * from department;

/*****   EMPLOYEE DATA   ********************************************************/

INSERT INTO EMPLOYEE VALUES(
	 null, 'Mary', 'Jacobs', 'Administration', '360-285-8110', 'Mary.Jacobs@WPC.com');
INSERT INTO EMPLOYEE VALUES(
	null, 'Rosalie', 'Jackson', 'Administration', '360-285-8120', 'Rosalie.Jackson@WPC.com');
INSERT INTO EMPLOYEE VALUES(
	null, 'Richard', 'Bandalone', 'Legal', '360-285-8210', 'Richard.Bandalone@WPC.com');
INSERT INTO EMPLOYEE VALUES(
	null, 'Tom', 'Caruthers', 'Accounting', '360-285-8310', 'Tom.Caruthers@WPC.com');
INSERT INTO EMPLOYEE VALUES(
	null, 'Heather', 'Jones', 'Accounting', '360-285-8320', 'Heather.Jones@WPC.com');
INSERT INTO EMPLOYEE VALUES(
	null, 'Mary', 'Abernathy', 'Finance', '360-285-8410', 'Mary.Abernathy@WPC.com');
INSERT INTO EMPLOYEE VALUES(
	null, 'George', 'Smith', 'Human Resources', '360-285-8510', 'George.Smith@WPC.com');
INSERT INTO EMPLOYEE VALUES(
	null, 'Tom', 'Jackson', 'Production', '360-287-8610', 'Tom.Jackson@WPC.com');
INSERT INTO EMPLOYEE VALUES(
	null, 'George', 'Jones', 'Production', '360-287-8620', 'George.Jones@WPC.com');
INSERT INTO EMPLOYEE VALUES(
	null, 'Ken', 'Numoto', 'Marketing', '360-287-8710', 'Ken.Numoto@WPC.com');
INSERT INTO EMPLOYEE(EmployeeNumber, FirstName, LastName, Department, Email)
	VALUES(
	null, 'James', 'Nestor', 'InfoSystems', 'James.Nestor@WPC.com');
INSERT INTO EMPLOYEE VALUES(
	null, 'Rick', 'Brown', 'InfoSystems', '360-287-8820', 'Rick.Brown@WPC.com');

select * from employee;
  
/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C       	*/
/*																				*/
/*	Wedgewood Pacific Corporation [WPC-CH10C-PQ] Project Questions 				*/
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions				                    */
/*																				*/
/********************************************************************************/

/***** Project Question 10C.32   ************************************************/
/***** Stored Procedure ReassignEmployeeDepartment  *****************************/

DELIMITER //

CREATE PROCEDURE ReassignEmployeeDepartment
			(IN varEmployeeNumber		Int,
			 IN newDepartment	      Char(35))

BEGIN

	# Department reassignments are not allowed - ROLLBACK transaction.
	ROLLBACK;
	SELECT 'Employee DEPARTMENT reassignments are not allowed.'
		AS ReassignEmployeeDepartment;

END
//
DELIMITER ;


/* To test this trigger, use:                                                   */

CALL ReassignEmployeeDepartment (1, 'Accounting');                          

/********************************************************************************/


/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C       	*/
/*																				*/
/*	Wedgewood Pacific Corporation [WPC-CH10C-PQ] Project Questions 				*/
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions				                    */
/*																				*/
/********************************************************************************/

/***** Project Question 10C.33   ************************************************/
/***** Stored Procedure DeleteDepartment  ***************************************/


DELIMITER //

CREATE PROCEDURE DeleteDepartment
	(IN		varDepartmentName		Char(35))

BEGIN

	DECLARE	varRowCount			  Int;
	DECLARE	varEmployeeID			Int;

	# Check to see if the DEPARTMENT has more than one EMPLOYEE.

	SELECT	COUNT(*) INTO varRowCount
	FROM		EMPLOYEE
	WHERE	 Department = varDepartmentName;

	# IF varRowCount > 1 THEN do NOT delete the department.
	IF (varRowCount > 1)
		THEN
		SELECT 'The DEPARTMENT has more than one EMPLOYEE.'
			AS	DeleteDepartmentResultsDeleteDenied;
		ROLLBACK;
	END IF;

	# IF varRowCount = 1 THEN DELETE the department.
	# Start transaction - Rollback everything if unable to complete it.
	START TRANSACTION;

	# Reassign the EMPLOYEE.
	SELECT EmployeeNumber
  FROM   EMPLOYEE
	WHERE  Department = varDepartmentName
  INTO   varEmployeeID;

	UPDATE EMPLOYEE
	SET		Department = 'Human Resources'
	WHERE	EmployeeNumber = varEmployeeID;

	# DELETE the DEPARTMENT.
	DELETE FROM DEPARTMENT
	WHERE	DepartmentName = varDepartmentName;

	# Commit the Transaction
	COMMIT;

	# The transaction is completed. Print message
	SELECT 'The DEPARTMENT is deleted.'
		AS DeleteDepartmentResultsDeleteOccured;

END;
//

DELIMITER ;


/* To test this trigger, use:                                                   */

#   (1)	To generate an error message

    CALL DeleteDepartment ('Accounting');

#   (2)	To delete a department

    CALL DeleteDepartment ('Finance');

    SELECT * FROM DEPARTMENT;

/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C       	*/
/*																				*/
/*	Wedgewood Pacific Corporation [WPC-CH10C-PQ] Project Questions 				*/
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions				                    */
/*																				*/
/********************************************************************************/

/***** Project Question 10C.34.A   **********************************************/
/***** Stored Procedure AllowReassignOfEmployeeDepartment  **********************/

DELIMITER //

CREATE PROCEDURE AllowReassignmentOfEmployeeDepartment

	(IN		varEmployeeNumber		  Int,
	 IN		varNewDepartmentName	 Char(35))

BEGIN

	DECLARE	varRowCount					      Int;
	DECLARE	varCurrentDepartmentName	 Char(35);

	# Check to see if the DEPARTMENT has more than one EMPLOYEE.

	SELECT	Department
	FROM		EMPLOYEE
	WHERE	 EmployeeNumber = varEmployeeNumber
	INTO		varCurrentDepartmentName;

	SELECT	COUNT(*) INTO varRowCount
	FROM		EMPLOYEE
	WHERE	 Department = varCurrentDepartmentName;

	# IF varRowCount = 1 THEN do NOT reasssign the employee.
	IF (varRowCount = 1)
		THEN
		  SELECT 'This the last EMPLOYEE in the DEPARTMENT.'
			    AS	ReassignEmployeeResultsReassignmentDenied;
		ROLLBACK;
	END IF;

	# IF varRowCount > 1 THEN REASSIGN the EMPLOYEE.
  IF (varRowCount > 1)
		THEN
    # Start transaction - Rollback everything if unable to complete it.
	  START TRANSACTION;

  	# Reassign the EMPLOYEE.

  	UPDATE EMPLOYEE
	  SET		Department = varNewDepartmentName
  	WHERE	EmployeeNumber = varEmployeeNumber;

  	# Commit the Transaction
	  COMMIT;

  	# The transaction is completed. Print message
	  SELECT 'The EMPLOYEE is reassigned to the new DEPARTMENT.'
		    AS ReassignEmployeeResultsReassignmentOccured;
    END IF;
END;
//
DELIMITER ;



/* To test this trigger, use:                                                   */

#   (1)	To generate an error message

   CALL AllowReassignmentOfEmployeeDepartment (10, 'Accounting');

#   (2)	To reassign an employee to a different department:

   CALL AllowReassignmentOfEmployeeDepartment (9, 'Accounting');



/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C       	*/
/*																				*/
/*	Wedgewood Pacific Corporation [WPC-CH10C-PQ] Project Questions 				*/
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions				                    */
/*																				*/
/********************************************************************************/

/***** Project Question 10C.34.B   **********************************************/
/***** Stored Procedure CreateDepartmentWithExistingEmployee  ********************/

DELIMITER //

CREATE PROCEDURE CreateDepartmentWithExistingEmployee
	(IN		varNewDepartmentName	Char(35),
	 IN		varNewBudgetCode			Char(30),
	 IN		varNewOfficeNumber		Char(15),
	 IN		varNewPhone				   Char(12),
	 IN		varEmployeeNumber		 Int)

BEGIN

	# Start transaction - Rollback everything if unable to complete it.
	START TRANSACTION;

	# INSERT the new DEPARTMENT data.

	INSERT INTO DEPARTMENT VALUES(
		varNewDepartmentName, VarNewBudgetCode, varNewOfficeNumber, varNewPhone);

		# Reassign the EMPLOYEE.

		UPDATE EMPLOYEE
		SET		Department = varNewDepartmentName
		WHERE	EmployeeNumber = varEmployeeNumber;

		# Commit the Transaction
		COMMIT;

	# The transaction is completed. Print message
	SELECT 'The new DEPARTMENT is created and the EMPLOYEE is reassigned.'
		AS CreateDepartmentWithExistingEmployeeResults;

END;
//
DELIMITER ;

/*  To test this procedure, use:                                          */

 CALL CreateDepartmentWithExistingEmployee
   ('Finance', 'BC-400-10', 'BLDG01-140', '360-285-8400', 6);






































































