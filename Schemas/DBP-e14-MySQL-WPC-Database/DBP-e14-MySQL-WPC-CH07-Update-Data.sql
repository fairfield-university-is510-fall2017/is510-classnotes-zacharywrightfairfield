/* 7.57 */
UPDATE EMPLOYEE
	SET Phone = '360-287-8810'
	WHERE EmployeeNumber = 11;

/* 7.58 */
UPDATE EMPLOYEE
	SET Department = 'Finance'
	WHERE EmployeeNumber = 5;

/* 7.59 */
UPDATE EMPLOYEE
	SET 	Phone = '360-287-8420'
	WHERE 	EmployeeNumber = 5;

/* 7.60 */
UPDATE EMPLOYEE
	SET 	Department = 'Finance', Phone = '360-287-8420'
	WHERE	EmployeeNumber = 5;

/* 7.61 */
UPDATE ASSIGNMENT
	SET 	HoursWorked = 60
	WHERE	EmployeeNumber = 10;

/* 7.62 DO NOT RUN */
/* MERGE is not supported in MySQL , try:

insert into employee
select * from new_email
on duplicate key update set employee.email = new_email.NewEmail;


==== original MERGE syntax =======
MERGE INTO EMPLOYEE USING NEW_EMAIL
	ON	EMPLOYEE.EmployeeNumber = NEW_EMAIL.EmployeeNumber
WHEN MATCHED THEN
	UPDATE	SET
	EMPLOYEE.Email = NEW_EMAIL.NewEmail;
*/
    
/* 7.63 and 64 are in WPC-Delete-Data */
