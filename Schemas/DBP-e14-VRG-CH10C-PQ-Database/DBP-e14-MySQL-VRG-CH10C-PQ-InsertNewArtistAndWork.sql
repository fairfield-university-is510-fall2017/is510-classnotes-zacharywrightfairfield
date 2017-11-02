/********************************************************************************/
/*											                                 	*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C     		*/
/*																				*/
/*	The VRG-CH10C-PQ Database - Stored Procedure InsertNewArtistAndWork		    */
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions	for 10C.36.F                    */
/*																				*/
/********************************************************************************/


DELIMITER //

CREATE PROCEDURE InsertNewArtistAndWork
			(IN newLastName		Char(25),
			 IN newFirstName		Char(25),
			 IN newNationality	Char(30),
			 IN newDateOfBirth	Numeric(4),
			 IN newDateDeceased	Numeric(4),
			 IN newTitle			Char(35),
			 IN newCopy 			Char(12),
			 IN newMedium			Char(35),
			 IN newDescription	Varchar(1000))

BEGIN

	DECLARE	varRowCount		Int;
	DECLARE	varArtistID		Int;

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
				AS InsertNewArtistErrorMessage;
		END IF;

	# varRowCount = 0 therefore ARTIST does not exist.
	# Insert new ARTIST data.
	INSERT INTO ARTIST
		(LastName, FirstName, Nationality, DateOfBirth, DateDeceased)
		VALUES
		(newLastName, newFirstName, newNationality, newDateOfBirth,
		 newDateDeceased);

  COMMIT;

	SELECT 'New ARTIST data added to database.'
		AS InsertNewArtistResults;

	# Get new ARTIST ArtistID

	SELECT ArtistID INTO varArtistID
	FROM	ARTIST
	WHERE		LastName = newLastName
		AND		FirstName = newFirstName;

	# Insert new WORK data.
	INSERT INTO WORK
		(Title, Copy, Medium, Description, ArtistID)
		VALUES
		(newTitle, newCopy, newMedium, newDescription, varArtistID);

END
//

DELIMITER ;


# Test data -->                                                                

 CALL InsertNewArtistAndWork ('Monet', 'Claude', 'French', 1840, 1926,
	'Water Lilies - 1907', '567/1000', 'High Quality Limited Print', 
	'French Impressionist');

 
 CALL InsertNewArtistAndWork ('van Gogh', 'Vincent', 'French', 1853, 1890, 
	'Cypresses', '678/1000', 'High Quality Limited Print', 
	'Dutch Post-impressionist');


SELECT * FROM ARTIST;

SELECT * FROM WORK;












