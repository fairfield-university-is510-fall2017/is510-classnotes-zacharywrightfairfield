# J 

UPDATE SERVICE
	SET		ServiceDescription = 'Men''s Shirts'
	WHERE	ServiceDescription = 'Men''s Shirt';

select * from service;

# K 

/* make a new invoice and invoice_items to delete */
INSERT INTO INVOICE (InvoiceNumber, CustomerID, DateIn)
	VALUES(2015010, 104, '2015-11-15');

INSERT INTO INVOICE_ITEM VALUES (
	2015010, 1, 16, 3, 3.50, 10.50);

INSERT INTO INVOICE_ITEM VALUES (
	2015010, 2, 11, 12, 2.50, 30.00);

SELECT * FROM INVOICE;
SELECT * FROM INVOICE_ITEM;

/* to test, run the following */
DELETE FROM INVOICE
	WHERE	InvoiceNumber = 2015010;
    
SELECT * FROM INVOICE;
SELECT * FROM INVOICE_ITEM;
