CREATE TABLE CUSTOMER (
		CustomerID		Int		NOT NULL auto_increment,
		FirstName 		Char(25)	NOT NULL,
		LastName			Char(25)	NOT NULL,
		Phone			Char(12)	NOT NULL,
		Email			Char(100)	NULL,
		CONSTRAINT		CustomerPK	PRIMARY KEY (CustomerID)
		);
ALTER TABLE CUSTOMER auto_increment = 100;

CREATE TABLE SERVICE (
		ServiceID			Int			NOT NULL,
		ServiceDescription	Char(50)		NOT NULL,
		UnitPrice			Numeric(8,2)	NOT NULL,
		CONSTRAINT		ServicePK		PRIMARY KEY(ServiceID),
		CONSTRAINT		ServicePrice	CHECK
				((UnitPrice >= 1.50) AND (UnitPrice <= 10.00))
		);

CREATE TABLE INVOICE (
		InvoiceNumber		Int		NOT NULL,
		CustomerID		Int		NOT NULL,
		DateIn			Date		NOT NULL,
		DateOut			Date		NULL,
		Subtotal			Numeric(8,2)	NULL,
		Tax				Numeric(8,2)	NULL,
		Total			Numeric(8,2)	NULL,
		CONSTRAINT		InvoicePK		PRIMARY KEY (InvoiceNumber),
		CONSTRAINT  		InvoiceCustomerFK FOREIGN KEY(CustomerID)
							REFERENCES CUSTOMER(CustomerID)
		);

CREATE TABLE INVOICE_ITEM (
		InvoiceNumber		Int		NOT NULL,
		ItemNumber		Int		NOT NULL,
		ServiceID			Int		NOT NULL,
		Quantity			Int		NOT NULL DEFAULT 1,
		UnitPrice			Numeric(8,2)	NULL,
		ExtendedPrice		Numeric(8,2)	NULL,
		CONSTRAINT		InvoiceItemPK	
						PRIMARY KEY(InvoiceNumber, ItemNumber),
		CONSTRAINT		InvoiceItemFK	FOREIGN KEY(InvoiceNumber)
							REFERENCES INVOICE(InvoiceNumber)
								ON DELETE CASCADE,
		CONSTRAINT		ItemServiceFK	FOREIGN KEY(ServiceID)
							REFERENCES Service(ServiceID)
								);
