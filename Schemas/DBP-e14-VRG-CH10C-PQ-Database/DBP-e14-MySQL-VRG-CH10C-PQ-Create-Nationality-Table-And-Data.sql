/********************************************************************************/
/*											                                 	*/
/*	Kroenke and Auer - Database Processing (13th Edition) Chapter 10C     		*/
/*																				*/
/*	The VRG-CH10C-PQ Database - Create ALLOWED_NATIONALITY Table - Insert Data  */
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions				                    */
/*																				*/
/********************************************************************************/

CREATE TABLE ALLOWED_NATIONALITY(
	Nation			Char(30) 					 NOT NULL,
	CONSTRAINT 	Allowed_Nationality_PK 	PRIMARY KEY(Nation)
	);


INSERT INTO ALLOWED_NATIONALITY VALUES('Canadian');
INSERT INTO ALLOWED_NATIONALITY VALUES('English');
INSERT INTO ALLOWED_NATIONALITY VALUES('French');
INSERT INTO ALLOWED_NATIONALITY VALUES('German');
INSERT INTO ALLOWED_NATIONALITY VALUES('Mexican');
INSERT INTO ALLOWED_NATIONALITY VALUES('Russian');
INSERT INTO ALLOWED_NATIONALITY VALUES('Spanish');
INSERT INTO ALLOWED_NATIONALITY VALUES('United States');

SELECT * FROM ALLOWED_NATIONALITY;



