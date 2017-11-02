/* Use the following statements to modify the CUSTOMER table      */

/* *** SQL-ALTER-TABLE-CH10C-01 *** */

ALTER TABLE CUSTOMER
	ADD isProblemAccount	BOOLEAN NULL DEFAULT '0';

/* *** SQL-UPDATE-CH10C-01 *** */
UPDATE	 CUSTOMER
	SET		isProblemAccount = 0;

/* *** SQL-UPDATE-CH10C-02 *** */
UPDATE	 CUSTOMER
	SET		isProblemAccount = 1
	WHERE	LastName	= 'Gliddens'
		AND	FirstName	= 'Melinda';

/* Use the following SELECT statement to display the modifications */

/* *** SQL-QUERY-CH10C-05 *** */
SELECT	 CustomerID, LastName, FirstName, isProblemAccount
FROM	 CUSTOMER;

/* Use the following CALL statement to test the stored procedure   */

/* *** SQL-CALL-CH10C-03 *** */
 CALL TransWithCheckIsProblemAccount (229, 1053, '2014-11-18', 475.00);
 
 
 