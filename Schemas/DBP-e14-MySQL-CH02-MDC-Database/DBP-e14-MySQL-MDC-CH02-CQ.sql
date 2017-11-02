/********************************************************************************/
/*											                                    */
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 02	        */
/*										                                        */
/*  Matha's Dry Cleaning [MDC-CH02] Database Project Questions			        */
/*										                                        */
/*	These are the MySQL code solutions	  			       					    */
/*																				*/
/********************************************************************************/


/*****   Case Question  A   *****************************************************/

/*****   CUSTOMER DATA  *********************************************************/

SELECT * FROM CUSTOMER;

/*****   INVOICE  ***************************************************************/

SELECT * FROM INVOICE;

/*****   INVOICE_ITEM  **********************************************************/

SELECT * FROM INVOICE_ITEM;

/*****   Case Question  B   *****************************************************/

SELECT LastName, FirstName, Phone
FROM   CUSTOMER;

/*****   Case Question  C   *****************************************************/

SELECT LastName, FirstName, Phone
FROM   CUSTOMER
WHERE  FirstName = 'Nikki';

/*****   Case Question  D   *****************************************************/

SELECT LastName, FirstName, Phone, DateIn, DateOut
FROM   CUSTOMER, INVOICE
WHERE  CustomerID = CustomerNumber
AND    TotalAmount > 100;

/*****   Case Question  E   *****************************************************/

SELECT LastName, FirstName, Phone
FROM   CUSTOMER
WHERE  FirstName Like 'B%';

/*****   Case Question  F   *****************************************************/

SELECT LastName, FirstName, Phone
FROM   CUSTOMER
WHERE  LastName Like '%cat%';

/*****   Case Question  G   *****************************************************/

SELECT LastName, FirstName, Phone
FROM   CUSTOMER
WHERE  PHONE LIKE '_23%';

/*****   Case Question  H   *****************************************************/

SELECT Max(TotalAmount), Min(TotalAmount)
FROM INVOICE;

/*****   Case Question  I   *****************************************************/

SELECT Avg(TotalAmount)
FROM INVOICE;

/*****   Case Question  J   *****************************************************/

SELECT Count(CustomerID)
FROM   CUSTOMER;

/*****   Case Question  K   *****************************************************/

SELECT LastName, FirstName
FROM CUSTOMER
GROUP BY LastName, FirstName;

/*****   Case Question  L   *****************************************************/

SELECT LastName, FirstName, COUNT(*) AS Last_First_Combination_Count
FROM CUSTOMER
GROUP BY LastName, FirstName;

/*****   Case Question  M   *****************************************************/

SELECT LastName, FirstName, Phone
FROM CUSTOMER
WHERE CustomerID IN
			(SELECT CustomerNumber
			FROM INVOICE
			WHERE TotalAmount > 100)
ORDER BY LastName, FirstName DESC;

/*****   Case Question  N   *****************************************************/

SELECT LastName, FirstName, Phone
FROM   CUSTOMER, INVOICE
WHERE  CustomerID=CustomerNumber And TotalAmount>100
ORDER BY LastName, FirstName DESC;

/*****   Case Question  O   *****************************************************/

SELECT LastName, FirstName, Phone
FROM   CUSTOMER JOIN INVOICE ON
       CustomerID=CustomerNumber 
WHERE  TotalAmount>100
ORDER BY LastName, FirstName DESC;

/*****   Case Question  P   *****************************************************/

SELECT LastName, FirstName, Phone
FROM CUSTOMER
WHERE CustomerID IN (SELECT	CustomerNumber
			FROM 		INVOICE
			WHERE 	InvoiceNumber IN 
						(SELECT InvoiceNumber
						FROM INVOICE_ITEM
						WHERE Item = 'Dress Shirt'))
ORDER BY LastName, FirstName DESC;

/*****   Case Question  Q   *****************************************************/

SELECT LastName, FirstName, Phone
FROM   CUSTOMER, INVOICE, INVOICE_ITEM
WHERE  CustomerID=CustomerNumber 
AND    INVOICE.InvoiceNumber=INVOICE_ITEM.InvoiceNumber 
AND    Item='Dress Shirt'
ORDER BY LastName, FirstName DESC;

/*****   Case Question  R   *****************************************************/

SELECT FirstName, LastName, Phone
FROM   CUSTOMER JOIN INVOICE ON
CustomerID=CustomerNumber
JOIN INVOICE_ITEM ON INVOICE.InvoiceNumber=INVOICE_ITEM.InvoiceNumber 
WHERE  Item='Dress Shirt'
ORDER BY LastName, FirstName DESC;

/*****   Case Question  S   *****************************************************/

SELECT LastName, FirstName, Phone
FROM CUSTOMER JOIN INVOICE
ON CustomerID = CustomerNumber
WHERE	  InvoiceNumber IN
   						(SELECT InvoiceNumber
      					 FROM INVOICE_ITEM
                WHERE Item = 'Dress Shirt')
ORDER BY LastName, FirstName DESC;

/* Alternate version, with join in subquery: */

SELECT LastName, FirstName, Phone
FROM CUSTOMER
WHERE CustomerID IN
(SELECT CustomerNumber 
FROM INVOICE JOIN INVOICE_ITEM
ON INVOICE.InvoiceNumber = INVOICE_ITEM.InvoiceNumber
 					 WHERE Item = 'Dress Shirt')
ORDER BY LastName, FirstName DESC;

/*****   Case Question  T   *****************************************************/

/*  LEFT OUTER JOIN SOLUTION  */

SELECT LastName, FirstName, Phone, TotalAmount
FROM CUSTOMER C LEFT JOIN (INVOICE I JOIN INVOICE_ITEM II
	ON I.InvoiceNumber = II.InvoiceNumber AND II.Item = 'Dress Shirt') 
	ON C.CustomerID = I.CustomerNumber
ORDER BY TotalAmount, LastName, FirstName DESC;

/*  UNION SOLUTION  */

SELECT LastName, FirstName, Phone, TotalAmount
FROM CUSTOMER C, INVOICE I, INVOICE_ITEM II
WHERE C.CustomerID = I.CustomerNumber AND I.InvoiceNumber =
	II.InvoiceNumber AND II.Item = 'Dress Shirt'
UNION
SELECT LastName, FirstName, Phone, NULL
FROM CUSTOMER
WHERE CustomerID NOT IN
	(SELECT CustomerNumber 
	 FROM INVOICE I, INVOICE_ITEM II
	 WHERE I.InvoiceNumber = II.InvoiceNumber AND II.Item = 'Dress Shirt')
ORDER BY TotalAmount, LastName, FirstName DESC;

/*  RIGHT OUTER JOIN SOLUTION  */

SELECT LastName, FirstName, Phone, TotalAmount
FROM (INVOICE I JOIN INVOICE_ITEM II
	ON I.InvoiceNumber = II.InvoiceNumber AND II.Item = 'Dress Shirt') RIGHT JOIN CUSTOMER C
	ON C.CustomerID = I.CustomerNumber
ORDER BY TotalAmount, LastName, FirstName DESC;

