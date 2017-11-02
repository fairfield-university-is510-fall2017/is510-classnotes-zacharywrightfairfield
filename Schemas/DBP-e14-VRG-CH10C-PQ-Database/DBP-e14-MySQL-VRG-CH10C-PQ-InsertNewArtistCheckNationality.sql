/********************************************************************************/
/*											                                 	*/
/*	Kroenke and Auer - Database Processing (13th Edition) Chapter 10C     		*/
/*	10C.36.I																			*/
/*	The VRG-CH10C-PQ Database - 												*/
/*                Stored Procedure InsertNewArtistCheckNationality              */
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions				                    */
/*																				*/
/********************************************************************************/

DELIMITER //

CREATE PROCEDURE InsertNewArtistCheckNationality
			(IN newLastName		  Char(25),
			 IN newFirstName		Char(25),
			 IN newNationality	Char(30),
			 IN newDateOfBirth	Numeric(4),
			 IN newDateDeceased	Numeric(4))

spicwt:BEGIN

	DECLARE	varRowCount		  Int;
	DECLARE	VarANRowCount		Int;

	# Check to see if ARTIST NATIONALITY is Allowed.
    
	SELECT	COUNT(*) INTO varANRowCount
	FROM		ALLOWED_NATIONALITY
	WHERE		Nation = newNationality;

	# IF varANRowCount = 0 THEN ARTIST NATIONALITY is NOT allowed.
	IF (varANRowCount = 0) THEN
			ROLLBACK;
			SELECT 'ARTIST Nationality is NOT allowed.'
				AS InsertNewArtistCheckNationalityErrorMessage;
       LEAVE spicwt;
    END IF;

	# Check to see if Artist already exists in database
	SELECT	COUNT(*) INTO varRowCount
	FROM		ARTIST
	WHERE		LastName = newLastName
		AND		FirstName = newFirstName;

	# IF varRowCount > 0 THEN ARTIST already exists.
	IF (varRowCount > 0)
		THEN
			ROLLBACK;
			SELECT 'Artist already exists'
				AS InsertNewArtistCheckNationalityErrorMessage;
     END IF;

	# varRowCount = 0 therefore ARTIST does not exist.
	# Insert new Customer data.
  IF (varRowCount = 0)
		THEN
      INSERT INTO ARTIST
		  (LastName, FirstName, Nationality, DateOfBirth, DateDeceased)
		  VALUES
		  (newLastName, newFirstName, newNationality, newDateOfBirth,
		   newDateDeceased);

    SELECT 'New ARTIST data added to database.'
		  AS InsertNewArtistResults;
    END IF;

END spicwt;

//
DELIMITER ;


# Test data --> 
# Error, Brazilian is not allowed
 CALL InsertNewArtistCheckNationality 
    ('Oiticica', 'Helio', 'Brazilian', 1937, 1980);
 

CALL InsertNewArtistCheckNationality
   ('Callahan', 'Kenneth', 'United States', 1905, 1986);
 
 
SELECT * FROM ARTIST;






















