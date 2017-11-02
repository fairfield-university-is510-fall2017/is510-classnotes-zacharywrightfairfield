/********************************************************************************/
/*																				*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C			*/
/*																				*/
/*	MEDIA Database																*/
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions									*/
/*	   for	Chapter 10C Review Questions										*/	
/*																				*/
/********************************************************************************/

/*	*** Chapter 10C Review Questions 10.4 - 10.14. ***							*/

/************ 10C.4 **************************************************************/

CREATE TABLE PICTURE(
	PictureID				Int				NOT NULL AUTO_INCREMENT,
	PictureName				Char(35)		NOT NULL,
	PictureDescription	 	Varchar(255)	NULL DEFAULT 'None',
	DateTaken				Date	 		NOT NULL,
	PictureFileName			Varchar(45)		NOT NULL,
	CONSTRAINT		PicturePK		PRIMARY KEY (PictureID)
	);

/************ 10C.5 **************************************************************/

CREATE TABLE SLIDE_SHOW(
	ShowID					Int				NOT NULL AUTO_INCREMENT,
	ShowName				Char(35)		NOT NULL,
	ShowDescription	 		Varchar(255)	DEFAULT 'None',
	Purpose					Char(15)		NOT NULL,
	CONSTRAINT				SlideShowPK		PRIMARY KEY (ShowID),
	CONSTRAINT				ValidPurpose	CHECK(Purpose IN
							 ('Home', 'Office', 'Family', 'Recreation',
							  'Sports', 'Pets'))
	);

ALTER TABLE SLIDE_SHOW AUTO_INCREMENT=1000;


/************ 10C.6 **************************************************************/

CREATE TABLE SLIDE_SHOW_PICTURE_INT(
	ShowID		Int			NOT NULL,
	PictureID	INT			NOT NULL,
	CONSTRAINT 	IntPK 		PRIMARY KEY (ShowID, PictureID),
	CONSTRAINT	ShowFK		FOREIGN KEY (ShowID)
					REFERENCES	SLIDE_SHOW (ShowID) ON DELETE RESTRICT,
	CONSTRAINT	PictureFK	FOREIGN KEY (PictureID)
					REFERENCES	PICTURE (PictureID)
						ON DELETE CASCADE
                        ON UPDATE CASCADE
	);

/************ 10C.7 **************************************************************/

INSERT INTO PICTURE VALUES (1,
  'SpotAndBall', 'My dog Spot chasing a ball', '2015-09-07', 'spot00001.jpg');
INSERT INTO PICTURE VALUES (2,
  'SpotAndCat', 'My dog Spot chasing a cat', '2015-09-08', 'spot00002.jpg');
INSERT INTO PICTURE VALUES (3,
  'SpotAndCar', 'My dog Spot chasing a car', '2015-10-11', 'spot00003.jpg');
INSERT INTO PICTURE VALUES (4,
  'SpotAndMailman', 
  'My dog Spot chasing a mailman - BAD DOG!', '2015-11-22', 'spot00004.jpg');
INSERT INTO PICTURE VALUES (5,
  'TheJudgeAndI',
  'I explain that Spot is really a good dog, and did not mean to chase the mailman',
  '2015-12-13', 'me00001.jpg');

SELECT * FROM PICTURE;


/*  10C.8 */
INSERT INTO SLIDE_SHOW  VALUES (1000,
	'My Dog Spot', 'My dog Spot likes to chase things', 'Pets');
INSERT INTO SLIDE_SHOW  VALUES (1001,
	'My Day In Court', 'I explain that Spot is really a good dog', 'Home');

SELECT * FROM SLIDE_SHOW;

/* 10C.9 */

INSERT INTO SLIDE_SHOW_PICTURE_INT VALUES (1000, 1);
INSERT INTO SLIDE_SHOW_PICTURE_INT VALUES (1000, 2);
INSERT INTO SLIDE_SHOW_PICTURE_INT VALUES (1000, 3);
INSERT INTO SLIDE_SHOW_PICTURE_INT VALUES (1000, 4);
INSERT INTO SLIDE_SHOW_PICTURE_INT VALUES (1001, 4);
INSERT INTO SLIDE_SHOW_PICTURE_INT VALUES (1001, 5);

SELECT * FROM SLIDE_SHOW_PICTURE_INT;

/************ 10C.10 **************************************************************/
/******  Create View  ***********************************************************/

CREATE VIEW PopularShowsView AS
	SELECT		S.ShowName AS Slide_Show_Name, P.PictureName AS Picture_Name
	FROM 		SLIDE_SHOW S, PICTURE P, SLIDE_SHOW_PICTURE_INT SPI
	WHERE 		S.ShowID = SPI.ShowID
	   AND 		SPI.PictureID = P.PictureID
	   AND		S.Purpose IN ('Home', 'Pets');

/******  Query View (10C.11)*************************************************************/

SELECT * FROM PopularShowsView;

/********************************************************************************/



