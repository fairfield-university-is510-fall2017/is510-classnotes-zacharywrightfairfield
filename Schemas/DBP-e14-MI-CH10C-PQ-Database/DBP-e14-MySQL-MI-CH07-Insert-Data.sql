/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 07/10B		*/
/*																				*/
/*	Morgan Importing [MI_CH07] Project Insert Data								*/
/*																				*/
/*	MySQL 5.6 code solutions													*/
/*																				*/
/********************************************************************************/



/*****   EMPLOYEE Data   ********************************************************/

INSERT INTO EMPLOYEE VALUES (null,
    'Morgan', 'James', 'Executive', '310-208-1401', '310-208-1499',
    'James.Morgan@morganimporting.com');

INSERT INTO EMPLOYEE VALUES (null,
    'Morgan', 'Jessica', 'Executive', '310-208-1402', '310-208-1499',
    'Jessica.Morgan@morganimporting.com');

INSERT INTO EMPLOYEE VALUES (null,
    'Williams', 'David', 'Purchasing', '310-208-1434', '310-208-1498',
    'David.Williams@morganimporting.com');

INSERT INTO EMPLOYEE VALUES (null,
    'Gilbertson', 'Teri', 'Purchasing', '310-208-1435', '310-208-1498',
    'Teri.Gilbertson@morganimporting.com');

INSERT INTO EMPLOYEE VALUES (null,
    'Wright', 'James', 'Receiving', '310-208-1456', '310-208-1497',
    'James.Wright@morganimporting.com');

INSERT INTO EMPLOYEE VALUES (null,
    'Douglas', 'Tom', 'Receiving', '310-208-1457', '310-208-1497',
    'Tom.Douglas@morganimporting.com');
	

/*****   STORE Data   ***********************************************************/

INSERT INTO STORE VALUES (1000,
		'Eastern Sales', 'Singapore', 'Singapore', '65-543-1233',
		'65-543-1239', 'Sales@EasternSales.com.sg', 'Jeremey');

INSERT INTO STORE VALUES (1050,
		'Eastern Treasures', 'Manila', 'Philippines', '63-2-654-2344',
		'63-2-654-2349', 'Sales@EasternTreasures.com.ph', 'Gracielle');

INSERT INTO STORE VALUES (1100,
		'Jade Antiques', 'Singapore', 'Singapore', '65-543-3455',
		'65-543-3459', 'Sales@JadeAntiques.com.sg', 'Swee Lai');

INSERT INTO STORE VALUES (1150,
		'Andes Treasures', 'Lima', 'Peru', '51-14-765-4566',
		'51-14-765-4569', 'Sales@AndesTreasures.com.pe', 'Juan Carlos');

INSERT INTO STORE VALUES (1200,
		'Eastern Sales', 'Hong Kong', 'Hong Kong', '852-876-5677',
		'852-876-5679', 'Sales@EasternSales.com.hk', 'Sam');

INSERT INTO STORE VALUES (1250,
		'Eastern Treasures', 'New Delhi', 'India', '91-11-987-6788',
		'91-11-987-6789', 'Sales@EasternTreasures.com.in', 'Deepinder');

INSERT INTO STORE VALUES (1300,
		'EuropeanImports', 'New York City', 'United States', '800-432-8766',
		'800-432-8769', 'Sales@ EuropeanImports.com', 'Marcello');

/*****   SHIPPER Data   ***********************************************************/

INSERT INTO SHIPPER VALUES (null,
		'ABC Trans-Oceanic', '800-234-5656', '800-234-5659',
		'Sales@ABCTransOceanic.com', 'Jonathan');
INSERT INTO SHIPPER VALUES (null,
		'International', '800-123-8898', '800-123-8899',
		'Sales@International.com', 'Marilyn');
INSERT INTO SHIPPER VALUES (null,
		'Worldwide', '800-123-4567', '800-123-4569',
		'Sales@Worldwide.com', 'Jose');

/*****   ITEM Data   ***********************************************************/

INSERT INTO ITEM VALUES (500,
		1050, 101, '2014-12-10', 'Antique Large Bureaus', 'Furniture', 13415);

INSERT INTO ITEM VALUES (505,
		1050, 102, '2014-12-12', 'Porcelain Lamps', 'Lamps', 13300);

INSERT INTO ITEM VALUES (510,
		1200, 104, '2014-12-15', 'Gold Rim Design China', 'Tableware', 38500);

INSERT INTO ITEM VALUES (515,
		1200, 104, '2014-12-16', 'Gold Rim Design Serving Dishes','Tableware', 3200);

INSERT INTO ITEM VALUES (520,
		1050, 102, '2015-04-07', 'QE Dining Set', 'Furniture', 14300);

INSERT INTO ITEM VALUES (525,
		1100, 103, '2015-05-18', 'Misc Linen', 'Linens', 88545);

INSERT INTO ITEM VALUES (530,
		1000, 103, '2015-05-19', 'Large Masks', 'Decorations', 22135);

INSERT INTO ITEM VALUES (535,
		1100, 104, '2015-05-20', 'Willow Design China', 'Tableware', 147575);

INSERT INTO ITEM VALUES (540,
		1100, 104, '2015-05-20', 'Willow Design Serving Dishes', 'Tableware', 12040);

INSERT INTO ITEM VALUES (545,
		1150, 102, '2015-06-14', 'Woven Goods', 'Decorations', 1200);

INSERT INTO ITEM VALUES (550,
		1150, 101, '2015-06-16', 'Antique Leather Chairs', 'Furniture', 5375);

INSERT INTO ITEM VALUES (555,
		1100, 104, '2015-07-15', 'Willow Design Serving Dishes', 'Tableware', 4500);

INSERT INTO ITEM VALUES (560,
		1000, 103, '2015-07-17', 'Large Bureau', 'Furniture', 9500);

INSERT INTO ITEM VALUES (565,
		1100, 104, '2015-07-20', 'Brass Lamps', 'Lamps', 1200);

/*****   SHIPMENT Data   ***********************************************************/

INSERT INTO SHIPMENT (ShipmentID, ShipperID, PurchasingAgentID, ShipperInvoiceNumber, Origin, Destination,
		ScheduledDepartureDate, ActualDepartureDate, EstimatedArrivalDate)
		VALUES (null, 1, 103, 2010651, 'Manila', 'Los Angeles', '2014-12-10', '2014-12-10', '2015-03-15');

INSERT INTO SHIPMENT VALUES (null, 
		1, 104, 2011012, 'Hong Kong', 'Seattle', '2015-01-10', '2015-01-12', '2015-03-20');

INSERT INTO SHIPMENT VALUES (null, 
		3, 103, 49100300, 'Manila', 'Los Angeles', '2015-05-05', '2015-05-05', '2015-06-17');

INSERT INTO SHIPMENT VALUES (null, 
		2, 104, 399400, 'Singapore', 'Portland', '2015-06-02', '2015-06-04','2015-07-17' );

INSERT INTO SHIPMENT VALUES (null, 
		3, 103, 84899440, 'Lima', 'Los Angeles', '2015-07-10', '2015-07-10', '2015-07-28');

INSERT INTO SHIPMENT VALUES (null, 
		2, 104, 488955,  'Singapore', 'Portland', '2015-08-05', '2015-08-09', '2015-09-11');

/*****   SHIPMENT Item   ***********************************************************/

INSERT INTO SHIPMENT_ITEM VALUES(100, 1, 500, 15000);

INSERT INTO SHIPMENT_ITEM VALUES(100, 2, 505, 15000);

INSERT INTO SHIPMENT_ITEM VALUES(101, 1, 510, 40000);

INSERT INTO SHIPMENT_ITEM VALUES(101, 2, 515, 3500);

INSERT INTO SHIPMENT_ITEM VALUES(102, 1, 520, 15000);

INSERT INTO SHIPMENT_ITEM VALUES(103, 1, 525, 90000);

INSERT INTO SHIPMENT_ITEM VALUES(103, 2, 530, 25000);

INSERT INTO SHIPMENT_ITEM VALUES(103, 3, 535, 150000);

INSERT INTO SHIPMENT_ITEM VALUES(103, 4, 540, 12500);

INSERT INTO SHIPMENT_ITEM VALUES(104, 1, 545, 12500);

INSERT INTO SHIPMENT_ITEM VALUES(104, 2, 550, 5500);

INSERT INTO SHIPMENT_ITEM VALUES(105, 1, 555, 4500);

INSERT INTO SHIPMENT_ITEM VALUES(105, 2, 560, 10000);

INSERT INTO SHIPMENT_ITEM VALUES(105, 3, 565, 1500);

/*****   SHIPMENT_RECEIPT   ***********************************************************/

INSERT INTO SHIPMENT_RECEIPT VALUES(200001, 100, 500, 105,'2015-03-17', '10:00', 
    3, 'Yes', NULL);
INSERT INTO SHIPMENT_RECEIPT VALUES(200002, 100, 505, 105, '2015-03-17', '10:00',
    50, 'Yes', NULL);
INSERT INTO SHIPMENT_RECEIPT VALUES(200003, 101, 510, 105, '2015-03-23', '15:30',
    100, 'Yes', NULL);
INSERT INTO SHIPMENT_RECEIPT VALUES(200004, 101, 515, 105, '2015-03-23', '15:30',
    10, 'Yes', NULL);
INSERT INTO SHIPMENT_RECEIPT VALUES(200005, 102, 520, 106, '2015-06-19', '10:15',
   1, 'No', 
    'One leg on one chair broken.');
INSERT INTO SHIPMENT_RECEIPT VALUES(200006, 103, 525, 106, '2015-07-20', '2:20',
   1000, 'Yes', NULL);
INSERT INTO SHIPMENT_RECEIPT VALUES(200007, 103, 530, 106, '2015-07-20', '2:20',
    100, 'Yes', NULL);
INSERT INTO SHIPMENT_RECEIPT VALUES(200008, 103, 535, 106, '2015-07-20', '2:20',
  100, 'Yes', NULL);
INSERT INTO SHIPMENT_RECEIPT VALUES(200009, 103, 540, 106, '2015-07-20', '2:20',
     10, 'Yes', NULL);
INSERT INTO SHIPMENT_RECEIPT VALUES(200010, 104, 545, 105, '2015-07-29', '21:00',
   100, 'Yes', NULL);
INSERT INTO SHIPMENT_RECEIPT VALUES(200011, 104, 550, 105, '2015-07-29', '21:00',
    5, 'Yes', NULL);
INSERT INTO SHIPMENT_RECEIPT VALUES(200012, 105, 555, 106, '2015-09-14', '14:45',
   4, 'Yes', NULL);
INSERT INTO SHIPMENT_RECEIPT VALUES(200013, 105, 560, 106, '2015-09-14', '14:45',
   1, 'Yes', NULL);
INSERT INTO SHIPMENT_RECEIPT VALUES(200014, 105, 565, 106, '2015-09-15', '14:45',
    10, 'No', 
    'Base of one lamp scratched.');

/********************************************************************************/


