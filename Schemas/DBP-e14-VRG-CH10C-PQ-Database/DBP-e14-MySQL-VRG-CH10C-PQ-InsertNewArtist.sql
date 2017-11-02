/********************************************************************************/
/*											                                 	*/
/*	Kroenke and Auer - Database Processing (13th Edition) Chapter 10C     		*/
/*																				*/
/*	The VRG-CH10C-PQ Database - Stored Procedure InsertNewArtist			    */
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions				                    */
/*																				*/
/********************************************************************************/


DELIMITER //

CREATE PROCEDURE InsertNewArtist
			(IN newLastName		Char(25),
			 IN newFirstName		Char(25),
			 IN newNationality	Char(30),
			 IN newDateOfBirth	Numeric(4),
			 IN newDateDeceased	Numeric(4)
			)

BEGIN

	DECLARE	varRowCount		Int;

	# Check to see if Artist already exists in database
	SELECT		varRowCount = COUNT(*)
	FROM		ARTIST
	WHERE		LastName = newLastName
		AND		FirstName = newFirstName;


	# IF varRowCount > 0 THEN ARTIST already exists.
	IF (varRowCount > 0)
		THEN
			ROLLBACK;
			SELECT 'Customer already exists'
				AS InsertNewArtistErrorMessage;
		END IF;

	# varRowCount = 0 therefore ARTIST does not exist.
	# Insert new ARTIST data.
	INSERT INTO ARTIST
		(LastName, FirstName, Nationality, DateOfBirth, DateDeceased)
		VALUES
		(newLastName, newFirstName, newNationality, newDateOfBirth,
		 newDateDeceased);

	SELECT 'New ARTIST data added to database.'
		AS InsertNewArtistResults;

END
//
DELIMITER ;

/*  Test data  -->                                                                  */

 CALL InsertNewArtist ('Ernst', 'Max', 'German', 1891, 1976);       

 CALL InsertNewArtist ('Alder', 'Jankel', 'German', 1895, 1949);   

 SELECT * FROM ARTIST;


























