
/*****   Question J   ***********************************************************/

SELECT * FROM ITEM
	WHERE ItemDescription LIKE 'Desk%';

UPDATE		ITEM
	SET		ItemDescription = 'Desk Lamps'
	WHERE	ItemDescription = 'Desk Lamp';

SELECT * FROM ITEM
	WHERE ItemDescription LIKE 'Desk%';

/*       To undo Question J:                                                    */

UPDATE		ITEM
	SET		ItemDescription = 'Desk Lamp'
	WHERE	ItemDescription = 'Desk Lamps';

SELECT * FROM ITEM
	WHERE ItemDescription LIKE 'Desk%';

/*****   Question K   ***********************************************************/

INSERT INTO ITEM VALUES(null,
	'Candles', '2015-02-15', 36.00, 60.00, 1);

SELECT * FROM ITEM;

/* ItemID is 26  */

INSERT INTO SALE VALUES(null, 2, 2, '2015-02-17', 60.00, 4.98, 4.98);

# saleid should be 16

INSERT INTO SALE_ITEM VALUES(16, 1, 26, 60.00); 

/* SaleID is  16 */
SELECT * FROM SALE
	WHERE SaleID = 16;

SELECT * FROM SALE_ITEM
	WHERE SaleID = 16;

DELETE FROM SALE
	WHERE SaleID = 16;

SELECT * FROM SALE;

SELECT * FROM SALE_ITEM;









