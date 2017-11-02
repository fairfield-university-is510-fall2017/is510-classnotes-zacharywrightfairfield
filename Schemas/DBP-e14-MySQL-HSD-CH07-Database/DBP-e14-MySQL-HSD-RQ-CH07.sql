/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 07 Case		*/
/*																				*/
/*	Heather Sweeny Designs [HSD] Database CH07 Case Questioins					*/
/*																				*/
/*	These are the MySQL 5.6  code solutions										*/
/*																				*/
/********************************************************************************/


/*****   Case Question E   ******************************************************/

SELECT * FROM CUSTOMER;

SELECT * FROM CONTACT;

SELECT * FROM INVOICE;

SELECT * FROM LINE_ITEM;

SELECT * FROM PRODUCT;

SELECT * FROM SEMINAR;

SELECT * FROM SEMINAR_CUSTOMER;

/*****   Case Question F   ******************************************************/

SELECT	LastName, FirstName, Phone
FROM		CUSTOMER
WHERE		City = 'Dallas';

/*****   Case Question G   ******************************************************/

SELECT		LastName, FirstName, Phone
FROM		CUSTOMER
WHERE		City = 'Dallas'
	AND		LastName LIKE 'T%';

/*****   Case Question H   ******************************************************/

# -- Two table solution - starting with LINE_ITEM

SELECT	InvoiceNumber
FROM	LINE_ITEM
WHERE	ProductNumber IN
		(SELECT ProductNumber
		 FROM	PRODUCT
		 WHERE	PRODUCT.ProductDescription =
			'Heather Sweeney Seminar Live in Dallas on 25-OCT-13');

# -- Three table solution - starting with INVOICE

SELECT		InvoiceNumber
FROM		INVOICE
WHERE		InvoiceNumber IN
			(SELECT InvoiceNumber
			 FROM	LINE_ITEM
			 WHERE	ProductNumber IN
					(SELECT ProductNumber
					 FROM	PRODUCT
					 WHERE	PRODUCT.ProductDescription =
							'Heather Sweeney Seminar Live in Dallas on 25-OCT-13'));

/*****   Case Question I   ******************************************************/

# -- Two table solution - starting with LINE_ITEM

SELECT		LI.InvoiceNumber
FROM		LINE_ITEM LI JOIN PRODUCT P
	ON		LI.ProductNumber = P.ProductNumber
WHERE		P.ProductDescription = 'Heather Sweeney Seminar Live in Dallas on 25-OCT-13';

# -- Three table solution - starting with INVOICE

SELECT		I.InvoiceNumber
FROM		INVOICE I JOIN LINE_ITEM LI
		ON	I.InvoiceNumber = LI.InvoiceNumber
			JOIN PRODUCT P
				ON LI.ProductNumber = P.ProductNumber
WHERE		P.ProductDescription = 'Heather Sweeney Seminar Live in Dallas on 25-OCT-13';

/*****   Case Question J   ******************************************************/

SELECT	DISTINCT FirstName, LastName, Phone
FROM		CUSTOMER C JOIN SEMINAR_CUSTOMER SC
		ON	C.CustomerID = SC.CustomerID
			JOIN SEMINAR S
				ON SC.SeminarID = S.SeminarID
WHERE		S.SeminarTitle = 'Kitchen on a Big D Budget'
ORDER BY	LastName DESC, FirstName DESC;

/*****   Case Question K   ******************************************************/

SELECT		DISTINCT FirstName, LastName, Phone,
			P.ProductNumber, P.ProductDescription
FROM		CUSTOMER C JOIN INVOICE I
		ON  C.CustomerID = I.CustomerID
			JOIN LINE_ITEM LI
				ON I.InvoiceNumber = LI.InvoiceNumber
					JOIN PRODUCT P
						ON LI.ProductNumber = P.ProductNumber
WHERE		P.ProductNumber LIKE 'VK%'
ORDER BY	LastName DESC, FirstName DESC, ProductNumber DESC;

/*****   Case Question L   ******************************************************/

SELECT	SUM(SubTotal) AS SumOfSubTotal
FROM		INVOICE;

/*****   Case Question M   ******************************************************/

SELECT	AVG(SubTotal) AS AverageOfSubTotal
FROM		INVOICE;

/*****   Case Question N   ******************************************************/

SELECT	SUM(SubTotal) AS SumOfSubTotal,
		AVG(SubTotal) AS AverageOfSubTotal
FROM		INVOICE;

/*****   Case Question O   ******************************************************/

SELECT		*
FROM		PRODUCT
WHERE		ProductNumber = 'VK004';

UPDATE		PRODUCT
	SET		UnitPrice = 34.95
	WHERE	ProductNumber = 'VK004';

SELECT		*
FROM		PRODUCT
WHERE		ProductNumber = 'VK004';

/*****   Case Question P   ******************************************************/

UPDATE		PRODUCT
	SET		UnitPrice = 24.95
	WHERE	ProductNumber = 'VK004';

SELECT		*
FROM		PRODUCT
WHERE		ProductNumber = 'VK004';


/*****   Case Question Q ******************************************************/

/*  SEE SOLUTION IN IM:  NOT INTENDED TO BE RUN !!!  */











