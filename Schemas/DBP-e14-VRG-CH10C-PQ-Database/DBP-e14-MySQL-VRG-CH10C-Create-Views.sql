/* *** SQL-CREATE-VIEW-CH07-01 *** */
CREATE VIEW CustomerNameView AS
SELECT LastName AS CustomerLastName,
FirstName AS CustomerFirstName
FROM CUSTOMER;

/* *** SQL-CREATE-VIEW-CH07-02 *** */
CREATE VIEW CustomerBasicDataView AS
SELECT LastName AS CustomerLastName,
FirstName AS CustomerFirstName,
AreaCode, PhoneNumber
FROM CUSTOMER;

/* *** SQL-CREATE-VIEW-CH07-03 *** */
CREATE VIEW CustomerBasicDataWAView AS
SELECT LastName AS CustomerLastName,
FirstName AS CustomerFirstName,
AreaCode, PhoneNumber
FROM CUSTOMER
WHERE State='WA';

/* *** SQL-CREATE-VIEW-CH07-04 *** */
CREATE VIEW CustomerPhoneView AS
SELECT LastName AS CustomerLastName,
FirstName AS CustomerFirstName,
('(' + AreaCode + ')' + PhoneNumber) AS CustomerPhone
FROM CUSTOMER;

/* *** SQL-CREATE-VIEW-CH07-05 *** */
CREATE VIEW CustomerInterestsView AS
SELECT C.LastName AS CustomerLastName,
C.FirstName AS CustomerFirstName,
A.LastName AS ArtistName
FROM CUSTOMER AS C JOIN CUSTOMER_ARTIST_INT AS CAI
ON C.CustomerID = CAI.CustomerID
JOIN ARTIST AS A
ON CAI.ArtistID = A.ArtistID;

/* *** SQL-CREATE-VIEW-CH07-06 *** */
CREATE VIEW ArtistWorkNetView AS
SELECT LastName AS ArtistLastName,
FirstName AS ArtistFirstName,
W.WorkID, Title, Copy, DateSold,
AcquisitionPrice, SalesPrice,
(SalesPrice - Acquisitionprice) as NetProfit
FROM TRANS AS T JOIN WORK AS W
ON T.WorkID = W.WorkID
JOIN ARTIST AS A
ON W.ArtistID = A.ArtistID;


/* *** SQL-CREATE-VIEW-CH07-07 *** */
CREATE VIEW ArtistWorkTotalNetView AS
SELECT ArtistLastName, ArtistFirstName,
WorkID,Title, Copy,
SUM(NetProfit) AS TotalNetProfit
FROM ArtistWorkNetView
GROUP BY ArtistLastName, ArtistFirstName,
WorkID, Title, Copy;

/* *** SQL-CREATE-VIEW-CH07-08 *** */
CREATE VIEW CustomerTableBasicDataView AS
SELECT *
FROM CUSTOMER;

