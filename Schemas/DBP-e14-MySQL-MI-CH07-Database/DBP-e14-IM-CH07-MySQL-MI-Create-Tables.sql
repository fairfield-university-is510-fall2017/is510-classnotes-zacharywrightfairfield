/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 07/10C		*/
/*																				*/
/*	Morgan Importing [MI-CH07] Project Create Tables							*/
/*																				*/
/*	MySQL 5.6 code solutions													*/
/*																				*/
/********************************************************************************/


CREATE  TABLE EMPLOYEE(
	EmployeeID		Int 			NOT NULL auto_increment,
	LastName		Char(25) 		NOT NULL,
	FirstName        Char(25) 		NOT NULL,
	Department		Char(35)		NOT NULL,
	Phone			Char(12)		NULL,
	Fax				Char(12)		NULL,
	EmailAddress	VarChar(100)	NOT NULL UNIQUE,
	CONSTRAINT 		EMPLOYEE_PK 	PRIMARY KEY(EmployeeID)
	);
    
ALTER TABLE EMPLOYEE auto_increment = 101;

CREATE TABLE STORE (
	StoreID				Int				NOT NULL,
	StoreName			Char(50)		NOT NULL,
	City				Char(35)		NOT NULL,
	Country				Char(50)		NOT NULL,
	Phone				Char(16)		NOT NULL,
	Fax					Char(16)		NULL,
	EmailAddress		Char(100)		NULL,
	Contact				Char(50)		NOT NULL,
	CONSTRAINT		Store_PK		PRIMARY KEY(StoreID),
	CONSTRAINT		StoreCountry	CHECK
						(Country IN ('Hong Kong', 'India',
						 'Japan', 'Peru','Philippines', 'Singapore',
						 'United States'))
	);
#ALTER TABLE STORE auto_increment= 1000;

CREATE TABLE ITEM (
	ItemID				Int				NOT NULL,
	StoreID				Int				NOT NULL,
	PurchasingAgentID	Int				NOT NULL,
	PurchaseDate		Date			NOT NULL,
	ItemDescription		VarChar(255)	NOT NULL,
	Category			Char(25)		NULL,
	PriceUSD			Numeric(12,2)	NOT NULL,
	CONSTRAINT		Purchase_Item_PK	PRIMARY KEY (ItemID),
	CONSTRAINT  	Purch_Item_Store_FK FOREIGN KEY(StoreID)
						REFERENCES STORE(StoreID),
							
	CONSTRAINT		Ship_Employee_FK 	FOREIGN KEY(PurchasingAgentID)
                       REFERENCES EMPLOYEE(EmployeeID) 
							
	);

#ALTER TABLE ITEM auto_increment=500;

CREATE TABLE SHIPPER (
	ShipperID			Int				NOT NULL auto_increment,
	ShipperName			Char(50)		NOT NULL,
	Phone				Char(16)		NOT NULL,
	Fax					Char(16)		NULL,
	EmailAddress		Char(100)		NULL,
	Contact				Char(50)		NOT NULL,
	CONSTRAINT		Shipper_PK		PRIMARY KEY(ShipperID)
	);

 


CREATE TABLE SHIPMENT (
	ShipmentID				Int			NOT NULL auto_increment,
	ShipperID				Int			NOT NULL,
	PurchasingAgentID		Int			NOT NULL,
	ShipperInvoiceNumber	Int			NOT NULL,
	Origin					Char(35)	NOT NULL,
	Destination				Char(35)	NOT NULL,
	ScheduledDepartureDate	Date		NULL,
	ActualDepartureDate		Date		NULL,
	EstimatedArrivalDate	Date		NULL,
	CONSTRAINT		Shipment_PK			PRIMARY KEY (ShipmentID),
			CONSTRAINT  	Ship_Shipper_FK		FOREIGN KEY(ShipperID)
						REFERENCES SHIPPER(ShipperID),
							
	CONSTRAINT		Shipment_Employee_FK 	FOREIGN KEY(PurchasingAgentID)
                       REFERENCES EMPLOYEE(EmployeeID) 
							ON DELETE NO ACTION
	);
ALTER TABLE SHIPMENT auto_increment = 100;

CREATE TABLE SHIPMENT_ITEM (
	ShipmentID				Int				NOT NULL,
	ShipmentItemID			Int				NOT NULL,
	ItemID					Int				NOT NULL,
	InsuredValue			Numeric(12,2)	NOT NULL,
	CONSTRAINT		ShipmentItem_PK	PRIMARY KEY(ShipmentID, ShipmentItemID),
	CONSTRAINT  	Ship_Item_Ship_FK 		FOREIGN KEY(ShipmentID)
						REFERENCES SHIPMENT(ShipmentID)
                        ON DELETE CASCADE,  
	CONSTRAINT  	Ship_Item_Purchase_Item_FK FOREIGN KEY(ItemID)
						REFERENCES ITEM(ItemID)
							ON DELETE CASCADE
	);
#alter table shipment_item drop foreign key ship_item_ship_fk;
#alter table shipment_item add constraint Ship_Item_Ship_FK 
#foreign key(ShipmentID) references SHIPMENT(ShipmentID) ON DELETE CASCADE;

CREATE TABLE SHIPMENT_RECEIPT (
	ReceiptNumber			Int				NOT NULL auto_increment,
    ShipmentID				Int				NOT NULL,
	ItemID					Int				NOT NULL,
    ReceivingAgentID		Int				NOT NULL,
    ReceiptDate				Date			NOT NULL,
	ReceiptTime				Time			NOT NULL,
    ReceiptQuantity			Int				NOT NULL,
    isReceivedUndamaged		Char(3)			NOT NULL,
    DamageNotes				Char(255)		NULL,
	CONSTRAINT		ShipmentReceipt_PK	    PRIMARY KEY(ReceiptNumber),
	CONSTRAINT		Ship_Receipt_Ship_FK	FOREIGN KEY(ShipmentID)
						REFERENCES SHIPMENT(ShipmentID) ON DELETE CASCADE,
	CONSTRAINT		Ship_Receipt_Item_FK	FOREIGN KEY(ItemID)
						REFERENCES ITEM(ItemID) ON DELETE CASCADE,
							
	CONSTRAINT		Ship_Receipt_Emp_FK	FOREIGN KEY(ReceivingAgentID)
							REFERENCES EMPLOYEE(EmployeeID)
	);
    
ALTER TABLE SHIPMENT_RECEIPT auto_increment = 200001;


/********************************************************************************/
