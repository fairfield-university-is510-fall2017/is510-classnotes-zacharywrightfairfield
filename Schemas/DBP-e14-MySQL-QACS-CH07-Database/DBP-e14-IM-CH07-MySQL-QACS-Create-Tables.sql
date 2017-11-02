/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (14th Edition) CH07/CH10C			*/
/*																				*/
/*	The Queen Anne Curiousity Shop Database Create Tables						*/
/*																				*/
/*	These are the MySQL 5.6 code solutions										*/
/*																				*/
/********************************************************************************/
/*																				*/

/********************************************************************************/

CREATE  TABLE CUSTOMER(
	CustomerID			Int				NOT NULL auto_increment,
	LastName			Char(25)		NOT NULL,
	FirstName			Char(25)		NOT NULL,
	Address			Char(35)		NULL,
	City				Char(35)		NULL,
	State				Char(2)			NULL,
	ZIP					Char(10)		NULL,
	Phone				Char(12)		NOT NULL,
	Email				VarChar(100)	NULL,
	CONSTRAINT 			CUSTOMER_PK 	PRIMARY KEY(CustomerID)
	);


CREATE  TABLE EMPLOYEE(
	EmployeeID			Int 			NOT NULL auto_increment,
	LastName			Char(25) 		NOT NULL,
	FirstName			Char(25) 		NOT NULL,
	Phone				Char(12)		NULL,
	Email 				VarChar(100)	NOT NULL UNIQUE,
	CONSTRAINT 			EMPLOYEE_PK 	PRIMARY KEY(EmployeeID)
	);


CREATE  TABLE VENDOR(
	VendorID			Int				NOT NULL auto_increment,
	CompanyName			Char(100)		NULL,
	ContactLastName		Char(25)		NOT NULL,
	ContactFirstName	Char(25)		NOT NULL,
	Address				Char(35)		NULL,
	City				Char(35)		NULL,
	State				Char(2)			NULL,
	ZIP					Char(10)		NULL,
	Phone				Char(12)		NOT NULL,
	Fax					Char(12)		NULL,
	Email				VarChar(100)	NULL,
	CONSTRAINT 			VENDOR_PK 		PRIMARY KEY(VendorID)
	);



CREATE  TABLE ITEM(
	ItemID				Int	 			NOT NULL auto_increment,
	ItemDescription		VarChar(255)	NOT NULL,
	PurchaseDate		Date			NOT NULL,
	ItemCost			Numeric(9,2)	NOT NULL,
	ItemPrice			Numeric(9,2)	NOT NULL,
	VendorID			Int				NOT NULL,
	CONSTRAINT 			ITEM_PK			PRIMARY KEY (ItemID),
	CONSTRAINT 			ITEM_VENDOR_FK  FOREIGN KEY	(VendorID)
								REFERENCES VENDOR(VendorID));


CREATE  TABLE SALE(
    SaleID				Int				NOT NULL auto_increment,
	CustomerID			Int	 			NOT NULL,
	EmployeeID			Int				NOT NULL,
	SaleDate			Date			NOT NULL,
	SubTotal			Numeric(15,2)	NULL,
	Tax					Numeric(15,2)	NULL,
	Total				Numeric(15,2)	NULL,
    CONSTRAINT 			SALE_PK 		PRIMARY KEY (SaleID),
	CONSTRAINT 			SALE_CUSTOMER_FK FOREIGN KEY (CustomerID)
								REFERENCES CUSTOMER(CustomerID),
	CONSTRAINT 			SALE_EMPLOYEE_FK FOREIGN KEY(EmployeeID)
								REFERENCES EMPLOYEE(EmployeeID));


CREATE  TABLE SALE_ITEM(
    SaleID				Int				NOT NULL,
	SaleItemID			Int				NOT NULL,
	ItemID				Int	 			NOT NULL,
	ItemPrice			Numeric(9,2)	NOT NULL,
    CONSTRAINT 			SALE_ITEM_PK 	PRIMARY KEY (SaleID, SaleItemID),
	CONSTRAINT 			SALE_ITEM_SALE_FK FOREIGN KEY (SaleID)
								REFERENCES SALE(SaleID) ON DELETE CASCADE,
	CONSTRAINT 			SALE_ITEM_ITEM_FK FOREIGN KEY (ItemID)
								REFERENCES ITEM(ItemID)    );




