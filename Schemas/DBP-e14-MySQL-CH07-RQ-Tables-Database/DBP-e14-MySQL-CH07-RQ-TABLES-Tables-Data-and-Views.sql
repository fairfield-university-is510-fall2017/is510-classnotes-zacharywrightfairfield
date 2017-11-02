/* Chapter 07 MySQL Solutions for DBP e14 */

/* 7.1 - 7.6 is prose or described in Ch10C  */

/* 7.7 */
CREATE TABLE CUSTOMER_01(
  EmailAddress	VARCHAR(100)		NOT NULL,
  LastName		VARCHAR(25)		NOT NULL,
  FirstName		VARCHAR(25)		NOT NULL,
  CONSTRAINT		CUSTOMER_01_PK	PRIMARY KEY(EmailAddress)
  );

/* 7.8 */
CREATE TABLE CUSTOMER_02(
  CustomerID		INT			NOT NULL AUTO_INCREMENT,
  EmailAddress		VARCHAR(100)		NOT NULL,
  LastName		VARCHAR(25)		NOT NULL,
  FirstName		VARCHAR(25)		NOT NULL,
  CONSTRAINT		CUSTOMER_02_PK		PRIMARY KEY(CustomerID)
  );

/* 7.9  prose*/

/* 7.10 */
CREATE TABLE CUSTOMER_03(
  CustomerID		INT			NOT NULL AUTO_INCREMENT,
  EmailAddress		VARCHAR(100)		NOT NULL,
  LastName		VARCHAR(25)		NOT NULL,
  FirstName		VARCHAR(25)		NOT NULL,
  CONSTRAINT		CUSTOMER_03_PK		PRIMARY KEY(CustomerID)
  );

/* 7.11 prose */

/* 7.12 */
CREATE TABLE CUSTOMER_04(
  CustomerID		INT			NOT NULL AUTO_INCREMENT,
  EmailAddress		VARCHAR(100)		NOT NULL,
  LastName		VARCHAR(25)		NOT NULL,
  FirstName		VARCHAR(25)		NOT NULL,
  CONSTRAINT		CUSTOMER_04_PK		PRIMARY KEY(CustomerID)
  );
  
/* 7.13 prose */

/* 7.14 */
CREATE TABLE SALE_01(
  SaleID		INT			NOT NULL AUTO_INCREMENT,
  DateOfSale		DATE			NOT NULL,
  EmailAddress	VARCHAR(100)		NOT NULL,
  SaleAmount		NUMERIC(7,2)		NOT NULL,
  CONSTRAINT		SALE_PK_01		PRIMARY KEY(SaleID),
  CONSTRAINT		S_01_C_01_FK		FOREIGN KEY(EmailAddress)
				REFERENCES CUSTOMER_01(EmailAddress)
					ON UPDATE CASCADE
  );

ALTER TABLE SALE_01 AUTO_INCREMENT =20150001;

/* 7.15- 7.17 prose */

/* 7.18 */
drop table sale_02;

CREATE TABLE SALE_02(
  SaleID		INT			NOT NULL auto_increment,
  DateOfSale		DATE			NOT NULL,
  CustomerID		INT			NOT NULL,
  SaleAmount		NUMERIC(7,2)		NOT NULL,
  CONSTRAINT		SALE_02_PK		PRIMARY KEY(SaleID),
  CONSTRAINT		S_02_C_04_FK		FOREIGN KEY(CustomerID)
				REFERENCES CUSTOMER_04(CustomerID) on update no action
  );

ALTER TABLE SALE_02 AUTO_INCREMENT =20150001;

/* 7.19-21 prose */

/* 7.22 */
INSERT INTO CUSTOMER_01 (EmailAddress, LastName, FirstName)
	VALUES('Robert.Shire@somewhere.com','Shire', 'Robert');
INSERT INTO CUSTOMER_01 (EmailAddress, LastName, FirstName)
	VALUES('Katherine.Goodyear@somewhere.com','Goodyear', 'Katherine');
INSERT INTO CUSTOMER_01 (EmailAddress, LastName, FirstName)
	VALUES('Chris.Bancroft@somewhere.com','Bancroft', 'Chris');

SELECT  * FROM CUSTOMER_01;

/* 7.23 */
INSERT INTO CUSTOMER_02 (EmailAddress, LastName, FirstName)
	VALUES('Robert.Shire@somewhere.com','Shire', 'Robert');
INSERT INTO CUSTOMER_02 (EmailAddress, LastName, FirstName)
	VALUES('Katherine.Goodyear@somewhere.com','Goodyear', 'Katherine');
INSERT INTO CUSTOMER_02 (EmailAddress, LastName, FirstName)
	VALUES('Chris.Bancroft@somewhere.com','Bancroft', 'Chris');
	
SELECT		* FROM CUSTOMER_02;

/* 7.24 prose */

/* 7.25 */
INSERT INTO CUSTOMER_03 (EmailAddress, LastName, FirstName)
	SELECT	EmailAddress, LastName, FirstName
	FROM  	CUSTOMER_01;

SELECT  * FROM CUSTOMER_03;

/* 7.26 prose */

/* 7.27 */
INSERT INTO CUSTOMER_04 (CustomerID, EmailAddress, LastName, FirstName)
	VALUES(17, 'Robert.Shire@somewhere.com','Shire', 'Robert');
INSERT INTO CUSTOMER_04 (CustomerID, EmailAddress, LastName, FirstName)
	VALUES(23, 'Katherine.Goodyear@somewhere.com','Goodyear', 'Katherine');
INSERT INTO CUSTOMER_04 (CustomerID, EmailAddress, LastName, FirstName)
	VALUES(46, 'Chris.Bancroft@somewhere.com','Bancroft', 'Chris');

ALTER TABLE CUSTOMER_04 AUTO_INCREMENT = 47;    
select * from customer_04;

/* 7.28 prose */

/* 7.29 */
INSERT INTO CUSTOMER_04 (EmailAddress, LastName, FirstName)
	VALUES('John.Griffith@somewhere.com','Griffith', 'John');
INSERT INTO CUSTOMER_04 (EmailAddress, LastName, FirstName)
	VALUES('Doris.Tierney@somewhere.com', 'Tierney', 'Doris');
INSERT INTO CUSTOMER_04 (EmailAddress, LastName, FirstName)
	VALUES('Donna.Anderson@elsewhere.com','Anderson', 'Donna');

SELECT * FROM CUSTOMER_04;

/* 7.30 prose */

/* 7.31 */

INSERT INTO SALE_01 (DateOfSale, EmailAddress, SaleAmount)
	VALUES('2015-01-14', 'Robert.Shire@somewhere.com', 234.00);
INSERT INTO SALE_01 (DateOfSale, EmailAddress, SaleAmount)
	VALUES('2015-01-14', 'Chris.Bancroft@somewhere.com', 56.50);
INSERT INTO SALE_01 (DateOfSale, EmailAddress, SaleAmount)
	VALUES('2015-01-16', 'Robert.Shire@somewhere.com', 123.00);
INSERT INTO SALE_01 (DateOfSale, EmailAddress, SaleAmount)
	VALUES('2015-01-17', 'Katherine.Goodyear@somewhere.com', 34.25);

SELECT * FROM SALE_01;

/* 7.32-33 prose */

/* 7.34 */
INSERT INTO SALE_02 (DateOfSale, CustomerID, SaleAmount)
	VALUES('2015-01-14', 17, 234.00);
INSERT INTO SALE_02 (DateOfSale, CustomerID, SaleAmount)
	VALUES('2015-01-14', 46, 56.50);
INSERT INTO SALE_02 (DateOfSale, CustomerID, SaleAmount)
	VALUES('2015-01-16', 17, 123.00);
INSERT INTO SALE_02 (DateOfSale, CustomerID, SaleAmount)
	VALUES('2015-01-17', 23, 34.25);
INSERT INTO SALE_02 (DateOfSale, CustomerID, SaleAmount)
	VALUES('2015-01-18', 49, 345.00);
INSERT INTO SALE_02 (DateOfSale, CustomerID, SaleAmount)
	VALUES('2015-01-21', 46, 567.35);
INSERT INTO SALE_02 (DateOfSale, CustomerID, SaleAmount)
	VALUES('2015-01-23', 47, 78.50);

SELECT * FROM SALE_02;

/* 7.35-36 prose */
/* 7.37 */
INSERT INTO SALE_02 (DateOfSale, CustomerID, SaleAmount)
	VALUES('2015-01-25', 50, 890.15);
    /* causes referential integrity error message */

/* 7.38 */
CREATE VIEW Customer01DataView AS
	SELECT	EmailAddress,
		LastName as CustomerLastName,
		FirstName as CustomerFirstName
FROM	CUSTOMER_01;

SELECT		*
FROM		Customer01DataView
ORDER BY	EmailAddress;

/* 7.39 */
CREATE VIEW Customer04DataView AS
	SELECT	CustomerID,
		LastName as CustomerLastName,
		FirstName as CustomerFirstName,
		EmailAddress
FROM	CUSTOMER_04;

SELECT		*
FROM		Customer04DataView
ORDER BY	CustomerID;

/* 7.40 */
CREATE VIEW CustomerSalesView AS
	SELECT	C.CustomerID,
		LastName as CustomerLastName,
		FirstName as CustomerFirstName,
		EmailAddress,
		SaleID, DateOfSale, SaleAmount
FROM	CUSTOMER_04 C JOIN SALE_02 S
		ON C.CustomerID = S.CustomerID;

SELECT		*
FROM		CustomerSalesView
ORDER BY	CustomerID;



