# B.3
DELIMITER //
CREATE FUNCTION GetLastNameCommaSeparated
-- These are the input parameters
(
varName VARCHAR(25)
)
RETURNS VARCHAR(25) DETERMINISTIC
BEGIN
-- This is the variable that will hold the value to be returned
DECLARE varLastName VARCHAR(25);
-- This is the variable that will hold the position of the comma
DECLARE varIndexValue INT;
-- SQL statement to find the comma separator
SET varIndexValue = LOCATE(',', varName);
-- SQL statement to determine last name
SET varLastName = SUBSTRING(varName, 1, (varIndexValue - 1));
-- Return the last name
RETURN varLastName;
END
//
DELIMITER ;

# B.4
/* *** SQL-ALTER-TABLE-CH10C-08 *** */
ALTER TABLE POSTCARDS_TEMP
ADD ArtistLastName Char(25) NULL;
/* *** SQL-ALTER-TABLE-CH10C-09 *** */
ALTER TABLE POSTCARDS_TEMP
ADD ArtistID Int NULL;

# B.5
/* *** SQL-UPDATE-CH10C-01 *** */
UPDATE POSTCARDS_TEMP
SET ArtistLastName = GetLastNameCommaSeparated(ArtistName);
/* *** SQL-UPDATE-CH10C-02 *** */
UPDATE POSTCARDS_TEMP
SET ArtistID =
(SELECT ArtistID
FROM ARTIST
WHERE ARTIST.LastName = POSTCARDS_TEMP.ArtistLastName);

# C.1
DELIMITER //
CREATE FUNCTION GetFirstNameCommaSeparated
-- These are the input parameters
(
varName VARCHAR(25)
)
RETURNS VARCHAR(25) DETERMINISTIC
BEGIN
-- This is the variable that will hold the value to be returned
DECLARE varFirstName VARCHAR(25);
-- This is the variable that will hold the position of the comma
DECLARE varIndexValue INT;
-- SQL statement to find the comma separator
SET varIndexValue = LOCATE(',', varName);
-- SQL statement to determine first name
SET varFirstName = SUBSTRING(varName, (varIndexValue + 2));
-- Return the last name
RETURN varFirstName;
END
//
DELIMITER ;

# C.2
 /* *** Similar to SQL-Query-CH10C-05 *** */
SELECT DISTINCT ArtistName,
GetFirstNameCommaSeparated(ArtistName) AS ArtistFirstName
FROM POSTCARDS_TEMP
ORDER BY ArtistName;


# D.1
/* *** Similar to SQL-Query-CH10C-05 *** */
ALTER table postcards_temp add column ArtistFirstName Char(25) null;

# D.2
/* *** similar to SQL-UPDATE-CH10C-01 *** */
UPDATE POSTCARDS_TEMP
SET ArtistFirstName = GetFirstNameCommaSeparated(ArtistName);

# E
/* E */

ALTER TABLE POSTCARDS_TEMP
	ADD WorkID INT NULL;

UPDATE POSTCARDS_TEMP 
	SET WorkID =
		(SELECT WorkID
		 FROM Work
		 WHERE WORK.Title = POSTCARDS_TEMP.WorkTitle
         LIMIT 1);
         
# F 
CREATE TABLE POSTCARD_SIZE_PRICE
  (PostcardSizePriceID INT NOT NULL auto_increment,
   PostcardSize VarChar(12) NOT NULL,
   PostcardPrice NUMERIC(8, 2) NOT NULL,
   CONSTRAINT PSP_PK PRIMARY KEY (PostcardSizePriceID));

# G
INSERT INTO POSTCARD_SIZE_PRICE
  SELECT null, PCT.PostcardSize, PCT.PostcardPrice
  FROM (SELECT DISTINCT PostcardSize, PostcardPrice
  FROM POSTCARDS_TEMP) as PCT;

select * from postcard_size_price;

# H 
ALTER TABLE POSTCARDS_TEMP
	ADD PostcardSizePriceID INT NULL;

UPDATE POSTCARDS_TEMP
	SET PostcardSizePriceID =
		(SELECT PostcardSizePriceID
		 FROM POSTCARD_SIZE_PRICE AS  P
		 WHERE P.PostCardSize = POSTCARDS_TEMP.PostCardSize);

select * from postcards_temp;

# I 
CREATE TABLE POSTCARD_INVENTORY
  (PostcardID INT NOT NULL auto_increment,
   ArtistID INT NOT NULL,
   WorkID INT NOT NULL,
   PostcardSizePriceID INT NOT NULL,
   QuantityOnHand INT NULL,
   QuantityOnOrder INT NULL,
   CONSTRAINT PI_PK PRIMARY KEY (PostcardID),
   CONSTRAINT PI_Artist_FK FOREIGN KEY (ArtistID) REFERENCES ARTIST (ArtistID),
   CONSTRAINT PI_Work_FK FOREIGN KEY (WorkID) REFERENCES WORK (WorkID),
   CONSTRAINT PI_PostcardSizePrice_FK FOREIGN KEY (PostcardSizePriceID) REFERENCES
      POSTCARD_SIZE_PRICE (PostcardSizePriceID));

# J 
INSERT INTO POSTCARD_INVENTORY
  SELECT Postcards_temp_id, ArtistID, WorkID, PostcardSizePriceID, QuantityOnHand, QuantityOnOrder
  FROM POSTCARDS_TEMP;
  
  select * from POSTCARD_INVENTORY;

